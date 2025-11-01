*  ***************************************************************** *
*  ***************************************************************** *
*     File-Name:   KIMIKO_GRAPHS.do                                  *
*     Author:      Eddie Hearn                                       *
*     Purpose:     Kimiko 2025 (example figures)                     *
*     Input File:  KIMIKO_2025.dta,                                  *
*     Outputfile: transparency.png, efficiency.png, scap.png         *
*     Program:	   Stata 19.5                                        *
*     OS:		   Debian GNU/Linux                                  *
*  ****************************************************************  *
*  ****************************************************************  *


use KIMIKO_2025
capture mkdir graphs

*******************
*** Example figures
*******************
spmap transparency using wdcoord,  id(id) fcolor(Blues) legstyle(2) title("Transparency 2021", size(5)) 
graph export graphs/transparency.png, replace

spmap efficiency using wdcoord,  id(id) fcolor(Blues) legstyle(2) title("Efficiency 2021", size(5)) 
graph export graphs/efficiency.png, replace

spmap PCI using wdcoord,  id(id) fcolor(Reds) legstyle(2) title("PCI 2021", size(5)) 
graph export graphs/pci.png, replace

spmap civic_society using wdcoord,  id(id) fcolor(Blues) legstyle(2) title("Social Capital 2021", size(5)) 
graph export graphs/scap.png, replace

