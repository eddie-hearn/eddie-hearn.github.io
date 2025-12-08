capture mkdir ZEMI
capture mkdir ZEMI/IMMIG


capture mkdir graphs
capture mkdir HELP

if c(os)=="Windows" {
display "Student detected"
cd ZEMI/EDUC
display "moving to working directory"
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/zem.do zem.do, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/immig.dta immig.dta, replace
}
else {
	display "Eddie Detected"
	}


use immig, clear

twoway (scatter growthpc impc ) (lfit growthpc impc ), xtitle("Immigrants per capita") ytitle("GDP gropwth Percapita") title("Economic growth and Immigration") legend(off)
graph export HELP/my_graph.png, replace
graph close

reg growthpc impc 
etable, title("Economic growth and Immigration") export(HELP/my_reg.docx, replace)
clear

cls


if c(os)=="Windows" {
display "Student detected"
shell attrib +h HELP
}
else {
	display "Eddie Detected"
	}


