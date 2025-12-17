*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   kaito.do                                       *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Kaito 2025 (analysis)                          *
*     Input File:  dream.sav                                       *                                             
*     Outputfile:                                                    *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *


log using katio.log, replace	
**** Load dataset


**** move to working directory for stata
if c(os)=="Windows" {
display "Kaito detected"
display "moving to working directory"
cd C:/Users/s4225
capture mkdir CAPSTONE
cd C:/Users/s4225/CAPSTONE
cp https://eddie-hearn.github.io/teaching/CAP/2025/kaito/kaito.do kaito.do, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kaito/dream.sav dream.sav, replace
}
else {
	display "Eddie Detected"
	}

import spss using "dream.sav", clear

keep F_IDEO F_INC_SDT1 F_CREGION F_AGECAT F_GENDER F_EDUCCAT F_RACETHNMOD AMDREAM1_W146 AMDREAMPOSS_W146 F_ATTENDPER F_INC_TIER2 F_RELIGCAT1

recode * (99=.)
gen dream_pos = (AMDREAMPOSS_W146*-1)+4
gen religous = (F_ATTENDPER*-1)+7
gen liberal = F_IDEO
gen male = 1 if F_GENDER==1
recode male (.=0)
gen dream2 = 1 if dream_pos==3
recode dream2 (.=0)
replace dream2 = . if dream_pos==.

graph bar , over(dream_pos, relabel (3 "Possible" 2 "Non longer possible" 1 "Never possible")) title("The American Dream")
graph export dream.png, replace


reg dream2 i.F_CREGION F_AGECAT i.F_EDUCCAT religous F_INC_SDT1 male i.F_RACETHNMOD

reg dream2 i.F_CREGION F_AGECAT i.F_EDUCCAT religous F_INC_SDT1 male i.F_RACETHNMOD if F_INC_TIER2==1

log close
