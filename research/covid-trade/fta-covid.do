log using fta-covid.log, replace name(covid)


*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   fta-covid.do                                      *
*     Author:      Eddie Hearn                                       *
*     Purpose:     FTAs and shocks                                   *
*     Input File:  clean-trade.dta                                   *
*     output:	   ols.tex ols-truncated.tex  clean-trade.dta        *
*     Program:	   Stata 17                                          *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *


*** install required packages if necesary ***
capture ssc install outreg2 

*** make a working directory for replication ***
capture mkdir replication

*** load data *** 	
use https://eddie-hearn.github.io/research/covid-trade/clean-trade

*** move to replication dir ***
cd replication

*** OLS regression with full data (. treated as 0) ****
reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto CU FTA covid i.origin i.destination, robust cluster(country_pair)
outreg2 using ols , tex title(OLS full data)ctitle(Model 1) replace  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_fta i.origin i.destination, cluster(country_pair) 
outreg2 using ols , tex ctitle(Model 2) append  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_cu i.origin i.destination, cluster(country_pair) 
outreg2 using ols , tex ctitle(Model 3) append drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_wto i.origin i.destination, cluster(country_pair) 
outreg2 using ols , tex ctitle(Model 4) append drop(i.origin i.destination)

*** OLS regression truncated (missing deleted) ***
reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto CU FTA covid i.origin i.destination, robust cluster(country_pair)
outreg2 using ols-truncated , tex title(OLS truncated data (missing deleted)) ctitle(Model 1) replace  drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_fta i.origin i.destination, cluster(country_pair) 
outreg2 using ols-truncated , tex ctitle(Model 2) append  drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_cu i.origin i.destination, cluster(country_pair) 
outreg2 using ols-truncated , tex ctitle(Model 3) append drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_wto i.origin i.destination, cluster(country_pair)
outreg2 using ols-truncated , tex ctitle(Model 4) append drop(i.origin i.destination)

save clean-trade.dta, replace
save fta-covid.do, replace

cd ..

if c(os)=="Windows" {
display "WINDOWS OS detected"
capture winexec explorer.exe replication
}

if c(os)=="MacOSX" {
display "MAC OS detected"
capture winexec open replication
}

if c(os)=="Unix" {
display "LINUX OS detected"
capture winexec xdg-open replication
}

log close covid
