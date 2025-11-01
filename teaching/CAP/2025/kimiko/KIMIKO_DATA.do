*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   KIMIKO_DATA.do                                    *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Kimiko 2025 (dataset)                             *
*     Input File:  WVS_Wave_7.dta, political-corruption-index.csv,   *
*                  rol.xlsx                                          *
*	  Output file: scap.dta, pci.dta, rol.dta, KIMIKO_2025.dta       *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

******
** Get social capital, general trust, confidence in Judiciary from World Values Survey wave 7
******

use WVS_Wave_7

****************************
*drop missing data
****************************
foreach var of varlist _all {
    capture confirm numeric variable `var'
    if !_rc {
        replace `var' = . if `var' < 0
    }
}

recode Q57 (2=0)
collapse (mean) Q94R Q95R  Q96R Q97R Q98R Q99R Q100R Q101R Q102R Q103R Q57 Q70, by(B_COUNTRY B_COUNTRY_ALPHA)
gen civic_society = ((Q94R+ Q95R +Q96R+ Q97R+ Q98R+ Q99R +Q100R+ Q101R +Q102R +Q103R)/10)*100
gen trust_general = Q57*100
gen trust_judiciary = (Q70*-1)+5
drop Q94R - Q70
rename B_COUNTRY_ALPHA alpha_code
rename B_COUNTRY num_code
save data/scap.dta, replace
clear

******
** Get political corruption from V-dem  (source Our World in Data)
******

import delim political-corruption-index.csv
keep if year ==2021
drop if code==""
keep code politicalcorruptionindexcentrale
rename politicalcorruptionindexcentrale PCI
rename code alpha_code
save data/pci.dta, replace
clear

******
** Get independence, corruption2, transparency, efficiency, region, income group  (source World Justice Project)
******

import excel "rol.xlsx", sheet("Sheet1") firstrow
rename Country  country
rename CountryCode code
gen independence = Factor1ConstraintsonGovernm
gen corruption2 = ( Factor2AbsenceofCorruption*-1)+1
gen transparency = Factor3OpenGovernment
gen efficiency = AV
drop WJPRuleofLawIndexOverallS - BF
rename code alpha_code
save data/rol.dta, replace

******
** merge data
******

merge 1:1 alpha_code using data/scap
drop _merge
merge 1:1 alpha_code using data/pci
drop _merge
replace PCI = PCI*100
replace independence= independence*100
replace corruption2 = corruption2 *100
replace transparency = transparency *100
replace efficiency = efficiency *100
order country alpha_code num_code num_code  Region IncomeGroup PCI corruption2 trust_judiciary trust_judiciary  civic_society trust_general transparency efficiency independence
rename alpha_code ISO_A3

save data/KIMIKO_2025.dta, replace
cd data
