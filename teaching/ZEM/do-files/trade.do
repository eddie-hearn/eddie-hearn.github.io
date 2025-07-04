

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

cp "https://eddie-hearn.github.io/teaching/ZEM/data/trade.dta" trade/trade.dta
cp "https://eddie-hearn.github.io/teaching/ZEM/do-files/trade.do" trade/trade.do

if c(os)=="Windows" {
display "WINDOWS OS detected"
capture winexec explorer.exe trade
}

if c(os)=="MacOSX" {
display "MAC OS detected"
capture winexec open trade
}

if c(os)=="Unix" {
display "LINUX OS detected"
capture winexec xdg-open trade
}

cd trade
display "folder should open - if not check your working directory and find the folder"
display "to use data type: use trade"
