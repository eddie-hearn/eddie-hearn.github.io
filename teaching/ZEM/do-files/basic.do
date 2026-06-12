*** open log file ***
log using basic.log, replace 

*     ***************************************************************** *
*     ***************************************************************** *
*     File-Name:   basic.do                                             *
*     Date:        June 12, 2026                                         *
*     Author:      Eddie Hearn                                          *
*     Purpose:     Seminar                                              *
*     Input File:  none                                                 *
*     Output File: none                                                 *
*     Data Output: none                                                 *
*     Program:	   Stata 18                                             *
*     Machine:     Linux-home                                           *
*     ****************************************************************  *
*     ****************************************************************  *

*** Create a list of juices  ***
local juice "apple orange grape" /* Create a list of juices */

*** Run loop over each type of juice ***
foreach i in `juice' {
    display "`i' juice" 
}

*** Close the log ***
log close
