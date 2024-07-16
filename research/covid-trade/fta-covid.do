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

*** make a working directory for covid-fta ***
capture mkdir covid
capture mkdir covid/results
capture mkdir covid/data

*** load data from web*** 	
use https://eddie-hearn.github.io/research/covid-trade/clean-trade

*** save data to local file *** 	
save covid/data/clean-trade.dta, replace

*** check for required input files ***
capture confirm file covid/data/clean-trade.dta
if _rc!=0 {
	display "dataset covid/data/clean-trade.dta must be in working directory"
	}

*** load data from local file *** 	
use "covid/data/clean-trade.dta"

*** OLS regression with full data (. treated as 0) ****
reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto CU FTA covid i.origin i.destination, robust cluster(country_pair)
outreg2 using covid/results/ols , tex title(OLS full data)ctitle(Model 1) replace  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto  CU FTA covid cov_fta i.origin i.destination, cluster(country_pair) 
outreg2 using covid/results/ols , tex ctitle(Model 2) append  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_cu i.origin i.destination, cluster(country_pair) 
outreg2 using covid/results/ols , tex ctitle(Model 3) append drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto CU FTA covid cov_wto i.origin i.destination, cluster(country_pair) 
outreg2 using covid/results/ols , tex ctitle(Model 4) append drop(i.origin i.destination)


*** OLS regression with added controls (. treated as 0) ****
reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto EU CU FTA per_trade covid i.origin i.destination, robust cluster(country_pair)
outreg2 using covid/results/ols-controls , tex title(OLS full data)ctitle(Model 1) replace  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto EU CU FTA per_trade covid cov_fta i.origin i.destination, cluster(country_pair) 
outreg2 using covid/results/ols-controls , tex ctitle(Model 2) append  drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  EU wto CU FTA per_trade covid cov_cu i.origin i.destination, cluster(country_pair) 
outreg2 using covid/results/ols-controls , tex ctitle(Model 3) append drop(i.origin i.destination)

reg ln_ex ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off EU wto CU FTA per_trade covid cov_wto i.origin i.destination, cluster(country_pair) 
outreg2 using covid/results/ols-controls , tex ctitle(Model 4) append drop(i.origin i.destination)


*** OLS regression truncated (missing deleted) ***
reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off wto CU FTA covid i.origin i.destination, robust cluster(country_pair)
outreg2 using covid/results/ols-truncated , tex title(OLS truncated data (missing deleted)) ctitle(Model 1) replace  drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_fta i.origin i.destination, cluster(country_pair) 
outreg2 using covid/results/ols-truncated , tex ctitle(Model 2) append  drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_cu i.origin i.destination, cluster(country_pair) 
outreg2 using covid/results/ols-truncated , tex ctitle(Model 3) append drop(i.origin i.destination)

reg ln_ex_tr ln_gdp_o ln_gdp_d ln_dist contig col_dep_ever comcol comlang_off  wto CU FTA covid cov_wto i.origin i.destination, cluster(country_pair)
outreg2 using covid/results/ols-truncated , tex ctitle(Model 4) append drop(i.origin i.destination)

capture  cp https://eddie-hearn.github.io/research/covid-trade/fta-covid.do covid/fta-covid.do, replace
capture  cp https://eddie-hearn.github.io/research/covid-trade/clean-trade.do covid/fta-covid.do, replace


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

log close covid

capture cp fta-covid.log covid/fta-covid.log, replace
capture rm fta-covid.log

