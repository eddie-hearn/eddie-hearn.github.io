*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   KIMIKO_REG.do                                     *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Kimiko 2025 (regression)                          *
*     Input File:  KIMIKO_2025.dta                                   *
*     Outputfile: transparency.png, efficiency.png, scap.png         *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

capture ssc install outreg2
cd C:\Users\ilove\FinalThesis
use KIMIKO_2025.dta

rename efficiency capacity
rename dummy_income1 wealthy
rename dummy_income2 low
rename dummy_income3 low_mid
rename dummy_income4 high_mid

save, replace


**** run your first regression for "trust_judiciary"

reg trust_judiciary  transparency capacity trust_general civic_society, level(90)
outreg2 using myreg.doc, replace ctitle (Judicial Trust) dec(4) 


**** run your second regression for "corruption2"

reg corruption2 independence capacity low low_mid high_mid trust_judiciary 
outreg2 using myreg.doc, append ctitle (Political Corruption) dec(4) 

