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
cd CAPSTONE_DATA
capture mkdir shape_data
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/KIMIKO_DATA.do KIMIKO_DATA.do, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/KIMIKO_GRAPHS.do KIMIKO_GRAPHS.do, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/KIMIKO_2025.dta KIMIKO_2025.dta, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/shape_data/wd.dta shape_data/wd.dta, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/shape_data/wdcoord.dta shape_data/wdcoord.dta, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/shape_data/WB_countries_Admin0_10m.shp shape_data/WB_countries_Admin0_10m.shp, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/shape_data/WB_countries_Admin0_10m.dbf shape_data/WB_countries_Admin0_10m.dbf, replace


capture ssc install spmap
capture ssc install shp2dta
capture ssc install mif2dta

do KIMIKO_GRAPHS
cd ..

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

