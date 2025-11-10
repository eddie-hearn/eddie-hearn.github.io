*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   KIMIKO_REG.do                                     *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Kimiko 2025 (regression)                          *
*     Input File:  KIMIKO_2025.dta                                   *
*     Outputfile:  myreg.doc                                         *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

capture ssc install outreg2

if c(os)=="Windows" {
display "Kimiko detected"
display "moving to working directory"
cd C:\Users\ilove\FinalThesis
display "downloading do file"
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/KIMIKO_REG.do KIMIKO_REG.do, replace 
}

use KIMIKO_2025.dta

*** changinging variable names if not done already
capture rename efficiency capacity
capture rename dummy_income1 wealthy
capture rename dummy_income2 low
capture rename dummy_income3 low_mid
capture rename dummy_income4 high_mid
save, replace


**** run your first regression for "trust_judiciary"

reg trust_judiciary  transparency capacity trust_general civic_society, level(90)
outreg2 using myreg.doc, replace ctitle (Judicial Trust) dec(4) 


**** run your second regression for "corruption2"

reg corruption2 independence capacity low low_mid high_mid trust_judiciary 
outreg2 using myreg.doc, append ctitle (Political Corruption) dec(4) 

