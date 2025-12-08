
capture mkdir ZEMI
capture mkdir ZEMI/UN
cd ZEMI/UN

capture mkdir graphs
capture mkdir HELP

cp https://eddie-hearn.github.io/teaching/ZEM/datasets/zem.do zem.do, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/all_collapsed.dta all_collapsed.dta, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/us_speeches.dta us_speeches.dta, replace

use all_collapsed, clear

twoway (scatter neg US_share ) (lfit  neg US_share), xtitle("US Share of Global GDP") ytitle("Negative Speech") title("US Hegemony and Cooperation") legend(off)
graph export HELP/all_graph.png, replace
graph close

reg neg US_share 
etable, title("US Hegemony and Cooperation") export(HELP/all_reg.docx, replace)
clear

use us_speeches, clear

twoway (scatter neg US_share ) (lfit  neg US_share), xtitle("US Share of Global GDP") ytitle("Negative Speech") title("US Hegemony and Cooperation") legend(off)
graph export HELP/us_graph.png, replace
graph close

reg neg US_share 
etable, title("US Hegemony and Cooperation") export(HELP/us_reg.docx, replace)
clear

cls

if c(os)=="Windows" {
	display "Student detected"
	shell attrib +h HELP
	}
else {
	display "Eddie Detected"
	}


