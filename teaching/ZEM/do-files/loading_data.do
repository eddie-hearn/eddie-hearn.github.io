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
capture mkdir data

use https://eddie-hearn.github.io/teaching/ZEM/data/births-per
save data/births-per, replace
export excel using "data/births-per", firstrow(variables) replace
export delim using "data/births-per.csv", replace

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
