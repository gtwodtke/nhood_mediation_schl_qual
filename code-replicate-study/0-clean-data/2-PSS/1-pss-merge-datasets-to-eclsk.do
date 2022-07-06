log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\0-clean-data\5-pss-merge.log", replace

/***************************
MERGE PSS DATASETS TO ECLS-K
***************************/

/*

This step assumes that the user has access to the relevant public PSS files. 
These files can be downloaded for SAS/SPSS format from the NCES website from the 
link: https://nces.ed.gov/surveys/pss/pssdata.asp Once read into SPSS, the user 
can subsequently output the data in Stata format from there. 

*/

/*

Years
	ECLS-K
		Fall 1998 	(Kindergarten)
		Spring 1999 (Kindergarten)
		Fall 1999 	(1st Grade)		---> R3CCDLEA R3CCDSID R3SCHPIN R3STSID
		Spring 2000 (1st Grade)		---> R4CCDLEA R4CCDSID R4SCHPIN R4STSID
		Spring 2002 (3rd Grade)		---> R5CCDLEA R5CCDSID R5SCHPIN R5STSID
		Spring 2004 (5th Grade)		---> R6CCDLEA R6CCDSID R6SCHPIN R6STSID
		Spring 2007 (8th Grade)		---> R7CCDLEA R7CCDSID R7SCHPIN R7STSID
	PSS
		1997-1998
		1999-2000					<--- R3, R4
		2001-2002					<--- R5
		2003-2004					<--- R6
		2005-2006					<--- R7(1)
		2007-2008					<--- R7(2)

*/

/* 1999-2000 */

// R3
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_9900_from_spss.dta", clear
keep spin p310 p315 p320 p325 p330 numstuds numteach
rename spin rpin
rename p310 am99
rename p315 asian99
rename p320 hisp99
rename p325 black99
rename p330 white99
rename numstuds member99
rename numteach fte99
rename rpin R3SCHPIN
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_9900_from_spss_r3.dta", replace

// R4
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_9900_from_spss.dta", clear
keep spin p310 p315 p320 p325 p330 numstuds numteach
rename spin rpin
rename p310 am99
rename p315 asian99
rename p320 hisp99
rename p325 black99
rename p330 white99
rename numstuds member99
rename numteach fte99
rename rpin R4SCHPIN
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_9900_from_spss_r4.dta", replace

/* 2001-2002 */

// R5
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0102_from_spss.dta", clear
keep ppin p310 p315 p320 p325 p330 numstuds numteach
rename ppin rpin
rename p310 am01
rename p315 asian01
rename p320 hisp01
rename p325 black01
rename p330 white01
rename numstuds member01
rename numteach fte01
rename rpin R5SCHPIN
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0102_from_spss_r5.dta", replace

/* 2003-2004 */

// R6
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0304_from_spss.dta", clear
keep ppin p310 p315 p320 p325 p330 numstuds numteach
rename ppin rpin
rename p310 am03
rename p315 asian03
rename p320 hisp03
rename p325 black03
rename p330 white03
rename numstuds member03
rename numteach fte03
rename rpin R6SCHPIN
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0304_from_spss_r6.dta", replace

/* 2005-2006 */

// R7(1)
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0506_from_spss.dta", clear
keep ppin p310 p315 p320 p325 p330 numstuds numteach
rename ppin rpin
rename p310 am05
rename p315 asian05
rename p320 hisp05
rename p325 black05
rename p330 white05
rename numstuds member05
rename numteach fte05
rename rpin R7SCHPIN
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0506_from_spss_r71.dta", replace

/* 2007-2008 */

// R7(2)
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0708_from_spss.dta", clear
keep ppin p310 p315 p320 p325 p330 numstuds numteach
rename ppin rpin
rename p310 am07
rename p315 asian07
rename p320 hisp07
rename p325 black07
rename p330 white07
rename numstuds member07
rename numteach fte07
rename rpin R7SCHPIN
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0708_from_spss_r72.dta", replace

/* 2006-2007 */

// R7
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0506_from_spss_r71.dta", clear
merge 1:1 R7SCHPIN using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0708_from_spss_r72.dta"
drop _merge
gen am06 = (am07 + am05)/2
gen asian06 = (asian07 + asian05)/2
gen hisp06 = (hisp07 + hisp05)/2
gen black06 = (black07 + black05)/2
gen white06 = (white07 + white05)/2
gen member06 = (member07 + member05)/2
gen fte06 = (fte07 + fte05)/2
drop am07 am05 asian07 asian05 hisp07 hisp05 black07 black05 white07 white05 member07 member05 fte07 fte05
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0607_from_spss_r7.dta", replace

/* Merge */

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\5-merged-data-keep-ccd.dta", clear

merge m:1 R3SCHPIN using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_9900_from_spss_r3.dta"
drop if _merge == 2
drop _merge
merge m:1 R4SCHPIN using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_9900_from_spss_r4.dta"
drop if _merge == 2
drop _merge
merge m:1 R5SCHPIN using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0102_from_spss_r5.dta"
drop if _merge == 2
drop _merge
merge m:1 R6SCHPIN using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0304_from_spss_r6.dta"
drop if _merge == 2
drop _merge
merge m:1 R7SCHPIN using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0607_from_spss_r7.dta"
drop if _merge == 2
drop _merge

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\6-merged-data-keep-ccd-pss-temp.dta", replace

erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_9900_from_spss_r3.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_9900_from_spss_r4.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0102_from_spss_r5.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0304_from_spss_r6.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0506_from_spss_r71.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0708_from_spss_r72.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\PSS\Individual waves\pss_0607_from_spss_r7.dta"

log close
