*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   Victoria_HELP.do                                  *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Victoria 2025 (HELP           )                   *
*     Input File:  NONE                                              *
*     Outputfile:  see Victoria.do                                   *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

if c(os)=="Windows" {
display "Victoria detected"
}

capture mkdir CAPSTONE_DATA
cd CAPSTONE_DATA
capture mkdir CAPSTONE_DATA/stata
capture mkdir CAPSTONE_DATA/python
capture mkdir CAPSTONE_DATA/stata/graphs
capture mkdir CAPSTONE_DATA/python/graphs

cp https://eddie-hearn.github.io/teaching/CAP/2025/victoria/Victoria.do CAPSTONE_DATA/stata/Victoria.do, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/victoria/results.csv CAPSTONE_DATA/stata/results.csv, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/victoria/results.csv CAPSTONE_DATA/python/results.csv, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/victoria/Victoria.py CAPSTONE_DATA/python/Victoria.py, replace

capture shell pip install pandas seaborn matplotlib statsmodels numpy
capture ssc install catplot

if c(os)=="Windows" {
display "WINDOWS OS detected"
capture winexec explorer.exe CAPSTONE_DATA
}
