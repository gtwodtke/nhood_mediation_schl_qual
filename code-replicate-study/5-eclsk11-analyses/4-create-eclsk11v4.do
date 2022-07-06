#delimit cr
capture log close 
capture clear all 

global data_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\" 
global log_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\5-eclsk11-analyses\" 

global figure_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\figures\eclsk11\"
log using "${log_directory}4-create-eclsk11v4.log", replace 

/******************************************************************
PROGRAM NAME: 4-create-eclsk11v4.do
AUTHOR: KW
PURPOSE: Generate test score impact and growth and lagged measures
NOTES: GW revised on 11/19/2021
*******************************************************************/

use "${data_directory}\eclsk11\eclsk11v3.dta"

/****************************************
DEAL WITH MISSING DATA FOR DATE VARIABLES   
*****************************************/
/* Look at missing data */ 
** Test assessment date 
local assessment 	x1asmtmm x1asmtdd x1asmtyy ///
					x2asmtmm x2asmtdd x2asmtyy ///
					x3asmtmm x3asmtdd x3asmtyy ///
					x4asmtmm x4asmtdd x4asmtyy ///
					x5asmtmm x5asmtdd x5asmtyy ///
					x6asmtmm x6asmtdd x6asmtyy 

foreach var of local assessment {
    count if `var' >= .
}

** School start date 
local assessment 	x2schbmm x2schbdd x2schbyy ///
					x4schbmm x4schbdd x4schbyy ///
					x6schbmm x6schbdd x6schbyy 

foreach var of local assessment {
    count if `var' >= .
}
					
** School end date 
local assessment 	x2schemm x2schedd x2scheyy ///
					x4schemm x4schedd x4scheyy ///
					x6schemm x6schedd x6scheyy

foreach var of local assessment {
    count if `var' >= .
}

/* Fill in missing values - round 1 */ 
** Replace values as . if -9 or -1 
local nums 2 4 6 7 8 9
quietly foreach i of local nums {
    replace x`i'schbdd = . if x`i'schbdd == -9 | x`i'schbdd == -1
	replace x`i'schbmm = . if x`i'schbmm == -9 | x`i'schbmm == -1
	replace x`i'schbyy = . if x`i'schbyy == -9 | x`i'schbyy == -1
	replace x`i'schedd = . if x`i'schedd == -9 | x`i'schedd == -1
	replace x`i'schemm = . if x`i'schemm == -9 | x`i'schemm == -1
	replace x`i'scheyy = . if x`i'scheyy == -9 | x`i'scheyy == -1
}

** Assessment date 
quietly levelsof s1_id, local(school_ids)
quietly foreach id of local school_ids {
    egen count = count(1) if s1_id == "`id'" & x1asmtdd !=., by(x1asmtmm x1asmtdd x1asmtyy)
	gen neg_count = -count
	sort neg_count
	
	gen most_freq_date_month 	= x1asmtmm if _n == 1
	gen most_freq_date_day 		= x1asmtdd if _n == 1
	gen most_freq_date_year		= x1asmtyy if _n == 1

	replace most_freq_date_month 	= x1asmtmm[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day 		= x1asmtdd[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= x1asmtyy[_n-1] if missing(most_freq_date_year)
	
	replace x1asmtmm = most_freq_date_month if s1_id == "`id'" & x1asmtmm == .
	replace x1asmtdd = most_freq_date_day 	if s1_id == "`id'" & x1asmtdd == .
	replace x1asmtyy = most_freq_date_year	if s1_id == "`id'" & x1asmtyy == .
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}

quietly levelsof s2_id, local(school_ids)
quietly foreach id of local school_ids {
    egen count = count(1) if s2_id == "`id'" & x2asmtdd !=., by(x2asmtmm x2asmtdd x2asmtyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x2asmtmm if _n == 1
	gen most_freq_date_day 		= x2asmtdd if _n == 1
	gen most_freq_date_year		= x2asmtyy if _n == 1
	
	replace most_freq_date_month 	= x2asmtmm[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day 		= x2asmtdd[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= x2asmtyy[_n-1] if missing(most_freq_date_year)
	
	replace x2asmtmm = most_freq_date_month if s2_id == "`id'" & x2asmtmm == .
	replace x2asmtdd = most_freq_date_day 	if s2_id == "`id'" & x2asmtdd == .
	replace x2asmtyy = most_freq_date_year	if s2_id == "`id'" & x2asmtyy == .
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

quietly levelsof s3_id, local(school_ids)
quietly foreach id of local school_ids {
    egen count = count(1) if s3_id == "`id'" & x3asmtdd !=., by(x3asmtmm x3asmtdd x3asmtyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x3asmtmm if _n == 1
	gen most_freq_date_day 		= x3asmtdd if _n == 1
	gen most_freq_date_year		= x3asmtyy if _n == 1
	
	replace most_freq_date_month 	= x3asmtmm[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day 		= x3asmtdd[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= x3asmtyy[_n-1] if missing(most_freq_date_year)
	
	replace x3asmtmm = most_freq_date_month if s3_id == "`id'" & x3asmtmm == .
	replace x3asmtdd = most_freq_date_day 	if s3_id == "`id'" & x3asmtdd == .
	replace x3asmtyy = most_freq_date_year	if s3_id == "`id'" & x3asmtyy == .
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

quietly levelsof s4_id, local(school_ids)
quietly foreach id of local school_ids {
    egen count = count(1) if s4_id == "`id'" & x4asmtdd !=., by(x4asmtmm x4asmtdd x4asmtyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x4asmtmm if _n == 1
	gen most_freq_date_day 		= x4asmtdd if _n == 1
	gen most_freq_date_year		= x4asmtyy if _n == 1
	
	replace most_freq_date_month 	= x4asmtmm[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day 		= x4asmtdd[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= x4asmtyy[_n-1] if missing(most_freq_date_year)
	
	replace x4asmtmm = most_freq_date_month if s4_id == "`id'" & x4asmtmm == .
	replace x4asmtdd = most_freq_date_day 	if s4_id == "`id'" & x4asmtdd == .
	replace x4asmtyy = most_freq_date_year	if s4_id == "`id'" & x4asmtyy == .
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

quietly levelsof s5_id, local(school_ids)
quietly foreach id of local school_ids {
    egen count = count(1) if s5_id == "`id'" & x5asmtdd !=., by(x5asmtmm x5asmtdd x5asmtyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x5asmtmm if _n == 1
	gen most_freq_date_day 		= x5asmtdd if _n == 1
	gen most_freq_date_year		= x5asmtyy if _n == 1
	
	replace most_freq_date_month 	= x5asmtmm[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day 		= x5asmtdd[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= x5asmtyy[_n-1] if missing(most_freq_date_year)
	
	replace x5asmtmm = most_freq_date_month if s5_id == "`id'" & x5asmtmm == .
	replace x5asmtdd = most_freq_date_day 	if s5_id == "`id'" & x5asmtdd == .
	replace x5asmtyy = most_freq_date_year	if s5_id == "`id'" & x5asmtyy == .
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

quietly levelsof s6_id, local(school_ids)
quietly foreach id of local school_ids {
    egen count = count(1) if s6_id == "`id'" & x6asmtdd !=., by(x6asmtmm x6asmtdd x6asmtyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x6asmtmm if _n == 1
	gen most_freq_date_day 		= x6asmtdd if _n == 1
	gen most_freq_date_year		= x6asmtyy if _n == 1
	
	replace most_freq_date_month 	= x6asmtmm[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day 		= x6asmtdd[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= x6asmtyy[_n-1] if missing(most_freq_date_year)
	
	replace x6asmtmm = most_freq_date_month if s6_id == "`id'" & x6asmtmm == .
	replace x6asmtdd = most_freq_date_day 	if s6_id == "`id'" & x6asmtdd == .
	replace x6asmtyy = most_freq_date_year	if s6_id == "`id'" & x6asmtyy == .
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

** School start date
replace x2schbmm = . if x2schbmm < 0 
replace x2schbdd = . if x2schbdd < 0
replace x2schbyy = . if x2schbyy < 0 
replace x4schbmm = . if x4schbmm < 0 
replace x4schbdd = . if x4schbdd < 0
replace x4schbyy = . if x4schbyy < 0 
replace x6schbmm = . if x6schbmm < 0 
replace x6schbdd = . if x6schbdd < 0
replace x6schbyy = . if x6schbyy < 0 

quietly levelsof s2_id, local(school_ids)

quietly foreach id of local school_ids {
    egen count = count(1) if s2_id == "`id'" & x2schbmm != . & x2schbdd !=. & x2schbyy !=., by(x2schbmm x2schbdd x2schbyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x2schbmm if _n == 1 
	gen most_freq_date_day 		= x2schbdd if _n == 1 
	gen most_freq_date_year 	= x2schbyy if _n == 1 
	
	replace most_freq_date_month 	= most_freq_date_month[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day		= most_freq_date_day[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= most_freq_date_year[_n-1] if missing(most_freq_date_year)
	
	replace x2schbmm = most_freq_date_month 	if s2_id == "`id'" & (x2schbmm == . | x2schbdd == . | x2schbyy == .)
	replace x2schbdd = most_freq_date_day 		if s2_id == "`id'" & (x2schbmm == . | x2schbdd == . | x2schbyy == .)
	replace x2schbyy = most_freq_date_year		if s2_id == "`id'" & (x2schbmm == . | x2schbdd == . | x2schbyy == .)
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

quietly levelsof s4_id, local(school_ids)

quietly foreach id of local school_ids {
    egen count = count(1) if s4_id == "`id'" & x4schbmm != . & x4schbdd !=. & x4schbyy !=., by(x4schbmm x4schbdd x4schbyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x4schbmm if _n == 1 
	gen most_freq_date_day 		= x4schbdd if _n == 1 
	gen most_freq_date_year 	= x4schbyy if _n == 1 
	
	replace most_freq_date_month 	= most_freq_date_month[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day		= most_freq_date_day[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= most_freq_date_year[_n-1] if missing(most_freq_date_year)
	
	replace x4schbmm = most_freq_date_month 	if s4_id == "`id'" & (x4schbmm == . | x4schbdd == . | x4schbyy == .)
	replace x4schbdd = most_freq_date_day 		if s4_id == "`id'" & (x4schbmm == . | x4schbdd == . | x4schbyy == .)
	replace x4schbyy = most_freq_date_year		if s4_id == "`id'" & (x4schbmm == . | x4schbdd == . | x4schbyy == .)
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

quietly levelsof s6_id, local(school_ids)

quietly foreach id of local school_ids {
    egen count = count(1) if s6_id == "`id'" & x6schbmm != . & x6schbdd !=. & x6schbyy !=., by(x6schbmm x6schbdd x6schbyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x6schbmm if _n == 1 
	gen most_freq_date_day 		= x6schbdd if _n == 1 
	gen most_freq_date_year 	= x6schbyy if _n == 1 
	
	replace most_freq_date_month 	= most_freq_date_month[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day		= most_freq_date_day[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= most_freq_date_year[_n-1] if missing(most_freq_date_year)
	
	replace x6schbmm = most_freq_date_month 	if s6_id == "`id'" & (x6schbmm == . | x6schbdd == . | x6schbyy == .)
	replace x6schbdd = most_freq_date_day 		if s6_id == "`id'" & (x6schbmm == . | x6schbdd == . | x6schbyy == .)
	replace x6schbyy = most_freq_date_year		if s6_id == "`id'" & (x6schbmm == . | x6schbdd == . | x6schbyy == .)
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

** School end date
replace x2schemm = . if x2schemm < 0 
replace x2schedd = . if x2schedd < 0
replace x2scheyy = . if x2scheyy < 0 
replace x4schemm = . if x4schemm < 0 
replace x4schedd = . if x4schedd < 0
replace x4scheyy = . if x4scheyy < 0 
replace x6schemm = . if x6schemm < 0 
replace x6schedd = . if x6schedd < 0
replace x6scheyy = . if x6scheyy < 0 

quietly levelsof s2_id, local(school_ids)

quietly foreach id of local school_ids {
    egen count = count(1) if s2_id == "`id'" & x2schemm != . & x2schedd !=. & x2scheyy !=., by(x2schemm x2schedd x2scheyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x2schemm if _n == 1 
	gen most_freq_date_day 		= x2schedd if _n == 1 
	gen most_freq_date_year 	= x2scheyy if _n == 1 
	
	replace most_freq_date_month 	= most_freq_date_month[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day		= most_freq_date_day[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= most_freq_date_year[_n-1] if missing(most_freq_date_year)
	
	replace x2schemm = most_freq_date_month 	if s2_id == "`id'" & (x2schemm == . | x2schedd == . | x2scheyy == .)
	replace x2schedd = most_freq_date_day 		if s2_id == "`id'" & (x2schemm == . | x2schedd == . | x2scheyy == .)
	replace x2scheyy = most_freq_date_year		if s2_id == "`id'" & (x2schemm == . | x2schedd == . | x2scheyy == .)
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

quietly levelsof s4_id, local(school_ids)

quietly foreach id of local school_ids {
    egen count = count(1) if s4_id == "`id'" & x4schemm != . & x4schedd !=. & x4scheyy !=., by(x4schemm x4schedd x4scheyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x4schemm if _n == 1 
	gen most_freq_date_day 		= x4schedd if _n == 1 
	gen most_freq_date_year 	= x4scheyy if _n == 1 
	
	replace most_freq_date_month 	= most_freq_date_month[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day		= most_freq_date_day[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= most_freq_date_year[_n-1] if missing(most_freq_date_year)
	
	replace x4schemm = most_freq_date_month 	if s4_id == "`id'" & (x4schemm == . | x4schedd == . | x4scheyy == .)
	replace x4schedd = most_freq_date_day 		if s4_id == "`id'" & (x4schemm == . | x4schedd == . | x4scheyy == .)
	replace x4scheyy = most_freq_date_year		if s4_id == "`id'" & (x4schemm == . | x4schedd == . | x4scheyy == .)
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

quietly levelsof s6_id, local(school_ids)

quietly foreach id of local school_ids {
    egen count = count(1) if s6_id == "`id'" & x6schemm != . & x6schedd !=. & x6scheyy !=., by(x6schemm x6schedd x6scheyy)
	gen neg_count = -count
	sort neg_count 
	
	gen most_freq_date_month 	= x6schemm if _n == 1 
	gen most_freq_date_day 		= x6schedd if _n == 1 
	gen most_freq_date_year 	= x6scheyy if _n == 1 
	
	replace most_freq_date_month 	= most_freq_date_month[_n-1] if missing(most_freq_date_month)
	replace most_freq_date_day		= most_freq_date_day[_n-1] if missing(most_freq_date_day)
	replace most_freq_date_year 	= most_freq_date_year[_n-1] if missing(most_freq_date_year)
	
	replace x6schemm = most_freq_date_month 	if s6_id == "`id'" & (x6schemm == . | x6schedd == . | x6scheyy == .)
	replace x6schedd = most_freq_date_day 		if s6_id == "`id'" & (x6schemm == . | x6schedd == . | x6scheyy == .)
	replace x6scheyy = most_freq_date_year		if s6_id == "`id'" & (x6schemm == . | x6schedd == . | x6scheyy == .)
	
	drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
	quietly
}

/* Save as temporary dataset */ 
save "${data_directory}\eclsk11\impact-measure-estimate-temp.dta", replace

/************************************************
COMBINE SEPARATE DATE VARIABLES INTO DATE OBJECTS   
*************************************************/
use "${data_directory}\eclsk11\impact-measure-estimate-temp.dta", clear

gen assessdate1 = mdy(x1asmtmm, x1asmtdd, x1asmtyy)
gen assessdate2 = mdy(x2asmtmm, x2asmtdd, x2asmtyy)
gen assessdate3 = mdy(x3asmtmm, x3asmtdd, x3asmtyy)
gen assessdate4 = mdy(x4asmtmm, x4asmtdd, x4asmtyy)
gen assessdate5 = mdy(x5asmtmm, x5asmtdd, x5asmtyy)
gen assessdate6 = mdy(x6asmtmm, x6asmtdd, x6asmtyy)

gen sch_beg2 = mdy(x2schbmm, x2schbdd, x2schbyy)
gen sch_beg4 = mdy(x4schbmm, x4schbdd, x4schbyy)
gen sch_beg6 = mdy(x6schbmm, x6schbdd, x6schbyy)

gen sch_end2 = mdy(x2schemm, x2schedd, x2scheyy)
gen sch_end4 = mdy(x4schemm, x4schedd, x4scheyy)
gen sch_end6 = mdy(x6schemm, x6schedd, x6scheyy)

format assessdate1 %td
format assessdate2 %td
format assessdate3 %td
format assessdate4 %td
format assessdate5 %td
format assessdate6 %td

format sch_beg2 %td
format sch_beg4 %td
format sch_beg6 %td

format sch_end2 %td
format sch_end4 %td
format sch_end6 %td

label variable assessdate1 "Child assessment date, Fall Kindergarten"
label variable assessdate2 "Child assessment date, Spring Kindergarten"
label variable assessdate3 "Child assessment date, Fall 1st grade"
label variable assessdate4 "Child assessment date, Spring 1st grade"
label variable assessdate5 "Child assessment date, Fall 2nd grade"
label variable assessdate6 "Child assessment date, Spring 2nd grade"

label variable sch_beg2 "School start date, Kindergarten"
label variable sch_beg4 "School start date, 1st grade"
label variable sch_beg6 "School start date, 2nd grade"

label variable sch_end2 "School end date, Kindergarten"
label variable sch_end4 "School end date, 1st grade"
label variable sch_end6 "School end date, 2nd grade"

/***************************************
DEAL WITH MISSING DATA AND DROP STUDENTS   
****************************************/
/* Drop if students missing school IDs for K-2nd grade */ 
drop if s1_id == ""
drop if s2_id == ""
drop if s3_id == ""
drop if s4_id == ""
drop if s5_id == ""
drop if s6_id == ""

/* Drop if students attended school all year long */ 
drop if syrrnd4 == 1

/* Drop if students transferred schools during 1st grade */ 
** Create measure for if s1_id and s2_id don't match and s3_id and s4_id don't match
gen ktrans = 0
replace ktrans = 1 if s1_id != s2_id & s1_id != "" & s2_id != ""

gen ftrans = 0 
replace ftrans = 1 if s3_id != s4_id & s3_id != "" & s4_id != ""

gen strans = 0 
replace strans = 1 if s5_id != s6_id & s5_id != "" & s6_id != ""

drop if ktrans == 1
drop if ftrans == 1
drop if strans == 1
drop ktrans ftrans strans

/* Drop if students attended summer school after kindergarten before 1st grade */ 
drop if smschl3 == 1

/************************************
CALCULATE EXPOSURES FROM DATE OBJECTS   
*************************************/
** # of months between start of Kindergarten and Kindergarten Fall assessment
gen k_exp_w1 = (assessdate1 - sch_beg2)/30
label variable k_exp_w1 "# of months between start of Kindergarten and Kindergarten Fall assessment"

** # of months between start of Kindergarten and Kindergarten Spring assessment
gen k_exp_w2 = (assessdate2 - sch_beg2)/30
label variable k_exp_w2 "# of months between start of Kindergarten and Kindergarten Spring assessment"

** # of months from start to end of Kindergarten 
gen k_exp_w3 = (sch_end2 - sch_beg2)/30
gen k_exp_w4 = (sch_end2 - sch_beg2)/30
gen k_exp_w5 = (sch_end2 - sch_beg2)/30
gen k_exp_w6 = (sch_end2 - sch_beg2)/30

label variable k_exp_w3 "# of months from start to end of Kindergarten"
label variable k_exp_w4 "# of months from start to end of Kindergarten"
label variable k_exp_w5 "# of months from start to end of Kindergarten"
label variable k_exp_w6 "# of months from start to end of Kindergarten"

** # of months over the summer before 1st grade
gen s1_exp_w1 = 0
gen s1_exp_w2 = 0
gen s1_exp_w3 = (sch_beg4 - sch_end2)/30
gen s1_exp_w4 = (sch_beg4 - sch_end2)/30
gen s1_exp_w5 = (sch_beg4 - sch_end2)/30
gen s1_exp_w6 = (sch_beg4 - sch_end2)/30

label variable s1_exp_w1 "# of months over the summer before 1st grade"
label variable s1_exp_w2 "# of months over the summer before 1st grade"
label variable s1_exp_w3 "# of months over the summer before 1st grade"
label variable s1_exp_w4 "# of months over the summer before 1st grade"
label variable s1_exp_w5 "# of months over the summer before 1st grade"
label variable s1_exp_w6 "# of months over the summer before 1st grade"

** # of months in between start of 1st grade and 1st grade Fall assessment 
gen frst_exp_w1 = 0
gen frst_exp_w2 = 0
gen frst_exp_w3 = (assessdate3 - sch_beg4)/30

label variable frst_exp_w1 "# of months in between start of 1st grade and 1st grade Fall assessment"
label variable frst_exp_w2 "# of months in between start of 1st grade and 1st grade Fall assessment"
label variable frst_exp_w3 "# of months in between start of 1st grade and 1st grade Fall assessment"

** # of months in between start of 1st grade and 1st grade Spring assessment
gen frst_exp_w4 = (assessdate4 - sch_beg4)/30
label variable frst_exp_w4 "# of months in between start of 1st grade and 1st grade Spring assessment"

** # of months from start to end of 1st grade
gen frst_exp_w5 = (sch_end4 - sch_beg4)/30
gen frst_exp_w6 = (sch_end4 - sch_beg4)/30

label variable k_exp_w5 "# of months from start to end of 1st grade"
label variable k_exp_w6 "# of months from start to end of 1st grade"

** # of months over the summer before 2nd grade
gen s2_exp_w1 = 0
gen s2_exp_w2 = 0
gen s2_exp_w3 = 0
gen s2_exp_w4 = 0
gen s2_exp_w5 = (sch_beg6 - sch_end4)/30
gen s2_exp_w6 = (sch_beg6 - sch_end4)/30

label variable s2_exp_w1 "# of months over the summer before 2nd grade"
label variable s2_exp_w2 "# of months over the summer before 2nd grade"
label variable s2_exp_w3 "# of months over the summer before 2nd grade"
label variable s2_exp_w4 "# of months over the summer before 2nd grade"
label variable s2_exp_w5 "# of months over the summer before 2nd grade"
label variable s2_exp_w6 "# of months over the summer before 2nd grade"

** # of months in between start of 2nd grade and 2nd grade Fall assessment 
gen scnd_exp_w1 = 0
gen scnd_exp_w2 = 0
gen scnd_exp_w3 = 0
gen scnd_exp_w4 = 0
gen scnd_exp_w5 = (assessdate5 - sch_beg6)/30

label variable scnd_exp_w1 "# of months in between start of 2nd grade and 2nd grade Fall assessment"
label variable scnd_exp_w2 "# of months in between start of 2nd grade and 2nd grade Fall assessment"
label variable scnd_exp_w3 "# of months in between start of 2nd grade and 2nd grade Fall assessment"
label variable scnd_exp_w4 "# of months in between start of 2nd grade and 2nd grade Fall assessment"
label variable scnd_exp_w5 "# of months in between start of 2nd grade and 2nd grade Fall assessment"

** # of months in between start of 2nd grade and 2nd grade Spring assessment
gen scnd_exp_w6 = (assessdate6 - sch_beg6)/30
label variable scnd_exp_w6 "# of months in between start of 2nd grade and 2nd grade Spring assessment"

/**********************
KEEP RELEVANT VARIABLES   
***********************/
/* Quick count */ 
count if 	rdtheta1 != . & ///
			mththeta1 != . & ///
			rdtheta2 != . & ///
			mththeta2 != . & ///
			sctheta2 != . & ///
			rdtheta3 != . & ///
			mththeta3 != . & ///
			sctheta3 != . & ///
			rdtheta4 != . & ///
			mththeta4 != . & ///
			sctheta4 != . & ///
			rdtheta5 != . & ///
			mththeta5 != . & ///
			sctheta5 != . & ///
			rdtheta6 != . & ///
			mththeta6 != . & ///
			sctheta6 != .
			
count if 	rdtheta1 != . & ///
			mththeta1 != . & ///
			rdtheta2 != . & ///
			mththeta2 != . & ///
			sctheta2 != . & ///
			rdtheta3 != . & ///
			mththeta3 != . & ///
			sctheta3 != . & ///
			rdtheta4 != . & ///
			mththeta4 != . & ///
			sctheta4 != . & ///
			rdtheta5 != . & ///
			mththeta5 != . & ///
			sctheta5 != . & ///
			rdtheta6 != . & ///
			mththeta6 != . & ///
			sctheta6 != . & ///
			k_exp_w1 != . & ///
			k_exp_w2 != . & ///
			k_exp_w3 != . & ///
			k_exp_w4 != . & ///
			k_exp_w5 != . & ///
			k_exp_w6 != . & ///
			s1_exp_w1 != . & ///
			s1_exp_w2 != . & ///
			s1_exp_w3 != . & ///
			s1_exp_w4 != . & ///
			s1_exp_w5 != . & ///
			s1_exp_w6 != . & ///			
			frst_exp_w1 != . & ///
			frst_exp_w2 != . & ///
			frst_exp_w3 != . & ///
			frst_exp_w4 != . & ///
			frst_exp_w5 != . & ///
			frst_exp_w6 != . & ///
			s2_exp_w1 != . & ///
			s2_exp_w2 != . & ///
			s2_exp_w3 != . & ///
			s2_exp_w4 != . & ///
			s2_exp_w5 != . & ///
			s2_exp_w6 != . & ///			
			scnd_exp_w1 != . & ///
			scnd_exp_w2 != . & ///
			scnd_exp_w3 != . & ///
			scnd_exp_w4 != . & ///
			scnd_exp_w5 != . & ///
			scnd_exp_w6 != .
			
/* Save as temporary dataset */ 
save "${data_directory}\eclsk11\impact-measure-estimate-temp2.dta", replace			

/* Keep only relevant variables for now */ 
keep ///
	k_exp_w1 k_exp_w2 k_exp_w3 k_exp_w4 k_exp_w5 k_exp_w6 ///
	s1_exp_w1 s1_exp_w2 s1_exp_w3 s1_exp_w4 s1_exp_w5 s1_exp_w6 ///
	frst_exp_w1 frst_exp_w2 frst_exp_w3 frst_exp_w4 frst_exp_w5 frst_exp_w6 ///
	s2_exp_w1 s2_exp_w2 s2_exp_w3 s2_exp_w4 s2_exp_w5 s2_exp_w6 ///
	scnd_exp_w1 scnd_exp_w2 scnd_exp_w3 scnd_exp_w4 scnd_exp_w5 scnd_exp_w6 ///
	childid s1_id s2_id s3_id s4_id s5_id s6_id ///
	rdtheta1 rdtheta2 rdtheta3 rdtheta4 rdtheta5 rdtheta6 ///
	mththeta1 mththeta2 mththeta3 mththeta4 mththeta5 mththeta6 ///
	race sfrlnch4

/* Rename school ID variables to keep naming consistent */ 
rename s1_id s_id1
rename s2_id s_id2
rename s3_id s_id3
rename s4_id s_id4
rename s5_id s_id5
rename s6_id s_id6

/* Drop if not at the same school during*/ 
drop if (s_id1 != s_id2) | (s_id1 != s_id3) | (s_id1 != s_id4) | (s_id1 != s_id5) | (s_id1 != s_id6)

/* Compute mean and SD for test score measures at Fall K to use for standardization */
sum rdtheta1
sum mththeta1
		
/*******************************
RESHAPE DATA TO LONG    
********************************/
reshape long	rdtheta mththeta ///
				k_exp_w s1_exp_w frst_exp_w s2_exp_w scnd_exp_w ///
				s_id, ///
				i(childid) j(wave)
				
/* Standardize test score measures using Fall K test score mean & SD */
gen temp = (rdtheta + 1.168691)/.7858335
drop rdtheta
rename temp rdtheta 

gen temp = (mththeta + 1.074036)/.6856962
drop mththeta
rename temp mththeta

/******************************************
MIXED EFFECTS MODEL FOR READING TEST SCORES   
*******************************************/
/* Mixed model and predict, with maximum # iterations to speed it up */ 
mixed		rdtheta ///
			k_exp_w s1_exp_w frst_exp_w s2_exp_w scnd_exp_w /// 
			|| s_id: k_exp_w s1_exp_w frst_exp_w s2_exp_w scnd_exp_w, cov(id) ///
			|| childid: k_exp_w s1_exp_w frst_exp_w s2_exp_w scnd_exp_w, cov(id) /// 
			mle difficult nostderr iterate(5)

predict b*, reffects

/* Generate reading impact measures */
lincom k_exp_w
gen re_k_read_mixed = r(estimate)

lincom s1_exp_w 
gen re_s1_read_mixed = r(estimate)

lincom frst_exp_w
gen re_frst_read_mixed = r(estimate)

lincom s2_exp_w 
gen re_s2_read_mixed = r(estimate)

lincom scnd_exp_w
gen re_scnd_read_mixed = r(estimate)

** Generate Downey impact measure for reading test scores
gen re_1st_impact_read_mixed = (re_frst_read_mixed + b3) - (re_s1_read_mixed + b2)
gen re_2nd_impact_read_mixed = (re_scnd_read_mixed + b5) - (re_s2_read_mixed + b4)
gen re_impact_read_mixed = (re_1st_impact_read_mixed + re_2nd_impact_read_mixed)/2
label variable re_impact_read_mixed "Downey impact measure reading from Stata"

drop ///
	b* ///
	re_k_read_mixed re_s1_read_mixed re_frst_read_mixed re_s2_read_mixed re_scnd_read_mixed ///
	re_1st_impact_read_mixed re_2nd_impact_read_mixed

/***************************************
MIXED EFFECTS MODEL FOR MATH TEST SCORES   
****************************************/
/* Mixed model and predict, with maximum # iterations to speed it up */ 
mixed		mththeta ///
			k_exp_w s1_exp_w frst_exp_w s2_exp_w scnd_exp_w /// 
			|| s_id: k_exp_w s1_exp_w frst_exp_w s2_exp_w scnd_exp_w, cov(id) ///
			|| childid: k_exp_w s1_exp_w frst_exp_w s2_exp_w scnd_exp_w, cov(id) /// 
			mle difficult nostderr iterate(5)

predict b*, reffects

/* Generate math impact measures */
lincom k_exp_w
gen re_k_math_mixed = r(estimate)

lincom s1_exp_w 
gen re_s1_math_mixed = r(estimate)

lincom frst_exp_w
gen re_frst_math_mixed = r(estimate)

lincom s2_exp_w 
gen re_s2_math_mixed = r(estimate)

lincom scnd_exp_w
gen re_scnd_math_mixed = r(estimate)

** Generate Downey impact measure for reading test scores
gen re_1st_impact_math_mixed = (re_frst_math_mixed + b3) - (re_s1_math_mixed + b2)
gen re_2nd_impact_math_mixed = (re_scnd_math_mixed + b5) - (re_s2_math_mixed + b4)
gen re_impact_math_mixed = (re_1st_impact_math_mixed + re_2nd_impact_math_mixed)/2
label variable re_impact_math_mixed "Downey impact measure math from Stata"

drop ///
	b* ///
	re_k_math_mixed re_s1_math_mixed re_frst_math_mixed re_s2_math_mixed re_scnd_math_mixed ///
	re_1st_impact_math_mixed re_2nd_impact_math_mixed

/*******************************************************************
HLM in batch mode to produce similar Downey impact measures as above   
********************************************************************/
/* Reading test score error variances */ 
sum rdtheta if wave == 1
sum rdtheta if wave == 2
sum rdtheta if wave == 3
sum rdtheta if wave == 4
sum rdtheta if wave == 5
sum rdtheta if wave == 6

gen rmvar = . 
replace rmvar = (1-.92)*((1)^2) if wave == 1
replace rmvar = (1-.94)*((.8202058)^2) if wave == 2
replace rmvar = (1-.95)*((.7129361)^2) if wave == 3
replace rmvar = (1-.95)*((.5663718)^2) if wave == 4
replace rmvar = (1-.95)*((.4997028)^2) if wave == 5
replace rmvar = (1-.91)*((.4403326)^2) if wave == 6

label variable rmvar "Reading test score error variances Downey impact, HLM"

/* Math test score error variances */ 
sum mththeta if wave == 1
sum mththeta if wave == 2
sum mththeta if wave == 3
sum mththeta if wave == 4
sum mththeta if wave == 5
sum mththeta if wave == 6

gen mmvar = .
replace mmvar = (1-.92)*((1)^2) if wave == 1
replace mmvar = (1-.93)*((.8561867)^2) if wave == 2
replace mmvar = (1-.93)*((.8370692)^2) if wave == 3
replace mmvar = (1-.93)*((.7530105)^2) if wave == 4
replace mmvar = (1-.93)*((.7424478)^2) if wave == 5
replace mmvar = (1-.94)*((.7249281)^2) if wave == 6

label variable mmvar "Math test score error variances Downey impact, HLM"

/* Rename variables */ 
rename s_id schoolid
rename childid stdid
rename rdtheta read
rename mththeta math
rename k_exp_w kind
rename s1_exp_w sum1
rename frst_exp_w gr1
rename s2_exp_w sum2
rename scnd_exp_w gr2

replace race = 9999 if race == .
replace sfrlnch4 = 9999 if sfrlnch4 == .

/* Set directories and sort by IDs and run HLM models */ 
glob drive "C:\Users\wodtke\Desktop\projects"
cd "${data_directory}\hlm-reference\"
sysdir set PERSONAL "C:\Program Files (x86)\Stata15\ado\personal\" 

sort schoolid stdid
hlm mkmdm using downey_nowt, type(hlm3) id3(schoolid) id2(stdid) l1(read math rmvar mmvar kind sum1 gr1 sum2 gr2) ///
	l2(race) ///
	l3(sfrlnch4) miss(now) run replace
	
hlm mdmset downey_nowt.mdm

foreach s in read math {

	if "`s'"=="read" loc wt="rmvar"
	if "`s'"=="math" loc wt="mmvar"

	hlm hlm3 `s' int(int(int rand) rand) ///
		kind(int(int rand) rand) ///
		sum1(int(int rand) rand) ///
		gr1(int(int rand) rand) ///
		sum2(int(int rand) rand) ///
		gr2(int(int rand) rand) rand, ///
		cmd(nowt_`s'_m1) pwgt(`wt') run replace res3
	matrix tau2 = e(tau2)
	loc int2 = tau2[1,1]
	loc kind2 = tau2[2,2]
	loc sum12 = tau2[3,3]
	loc gr12 = tau2[4,4]
	loc sum22 = tau2[5,5]
	loc gr22 = tau2[6,6]
	matrix tau3 = e(tau3)
	loc int3 = tau3[1,1]
	loc kind3 = tau3[2,2]
	loc sum13 = tau3[3,3]
	loc gr13 = tau3[4,4]
	loc sum23 = tau3[5,5]
	loc gr23 = tau3[6,6]
	estadd scalar int2 = `int2', replace
	estadd scalar kind2 = `kind2', replace
	estadd scalar sum12 = `sum12', replace
	estadd scalar gr12 = `gr12', replace
	estadd scalar sum22 = `sum22', replace
	estadd scalar gr22 = `gr22', replace
	estadd scalar int3 = `int3', replace
	estadd scalar kind3 = `kind3', replace
	estadd scalar sum13 = `sum13', replace
	estadd scalar gr13 = `gr13', replace
	estadd scalar sum23 = `sum23', replace
	estadd scalar gr23 = `gr23', replace
	est store m1`s'
}

rename schoolid L3ID 

/* Generate learning rates for reading */ 
merge n:1 L3ID using "${data_directory}hlm-reference\nowt_read_m1_res3.dta", keepusing(EB00 EB10 EB20 EB30 EB40 EB50)

sum EB*

gen re_schlyr_read_HLM = ((0.102072 + EB30) + (0.045019 + EB50))*0.5
gen re_summer_read_HLM = ((-0.053806 + EB20) + (-0.023049 + EB40))*0.5
sum re_schlyr_read_HLM re_summer_read_HLM, detail
replace re_summer_read_HLM=r(p99) if re_summer_read_HLM>r(p99) & re_summer_read_HLM<999

drop EB* _merge

/* Generate impact scores for math */ 
merge n:1 L3ID using "${data_directory}hlm-reference\nowt_math_m1_res3.dta", keepusing(EB00 EB10 EB20 EB30 EB40 EB50)

sum EB* _merge

** Downey impact measure for math test scores
gen re_schlyr_math_HLM = ((0.119258 + EB30) + (0.082309 + EB50))*0.5
gen re_summer_math_HLM = ((0.000499 + EB20) + (-0.037127 + EB40))*0.5
sum re_schlyr_math_HLM re_summer_math_HLM, detail

drop EB* _merge

/* Rename variables back to original names */ 
rename L3ID s_id
rename stdid childid
rename read rdtheta
rename math mththeta
rename kind k_exp_w
rename sum1 s1_exp_w
rename gr1 frst_exp_w
rename sum2 s2_exp_w
rename gr2 scnd_exp_w

/* Re-add race and free or reduced lunch missing values */ 
replace race = . if race == 9999
replace sfrlnch4 = . if sfrlnch4 == 9999

/* Save as temporary dataset */ 
save "${data_directory}\eclsk11\impact-measure-estimate-temp3.dta", replace

/***************************************************
SAVE DATASETS AND MERGE BACK INTO THE ECLS-K DATASET    
****************************************************/
/* Rename key variables */ 
rename re_schlyr_math_HLM                  re_schlyr_math
rename re_schlyr_read_HLM                  re_schlyr_read
rename re_summer_math_HLM                  re_summer_math
rename re_summer_read_HLM                  re_summer_read

rename childid CHILDID

/* Keep only necessary variables */
keep CHILDID ///
     wave ///
     s_id ///
     re_schlyr_math ///
     re_schlyr_read ///
	 re_summer_math ///
	 re_summer_read
	
/* Reshape data to wide */ 
reshape wide s_id, i(CHILDID) j(wave)

rename s_id1 S1_ID
rename s_id2 S2_ID
rename s_id3 S3_ID
rename s_id4 S4_ID
rename CHILDID childid

/* Save as temporary dataset */ 
save "${data_directory}\eclsk11\impact-measure-estimate-temp4.dta", replace
			
/* Merge dataset back into ECLS-K dataset */ 
merge 1:1 childid using "${data_directory}\eclsk11\impact-measure-estimate-temp2.dta"

/* Save as eclsk11v4 dataset */
save "${data_directory}\eclsk11\eclsk11v4.dta", replace

/* Save as eclsk11v4 dataset */
save "${data_directory}\eclsk11\eclsk11v4.dta", replace 

/******************************
MERGE BACK IN WITH FULL DATASET    
*******************************/
/* Merge back in with full dataset */ 
keep childid ///
	 re_schlyr_math ///
     re_schlyr_read ///
	 re_summer_math ///
	 re_summer_read

merge 1:1 childid using "${data_directory}eclsk11\eclsk11v3.dta"

drop _merge 

sort s3_id
foreach x in re_schlyr_math re_schlyr_read re_summer_math re_summer_read {
	by s3_id: egen temp=mean(`x')
	replace `x'=temp if `x'==. & s3_id!=""
	drop temp
	}

/* Save as eclsk11v4 dataset */
save "${data_directory}\eclsk11\eclsk11v4.dta", replace 

/* Drop temporary datasets */
erase "${data_directory}\eclsk11\impact-measure-estimate-temp.dta"
erase "${data_directory}\eclsk11\impact-measure-estimate-temp2.dta"
erase "${data_directory}\eclsk11\impact-measure-estimate-temp3.dta"
erase "${data_directory}\eclsk11\impact-measure-estimate-temp4.dta"

clear
log close





