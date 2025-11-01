*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   KIMIKO_GRAPHS.do                                  *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Kimiko 2025 (example figures)                     *
*     Input File:  KIMIKO_2025.dta,WB_countries_Admin0_10m.shp,      *
*                  wdcoord.dta,  wd.dta                              *                                               
*     Outputfile: transparency.png, efficiency.png, scap.png         *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *

use KIMIKO_2025
capture mkdir graphs

preserve

**********
****add shape information 
**********

cd shape_data
shp2dta using WB_countries_Admin0_10m, database(wd) coordinates(wdcoord) genid(id) genc(c) replace
use wd, clear
merge m:1 ISO_A3 using ../KIMIKO_2025

*******************
*** Example figures
*******************
spmap transparency using wdcoord,  id(id) fcolor(Blues) legstyle(2) title("Transparency 2021", size(5)) 
graph export ../graphs/transparency.png, replace

spmap efficiency using wdcoord,  id(id) fcolor(Blues) legstyle(2) title("Efficiency 2021", size(5)) 
graph export ../graphs/efficiency.png, replace

spmap PCI using wdcoord,  id(id) fcolor(Reds) legstyle(2) title("PCI 2021", size(5)) 
graph export ../graphs/pci.png, replace

spmap civic_society using wdcoord,  id(id) fcolor(Blues) legstyle(2) title("Social Capital 2021", size(5)) 
graph export ../graphs/scap.png, replace

cd ..
restore
