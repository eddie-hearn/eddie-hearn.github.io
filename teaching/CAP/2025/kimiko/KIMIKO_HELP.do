*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   KIMIKO_HELP.do                                    *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Kimiko 2025 (HELP           )                     *
*     Input File:  NONE                                              *
*     Outputfile:  see KIMIKO_GRAPHS.do                              *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

capture mkdir CAPSTONE_DATA
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/KIMIKO_DATA.do KIMIKO_DATA.do
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/KIMIKO_GRAPHS.do KIMIKO_GRAPHS.do
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/KIMIKO_2025.dta KIMIKO_2025.dta

cd CAPSTONE_DATA
do KIMIKO_GRAPHS

if c(os)=="Windows" {
display "WINDOWS OS detected"
capture winexec explorer.exe CAPSTONE_DATA
}

if c(os)=="MacOSX" {
display "MAC OS detected"
capture winexec open CAPSTONE_DATA
}

if c(os)=="Unix" {
display "LINUX OS detected"
capture winexec xdg-open CAPSTONE_DATA
}

