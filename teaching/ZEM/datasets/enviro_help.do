capture mkdir ZEMI
capture mkdir ZEMI/ENVIRO


capture mkdir graphs
capture mkdir HELP

if c(os)=="Windows" {
display "Student detected"
cd ZEMI/EDUC
display "moving to working directory"
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/zem.do zem.do, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/enviro.dta enviro.dta, replace
}
else {
	display "Eddie Detected"
	}


use enviro, clear

twoway (scatter pccbco2 gdppc) (lfit pccbco2 gdppc), xtitle("GDP per capita") ytitle("CO2") title("Environment and Wealth") legend(off)
graph export HELP/my_graph.png, replace
graph close

reg pccbco2 gdppc
etable, title("Environment and Wealth") export(HELP/my_reg.docx, replace)

reg pccbco2 gdppc gdp2
predict Y
etable, title("Kuznets Curve") export(HELP/kuznets.docx, replace)
twoway (scatter pccbco2 gdppc)(scatter Y gdppc), xtitle("GDP per capita") ytitle("CO2") title("Kuznets Curve") legend(off)
graph export HELP/kuznets.png, replace
graph close

clear

cls


if c(os)=="Windows" {
display "Student detected"
shell attrib +h HELP
}
else {
	display "Eddie Detected"
	}

