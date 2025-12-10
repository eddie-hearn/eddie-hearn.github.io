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
if c(os)=="Windows" {
display "Victoria detected"
display "moving to working directory"
cd C:/Users/mtgro/CAPSTONE_DATA/stata
cp https://eddie-hearn.github.io/teaching/CAP/2025/victoria/Victoria.do Victoria.do, replace
}
else {
	display "Eddie Detected"
	}
	
**** Load dataset
import delimit results.csv, clear

**** Recode variables so Trust is high score
recode gender (2=0)
rename gender male
replace watch = ((watch*-1)+6)
replace trust = ((trust*-1)+6)
replace abortion = ((abortion*-1)+6)
replace immigration = (( immigration *-1)+6)
replace emperor = (( emperor *-1)+6)
replace hatespeech = (( hatespeech *-1)+6)
replace liberal_emotional_text = (( liberal_emotional_text *-1)+6)
replace liberal_neutral_text = (( liberal_neutral_text *-1)+6)
replace conservative_emotional_text = ((conservative_emotional_text *-1)+6)
replace conservative_neutral_text = ((conservative_neutral_text *-1)+6)
rename liberal_emotional_text liberal_emotional_trust
rename liberal_neutral_text liberal_neutral_trust
rename conservative_emotional_text conservative_emotional_trust
rename conservative_neutral_text conservative_neutral_trust

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

graph bar conservative_neutral_trust , over( ideo3 ) title("Trust of Conservative-Nuetral Text") ytitle("Mean of Trust")  intensity(25)
graph export "graphs/RESULT_con_neu.png", replace
graph bar conservative_emotional_trust , over( ideo3 ) title("Trust of Conservative-emotional Text") ytitle("Mean of Trust")  intensity(25)
graph export "graphs/RESULT_con_emo.png", replace
graph bar liberal_neutral_trust , over( ideo3 ) title("Trust of Liberal-Nuetral Text") ytitle("Mean of Trust")  intensity(25)
graph export "graphs/RESULT_lib_neu.png", replace
graph bar liberal_emotional_trust , over( ideo3 ) title("Trust of Liberal-emotional Text") ytitle("Mean of Trust")  intensity(25)
graph export "graphs/RESULT_lib_emo.png", replace



***** examine hypothesis
graph bar (mean) liberal_emotional_trust (mean) conservative_emotional_trust if ideo3=="Liberal", title("Liberal Trust of Emotional Media") ytitle("Mean of Trust")  intensity(25) legend(order(1 "Liberal Emotional" 2 "Conservative Emotional"))
graph export "graphs/liberal_partisan_emotional.png", replace

graph bar (mean) liberal_emotional_trust (mean) conservative_emotional_trust if ideo3=="Conservative", title("Conservative Trust of Emotional Media") ytitle("Mean of Trust")  intensity(25) legend(order(1 "Liberal Emotional" 2 "Conservative Emotional"))
graph export "graphs/conservative_partisan_emotional.png", replace

graph bar (mean) liberal_emotional_trust (mean) liberal_neutral_trust if ideo3=="Conservative", title("Conservative Trust of Liberal Media") ytitle("Mean of Trust")  intensity(25) legend(order(1 "Liberal Emotional" 2 "Liberal Nuetral"))
graph export "graphs/conservative_partisan.png", replace

graph bar (mean) conservative_emotional_trust (mean) conservative_neutral_trust if ideo3=="Liberal", title("Liberal Trust of Conservative Media") ytitle("Mean of Trust")  intensity(25) legend(order(1 "Conservative Emotional" 2 "Conservative Nuetral"))
graph export "graphs/liberal_partisan.png", replace


graph bar (mean) liberal_neutral_trust (mean) conservative_neutral_trust if ideo3=="Liberal", title("Liberal Trust of Neutral Media") ytitle("Mean of Trust")  intensity(25) legend(order(1 "Liberal Neutral" 2 "Conservative Neutral"))
graph export "graphs/liberal_partisan_neutral.png", replace

graph bar (mean) liberal_neutral_trust (mean) conservative_neutral_trust if ideo3=="Conservative", title("Conservative Trust of Neutral Media") ytitle("Mean of Trust")  intensity(25) legend(order(1 "Liberal Neutral" 2 "Conservative Neutral"))
graph export "graphs/conservative_partisan_neutral.png", replace

graph bar (mean) liberal_neutral_trust (mean) liberal_emotional_trust if ideo3=="Liberal", title("Liberal Media Trust") ytitle("Mean of Trust")  intensity(25) legend(order(1 "Liberal Neutral" 2 "Liberal Emotional"))
graph export "graphs/liberal_trust.png", replace

graph bar (mean) conservative_neutral_trust (mean) conservative_emotional_trust if ideo3=="Liberal", title("Conservative Media Trust") ytitle("Mean of Trust")  intensity(25) legend(order(1 "Conservative Neutral" 2 "Conservative Emotional"))
graph export "graphs/conservative_trust.png", replace
