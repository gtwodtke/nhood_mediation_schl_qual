#delimit cr
capture log close 
capture clear all 

global data_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\" 
global log_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\5-eclsk11-analyses\" 

log using "${log_directory}3-create-eclsk11v3.log", replace 

/******************************************************************
PROGRAM NAME: 3-create-eclsk11v3.do
AUTHOR: KW
PURPOSE: Clean and merge CCD and PSS data with ECLSK11v2 file and 
create the per pupil measures
NOTES: GW revised on 11/19/2021
*******************************************************************/

/********************************************************
CLEAN CCD NON-FISCAL YEARS SCHOOL-LEVEL DATA ACROSS YEARS   
*********************************************************/
* Save ccd_s_1
use "${data_directory}ccd\school_level\ccd_s_1011.dta"
rename *, lower
keep ncessch kg member 
replace kg = . if kg == -2 | kg == -9 | kg == -1
replace member = . if member == -2 | member == -9 | member == -1
rename kg ccd_schl_kenr1
rename member ccd_schl_enr1
rename ncessch f1ccdsid
label variable ccd_schl_kenr1 "CCD Total number of school Kindergarten students, Fall 2010"
label variable ccd_schl_enr1 "CCD Total number of school students, Fall 2010"
save "${data_directory}ccd\school_level\ccd_s_1.dta", replace
clear

* Save ccd_s_2
use "${data_directory}ccd\school_level\ccd_s_1011.dta"
rename *, lower
keep ncessch kg member 
replace kg = . if kg == -2 | kg == -9 | kg == -1
replace member = . if member == -2 | member == -9 | member == -1
rename kg ccd_schl_kenr2
rename member ccd_schl_enr2
rename ncessch f2ccdsid
label variable ccd_schl_kenr2 "CCD Total number of school Kindergarten students, Spring 2011"
label variable ccd_schl_enr2 "CCD Total number of school students, Spring 2011"
save "${data_directory}ccd\school_level\ccd_s_2.dta", replace
clear

* Save ccd_s_3
use "${data_directory}ccd\school_level\ccd_s_1112.dta"
rename *, lower
keep ncessch g01 member 
replace g01 = . if g01 == -2 | g01 == -9 | g01 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g01 ccd_schl_1enr3
rename member ccd_schl_enr3
rename ncessch f3ccdsid
label variable ccd_schl_1enr3 "CCD Total number of school 1st grade students, Fall 2011"
label variable ccd_schl_enr3 "CCD Total number of school students, Fall 2011"
save "${data_directory}ccd\school_level\ccd_s_3.dta", replace
clear

* Save ccd_s_4
use "${data_directory}ccd\school_level\ccd_s_1112.dta"
rename *, lower
keep ncessch g01 member 
replace g01 = . if g01 == -2 | g01 == -9 | g01 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g01 ccd_schl_1enr4
rename member ccd_schl_enr4
rename ncessch f4ccdsid
label variable ccd_schl_1enr4 "CCD Total number of school 1st grade students, Spring 2012"
label variable ccd_schl_enr4 "CCD Total number of school students, Spring 2012"
save "${data_directory}ccd\school_level\ccd_s_4.dta", replace
clear

* Save ccd_s_5
use "${data_directory}ccd\school_level\ccd_s_1213.dta"
rename *, lower
keep ncessch g02 member 
replace g02 = . if g02 == -2 | g02 == -9 | g02 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g02 ccd_schl_2enr5
rename member ccd_schl_enr5
rename ncessch f5ccdsid
label variable ccd_schl_2enr5 "CCD Total number of school 2nd grade students, Fall 2012"
label variable ccd_schl_enr5 "CCD Total number of school students, Fall 2012"
save "${data_directory}ccd\school_level\ccd_s_5.dta", replace
clear

* Save ccd_s_6
use "${data_directory}ccd\school_level\ccd_s_1213.dta"
rename *, lower
keep ncessch g02 member 
replace g02 = . if g02 == -2 | g02 == -9 | g02 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g02 ccd_schl_2enr6
rename member ccd_schl_enr6
rename ncessch f6ccdsid
label variable ccd_schl_2enr6 "CCD Total number of school 2nd grade students, Spring 2013"
label variable ccd_schl_enr6 "CCD Total number of school students, Spring 2013"
save "${data_directory}ccd\school_level\ccd_s_6.dta", replace
clear

* Save ccd_s_7
use "${data_directory}ccd\school_level\ccd_s_1314.dta"
rename *, lower
keep ncessch g03 member 
replace g03 = . if g03 == -2 | g03 == -9 | g03 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g03 ccd_schl_3enr7
rename member ccd_schl_enr7
rename ncessch f7ccdsid
label variable ccd_schl_3enr7 "CCD Total number of school 3nd grade students, Spring 2014"
label variable ccd_schl_enr7 "CCD Total number of school students, Spring 2014"
save "${data_directory}ccd\school_level\ccd_s_7.dta", replace
clear

* Save ccd_s_8
use "${data_directory}ccd\school_level\ccd_s_1415.dta"
rename *, lower
keep ncessch g04 member 
replace g04 = . if g04 == -2 | g04 == -9 | g04 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g04 ccd_schl_4enr8
rename member ccd_schl_enr8
rename ncessch f8ccdsid
label variable ccd_schl_4enr8 "CCD Total number of school 4th grade students, Spring 2015"
label variable ccd_schl_enr8 "CCD Total number of school students, Spring 2015"
save "${data_directory}ccd\school_level\ccd_s_8.dta", replace
clear

* Save ccd_s_9
use "${data_directory}ccd\school_level\ccd_s_1516.dta"
rename *, lower
keep ncessch g05 member 
replace g05 = . if g05 == -2 | g05 == -9 | g05 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g05 ccd_schl_5enr9
rename member ccd_schl_enr9
rename ncessch f9ccdsid
label variable ccd_schl_5enr9 "CCD Total number of school 5th grade students, Spring 2016"
label variable ccd_schl_enr9 "CCD Total number of school students, Spring 2016"
save "${data_directory}ccd\school_level\ccd_s_9.dta", replace
clear

/********************************************************
CLEAN PSS NON-FISCAL YEARS SCHOOL-LEVEL DATA ACROSS YEARS   
*********************************************************/
* Clean pss0910 to use to interpolate for real pss_s_1
use "${data_directory}pss\pss0910.dta"
keep ppin P160 P305
rename ppin fschpin
rename P160 pss_schl_kenr1
rename P305 pss_schl_enr1
label variable pss_schl_kenr1 "PSS Total number of school 1st grade students, Fall 2010"
label variable pss_schl_enr1 "PSS Total number of school students, Fall 2010"
save "${data_directory}pss\pss_s_1.dta", replace
clear

* Clean pss0910 for pss_s_2
use "${data_directory}pss\pss0910.dta"
keep ppin P160 P305
rename ppin fschpin
rename P160 pss_schl_kenr2
rename P305 pss_schl_enr2
label variable pss_schl_kenr2 "PSS Total number of school 1st grade students, Spring 2011"
label variable pss_schl_enr2 "PSS Total number of school students, Spring 2011"
save "${data_directory}pss\pss_s_2.dta", replace
clear

* Save pss_s_3
use "${data_directory}pss\pss1112.dta"
keep ppin p190 p305 p160 
rename ppin fschpin
rename p190 pss_schl_1enr3
rename p305 pss_schl_enr3
rename p160 pss_schl_kenr3
label variable pss_schl_1enr3 "PSS Total number of school 1st grade students, Fall 2011"
label variable pss_schl_enr3 "PSS Total number of school students, Fall 2011"
label variable pss_schl_kenr3 "PSS Total number of school K students, Fall 2011"
save "${data_directory}pss\pss_s_3.dta", replace
clear

* Save pss_s_4
use "${data_directory}pss\pss1112.dta"
keep ppin p190 p305 p200
rename ppin fschpin
rename p190 pss_schl_1enr4
rename p305 pss_schl_enr4
rename p200 pss_schl_2enr4
label variable pss_schl_1enr4 "PSS Total number of school 1st grade students, Spring 2012"
label variable pss_schl_enr4 "PSS Total number of school students, Spring 2012"
label variable pss_schl_2enr4 "PSS Total number of school 2rd grade students, Spring 2012"
save "${data_directory}pss\pss_s_4.dta", replace
clear

* Save pss_s_7
use "${data_directory}pss\pss1314.dta"
rename *, lower
keep ppin p210 p305 p200 p220
rename ppin fschpin
rename p210 pss_schl_3enr7
rename p305 pss_schl_enr7
rename p200 pss_schl_2enr7
rename p220 pss_schl_4enr7
label variable pss_schl_3enr7 "PSS Total number of school 3rd grade students, Spring 2014"
label variable pss_schl_enr7 "PSS Total number of school students, Spring 2014"
label variable pss_schl_2enr7 "PSS Total number of 2nd grade students, Spring 2014"
label variable pss_schl_4enr7 "PSS Total number of 2nd grade students, Spring 2014"
save "${data_directory}pss\pss_s_7.dta", replace
clear

* Save pss_s_9
use "${data_directory}pss\pss1516.dta"
keep ppin p230 p305 p220
rename ppin fschpin
rename p230 pss_schl_5enr9
rename p305 pss_schl_enr9
rename p220 pss_schl_4enr9
label variable pss_schl_5enr9 "PSS Total number of school 5th grade students, Spring 2016"
label variable pss_schl_enr9 "PSS Total number of school students, Spring 2016"
label variable pss_schl_4enr9 "PSS Total number of 4th grade students, Spring 2016"
save "${data_directory}pss\pss_s_9.dta", replace
clear

/* Merge these PSS datasets together to interpolate for W1, W2, W5, and W8 measures */ 
use "${data_directory}pss\pss_s_1.dta"
merge 1:1 fschpin using "${data_directory}pss\pss_s_2.dta"
drop _merge 
merge 1:1 fschpin using "${data_directory}pss\pss_s_3.dta"
drop _merge
merge 1:1 fschpin using "${data_directory}pss\pss_s_4.dta"
drop _merge
merge 1:1 fschpin using "${data_directory}pss\pss_s_7.dta"
drop _merge
merge 1:1 fschpin using "${data_directory}pss\pss_s_9.dta"
drop _merge
save "${data_directory}pss\pss_s_m.dta", replace

/* Interpolate PSS measures for W1, W2, W5, and W8 measures and save new pss_s_x datasets */
** W1 measures 
replace pss_schl_kenr1 = (pss_schl_kenr1+pss_schl_kenr3)/2
replace pss_schl_enr1 = (pss_schl_enr1+pss_schl_enr3)/2
keep fschpin pss_schl_kenr1 pss_schl_enr1
save "${data_directory}pss\pss_s_1.dta", replace
clear

** W2 measures 
use "${data_directory}pss\pss_s_m.dta"
replace pss_schl_kenr2 = (pss_schl_kenr2+pss_schl_kenr3)/2
replace pss_schl_enr2 = (pss_schl_enr2+pss_schl_enr3)/2
keep fschpin pss_schl_kenr2 pss_schl_enr2
save "${data_directory}pss\pss_s_2.dta", replace
clear

** W5 measures 
use "${data_directory}pss\pss_s_m.dta"
gen pss_schl_2enr5 = . 
replace pss_schl_2enr5 = (pss_schl_2enr4+pss_schl_2enr7)/2
gen pss_schl_enr5 = . 
replace pss_schl_enr5 = (pss_schl_enr4+pss_schl_enr7)/2
keep fschpin pss_schl_2enr5 pss_schl_enr5 
label variable pss_schl_2enr5 "PSS Total number of school 2nd grade students, Fall 2012"
label variable pss_schl_enr5 "PSS Total number of school students, Fall 2012"
save "${data_directory}pss\pss_s_5.dta", replace
clear

** W6 measures 
use "${data_directory}pss\pss_s_m.dta"
gen pss_schl_2enr6 = . 
replace pss_schl_2enr6 = (pss_schl_2enr4+pss_schl_2enr7)/2
gen pss_schl_enr6 = . 
replace pss_schl_enr6 = (pss_schl_enr4+pss_schl_enr7)/2
label variable pss_schl_2enr6 "PSS Total number of school 2nd grade students, Spring 2013"
label variable pss_schl_enr6 "PSS Total number of school students, Spring 2013"
keep fschpin pss_schl_2enr6 pss_schl_enr6 
save "${data_directory}pss\pss_s_6.dta", replace
clear

** W8 measures 
use "${data_directory}pss\pss_s_m.dta"
gen pss_schl_4enr8 = .
replace pss_schl_4enr8 = (pss_schl_4enr7+pss_schl_4enr9)/2
gen pss_schl_enr8 = .
replace pss_schl_enr8 = (pss_schl_enr7+pss_schl_enr9)/2
label variable pss_schl_4enr8 "PSS Total number of school 4th grade students, Spring 2015"
label variable pss_schl_enr8 "PSS Total number of school students, Spring 2015"
keep fschpin pss_schl_4enr8 pss_schl_enr8 
save "${data_directory}pss\pss_s_8.dta", replace
clear

/* Go back to each pss_s_x dataset and rename the ID tomerge with ECLS-K */ 
use "${data_directory}pss\pss_s_1.dta"
rename fschpin f1schpin
save "${data_directory}pss\pss_s_1.dta", replace
clear

use "${data_directory}pss\pss_s_2.dta"
rename fschpin f2schpin
save "${data_directory}pss\pss_s_2.dta", replace
clear

use "${data_directory}pss\pss_s_3.dta"
rename fschpin f3schpin
drop pss_schl_kenr3
save "${data_directory}pss\pss_s_3.dta", replace
clear

use "${data_directory}pss\pss_s_4.dta"
rename fschpin f4schpin
drop pss_schl_2enr4
save "${data_directory}pss\pss_s_4.dta", replace
clear

use "${data_directory}pss\pss_s_5.dta"
rename fschpin f5schpin
save "${data_directory}pss\pss_s_5.dta", replace
clear

use "${data_directory}pss\pss_s_6.dta"
rename fschpin f6schpin
save "${data_directory}pss\pss_s_6.dta", replace
clear

use "${data_directory}pss\pss_s_7.dta"
rename fschpin f7schpin
drop pss_schl_2enr7 pss_schl_4enr7
save "${data_directory}pss\pss_s_7.dta", replace
clear

use "${data_directory}pss\pss_s_8.dta"
rename fschpin f8schpin
save "${data_directory}pss\pss_s_8.dta", replace
clear

use "${data_directory}pss\pss_s_9.dta"
rename fschpin f9schpin
drop pss_schl_4enr9
save "${data_directory}pss\pss_s_9.dta", replace
clear

/**********************************************************
CLEAN CCD NON-FISCAL YEARS DISTRICT-LEVEL DATA ACROSS YEARS   
***********************************************************/
* Save ccd_d_1
use "${data_directory}ccd\district_level\ccd_d_1011.dta"
rename *, lower
destring leaid, replace 
keep leaid kg member
replace kg = . if kg == -2 | kg == -9 | kg == -1
replace member = . if member == -2 | member == -9 | member == -1
rename kg ccd_dstr_kenr1
rename member ccd_dstr_enr1
rename leaid f1ccdlea
label variable ccd_dstr_kenr1 "CCD Total number of district Kindergarten students, Fall 2010"
label variable ccd_dstr_enr1 "CCD Total number of district students, Fall 2010"
save "${data_directory}ccd\district_level\ccd_d_1.dta", replace
clear

* Save ccd_d_2
use "${data_directory}ccd\district_level\ccd_d_1011.dta"
rename *, lower
destring leaid, replace 
keep leaid kg member
replace kg = . if kg == -2 | kg == -9 | kg == -1
replace member = . if member == -2 | member == -9 | member == -1
rename kg ccd_dstr_kenr2
rename member ccd_dstr_enr2
rename leaid f2ccdlea
label variable ccd_dstr_kenr2 "CCD Total number of district Kindergarten students, Spring 2011"
label variable ccd_dstr_enr2 "CCD Total number of district students, Spring 2011"
save "${data_directory}ccd\district_level\ccd_d_2.dta", replace
clear

* Save ccd_d_3
use "${data_directory}ccd\district_level\ccd_d_1112.dta"
rename *, lower
destring leaid, replace 
keep leaid g01 member
replace g01 = . if g01 == -2 | g01 == -9 | g01 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g01 ccd_dstr_1enr3
rename member ccd_dstr_enr3
rename leaid f3ccdlea
label variable ccd_dstr_1enr3 "CCD Total number of district 1st grade students, Fall 2011"
label variable ccd_dstr_enr3 "CCD Total number of district students, Fall 2011"
save "${data_directory}ccd\district_level\ccd_d_3.dta", replace
clear

* Save ccd_d_4
use "${data_directory}ccd\district_level\ccd_d_1112.dta"
rename *, lower
destring leaid, replace 
keep leaid g01 member
replace g01 = . if g01 == -2 | g01 == -9 | g01 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g01 ccd_dstr_1enr4
rename member ccd_dstr_enr4
rename leaid f4ccdlea
label variable ccd_dstr_1enr4 "CCD Total number of district 1st grade students, Spring 2012"
label variable ccd_dstr_enr4 "CCD Total number of district students, Spring 2012"
save "${data_directory}ccd\district_level\ccd_d_4.dta", replace
clear

* Save ccd_d_5
use "${data_directory}ccd\district_level\ccd_d_1213.dta"
rename *, lower
destring leaid, replace 
keep leaid g02 member
replace g02 = . if g02 == -2 | g02 == -9 | g02 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g02 ccd_dstr_2enr5
rename member ccd_dstr_enr5
rename leaid f5ccdlea
label variable ccd_dstr_2enr5 "CCD Total number of district 2nd grade students, Fall 2012"
label variable ccd_dstr_enr5 "CCD Total number of district students, Fall 2012"
save "${data_directory}ccd\district_level\ccd_d_5.dta", replace
clear

* Save ccd_d_6
use "${data_directory}ccd\district_level\ccd_d_1213.dta"
rename *, lower
destring leaid, replace 
keep leaid g02 member
replace g02 = . if g02 == -2 | g02 == -9 | g02 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g02 ccd_dstr_2enr6
rename member ccd_dstr_enr6
rename leaid f6ccdlea
label variable ccd_dstr_2enr6 "CCD Total number of district 2nd grade students, Spring 2013"
label variable ccd_dstr_enr6 "CCD Total number of district students, Spring 2013"
save "${data_directory}ccd\district_level\ccd_d_6.dta", replace
clear

* Save ccd_d_7
use "${data_directory}ccd\district_level\ccd_d_1314.dta"
rename *, lower
destring leaid, replace 
keep leaid g03 member
replace g03 = . if g03 == -2 | g03 == -9 | g03 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g03 ccd_dstr_3enr7
rename member ccd_dstr_enr7
rename leaid f7ccdlea
label variable ccd_dstr_3enr7 "CCD Total number of district 2nd grade students, Spring 2014"
label variable ccd_dstr_enr7 "CCD Total number of district students, Spring 2014"
save "${data_directory}ccd\district_level\ccd_d_7.dta", replace
clear

* Save ccd_d_8
use "${data_directory}ccd\district_level\ccd_d_1415.dta"
rename *, lower
destring leaid, replace 
keep leaid g04 member
replace g04 = . if g04 == -2 | g04 == -9 | g04 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g04 ccd_dstr_4enr8
rename member ccd_dstr_enr8
rename leaid f8ccdlea
label variable ccd_dstr_4enr8 "CCD Total number of district 2nd grade students, Spring 2015"
label variable ccd_dstr_enr8 "CCD Total number of district students, Spring 2015"
save "${data_directory}ccd\district_level\ccd_d_8.dta", replace
clear

* Save ccd_d_9
use "${data_directory}ccd\district_level\ccd_d_1516.dta"
rename *, lower
destring leaid, replace 
keep leaid g05 member
replace g05 = . if g05 == -2 | g05 == -9 | g05 == -1
replace member = . if member == -2 | member == -9 | member == -1
rename g05 ccd_dstr_5enr9
rename member ccd_dstr_enr9
rename leaid f9ccdlea
label variable ccd_dstr_5enr9 "CCD Total number of district 2nd grade students, Spring 2016"
label variable ccd_dstr_enr9 "CCD Total number of district students, Spring 2016"
save "${data_directory}ccd\district_level\ccd_d_9.dta", replace
clear

/******************************************************
CLEAN CCD FISCAL YEARS DISTRICT-LEVEL DATA ACROSS YEARS   
*******************************************************/
* Save fisc_ccd_d_1
use "${data_directory}ccd\district_level\fisc_ccd_d_1011.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp1
rename leaid f1ccdlea
label variable ccd_dstr_exp1 "CCD Total district expenditures, Fall 2010"
save "${data_directory}ccd\district_level\f_ccd_d_1.dta", replace
clear

* Save fisc_ccd_d_2
use "${data_directory}ccd\district_level\fisc_ccd_d_1011.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp2
rename leaid f2ccdlea
label variable ccd_dstr_exp2 "CCD Total district expenditures, Spring 2011"
save "${data_directory}ccd\district_level\f_ccd_d_2.dta", replace
clear

* Save fisc_ccd_d_3
use "${data_directory}ccd\district_level\fisc_ccd_d_1112.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp3
rename leaid f3ccdlea
label variable ccd_dstr_exp3 "CCD Total district expenditures, Fall 2011"
save "${data_directory}ccd\district_level\f_ccd_d_3.dta", replace
clear

* Save fisc_ccd_d_4
use "${data_directory}ccd\district_level\fisc_ccd_d_1112.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp4
rename leaid f4ccdlea
label variable ccd_dstr_exp4 "CCD Total district expenditures, Spring 2012"
save "${data_directory}ccd\district_level\f_ccd_d_4.dta", replace
clear

* Save fisc_ccd_d_5
use "${data_directory}ccd\district_level\fisc_ccd_d_1213.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp5
rename leaid f5ccdlea
label variable ccd_dstr_exp5 "CCD Total district expenditures, Fall 2012"
save "${data_directory}ccd\district_level\f_ccd_d_5.dta", replace
clear

* Save fisc_ccd_d_6
use "${data_directory}ccd\district_level\fisc_ccd_d_1213.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp6
rename leaid f6ccdlea
label variable ccd_dstr_exp6 "CCD Total district expenditures, Spring 2013"
save "${data_directory}ccd\district_level\f_ccd_d_6.dta", replace
clear

* Save fisc_ccd_d_7
use "${data_directory}ccd\district_level\fisc_ccd_d_1314.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp7
rename leaid f7ccdlea
label variable ccd_dstr_exp7 "CCD Total district expenditures, Spring 2014"
save "${data_directory}ccd\district_level\f_ccd_d_7.dta", replace
clear

* Save fisc_ccd_d_8
use "${data_directory}ccd\district_level\fisc_ccd_d_1415.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp8
rename leaid f8ccdlea
label variable ccd_dstr_exp8 "CCD Total district expenditures, Spring 2015"
save "${data_directory}ccd\district_level\f_ccd_d_8.dta", replace
clear

* Save fisc_ccd_d_9
use "${data_directory}ccd\district_level\fisc_ccd_d_1516.dta"
rename *, lower
destring leaid, replace 
keep leaid totalexp 
replace totalexp = . if totalexp < 0 
rename totalexp ccd_dstr_exp9
rename leaid f9ccdlea
label variable ccd_dstr_exp9 "CCD Total district expenditures, Spring 2016"
save "${data_directory}ccd\district_level\f_ccd_d_9.dta", replace
clear

/*********************************************************
MERGE DISTRICT LEVEL CCD AND CREATE EXPENDITURES PER PUPIL    
**********************************************************/
* Save ccd_d_1 
use "${data_directory}ccd\district_level\f_ccd_d_1.dta"
merge 1:1 f1ccdlea using "${data_directory}ccd\district_level\ccd_d_1.dta"
drop _merge
drop ccd_dstr_kenr1 
gen ccd_dstr_exppp1 = . 
replace ccd_dstr_exppp1 = ccd_dstr_exp1/ccd_dstr_enr1 
replace ccd_dstr_exppp1 = round(ccd_dstr_exppp1, 0.01)
label variable ccd_dstr_exppp1 "CCD Total district expenditures per pupil, Fall 2010"
drop ccd_dstr_exp1 ccd_dstr_enr1 
save "${data_directory}ccd\district_level\ccd_d_1.dta", replace
clear

* Save ccd_d_2 
use "${data_directory}ccd\district_level\f_ccd_d_2.dta"
merge 1:1 f2ccdlea using "${data_directory}ccd\district_level\ccd_d_2.dta"
drop _merge
drop ccd_dstr_kenr2 
gen ccd_dstr_exppp2 = . 
replace ccd_dstr_exppp2 = ccd_dstr_exp2/ccd_dstr_enr2 
replace ccd_dstr_exppp2 = round(ccd_dstr_exppp2, 0.01)
label variable ccd_dstr_exppp2 "CCD Total district expenditures per pupil, Spring 2011"
drop ccd_dstr_exp2 ccd_dstr_enr2 
save "${data_directory}ccd\district_level\ccd_d_2.dta", replace
clear

* Save ccd_d_3 
use "${data_directory}ccd\district_level\f_ccd_d_3.dta"
merge 1:1 f3ccdlea using "${data_directory}ccd\district_level\ccd_d_3.dta"
drop _merge
drop ccd_dstr_1enr3 
gen ccd_dstr_exppp3 = . 
replace ccd_dstr_exppp3 = ccd_dstr_exp3/ccd_dstr_enr3 
replace ccd_dstr_exppp3 = round(ccd_dstr_exppp3, 0.01)
label variable ccd_dstr_exppp3 "CCD Total district expenditures per pupil, Fall 2011"
drop ccd_dstr_exp3 ccd_dstr_enr3 
save "${data_directory}ccd\district_level\ccd_d_3.dta", replace
clear

* Save ccd_d_4 
use "${data_directory}ccd\district_level\f_ccd_d_4.dta"
merge 1:1 f4ccdlea using "${data_directory}ccd\district_level\ccd_d_4.dta"
drop _merge
drop ccd_dstr_1enr4 

*Fix enrollment and expenditures values that are 0 or off in some way 
replace ccd_dstr_exp4 = . if ccd_dstr_exp4 == 0 
replace ccd_dstr_enr4 = . if ccd_dstr_enr4 == 0 

gen ccd_dstr_exppp4 = . 
replace ccd_dstr_exppp4 = ccd_dstr_exp4/ccd_dstr_enr4 
replace ccd_dstr_exppp4 = round(ccd_dstr_exppp4, 0.01)
label variable ccd_dstr_exppp4 "CCD Total district expenditures per pupil, Spring 2012"
replace ccd_dstr_exppp4 = . if ccd_dstr_exppp4 < 6110.51
replace ccd_dstr_exppp4 = . if ccd_dstr_exppp4 >= 72932.59


drop ccd_dstr_exp4 ccd_dstr_enr4 
save "${data_directory}ccd\district_level\ccd_d_4.dta", replace
clear

* Save ccd_d_5 
use "${data_directory}ccd\district_level\f_ccd_d_5.dta"
merge 1:1 f5ccdlea using "${data_directory}ccd\district_level\ccd_d_5.dta"
drop _merge
drop ccd_dstr_2enr5 
gen ccd_dstr_exppp5 = . 
replace ccd_dstr_exppp5 = ccd_dstr_exp5/ccd_dstr_enr5 
replace ccd_dstr_exppp5 = round(ccd_dstr_exppp5, 0.01)
label variable ccd_dstr_exppp5 "CCD Total district expenditures per pupil, Fall 2012"
drop ccd_dstr_exp5 ccd_dstr_enr5 
save "${data_directory}ccd\district_level\ccd_d_5.dta", replace
clear

* Save ccd_d_6 
use "${data_directory}ccd\district_level\f_ccd_d_6.dta"
merge 1:1 f6ccdlea using "${data_directory}ccd\district_level\ccd_d_6.dta"
drop _merge
drop ccd_dstr_2enr6 
gen ccd_dstr_exppp6 = . 
replace ccd_dstr_exppp6 = ccd_dstr_exp6/ccd_dstr_enr6 
replace ccd_dstr_exppp6 = round(ccd_dstr_exppp6, 0.01)
label variable ccd_dstr_exppp6 "CCD Total district expenditures per pupil, Spring 2013"
drop ccd_dstr_exp6 ccd_dstr_enr6 
save "${data_directory}ccd\district_level\ccd_d_6.dta", replace
clear

* Save ccd_d_7 
use "${data_directory}ccd\district_level\f_ccd_d_7.dta"
merge 1:1 f7ccdlea using "${data_directory}ccd\district_level\ccd_d_7.dta"
drop _merge
drop ccd_dstr_3enr7 
gen ccd_dstr_exppp7 = . 
replace ccd_dstr_exppp7 = ccd_dstr_exp7/ccd_dstr_enr7 
replace ccd_dstr_exppp7 = round(ccd_dstr_exppp7, 0.01)
label variable ccd_dstr_exppp7 "CCD Total district expenditures per pupil, Spring 2014"
drop ccd_dstr_exp7 ccd_dstr_enr7 
save "${data_directory}ccd\district_level\ccd_d_7.dta", replace
clear

* Save ccd_d_8
use "${data_directory}ccd\district_level\f_ccd_d_8.dta"
merge 1:1 f8ccdlea using "${data_directory}ccd\district_level\ccd_d_8.dta"
drop _merge
drop ccd_dstr_4enr8 
gen ccd_dstr_exppp8 = . 
replace ccd_dstr_exppp8 = ccd_dstr_exp8/ccd_dstr_enr8 
replace ccd_dstr_exppp8 = round(ccd_dstr_exppp8, 0.01)
label variable ccd_dstr_exppp8 "CCD Total district expenditures per pupil, Spring 2015"
drop ccd_dstr_exp8 ccd_dstr_enr8 
save "${data_directory}ccd\district_level\ccd_d_8.dta", replace
clear

* Save ccd_d_9 
use "${data_directory}ccd\district_level\f_ccd_d_9.dta"
merge 1:1 f9ccdlea using "${data_directory}ccd\district_level\ccd_d_9.dta"
drop _merge
drop ccd_dstr_5enr9 
gen ccd_dstr_exppp9 = . 
replace ccd_dstr_exppp9 = ccd_dstr_exp9/ccd_dstr_enr9 
replace ccd_dstr_exppp9 = round(ccd_dstr_exppp9, 0.01)
label variable ccd_dstr_exppp9 "CCD Total district expenditures per pupil, Spring 2016"
drop ccd_dstr_exp9 ccd_dstr_enr9 
save "${data_directory}ccd\district_level\ccd_d_9.dta", replace
clear

/* Drop remaining temporary f_ccd saved datasets */ 
erase "${data_directory}ccd\district_level\f_ccd_d_1.dta"
erase "${data_directory}ccd\district_level\f_ccd_d_2.dta"
erase "${data_directory}ccd\district_level\f_ccd_d_3.dta"
erase "${data_directory}ccd\district_level\f_ccd_d_4.dta"
erase "${data_directory}ccd\district_level\f_ccd_d_5.dta"
erase "${data_directory}ccd\district_level\f_ccd_d_6.dta"
erase "${data_directory}ccd\district_level\f_ccd_d_7.dta"
erase "${data_directory}ccd\district_level\f_ccd_d_8.dta"
erase "${data_directory}ccd\district_level\f_ccd_d_9.dta"

/**************************************
MERGE ALL CCD AND PSS DATA WITH ECLSKV2    
***************************************/
use "${data_directory}eclsk11\eclsk11v2.dta"
local nums 1 2 3 4 5 6 7 8 9 
foreach i of local nums {
	destring f`i'ccdlea, replace
}
/* Merge CCD district-level */ 
*** CCD district-level fiscal
* W1 
replace f1ccdlea = . if f1ccdlea == -1
merge m:1 f1ccdlea using "${data_directory}ccd\district_level\ccd_d_1.dta"
*Look at non matched 
bysort f1ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 3 unique districts didn't match */ 
tabulate n if _merge == 2 /* 18,162 unique districts didn't match */ 
drop if _merge == 2
drop _merge n

* W2
replace f2ccdlea = . if f2ccdlea == -1
merge m:1 f2ccdlea using "${data_directory}ccd\district_level\ccd_d_2.dta"
*Look at non matched 
bysort f2ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 5 unique districts didn't match */ 
tabulate n if _merge == 2 /* 18,072 unique districts didn't match */ 
drop if _merge == 2
drop _merge n

* W3 
replace f3ccdlea = . if f3ccdlea == -1
merge m:1 f3ccdlea using "${data_directory}ccd\district_level\ccd_d_3.dta"
*Look at non matched 
bysort f3ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 13,272 unique districts didn't match - most school data on 1st grade was collected in W4 */ 
tabulate n if _merge == 2 /* 18,365 unique districts didn't match */ 
drop if _merge == 2
drop _merge n

* W4 
replace f4ccdlea = . if f4ccdlea == -1
merge m:1 f4ccdlea using "${data_directory}ccd\district_level\ccd_d_4.dta"
*Look at non matched 
bysort f4ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 7 unique districts didn't match */ 
tabulate n if _merge == 2 /* 18,016 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W5 
replace f5ccdlea = . if f5ccdlea == -1
merge m:1 f5ccdlea using "${data_directory}ccd\district_level\ccd_d_5.dta"
*Look at non matched 
bysort f5ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 4 unique districts didn't match */ 
tabulate n if _merge == 2 /* 18,430 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W6 
replace f6ccdlea = . if f6ccdlea == -1
merge m:1 f6ccdlea using "${data_directory}ccd\district_level\ccd_d_6.dta"
*Look at non matched 
bysort f6ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 7 unique districts didn't match */ 
tabulate n if _merge == 2 /* 18,064 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W7 
replace f7ccdlea = . if f7ccdlea == -1
merge m:1 f7ccdlea using "${data_directory}ccd\district_level\ccd_d_7.dta"
*Look at non matched 
bysort f7ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 9 unique districts didn't match */ 
tabulate n if _merge == 2 /* 18,193 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W8 
replace f8ccdlea = . if f8ccdlea == -1
merge m:1 f8ccdlea using "${data_directory}ccd\district_level\ccd_d_8.dta"
*Look at non matched 
bysort f8ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 10 unique districts didn't match */ 
tabulate n if _merge == 2 /* 18,215 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W9 
replace f9ccdlea = . if f9ccdlea == -1
merge m:1 f9ccdlea using "${data_directory}ccd\district_level\ccd_d_9.dta"
*Look at non matched 
bysort f9ccdlea: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 11 unique districts didn't match */ 
tabulate n if _merge == 2 /* 18,198 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

/* Merge CCD school-level */ 
* W1 
replace f1ccdsid = "" if f1ccdsid == "-1"
merge m:m f1ccdsid using "${data_directory}ccd\school_level\ccd_s_1.dta"
*Look at non matched 
bysort f1ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 21 unique districts didn't match */ 
tabulate n if _merge == 2 /* 103,122 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W2 
replace f2ccdsid = "" if f2ccdsid == "-1"
merge m:m f2ccdsid using "${data_directory}ccd\school_level\ccd_s_2.dta"
*Look at non matched 
bysort f2ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 30 unique districts didn't match */ 
tabulate n if _merge == 2 /* 102,723 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W3 
replace f3ccdsid = "" if f3ccdsid == "-1"
merge m:m f3ccdsid using "${data_directory}ccd\school_level\ccd_s_3.dta"
*Look at non matched 
bysort f3ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 10 unique districts didn't match */ 
tabulate n if _merge == 2 /* 102,878 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W4 
replace f4ccdsid = "" if f4ccdsid == "-1"
merge m:m f4ccdsid using "${data_directory}ccd\school_level\ccd_s_4.dta"
*Look at non matched 
bysort f4ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 44 unique districts didn't match */ 
tabulate n if _merge == 2 /* 101,785 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W5 
replace f5ccdsid = "" if f5ccdsid == "-1"
merge m:m f5ccdsid using "${data_directory}ccd\school_level\ccd_s_5.dta"
*Look at non matched 
bysort f5ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 16 unique districts didn't match */ 
tabulate n if _merge == 2 /* 102,145 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W6 
replace f6ccdsid = "" if f6ccdsid == "-1"
merge m:m f6ccdsid using "${data_directory}ccd\school_level\ccd_s_6.dta"
*Look at non matched 
bysort f6ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 59 unique districts didn't match */ 
tabulate n if _merge == 2 /* 100,921 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W7 
replace f7ccdsid = "" if f7ccdsid == "-1"
merge m:m f7ccdsid using "${data_directory}ccd\school_level\ccd_s_7.dta"
*Look at non matched 
bysort f7ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 66 unique districts didn't match */ 
tabulate n if _merge == 2 /* 100,658 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W8 
replace f8ccdsid = "" if f8ccdsid == "-1"
merge m:m f8ccdsid using "${data_directory}ccd\school_level\ccd_s_8.dta"
*Look at non matched 
bysort f8ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 81 unique districts didn't match */ 
tabulate n if _merge == 2 /* 97,937 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

* W9 
replace f9ccdsid = "" if f9ccdsid == "-1"
merge m:m f9ccdsid using "${data_directory}ccd\school_level\ccd_s_9.dta"
*Look at non matched 
bysort f9ccdsid: gen n = _n
replace n = 0 if n > 1 & n < 100000
tabulate n if _merge == 1 /* 78 unique districts didn't match */ 
tabulate n if _merge == 2 /* 96,976 unique districts didn't match */ 
drop if _merge == 2 
drop _merge n

/* Merge PSS */ 
* W1
replace f1schpin = "" if f1schpin == "-1"
merge m:m f1schpin using "${data_directory}pss\pss_s_1.dta"
drop if _merge == 2
drop _merge

* W2
replace f2schpin = "" if f2schpin == "-1"
merge m:m f2schpin using "${data_directory}pss\pss_s_2.dta"
drop if _merge == 2
drop _merge

* W3
replace f3schpin = "" if f3schpin == "-1"
merge m:m f3schpin using "${data_directory}pss\pss_s_3.dta"
drop if _merge == 2
drop _merge

* W4
replace f4schpin = "" if f4schpin == "-1"
merge m:m f4schpin using "${data_directory}pss\pss_s_4.dta"
drop if _merge == 2
drop _merge

* W5
replace f5schpin = "" if f5schpin == "-1"
merge m:m f5schpin using "${data_directory}pss\pss_s_5.dta"
drop if _merge == 2
drop _merge

* W6
replace f6schpin = "" if f6schpin == "-1"
merge m:m f6schpin using "${data_directory}pss\pss_s_6.dta"
drop if _merge == 2
drop _merge

* W7 
replace f7schpin = "" if f7schpin == "-1"
merge m:m f7schpin using "${data_directory}pss\pss_s_7.dta"
drop if _merge == 2
drop _merge

* W8 
replace f8schpin = "" if f8schpin == "-1"
merge m:m f8schpin using "${data_directory}pss\pss_s_8.dta"
drop if _merge == 2
drop _merge

* W9
replace f9schpin = "" if f9schpin == "-1"
merge m:m f9schpin using "${data_directory}pss\pss_s_9.dta"
drop if _merge == 2
drop _merge

/* Drop remaining temporary saved datasets */ 
erase "${data_directory}ccd\district_level\ccd_d_1.dta"
erase "${data_directory}ccd\district_level\ccd_d_2.dta"
erase "${data_directory}ccd\district_level\ccd_d_3.dta"
erase "${data_directory}ccd\district_level\ccd_d_4.dta"
erase "${data_directory}ccd\district_level\ccd_d_5.dta"
erase "${data_directory}ccd\district_level\ccd_d_6.dta"
erase "${data_directory}ccd\district_level\ccd_d_7.dta"
erase "${data_directory}ccd\district_level\ccd_d_8.dta"
erase "${data_directory}ccd\district_level\ccd_d_9.dta"
erase "${data_directory}ccd\school_level\ccd_s_1.dta"
erase "${data_directory}ccd\school_level\ccd_s_2.dta"
erase "${data_directory}ccd\school_level\ccd_s_3.dta"
erase "${data_directory}ccd\school_level\ccd_s_4.dta"
erase "${data_directory}ccd\school_level\ccd_s_5.dta"
erase "${data_directory}ccd\school_level\ccd_s_6.dta"
erase "${data_directory}ccd\school_level\ccd_s_7.dta"
erase "${data_directory}ccd\school_level\ccd_s_8.dta"
erase "${data_directory}ccd\school_level\ccd_s_9.dta"
erase "${data_directory}pss\pss_s_1.dta"
erase "${data_directory}pss\pss_s_2.dta"
erase "${data_directory}pss\pss_s_3.dta"
erase "${data_directory}pss\pss_s_4.dta"
erase "${data_directory}pss\pss_s_5.dta"
erase "${data_directory}pss\pss_s_6.dta"
erase "${data_directory}pss\pss_s_7.dta"
erase "${data_directory}pss\pss_s_8.dta"
erase "${data_directory}pss\pss_s_9.dta"
erase "${data_directory}pss\pss_s_m.dta"

/***************************************
COMBINE PSS AND CCD ENROLLMENT VARIABLES  
****************************************/
rename ccd_schl_enr1 schl_enr1 
rename ccd_schl_enr2 schl_enr2 
rename ccd_schl_enr3 schl_enr3 
rename ccd_schl_enr4 schl_enr4 
rename ccd_schl_enr5 schl_enr5 
rename ccd_schl_enr6 schl_enr6 
rename ccd_schl_enr7 schl_enr7 
rename ccd_schl_enr8 schl_enr8 
rename ccd_schl_enr9 schl_enr9

replace schl_enr3 = pss_schl_enr3 if schl_enr3 == .
replace schl_enr4 = pss_schl_enr4 if schl_enr4 == .
replace schl_enr7 = pss_schl_enr7 if schl_enr7 == .
replace schl_enr9 = pss_schl_enr9 if schl_enr9 == .

label variable schl_enr1 "Total number of school students, Kindergarten Fall"
label variable schl_enr2 "Total number of school students, Kindergarten Spring"
label variable schl_enr3 "Total number of school students, 1st grade Fall"
label variable schl_enr4 "Total number of school students, 1st grade Spring"
label variable schl_enr5 "Total number of school students, 2nd grade Fall"
label variable schl_enr6 "Total number of school students, 2nd grade Spring"
label variable schl_enr7 "Total number of school students, 3rd grade"
label variable schl_enr8 "Total number of school students, 4th grade"
label variable schl_enr9 "Total number of school students, 5th grade"

** Fix a few data errors here 
replace schl_enr4 = . if stotenrl4 == 1 & schl_enr4 == 1408
replace schl_enr4 = . if stotenrl4 == 3 & schl_enr4 == 1120
replace schl_enr4 = . if stotenrl4 == 4 & schl_enr4 == 1005
replace schl_enr4 = . if stotenrl4 == 3 & schl_enr4 == 917
replace schl_enr4 = . if schl_enr4 == 0


rename ccd_schl_kenr1 schl_kenr1 
rename ccd_schl_kenr2 schl_kenr2 
rename ccd_schl_1enr3 schl_1enr3 
rename ccd_schl_1enr4 schl_1enr4 
rename ccd_schl_2enr5 schl_2enr5 
rename ccd_schl_2enr6 schl_2enr6 
rename ccd_schl_3enr7 schl_3enr7 
rename ccd_schl_4enr8 schl_4enr8 
rename ccd_schl_5enr9 schl_5enr9

replace schl_1enr3 = pss_schl_1enr3 if schl_1enr3 == .
replace schl_1enr4 = pss_schl_1enr4 if schl_1enr4 == .
replace schl_enr7 = pss_schl_3enr7 if schl_3enr7 == .
replace schl_enr9 = pss_schl_5enr9 if schl_5enr9 == .

label variable schl_kenr1 "Total number of Kindergarten school students, Kindergarten Fall"
label variable schl_kenr2 "Total number of Kindergarten school students, Kindergarten Spring"
label variable schl_1enr3 "Total number of 1st grade school students, 1st grade Fall"
label variable schl_1enr4 "Total number of 1st grade school students, 1st grade Spring"
label variable schl_2enr5 "Total number of 2nd grade school students, 2nd grade Fall"
label variable schl_2enr6 "Total number of 2nd grade school students, 2nd grade Spring"
label variable schl_3enr7 "Total number of 3rd grade chool students, 3rd grade"
label variable schl_4enr8 "Total number of 4th grade school students, 4th grade"
label variable schl_5enr9 "Total number of 5th grade school students, 5th grade"

drop pss*

/***********************************
CREATE ADDITIONAL PER PUPIL MEASURES  
************************************/
/* Teacher-pupil ratios by subject */ 
** # Full-time regular classroom teachers 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	gen strg_pp_`i' = (strgl`i'/schl_enr`i')*100
}
label variable strg_pp_2 "Teachers-per-100-students - regular classroom teachers, Kindergarten Spring"
label variable strg_pp_4 "Teachers-per-100-students - regular classroom teachers, 1st grade Spring"
label variable strg_pp_6 "Teachers-per-100-students - regular classroom teachers, 2nd grade Spring"
label variable strg_pp_7 "Teachers-per-100-students - regular classroom teachers, 3rd grade"
label variable strg_pp_8 "Teachers-per-100-students - regular classroom teachers, 4th grade"
label variable strg_pp_9 "Teachers-per-100-students - regular classroom teachers, 5th grade"

sum strg_pp_4, det
replace strg_pp_4 = . if strg_pp_4 < r(p1) | strg_pp_4 > r(p99)

drop strgl*

** # Full-time elective teachers 
rename selctv2 sartstf2
local nums 2 4 6 7 8 9 
foreach i of local nums {
	gen start_pp_`i' = (sartstf`i'/schl_enr`i')*100
}
label variable start_pp_2 "Teachers-per-100-students - elective teachers, Kindergarten Spring"
label variable start_pp_4 "Teachers-per-100-students - elective teachers, 1st grade Spring"
label variable start_pp_6 "Teachers-per-100-students - elective teachers, 2nd grade Spring"
label variable start_pp_7 "Teachers-per-100-students - elective teachers, 3rd grade"
label variable start_pp_8 "Teachers-per-100-students - elective teachers, 4th grade"
label variable start_pp_9 "Teachers-per-100-students - elective teachers, 5th grade"

sum start_pp_4, det

drop sarts*

** # Full-time gym/health teachers 
local nums 4 6 7 8 9 
foreach i of local nums {
	gen stgym_pp_`i' = (sgymstf`i'/schl_enr`i')*100
}
label variable stgym_pp_4 "Teachers-per-100-students - gym/health teachers, 1st grade Spring"
label variable stgym_pp_6 "Teachers-per-100-students - gym/health teachers, 2nd grade Spring"
label variable stgym_pp_7 "Teachers-per-100-students - gym/health teachers, 3rd grade"
label variable stgym_pp_8 "Teachers-per-100-students - gym/health teachers, 4th grade"
label variable stgym_pp_9 "Teachers-per-100-students - gym/health teachers, 5th grade"

sum stgym_pp_4, det

drop sgymstf*

** # Full-time special education teachers 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	gen stsp_pp_`i' = (spedstf`i'/schl_enr`i')*100
}
label variable stsp_pp_2 "Teachers-per-100-students - special education teachers, Kindergarten Spring"
label variable stsp_pp_4 "Teachers-per-100-students - special education teachers, 1st grade Spring"
label variable stsp_pp_6 "Teachers-per-100-students - special education teachers, 2nd grade Spring"
label variable stsp_pp_7 "Teachers-per-100-students - special education teachers, 3rd grade"
label variable stsp_pp_8 "Teachers-per-100-students - special education teachers, 4th grade"
label variable stsp_pp_9 "Teachers-per-100-students - special education teachers, 5th grade"

sum stsp_pp_4, det
replace stsp_pp_4 = . if stsp_pp_4 > 6 & stsp_pp_4 < 50

drop spedstf*

** # Full-time ESL/Bilingual teachers
local nums 2 4 6 7 8 9 
foreach i of local nums {
	gen stesl_pp_`i' = (seslstf`i'/schl_enr`i')*100
}
label variable stesl_pp_2 "Teachers-per-100-students - ESL/bilingual teachers, Kindergarten Spring"
label variable stesl_pp_4 "Teachers-per-100-students - ESL/bilingual teachers, 1st grade Spring"
label variable stesl_pp_6 "Teachers-per-100-students - ESL/bilingual teachers, 2nd grade Spring"
label variable stesl_pp_7 "Teachers-per-100-students - ESL/bilingual teachers, 3rd grade"
label variable stesl_pp_8 "Teachers-per-100-students - ESL/bilingual teachers, 4th grade"
label variable stesl_pp_9 "Teachers-per-100-students - ESL/bilingual teachers, 5th grade"

sum stesl_pp_4, det

drop seslstf*

** # Full-time reading teachers/specialists 
gen strd_pp_2 = schl_enr2/srdstf2
label variable strd_pp_2 "Teachers-per-100-students - reading teachers, Kindergarten Spring"
drop srdstf2 

** # Full-time Gifted/talented teachers 
local nums 2 4 6
foreach i of local nums {
	gen stgft_pp_`i' = (sgftstf`i'/schl_enr`i')*100
}
label variable stgft_pp_2 "Teachers-per-100-students - G/T teachers, Kindergarten Spring"
label variable stgft_pp_4 "Teachers-per-100-students - G/T teachers, 1st grade Spring"
label variable stgft_pp_6 "Teachers-per-100-students - G/T teachers, 2nd grade Spring"

sum stgft_pp_4, det

drop sgftstf*

** # Full-time school nurses/health professionals 
local nums 2 4 6
foreach i of local nums {
	gen stnrs_pp_`i' = (snrsstf`i'/schl_enr`i')*100
}
label variable stnrs_pp_2 "Teachers-per-100-students - school nurses, Kindergarten Spring"
label variable stnrs_pp_4 "Teachers-per-100-students - school nurses, 1st grade Spring"
label variable stnrs_pp_6 "Teachers-per-100-students - school nurses, 2nd grade Spring"

sum stnrs_pp_4, det 

drop snrsstf*

** # Full-time school psychologists/social workers
local nums 2 4 6
foreach i of local nums {
	gen stfpsy_pp_`i' = (spsyfstf`i'/schl_enr`i')*100
}
label variable stfpsy_pp_2 "Teachers-per-100-students - school psychologists, Kindergarten Spring"
label variable stfpsy_pp_4 "Teachers-per-100-students - school psychologists, 1st grade Spring"
label variable stfpsy_pp_6 "Teachers-per-100-students - school psychologists, 2nd grade Spring"

sum stfpsy_pp_4, det

drop spsyfstf*

** # Part-time school psychologists/social workers 
local nums 2 4 6
foreach i of local nums {
	gen stppsy_pp_`i' = (spsypstf`i'/schl_enr`i')*100
}
label variable stppsy_pp_2 "Teachers-per-100-students - school psychologists part-time, Kindergarten Spring"
label variable stppsy_pp_4 "Teachers-per-100-students - school psychologists part-time, 1st grade Spring"
label variable stppsy_pp_6 "Teachers-per-100-students - school psychologists part-time, 2nd grade Spring"

sum stppsy_pp_4, det

drop spsypstf*

** # Full-time para professionals 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	gen stpar_pp_`i' = (sparastf`i'/schl_enr`i')*100
}
label variable stpar_pp_2 "Teachers-per-100-students - para professionals, Kindergarten Spring"
label variable stpar_pp_4 "Teachers-per-100-students - para professionals, 1st grade Spring"
label variable stpar_pp_6 "Teachers-per-100-students - para professionals, 2nd grade Spring"
label variable stpar_pp_7 "Teachers-per-100-students - para professionals, 3rd grade"
label variable stpar_pp_8 "Teachers-per-100-students - para professionals, 4th grade"
label variable stpar_pp_9 "Teachers-per-100-students - para professionals, 5th grade"

sum stpar_pp_4, det
replace stpar_pp_4 = . if stpar_pp_4 > 72 & stpar_pp_4 < 75

drop sparastf*

** # Full-time librarians 
local nums 2 4 6
foreach i of local nums {
	gen stlib_pp_`i' = (slibstf`i'/schl_enr`i')*100
}
label variable stlib_pp_2 "Teachers-per-100-students - librarians, Kindergarten Spring"
label variable stlib_pp_4 "Teachers-per-100-students - librarians, 1st grade Spring"
label variable stlib_pp_6 "Teachers-per-100-students - librarians, 2nd grade Spring"

sum stlib_pp_4, det

drop slibstf*

** # Full-time computer teachers 
local nums 4 6
foreach i of local nums {
	gen stcmp_pp_`i' = (scmpstf`i'/schl_enr`i')*100
}
label variable stcmp_pp_4 "Teachers-per-100-students - computer teachers, 1st grade Spring"
label variable stcmp_pp_6 "Teachers-per-100-students - computer teachers, 2nd grade Spring"

sum stcmp_pp_4, det

drop scmpstf*

** # Teachers total at school 
local nums 2 4 6 9
foreach i of local nums {
	gen sttot_pp_`i' = (stnum`i'/schl_enr`i')*100
}
label variable sttot_pp_2 "Teachers-per-100-students - librarians, Kindergarten Spring"
label variable sttot_pp_4 "Teachers-per-100-students - librarians, 1st grade Spring"
label variable sttot_pp_6 "Teachers-per-100-students - librarians, 2nd grade Spring"
label variable sttot_pp_9 "Teachers-per-100-students - librarians, 5th grade Spring"

sum sttot_pp_4, det 
replace sttot_pp_4 = . if sttot_pp_4 > 200 & sttot_pp_4 < 206

/* Teacher turnover rates */ 
local nums 2 4 6 9
foreach i of local nums {
	gen sttrn`i' = (slftt`i'/stnum`i')
}
label variable sttrn2 "Teacher turnover rate, Kindergarten Spring"
label variable sttrn4 "Teacher turnover rate, 1st grade Spring"
label variable sttrn6 "Teacher turnover rate, 2nd grade Spring"
label variable sttrn9 "Teacher turnover rate, 5th grade Spring"

sum sttrn4, det
replace sttrn4 = . if sttrn4 > 1 & sttrn4 < 5


/******************************
SAVE AS STATA DATASET ECLSK11v3  
*******************************/
save "${data_directory}\eclsk11\eclsk11v3.dta", replace

clear
log close
