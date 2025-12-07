
capture mkdir ZEMI
capture mkdir ZEMI/EDUC


capture mkdir graphs
capture mkdir HELP

if c(os)=="Windows" {
display "Student detected"
cd ZEMI/EDUC
display "moving to working directory"
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/zem.do zem.do, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/educ.dta educ.dta, replace
}
else {
	display "Eddie Detected"
	}


use educ, clear

twoway (scatter gdppc literacy) (lfit gdppc literacy), xtitle("GDP per capita") ytitle("Literacy") title("Literacy and Economic Growth")
graph export HELP/my_graph.png, replace
graph close

reg gdppc literacy
etable, title("GDP Percapita vs literacy") export(my_reg.docx, replace)

clear

cls


if c(os)=="Windows" {
display "Student detected"
shell attrib +h HELP
}
else {
	display "Eddie Detected"
	}

