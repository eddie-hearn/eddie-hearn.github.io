
capture ssc install spmap
capture ssc install shp2dta
capture ssc install mif2dta


capture mkdir ZEMI
capture mkdir ZEMI/REP

cd ZEMI/REP
capture mkdir shape_data
capture mkdir graphs


cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/shape_data/wd.dta shape_data/wd.dta, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/shape_data/wdcoord.dta shape_data/wdcoord.dta, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/shape_data/WB_countries_Admin0_10m.shp shape_data/WB_countries_Admin0_10m.shp, replace
cp https://eddie-hearn.github.io/teaching/CAP/2025/kimiko/shape_data/WB_countries_Admin0_10m.dbf shape_data/WB_countries_Admin0_10m.dbf, replace


cp https://eddie-hearn.github.io/teaching/ZEM/datasets/zem.do zem.do, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/nbi.dta nbi.dta, replace


