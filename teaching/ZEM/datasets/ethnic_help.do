
capture mkdir ZEMI
capture mkdir ZEMI/ETHNIC
cd ZEMI/ETHNIC

capture mkdir graphs
capture mkdir HELP

cp https://eddie-hearn.github.io/teaching/ZEM/datasets/zem.do zem.do, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/ethnic_conflict.dta ethnic_conflict.dta, replace

use ethnic_conflict, clear

twoway (scatter duration ethnowar ) (lfit duration ethnowar ), xtitle("Ethnic Conflict") ytitle("Years") title("Ethnic Conflict and Civil War Duration") legend(off)
graph export HELP/my_graph.png, replace
graph close

reg duration ethnowar
etable, title("Ethnic Conflict and Civil War Duration") export(HELP/my_reg.docx, replace)
clear

cls

if c(os)=="Windows" {
	display "Student detected"
	shell attrib +h HELP
	}
else {
	display "Eddie Detected"
	}


