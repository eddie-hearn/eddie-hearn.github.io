capture mkdir ZEMI
capture mkdir ZEMI/REP


capture mkdir graphs
capture mkdir HELP

if c(os)=="Windows" {
display "Student detected"
cd ZEMI/EDUC
display "moving to working directory"
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/zem.do zem.do, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/nbi.dta nbi.dta, replace
}
else {
	display "Eddie Detected"
	}


use nbi, clear

twoway (scatter nbi mil ) (lfit  nbi mil), xtitle("Military spending") ytitle("Reputation") title("Military force and Reputation") legend(off)
graph export HELP/my_graph.png, replace
graph close

reg nbi mil 
etable, title("Military force and Reputation") export(HELP/my_reg.docx, replace)
clear

cls


if c(os)=="Windows" {
display "Student detected"
shell attrib +h HELP
}
else {
	display "Eddie Detected"
	}


