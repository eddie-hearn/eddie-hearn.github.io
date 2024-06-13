     ****************************************************************** *
*     ***************************************************************** *
*     File-Name:   loading_data.do                                      *
*     Date:        June 13, 2024                                        *
*     Author:      Eddie Hearn                                          *
*     Purpose:     Loading data                                         *
*     Input File:  none                                                 *
*     Output File: none                                                 *
*     Data Output: none                                                 *
*     Program:	   Stata 18                                             *
*     Machine:     Linux-home                                           *
*     ****************************************************************  *
*     ****************************************************************  *

clear
cd ~/
capture mkdir zemi
cd zemi
mkdir data

use https://eddie-hearn.github.io/teaching/ZEM/data/births-per
save births-per, replace
export excel using "births-per", firstrow(variables) replace
export delim using "births-per.csv", replace

if c(os)=="Windows" {
display "WINDOWS OS detected"
capture winexec explorer.exe data
}

if c(os)=="MacOSX" {
display "MAC OS detected"
capture winexec open data
}

if c(os)=="Unix" {
display "LINUX OS detected"
capture winexec xdg-open data
}

clear

cd data
