*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   Victoria.do                                       *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Victoria 2025 (analysis)                          *
*     Input File:  results.csv                                       *                                             
*     Outputfile:                                                    *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

clear

**** move to working directory for stata
cd C:/Users/mtgro/CAPSTONE_DATA/stata

**** Load dataset

import delimit results.csv, clear

**** First lets makes some grapsh of the distribution of our variables 

catplot, over( con ) blabel(bar, pos(base)) intensity(25)  title("Political Ideology (Conservative)")
graph export graphs/ideology.png, replace

ds
local myvarlist = "`r(varlist)'"
local total : word count `myvarlist'

forvalues i = 1/`total' {
        local xvar : word `i' of `myvarlist'
        catplot, over( `xvar' ) blabel(bar, pos(base)) intensity(25)  title("`xvar'") recast(bar)
        graph export "graphs/`xvar'.png", replace
                }


**** Create ideology3 

gen ideology3 = .
replace ideology3 = 1 if con<12
replace ideology3 = 3 if con>14
recode ideology3 (.=2)

gen ideo3 = "Liberal" if ideology3==1
replace ideo3 = "Nuetral" if ideology3==2
replace ideo3 = "Conservative" if ideology3==3


**** Analyze each DV

graph bar conservative_neutral_text , over( ideo3 ) title("Distrust of Conservative-Nuetral Text") ytitle("Mean of Distrust")  intensity(25)
graph export "graphs/RESULT_con_neu.png", replace
graph bar conservative_emotional_text , over( ideo3 ) title("Distrust of Conservative-emotional Text") ytitle("Mean of Distrust")  intensity(25)
graph export "graphs/RESULT_con_emo.png", replace
graph bar liberal_neutral_text , over( ideo3 ) title("Distrust of Liberal-Nuetral Text") ytitle("Mean of Distrust")  intensity(25)
graph export "graphs/RESULT_lib_neu.png", replace
graph bar liberal_emotional_text , over( ideo3 ) title("Distrust of Liberal-emotional Text") ytitle("Mean of Distrust")  intensity(25)
graph export "graphs/RESULT_lib_emo.png", replace


