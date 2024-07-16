log using clean-trade.log, replace name(clean)


*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   clean-trade.do                                    *
*     Author:      Eddie Hearn                                       *
*     Purpose:     FTAs and shocks                                   *
*     Input File:  covid-trade.dta                                   *
*     output:	   clean-trade.dta                                   *
*     Program:	   Stata 17                                          *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *



*** check for required input files ***
capture confirm file covid-trade.dta
if _rc!=0 {
	display "dataset data/covid-trade.dta must be in working directory"
	}


*** load data *** 	
use "data/covid-trade.dta"


*** remove extra years ***
keep if year==2020 | year == 2019


*** remove non states ***
keep if country_exists_o ==1
keep if country_exists_d ==1


*** make id variables ***
egen country_pair = group( country_id_o country_id_d ), label
egen origin = group( country_id_o ), label lname( country_id_o)
egen destination = group( country_id_d ), label lname( country_id_d)


*** gen dv if .=0 ***
gen ex = tradeflow_imf_o
replace ex = 0 if tradeflow_imf_o==.

bysort origin year: egen tot_exports=total(ex)
gen per_trade = ex/tot_exports
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



keep ln_ex ex_pos ln_dist dist contig comlang_off comcol col_dep_ever origin destination ln_gdp_o ln_gdp_d covid wto CU FTA cov_wto cov_cu cov_fta ln_ex_tr ex_pos_tr country_pair year country_id* tradeflow_i* ex tot_exports per_trade EU

save data/clean-trade.dta, replace
log close clean
