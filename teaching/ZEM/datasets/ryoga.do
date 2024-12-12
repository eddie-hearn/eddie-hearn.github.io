
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/terrorism.csv terrorism.csv, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/pol-dev.csv pol-dev.csv, replace 
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/econ-dev.csv econ-dev.csv, replace

import delim pol-dev.csv
save pol-dev.dta, replace
clear

import delim econ-dev.csv
save econ-dev.dta, replace
clear

import delim terrorism.csv

merge m:1 year country using econ-dev
keep if _merge==3
drop _merge

merge m:1 year iso3alphacode using pol-dev

gen date2 = date(date, "DM19Y")

gen date3 = date(date, "DM20Y")

gen yr=year(date2)
gen yr1=year(date3)

replace date2=0 if yr<1968
replace date3=0 if yr>2009

gen date_adj = date2+date3

drop date2 date3 yr yr1 

gen occurred=1
replace democracy=1 if country=="United States"

save terrorism.dta, replace

preserve
keep if democracy==1
collapse injuries fatalities (count) occurred, by(year)
rename injuries dem_injuries
rename fatalities dem_fatalities
rename occurred dem_occurred
save dem-injuries.dta, replace

restore
preserve
keep if democracy==0
collapse injuries fatalities (count) occurred, by(year)
rename injuries aut_injuries
rename fatalities aut_fatalities
rename occurred aut_occurred
save aut-injuries.dta, replace
restore

clear
use dem-injuries

merge 1:1 year using aut-injuries
drop _merge
save injuries.dta, replace

keep if year>1967 & year<2010
twoway ( line dem_injuries year) ( line aut_injuries year), xtitle("") ytitle("Average injuries") title("Injuries per Year by Regime Type") legend( label(1 "Democracies") label(2 "Autocracies"))
graph export injuries.png, replace

twoway ( line dem_fatalities year) ( line aut_fatalities year), xtitle("") ytitle("Average fatalities") title("Fatalities per Year by Regime Type") legend( label(1 "Democracies") label(2 "Autocracies"))
graph export fatalities.png, replace

twoway ( line dem_occurred year) ( line aut_occurred year), xtitle("") ytitle("Incidents") title("Incidents per Year by Regime Type") legend( label(1 "Democracies") label(2 "Autocracies"))
graph export incidents.png, replace

save econ-dev.dta, replace

clear
