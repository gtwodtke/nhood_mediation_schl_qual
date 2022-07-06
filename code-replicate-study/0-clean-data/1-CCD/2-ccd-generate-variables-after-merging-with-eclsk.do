/***********************************************
CCD GENERATE VARIABLES AFTER MERGING WITH ECLS-K
***********************************************/

/*

99 <--- CCD 1999-2000
1  <--- CCD 2001-2002
3  <--- CCD 2003-2004
6  <--- CCD 2006-2007

*/

set more off

/*** INPUT DATA ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\4-merged-data-keep-ccd-temp.dta", clear

/*** CREATE SCHOOL RACIAL COMPOSITION VARIABLES ***/

// PERCENT BLACK

foreach i in 99 {
	gen nschblk`i' = BLACK`i'/MEMBER`i'
	replace nschblk`i' = . if (nschblk`i' > -999 & nschblk`i' < 0) | (nschblk`i' > 1 & nschblk`i' < 999)
	label variable nschblk`i' "SCHOOL PERCENT BLACK - 19`i'"
}

foreach i in 1 3 6 {
	gen nschblk0`i' = BLACK0`i'/MEMBER0`i'
	replace nschblk0`i' = . if (nschblk0`i' > -999 & nschblk0`i' < 0) | (nschblk0`i' > 1 & nschblk0`i' < 999)
	label variable nschblk0`i' "SCHOOL PERCENT BLACK - 200`i'"
}

/***PERCENT NON-HISPANIC WHITE***/

foreach i in 99 {
	gen nschwht`i' = WHITE`i'/MEMBER`i'
	replace nschwht`i' = . if (nschwht`i' > -999 & nschwht`i' < 0) | (nschwht`i' > 1 & nschwht`i' < 999)
	label variable nschwht`i' "SCHOOL PERCENT NON-HISPANIC WHITE - 19`i'"
}

foreach i in 1 3 6 {
	gen nschwht0`i' = WHITE0`i'/MEMBER0`i'
	replace nschwht0`i' = . if (nschwht0`i' > -999 & nschwht0`i' < 0) | (nschwht0`i' > 1 & nschwht0`i' < 999)
	label variable nschwht0`i' "SCHOOL PERCENT NON-HISPANIC WHITE - 200`i'"
}

/***PERCENT ASIAN OR PACIFIC ISLANDER***/

foreach i in 99 {
	gen nschasian`i' = ASIAN`i'/MEMBER`i'
	replace nschasian`i' = . if (nschasian`i' > -999 & nschasian`i' < 0) | (nschasian`i' > 1 & nschasian`i' < 999)
	label variable nschasian`i' "SCHOOL PERCENT ASIAN OR PACIFIC ISLANDER - 19`i'"
}

foreach i in 1 3 6 {
	gen nschasian0`i' = ASIAN0`i'/MEMBER0`i'
	replace nschasian0`i' = . if (nschasian0`i' > -999 & nschasian0`i' < 0) | (nschasian0`i' > 1 & nschasian0`i' < 999)
	label variable nschasian0`i' "SCHOOL PERCENT ASIAN OR PACIFIC ISLANDER - 200`i'"
}

/***PERCENT AMERICAN INDIAN OR ALASKA NATIVE***/

foreach i in 99 {
	gen nscham`i' = AM`i'/MEMBER`i'
	replace nscham`i' = . if (nscham`i' > -999 & nscham`i' < 0) | (nscham`i' > 1 & nscham`i' < 999)
	label variable nscham`i' "SCHOOL PERCENT AMERICAN INDIAN OR ALASKA NATIVE - 19`i'"
}

foreach i in 1 3 6 {
	gen nscham0`i' = AM0`i'/MEMBER0`i'
	replace nscham0`i' = . if (nscham0`i' > -999 & nscham0`i' < 0) | (nscham0`i' > 1 & nscham0`i' < 999)
	label variable nscham0`i' "SCHOOL PERCENT AMERICAN INDIAN OR ALASKA NATIVE - 200`i'"
}

/***PERCENT HISPANIC***/

foreach i in 99 {
	gen nschhisp`i' = HISP`i'/MEMBER`i'
	replace nschhisp`i' = . if (nschhisp`i' > -999 & nschhisp`i' < 0) | (nschhisp`i' > 1 & nschhisp`i' < 999)
	label variable nschhisp`i' "SCHOOL PERCENT HISPANIC - 19`i'"
}

foreach i in 1 3 6 {
	gen nschhisp0`i' = HISP0`i'/MEMBER0`i'
	replace nschhisp0`i' = . if (nschhisp0`i' > -999 & nschhisp0`i' < 0) | (nschhisp0`i' > 1 & nschhisp0`i' < 999)
	label variable nschhisp0`i' "SCHOOL PERCENT HISPANIC - 200`i'"
}

/**************************************
CREATE SCHOOL SES COMPOSITION VARIABLES
***************************************/

/***PERCENT ELIGIBLE FOR FREE LUNCH***/

foreach i in 99 {
	gen nschlnch`i' = FRELCH`i'/MEMBER`i'
	replace nschlnch`i' = . if (nschlnch`i' > -999 & nschlnch`i' < 0) | (nschlnch`i' > 1 & nschlnch`i' < 999)
	label variable nschlnch`i' "SCHOOL PERCENT ELIGIBLE FOR FREE LUNCH - 19`i'"
}

foreach i in 1 3 6 {
	gen nschlnch0`i' = FRELCH0`i'/MEMBER0`i'
	replace nschlnch0`i' = . if (nschlnch0`i' > -999 & nschlnch0`i' < 0) | (nschlnch0`i' > 1 & nschlnch0`i' < 999)
	label variable nschlnch0`i' "SCHOOL PERCENT ELIGIBLE FOR FREE LUNCH - 200`i'"
}

/********************************************
CREATE SCHOOL TEACHER-PUPIL RATIO VARIABLES
*********************************************/

/***TEACHER PUPIL RATIO***/

foreach i in 99 {
	gen nschtpr`i' = PUPTCH`i' if PUPTCH`i' > 1 & PUPTCH`i' < 40
	label variable nschtpr`i' "SCHOOL TEACHER-PUPIL RATIO - 19`i'"
}

foreach i in 1 3 6 {
	gen nschtpr0`i' = PUPTCH0`i' if PUPTCH0`i' > 1 & PUPTCH0`i' < 40
	label variable nschtpr0`i' "SCHOOL TEACHER-PUPIL RATIO - 200`i'"
}

/************************************************
CREATE DISTRICT EDUCATIONAL EXPENDITURE VARIABLES
*************************************************/

/***DISTRICT EXPENDITURES PER PUPIL***/

foreach i in 99 {
	gen ndstexp`i' = TCURELSC`i'/DMEMBER`i'
	replace ndstexp`i' = . if ndstexp`i' < 1000 | ndstexp`i' > 20000
	label variable ndstexp`i' "DISTRICT PER PUPIL EXPENDITURE - 19`i'"
}

foreach i in 1 3 6 {
	gen ndstexp0`i' = TCURELSC0`i'/DMEMBER0`i'
	replace ndstexp0`i' = . if ndstexp0`i' < 1000 | ndstexp0`i' > 20000 
	label variable ndstexp0`i' "DISTRICT PER PUPIL EXPENDITURE - 200`i'"
}

/********
SAVE DATA
*********/

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\5-merged-data-keep-ccd.dta", replace
