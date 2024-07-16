log using fta-covid.log, replace name(covid)


*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   fta-covid.do                                      *
*     Author:      Eddie Hearn                                       *
*     Purpose:     FTAs and shocks                                   *
*     Input File:  Gravity_V202211.dta                               *
*     output:	   ols.tex ols-truncated.tex  covid-trade.dta        *
*     Program:	   Stata 17                                          *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

*** make a working directory for covid-fta ***
capture mkdir covid
capture mkdir covid/results
capture mkdir covid/data

*** Copy full dataset from web ***
cd covid/data
cp http://www.cepii.fr/DATA_DOWNLOAD/gravity/data/Gravity_dta_V202211.zip covid-trade.zip
unzipfile covid-trade.zip

use Gravity_V202211.dta
rm covid-trade.zip

*** install required packages if necesary ***
capture ssc install outreg2 

cd ../..

*** make id variables ***
egen country_pair = group( country_id_o country_id_d ), label
egen origin = group( country_id_o ), label lname( country_id_o)
egen destination = group( country_id_d ), label lname( country_id_d)


*** gen dv if .=0 ***
gen ex = tradeflow_imf_o
replace ex = 0 if tradeflow_imf_o==.

bysort origin year: egen tot_exports=total(ex)
gen per_trade = ex/tot_exports
recode per_trade (.=0)
replace ex = ex+1


gen ln_ex = ln(ex)
gen ex_pos = (ex-1)/10000000 


*** gen dv if . = missing ***
gen ln_ex_tr = ln(tradeflow_imf_o)
gen ex_pos_tr =  tradeflow_imf_o/10000000 


*** gen gravity variables ***
gen ln_dist = ln(distcap)
gen ln_gdp_o = ln( gdp_o ) 
gen ln_gdp_d = ln( gdp_d ) 


*** gen covid dummy ***
gen covid = 0
replace covid =1 if year ==2020


*** gen institution variables ***
gen wto= 1 if wto_o==1 & wto_d==1
recode wto (.=0)

gen EU = 1 if eu_o==1 & eu_d==1
recode EU (.=0)

codebook rta_type

gen CU = 0
replace CU =1 if rta_type==1 | rta_type== 2

gen FTA = 0
replace FTA = 1 if rta_type>2  &  rta_type<8


*** gen interaction variables ***
gen cov_wto = covid * wto
gen cov_cu= covid * CU
gen cov_fta = covid * FTA

save covid/data/covid-trade.dta

*** set sample restrictions: UN countries, 2019-2020 ***
local sample "if country_exists_o ==1 & country_exists_d ==1 & (year==2019 | year==2020)"

*** OLS regression with full data (. treated as 0) ****
reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto CU FTA covid i.origin i.destination `sample', robust cluster(country_pair)
outreg2 using covid/results/ols , tex title(OLS full data)ctitle(Model 1) replace  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto  CU FTA covid cov_fta i.origin i.destination `sample', cluster(country_pair) 
outreg2 using covid/results/ols , tex ctitle(Model 2) append  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_cu i.origin i.destination `sample', cluster(country_pair) 
outreg2 using covid/results/ols , tex ctitle(Model 3) append drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto CU FTA covid cov_wto i.origin i.destination `sample' , cluster(country_pair) 
outreg2 using covid/results/ols , tex ctitle(Model 4) append drop(i.origin i.destination)


*** OLS regression with added controls (. treated as 0) ****
reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto EU CU FTA per_trade covid i.origin i.destination `sample', robust cluster(country_pair)
outreg2 using covid/results/ols-controls , tex title(OLS full data)ctitle(Model 1) replace  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto EU CU FTA per_trade covid cov_fta i.origin i.destination `sample', cluster(country_pair) 
outreg2 using covid/results/ols-controls , tex ctitle(Model 2) append  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  EU wto CU FTA per_trade covid cov_cu i.origin i.destination `sample', cluster(country_pair) 
outreg2 using covid/results/ols-controls , tex ctitle(Model 3) append drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off EU wto CU FTA per_trade covid cov_wto i.origin i.destination `sample', cluster(country_pair) 
outreg2 using covid/results/ols-controls , tex ctitle(Model 4) append drop(i.origin i.destination)


*** OLS regression truncated (missing deleted) ***
reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto CU FTA covid i.origin i.destination `sample', robust cluster(country_pair)
outreg2 using covid/results/ols-truncated , tex title(OLS truncated data (missing deleted)) ctitle(Model 1) replace  drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_fta i.origin i.destination `sample', cluster(country_pair) 
outreg2 using covid/results/ols-truncated , tex ctitle(Model 2) append  drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_cu i.origin i.destination `sample', cluster(country_pair) 
outreg2 using covid/results/ols-truncated , tex ctitle(Model 3) append drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_wto i.origin i.destination `sample', cluster(country_pair)
outreg2 using covid/results/ols-truncated , tex ctitle(Model 4) append drop(i.origin i.destination)

capture  cp https://eddie-hearn.github.io/research/covid-trade/fta-covid.do covid/fta-covid.do, replace
log close covid

capture cp fta-covid.log covid/fta-covid.log, replace
capture rm fta-covid.log

if c(os)=="Windows" {
display "WINDOWS OS detected"
capture winexec explorer.exe covid
}

if c(os)=="MacOSX" {
display "MAC OS detected"
capture winexec open covid
}

if c(os)=="Unix" {
display "LINUX OS detected"
capture winexec xdg-open covid
}



