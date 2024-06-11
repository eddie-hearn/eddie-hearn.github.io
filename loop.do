log using covid.log, replace name(covid)

*     ***************************************************************** *
*     ***************************************************************** *
*     File-Name:   covid.do                                             *
*     Date:        June 12, 2024                                        *
*     Author:      Eddie Hearn                                          *
*     Purpose:     First year Sem                                       *
*     Input File:  stmf.csv                                             *
*     Output File: graphs/log                                           *
*     Data Output: covid.dta                                            *
*     Program:	   Stata 18                                             *
*     Machine:     Linux-terminal                                       *
*     ****************************************************************  *
*     ****************************************************************  *

set scheme s1color 
set more off
clear

quietly capture mkdir reports
if _rc!=0 {
	noisily display "directory already exists"
	}
 
use "https://eddie-hearn.github.io/teaching/FYS/covid.dta"

cd reports

quietly levelsof countrycode, local(code)   // create local macro of country names

foreach c in `code' {						// loop for each country
	log using `c'.log, replace name(`c')
	local break "*****************************************************************************"
	local blank " "
	di "`blank'"
	di "`blank'"
	di "`break'"
	di "`c'"    //print country code
	di "`break'"
	quietly sum rtotal if countrycode == "`c'" & year >2015 & year < 2020 // calculate average mortality rate for 2015-2019
        local r_avg_mean = r(mean)      //local macro equal to mean 
        local r_avg_obs = r(N)          //local macro equal to number of observations
        local r_avg_sd = r(sd)          //local macro equal to standard deviation
     quietly sum dtotal if countrycode == "`c'" & year >2015 & year < 2020 // calculate total deaths for 2015-2019
        local t_avg_mean = r(mean)      //local macro equal to mean 
     	local population_avg = (`t_avg_mean'*52)/`r_avg_mean'
        
     local nen 2020 2021 2022			//local for each nen
     foreach n of local nen {			//loop for each nen
        quietly sum dtotal if countrycode == "`c'" & year == `n'   // calculate total mortality for year n
        	local t_`n'_mean = r(mean)     //local macro equal to mean of total deaths
        
        quietly sum rtotal if countrycode == "`c'" & year == `n'   // calculate average mortality rate for year n
        	local r_`n'_mean = r(mean)     //local macro equal to mean 
        	local r_`n'_obs = r(N)         //local macro equal to number of observations
        	local r_`n'_sd = r(sd)         //local macro equal to standard deviation

        local population_`n' = (`t_`n'_mean'*52)/`r_`n'_mean' 			// estimate population for year n
        local deaths_`n' = `population_`n'' * `r_`n'_mean'				// estimate total deaths for year n
        local expected_`n' = `population_`n'' * `r_avg_mean'			// estimate expected deaths for year n
        local excess_`n' = (`deaths_`n'') - (`expected_`n'')			// estimate excess deaths for year n
        
        di "`blank'"
        di "`c' Expected versus `n' deaths"
        ttesti `r_avg_obs' `r_avg_mean'  `r_avg_sd' `r_`n'_obs' `r_`n'_mean'  `r_`n'_sd'     //t-test expected - year n
        }
    di "`blank'"
    di "`break'"
    foreach n of local nen {  				//loop to display results for each nen
        di "`blank'"
        di "`n' population `c'"
        di `population_`n''
        di "`blank'"
        di "`n' Average Excess deaths `c'"
        di `excess_`n''
        di "`blank'"
       }
    di "`blank'"
    di "`break'"
       
    twoway  (line dtotal week if year == 2015 &  countrycode=="`c'", lcolor(gray)) ///
            (line dtotal week if year == 2016 &  countrycode=="`c'", lcolor(gray)) ///
            (line dtotal week if year == 2017 &  countrycode=="`c'", lcolor(gray)) ///
            (line dtotal week if year == 2018 &  countrycode=="`c'", lcolor(gray)) ///
            (line dtotal week if year == 2019 &  countrycode=="`c'", lcolor(gray)) ///
            (line dtotal week if year == 2020 &  countrycode=="`c'") ///
            (line dtotal week if year == 2021 &  countrycode=="`c'") ///
            (line dtotal week if year == 2022 &  countrycode=="`c'") ///
            (line dtotal week if year == 2023 &  countrycode=="`c'"), ///
                title("Weekly Deaths `c'") ///
                ytitle("Deaths" " ") ///
                legend(order(5 "2015-2019" 6 "2020" 7 "2021" 8 "2022" 9 "2023") col(5)) ///
                xlabel(.3 "Jan" 4.3 "Feb" 8.6 "Mar" 12.9 "Apr" 17.3 "May" 21.6 "Jun" 25.9 "Jul" 30.2 "Aug" 34.5 "Sep" /// 
                    38.8 "Oct" 43.1 "Nov" 47.4 "Dec", ang(45))
    graph export "`c'.png", replace

    log close `c'
	}

cd ..  
save covid.dta, replace

if c(os)=="Windows" {
display "WINDOWS OS detected"
capture winexec start reports
}

if c(os)=="MacOSX" {
display "MAC OS detected"
capture winexec open reports
}

if c(os)=="Unix" {
display "LINUX OS detected"
capture winexec xdg-open reports
}

log close covid
