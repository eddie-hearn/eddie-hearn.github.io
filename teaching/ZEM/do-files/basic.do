
log using basic.log, replace 

*     ***************************************************************** *
*     ***************************************************************** *
*     File-Name:   basic.do                                             *
*     Date:        May 31, 2024                                         *
*     Author:      Eddie Hearn                                          *
*     Purpose:     Seminar                                              *
*     Input File:  none                                                 *
*     Output File: none                                                 *
*     Data Output: none                                                 *
*     Program:	   Stata 18                                             *
*     Machine:     Linux-home                                           *
*     ****************************************************************  *
*     ****************************************************************  *

 local juice "apple orange grape" /* Create a list of juices */

*** Run loop over each type of juice ***

foreach i in `juice' {
    display "`i' juice" // here is another example of a comment
}

display /// if you wanted to make a comment and join the next line with this one
"here is a comment"
    

log close
