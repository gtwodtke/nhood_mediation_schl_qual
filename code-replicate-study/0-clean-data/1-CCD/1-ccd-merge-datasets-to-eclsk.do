log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\0-clean-data\4-ccd-merge.log", replace

/***************************
MERGE CCD DATASETS TO ECLS-K
***************************/

/*

This step assumes that the user has access to the relevant public CCD files. 
These files can be downloaded for SAS/SPSS format from the NCES website from the 
link: https://nces.ed.gov/ccd/ccddata.asp Once read into SPSS, the user can
subsequently output the data in Stata format from there. 

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
	CCD
		1997-1998
		1998-1999
		1999-2000					<--- R3, R4
		2000-2001
		2001-2002					<--- R5
		2002-2003
		2003-2004					<--- R6
		2004-2005
		2005-2006
		2006-2007					<--- R7

*/

/***** CCD School Datasets *****/

/* 1999-2000 */

// R3
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_9900_from_spss.dta", clear
keep NCESSCH LEAID SCHNO STATUS99 FTE99 MEMBER99 FRELCH99 REDLCH99 TOTFRL99 AM99 ASIAN99 HISP99 BLACK99 WHITE99 PUPTCH99 CHARTR99 MAGNET99
rename NCESSCH R3CCDSID
rename LEAID R3CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_9900_from_spss_r3.dta", replace

// R4
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_9900_from_spss.dta", clear
keep NCESSCH LEAID SCHNO STATUS99 FTE99 MEMBER99 FRELCH99 REDLCH99 TOTFRL99 AM99 ASIAN99 HISP99 BLACK99 WHITE99 PUPTCH99
rename NCESSCH R4CCDSID
rename LEAID R4CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_9900_from_spss_r4.dta", replace

/* 2001-2002 */

// R5
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0102_from_spss.dta", clear
keep NCESSCH LEAID SCHNO STATUS01 FTE01 MEMBER01 FRELCH01 REDLCH01 TOTFRL01 AM01 ASIAN01 HISP01 BLACK01 WHITE01 PUPTCH01
rename NCESSCH R5CCDSID
rename LEAID R5CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0102_from_spss_r5.dta", replace

/* 2003-2004 */

// R6
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0304_from_spss.dta", clear
keep NCESSCH LEAID SCHNO STATUS03 FTE03 MEMBER03 FRELCH03 REDLCH03 TOTFRL03 AM03 ASIAN03 HISP03 BLACK03 WHITE03 PUPTCH03
rename NCESSCH R6CCDSID
rename LEAID R6CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0304_from_spss_r6.dta", replace

/* 2006-2007 */

// R7
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0607_from_spss.dta", clear
keep NCESSCH LEAID SCHNO STATUS06 FTE06 MEMBER06 FRELCH06 REDLCH06 TOTFRL06 AM06 ASIAN06 HISP06 BLACK06 WHITE06 PUPTCH06
rename NCESSCH R7CCDSID
rename LEAID R7CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0607_from_spss_r7.dta", replace

/***** CCD District Datasets *****/

/* 1999-2000 */

// R3
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_9900_from_spss.dta", clear
keep LEAID V33 TOTALEXP TCURELSC TCURINST TCURSSVC TCUROTH TNONELSE TCAPOUT Z32 Z33 Z34
rename V33 DMEMBER99
rename TOTALEXP TOTALEXP99
rename TCURELSC TCURELSC99
rename TCURINST TCURINST99
rename TCURSSVC TCURSSVC99
rename TCUROTH TCUROTH99
rename TNONELSE TNONELSE99
rename TCAPOUT TCAPOUT99
rename Z32 TSALARY99
rename Z33 SALINST99
rename Z34 TEMPBEN99
drop if LEAID==" " | LEAID=="N"
rename LEAID R3CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_9900_from_spss_r3.dta", replace

// R4
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_9900_from_spss.dta", clear
keep LEAID V33 TOTALEXP TCURELSC TCURINST TCURSSVC TCUROTH TNONELSE TCAPOUT Z32 Z33 Z34
rename V33 DMEMBER99
rename TOTALEXP TOTALEXP99
rename TCURELSC TCURELSC99
rename TCURINST TCURINST99
rename TCURSSVC TCURSSVC99
rename TCUROTH TCUROTH99
rename TNONELSE TNONELSE99
rename TCAPOUT TCAPOUT99
rename Z32 TSALARY99
rename Z33 SALINST99
rename Z34 TEMPBEN99
drop if LEAID==" " | LEAID=="N"
rename LEAID R4CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_9900_from_spss_r4.dta", replace

/* 2001-2002 */

// R5
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0102_from_spss.dta", clear
keep LEAID V33 TOTALEXP TCURELSC TCURINST TCURSSVC TCUROTH TNONELSE TCAPOUT Z32 Z33 Z34
rename V33 DMEMBER01
rename TOTALEXP TOTALEXP01
rename TCURELSC TCURELSC01
rename TCURINST TCURINST01
rename TCURSSVC TCURSSVC01
rename TCUROTH TCUROTH01
rename TNONELSE TNONELSE01
rename TCAPOUT TCAPOUT01
rename Z32 TSALARY01
rename Z33 SALINST01
rename Z34 TEMPBEN01
drop if LEAID==" " | LEAID=="N"
rename LEAID R5CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0102_from_spss_r5.dta", replace

/* 2003-2004 */

// R6
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0304_from_spss.dta", clear
keep LEAID V33 TOTALEXP TCURELSC TCURINST TCURSSVC TCUROTH TNONELSE TCAPOUT Z32 Z33 Z34
rename V33 DMEMBER03
rename TOTALEXP TOTALEXP03
rename TCURELSC TCURELSC03
rename TCURINST TCURINST03
rename TCURSSVC TCURSSVC03
rename TCUROTH TCUROTH03
rename TNONELSE TNONELSE03
rename TCAPOUT TCAPOUT03
rename Z32 TSALARY03
rename Z33 SALINST03
rename Z34 TEMPBEN03
drop if LEAID==" " | LEAID=="N"
rename LEAID R6CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0304_from_spss_r6.dta", replace

/* 2006-2007 */

// R7
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0607_from_spss.dta", clear
keep LEAID V33 TOTALEXP TCURELSC TCURINST TCURSSVC TCUROTH TNONELSE TCAPOUT Z32 Z33 Z34
rename V33 DMEMBER06
rename TOTALEXP TOTALEXP06
rename TCURELSC TCURELSC06
rename TCURINST TCURINST06
rename TCURSSVC TCURSSVC06
rename TCUROTH TCUROTH06
rename TNONELSE TNONELSE06
rename TCAPOUT TCAPOUT06
rename Z32 TSALARY06
rename Z33 SALINST06
rename Z34 TEMPBEN06
drop if LEAID==" " | LEAID=="N"
rename LEAID R7CCDLEA
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0607_from_spss_r7.dta", replace

/* Merge */

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\3-merged-data-keep.dta", clear

/* Merge CCD School Datasets to ECLS-K */

merge m:1 R3CCDSID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_9900_from_spss_r3.dta"
drop if _merge == 2
drop _merge
merge m:1 R4CCDSID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_9900_from_spss_r4.dta"
drop if _merge == 2
drop _merge
merge m:1 R5CCDSID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0102_from_spss_r5.dta"
drop if _merge == 2
drop _merge
merge m:1 R6CCDSID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0304_from_spss_r6.dta"
drop if _merge == 2
drop _merge
merge m:1 R7CCDSID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0607_from_spss_r7.dta"
drop if _merge == 2
drop _merge

erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_9900_from_spss_r3.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_9900_from_spss_r4.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0102_from_spss_r5.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0304_from_spss_r6.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_School\ccd_0607_from_spss_r7.dta"

/* Merge CCD School Datasets to ECLS-K */

merge m:1 R3CCDLEA using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_9900_from_spss_r3.dta"
drop if _merge == 2
drop _merge
merge m:1 R4CCDLEA using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_9900_from_spss_r4.dta"
drop if _merge == 2
drop _merge
merge m:1 R5CCDLEA using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0102_from_spss_r5.dta"
drop if _merge == 2
drop _merge
merge m:1 R6CCDLEA using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0304_from_spss_r6.dta"
drop if _merge == 2
drop _merge
merge m:1 R7CCDLEA using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0607_from_spss_r7.dta"
drop if _merge == 2
drop _merge

erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_9900_from_spss_r3.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_9900_from_spss_r4.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0102_from_spss_r5.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0304_from_spss_r6.dta"
erase "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\CCD\Individual waves\CCD_District\ccd_finance_0607_from_spss_r7.dta"


/*** 11.11.21 KW WORK FOR R&R: CREATE SCHOOL TYPE VARIABLES & TABULATE FOR 1ST GRADE SCHOOL ***/

// INDICATOR FOR # OF SCHOOLS 
sort S4_ID
by S4_ID: gen schl_num = 1 if _n == 1
replace schl_num = . if S4_ID == "" 

// ECLS-K SCHOOL TYPE 
** Tabulation for # of students 
tab S4SCTYP, mi

** Tabulation for # of schools 
tab S4SCTYP if schl_num == 1, mi

// CCD MAGNET SCHOOL INDICATOR
replace MAGNET99 = "" if MAGNET99 == "M" | MAGNET99 == "N" 
destring MAGNET99, replace
replace MAGNET99 = 0 if MAGNET99 == 2
label define yes1 0 "No" 1 "Yes" 
label values MAGNET99 yes1

** Tabulate for # of students if a public school
tab MAGNET99 if S4SCTYP == 4, mi

** Tabulate for # of schools if a public school
tab MAGNET99 if S4SCTYP == 4 & schl_num == 1, mi

// CCD CHARTER SCHOOL 
replace CHARTR99 = "" if CHARTR99 == "M" | CHARTR99 == "N"
destring CHARTR99, replace 
replace CHARTR99 = 0 if CHARTR99 == 2
label values CHARTR99 yes1 

** Tabulate for # of students if a public school
tab CHARTR99 if S4SCTYP == 4, mi

** Tabulate for # of schools if a public school
tab CHARTR99 if S4SCTYP == 4 & schl_num == 1, mi

// DROP CHARTER, MAGNET, AND SCHOOL # VARS 
drop CHARTR99 MAGNET99 schl_num



/* Save */

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\4-merged-data-keep-ccd-temp.dta", replace

log close
