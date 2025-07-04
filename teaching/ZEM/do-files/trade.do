

clear

*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   trade.do                                          *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Zem 2025                                          *
*     Input File:  https://eddie-hearn.github.io/                    *
*						teaching/ZEM/data/trade.dta                  *
*     Program:	   Stata 18                                          *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

set scheme s1color 
set more off
clear

quietly capture mkdir trade
if _rc!=0 {
	noisily display "directory already exists"
	}

cd trade
cp "https://eddie-hearn.github.io/teaching/ZEM/data/trade.dta" trade.dta
cp "https://eddie-hearn.github.io/teaching/ZEM/data/trade.do" trade.do

if c(os)=="Windows" {
display "WINDOWS OS detected"
capture winexec explorer.exe covid
}

if c(os)=="MacOSX" {
display "MAC OS detected"
capture winexec open covid
}

if c(os)=="Unix" {
display "LINUX OS detected"
capture winexec xdg-open covid
}


