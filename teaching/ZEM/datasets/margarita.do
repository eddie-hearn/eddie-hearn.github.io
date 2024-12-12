cp https://eddie-hearn.github.io/teaching/ZEM/datasets/econ-dev.csv econ-dev.csv, replace
import delim econ-dev.csv

*** make a list of arab spring countries
local arab "Tunisia Algeria Jordan Oman Saudi Arabia Egypt Syria Yemen Djibouti Sudan Palestine Iraq Bahrain Libya Kuwait Morocco Mauritania"

gen arab_spring = 0
foreach c of local arab{
	replace arab_spring=1 if country=="`c'"
	}

*** Keep if MENA or Arab Spring	
keep if six_regions == "middle_east_north_africa" | arab_spring ==1


*** Make lists of different Arab Spring oputcomes 
local overthrow "Tunisia Egypt Yemen Libya"
local concessions "Jordan Oman Bahrain Kuwait Morocco Lebanon"
local war "Syria"

foreach c of local concessions{
	replace arab_spring=2 if country=="`c'"
	}
	
foreach c of local overthrow{
	replace arab_spring=3 if country=="`c'"
	}

foreach c of local war{
	replace arab_spring=4 if country=="`c'"
	}

tset locationcode year
gen lag_inc= L.inc
gen growth_rate = ((inc-L.inc)/L.inc)*100
drop inc
rename growth_rate inc

preserve
collapse inc , by(year)
save mena.dta, replace
restore

levelsof arab_spring, local(levels)
foreach v of local levels {
	preserve
	collapse inc if arab_spring==`v', by(year)
	rename inc inc_`v'
	save `v'.dta, replace
	restore
	}

clear
use mena
forvalues i = 0/3 {
	merge 1:1 year using `i'
	drop _merge
	save mena, replace
	}

preserve
keep if year >1989

twoway  (line inc_0  year ) (line inc_1 year) (line inc_2 year ) (line inc_3 year), xline(2010) xlabel(1990(2)2022, angle(45)) legend(label( 1 "No Protest") label(2 "Protest") label(3 "Concessions") label(4 "Regime Change")) xtitle("") ytitle("Growth rate (%)") title("Effect of Arab Spring on Economic Growth in Middle East")
graph export margarita.png, replace
