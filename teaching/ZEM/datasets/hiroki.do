
import delim business.csvhttps://www.reed.edu/psychology/stata/gs/tutorials/Zscores.html

twoway  (lfitci bus_score dem_score if year==2019)(scatter bus_score dem_score if year==2019), title("Regime type and Ease of Doing Business in 2019") xtitle("Autocratic              {&hArr}               Democracratic") ytitle("Business score") legend(off)
