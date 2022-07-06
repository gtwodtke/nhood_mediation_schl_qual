log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\1-generate-impact-measures\0-exposure-calculations.log", replace

/************************
IMPACT MEASURE ESTIMATION
************************/

/*** Read data ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\8-merged-data-keep-ccd-pss-geolytics.dta", clear





/*** Calculate exposure ***/

/* Get a sense of missingness */

// Assessment date

local assessment C1ASMTMM C1ASMTDD C1ASMTYY ///
				 C2ASMTMM C2ASMTDD C2ASMTYY ///
				 C3ASMTMM C3ASMTDD C3ASMTYY ///
				 C4ASMTMM C4ASMTDD C4ASMTYY

foreach var of local assessment {
    count if `var' >= .
}

// School start date

local start U2SCHBMM U2SCHBDD U2SCHBYY ///
			U4SCHBMM U4SCHBDD U4SCHBYY

foreach var of local start {
    count if `var' >= .
}

// School end date

local end U2SCHEMM U2SCHEDD U2SCHEYY ///
		  U4SCHEMM U4SCHEDD U4SCHEYY

foreach var of local end {
    count if `var' >= .
}





/* Fill in missing values (Round 1)  */

// Assessment date

levelsof S1_ID, local(school_ids)

foreach id of local school_ids {

     egen count = count(1) if S1_ID == "`id'" & C1ASMTDD != ., by(C1ASMTMM C1ASMTDD C1ASMTYY)
	 
	 gen neg_count = -count
	 
	 sort neg_count
	 
	 gen most_freq_date_month = C1ASMTMM if _n == 1
	 gen most_freq_date_day   = C1ASMTDD if _n == 1
	 gen most_freq_date_year  = C1ASMTYY if _n == 1
	 
	 replace most_freq_date_month = most_freq_date_month[_n-1] if missing(most_freq_date_month)
	 replace most_freq_date_day   = most_freq_date_day[_n-1]   if missing(most_freq_date_day)
	 replace most_freq_date_year  = most_freq_date_year[_n-1]  if missing(most_freq_date_year)
	 
	 replace C1ASMTMM = most_freq_date_month if S1_ID == "`id'" & C1ASMTMM == .
	 replace C1ASMTDD = most_freq_date_day   if S1_ID == "`id'" & C1ASMTDD == .
	 replace C1ASMTYY = most_freq_date_year  if S1_ID == "`id'" & C1ASMTYY == .
	 
	 drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}

levelsof S2_ID, local(school_ids)

foreach id of local school_ids {

     egen count = count(1) if S2_ID == "`id'" & C2ASMTDD != ., by(C2ASMTMM C2ASMTDD C2ASMTYY)
	 
	 gen neg_count = -count
	 
	 sort neg_count
	 
	 gen most_freq_date_month = C2ASMTMM if _n == 1
	 gen most_freq_date_day   = C2ASMTDD if _n == 1
	 gen most_freq_date_year  = C2ASMTYY if _n == 1
	 
	 replace most_freq_date_month = most_freq_date_month[_n-1] if missing(most_freq_date_month)
	 replace most_freq_date_day   = most_freq_date_day[_n-1]   if missing(most_freq_date_day)
	 replace most_freq_date_year  = most_freq_date_year[_n-1]  if missing(most_freq_date_year)
	 
	 replace C2ASMTMM = most_freq_date_month if S2_ID == "`id'" & C2ASMTMM == .
	 replace C2ASMTDD = most_freq_date_day   if S2_ID == "`id'" & C2ASMTDD == .
	 replace C2ASMTYY = most_freq_date_year  if S2_ID == "`id'" & C2ASMTYY == .
	 
	 drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}

levelsof S3_ID, local(school_ids)

foreach id of local school_ids {

     egen count = count(1) if S3_ID == "`id'" & C3ASMTDD != ., by(C3ASMTMM C3ASMTDD C3ASMTYY)
	 
	 gen neg_count = -count
	 
	 sort neg_count
	 
	 gen most_freq_date_month = C3ASMTMM if _n == 1
	 gen most_freq_date_day   = C3ASMTDD if _n == 1
	 gen most_freq_date_year  = C3ASMTYY if _n == 1
	 
	 replace most_freq_date_month = most_freq_date_month[_n-1] if missing(most_freq_date_month)
	 replace most_freq_date_day   = most_freq_date_day[_n-1]   if missing(most_freq_date_day)
	 replace most_freq_date_year  = most_freq_date_year[_n-1]  if missing(most_freq_date_year)
	 
	 replace C3ASMTMM = most_freq_date_month if S3_ID == "`id'" & C3ASMTMM == .
	 replace C3ASMTDD = most_freq_date_day   if S3_ID == "`id'" & C3ASMTDD == .
	 replace C3ASMTYY = most_freq_date_year  if S3_ID == "`id'" & C3ASMTYY == .
	 
	 drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}

levelsof S4_ID, local(school_ids)

foreach id of local school_ids {

     egen count = count(1) if S4_ID == "`id'" & C4ASMTDD != ., by(C4ASMTMM C4ASMTDD C4ASMTYY)
	 
	 gen neg_count = -count
	 
	 sort neg_count
	 
	 gen most_freq_date_month = C4ASMTMM if _n == 1
	 gen most_freq_date_day   = C4ASMTDD if _n == 1
	 gen most_freq_date_year  = C4ASMTYY if _n == 1
	 
	 replace most_freq_date_month = most_freq_date_month[_n-1] if missing(most_freq_date_month)
	 replace most_freq_date_day   = most_freq_date_day[_n-1]   if missing(most_freq_date_day)
	 replace most_freq_date_year  = most_freq_date_year[_n-1]  if missing(most_freq_date_year)
	 
	 replace C4ASMTMM = most_freq_date_month if S4_ID == "`id'" & C4ASMTMM == .
	 replace C4ASMTDD = most_freq_date_day   if S4_ID == "`id'" & C4ASMTDD == .
	 replace C4ASMTYY = most_freq_date_year  if S4_ID == "`id'" & C4ASMTYY == .
	 
	 drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}

// School start date

levelsof S2_ID, local(school_ids)

foreach id of local school_ids {

     egen count = count(1) if S2_ID == "`id'" & U2SCHBMM != . & U2SCHBDD != . & U2SCHBYY != ., by(U2SCHBMM U2SCHBDD U2SCHBYY)
	 
	 gen neg_count = -count
	 
	 sort neg_count
	 
	 gen most_freq_date_month = U2SCHBMM if _n == 1
	 gen most_freq_date_day   = U2SCHBDD if _n == 1
	 gen most_freq_date_year  = U2SCHBYY if _n == 1
	 
	 replace most_freq_date_month = most_freq_date_month[_n-1] if missing(most_freq_date_month)
	 replace most_freq_date_day   = most_freq_date_day[_n-1]   if missing(most_freq_date_day)
	 replace most_freq_date_year  = most_freq_date_year[_n-1]  if missing(most_freq_date_year)
	 
	 replace U2SCHBMM = most_freq_date_month if S2_ID == "`id'" & (U2SCHBMM == . | U2SCHBDD == . | U2SCHBYY == .)
	 replace U2SCHBDD = most_freq_date_day   if S2_ID == "`id'" & (U2SCHBMM == . | U2SCHBDD == . | U2SCHBYY == .)
	 replace U2SCHBYY = most_freq_date_year  if S2_ID == "`id'" & (U2SCHBMM == . | U2SCHBDD == . | U2SCHBYY == .)
	 
	 drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}

levelsof S4_ID, local(school_ids)

foreach id of local school_ids {

     egen count = count(1) if S4_ID == "`id'" & U4SCHBMM != . & U4SCHBDD != . & U4SCHBYY != ., by(U4SCHBMM U4SCHBDD U4SCHBYY)
	 
	 gen neg_count = -count
	 
	 sort neg_count
	 
	 gen most_freq_date_month = U4SCHBMM if _n == 1
	 gen most_freq_date_day   = U4SCHBDD if _n == 1
	 gen most_freq_date_year  = U4SCHBYY if _n == 1
	 
	 replace most_freq_date_month = most_freq_date_month[_n-1] if missing(most_freq_date_month)
	 replace most_freq_date_day   = most_freq_date_day[_n-1]   if missing(most_freq_date_day)
	 replace most_freq_date_year  = most_freq_date_year[_n-1]  if missing(most_freq_date_year)
	 
	 replace U4SCHBMM = most_freq_date_month if S4_ID == "`id'" & (U4SCHBMM == . | U4SCHBDD == . | U4SCHBYY == .)
	 replace U4SCHBDD = most_freq_date_day   if S4_ID == "`id'" & (U4SCHBMM == . | U4SCHBDD == . | U4SCHBYY == .)
	 replace U4SCHBYY = most_freq_date_year  if S4_ID == "`id'" & (U4SCHBMM == . | U4SCHBDD == . | U4SCHBYY == .)
	 
	 drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}

// School end date

levelsof S2_ID, local(school_ids)

foreach id of local school_ids {

     egen count = count(1) if S2_ID == "`id'" & U2SCHEMM != . & U2SCHEDD != . & U2SCHEYY != ., by(U2SCHEMM U2SCHEDD U2SCHEYY)
	 
	 gen neg_count = -count
	 
	 sort neg_count
	 
	 gen most_freq_date_month = U2SCHEMM if _n == 1
	 gen most_freq_date_day   = U2SCHEDD if _n == 1
	 gen most_freq_date_year  = U2SCHEYY if _n == 1
	 
	 replace most_freq_date_month = most_freq_date_month[_n-1] if missing(most_freq_date_month)
	 replace most_freq_date_day   = most_freq_date_day[_n-1]   if missing(most_freq_date_day)
	 replace most_freq_date_year  = most_freq_date_year[_n-1]  if missing(most_freq_date_year)
	 
	 replace U2SCHEMM = most_freq_date_month if S2_ID == "`id'" & (U2SCHEMM == . | U2SCHEDD == . | U2SCHEYY == .)
	 replace U2SCHEDD = most_freq_date_day   if S2_ID == "`id'" & (U2SCHEMM == . | U2SCHEDD == . | U2SCHEYY == .)
	 replace U2SCHEYY = most_freq_date_year  if S2_ID == "`id'" & (U2SCHEMM == . | U2SCHEDD == . | U2SCHEYY == .)
	 
	 drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}

levelsof S4_ID, local(school_ids)

foreach id of local school_ids {

     egen count = count(1) if S4_ID == "`id'" & U4SCHEMM != . & U4SCHEDD != . & U4SCHEYY != ., by(U4SCHEMM U4SCHEDD U4SCHEYY)
	 
	 gen neg_count = -count
	 
	 sort neg_count
	 
	 gen most_freq_date_month = U4SCHEMM if _n == 1
	 gen most_freq_date_day   = U4SCHEDD if _n == 1
	 gen most_freq_date_year  = U4SCHEYY if _n == 1
	 
	 replace most_freq_date_month = most_freq_date_month[_n-1] if missing(most_freq_date_month)
	 replace most_freq_date_day   = most_freq_date_day[_n-1]   if missing(most_freq_date_day)
	 replace most_freq_date_year  = most_freq_date_year[_n-1]  if missing(most_freq_date_year)
	 
	 replace U4SCHEMM = most_freq_date_month if S4_ID == "`id'" & (U4SCHEMM == . | U4SCHEDD == . | U4SCHEYY == .)
	 replace U4SCHEDD = most_freq_date_day   if S4_ID == "`id'" & (U4SCHEMM == . | U4SCHEDD == . | U4SCHEYY == .)
	 replace U4SCHEYY = most_freq_date_year  if S4_ID == "`id'" & (U4SCHEMM == . | U4SCHEDD == . | U4SCHEYY == .)
	 
	 drop count neg_count most_freq_date_month most_freq_date_day most_freq_date_year
}





/* Save data */

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-temp.dta", replace





/* Fill in missing values (Round 2)  */

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-temp.dta", clear

replace U2SCHBMM = 9    if U2SCHBMM == . | U2SCHBMM == .b | U2SCHBDD == . | U2SCHBDD == .b | U2SCHBYY == . | U2SCHBYY == .b
replace U2SCHBDD = 1    if U2SCHBMM == . | U2SCHBMM == .b | U2SCHBDD == . | U2SCHBDD == .b | U2SCHBYY == . | U2SCHBYY == .b
replace U2SCHBYY = 1998 if U2SCHBMM == . | U2SCHBMM == .b | U2SCHBDD == . | U2SCHBDD == .b | U2SCHBYY == . | U2SCHBYY == .b

replace U4SCHBMM = 9    if U4SCHBMM == . | U4SCHBMM == .b | U4SCHBDD == . | U4SCHBDD == .b | U4SCHBYY == . | U4SCHBYY == .b
replace U4SCHBDD = 1    if U4SCHBMM == . | U4SCHBMM == .b | U4SCHBDD == . | U4SCHBDD == .b | U4SCHBYY == . | U4SCHBYY == .b
replace U4SCHBYY = 1999 if U4SCHBMM == . | U4SCHBMM == .b | U4SCHBDD == . | U4SCHBDD == .b | U4SCHBYY == . | U4SCHBYY == .b

replace U2SCHEMM = 6    if U2SCHEMM == . | U2SCHEMM == .b | U2SCHEDD == . | U2SCHEDD == .b | U2SCHEYY == . | U2SCHEYY == .b
replace U2SCHEDD = 15   if U2SCHEMM == . | U2SCHEMM == .b | U2SCHEDD == . | U2SCHEDD == .b | U2SCHEYY == . | U2SCHEYY == .b
replace U2SCHEYY = 1999 if U2SCHEMM == . | U2SCHEMM == .b | U2SCHEDD == . | U2SCHEDD == .b | U2SCHEYY == . | U2SCHEYY == .b

replace U4SCHEMM = 6    if U4SCHEMM == . | U4SCHEMM == .b | U4SCHEDD == . | U4SCHEDD == .b | U4SCHEYY == . | U4SCHEYY == .b
replace U4SCHEDD = 15   if U4SCHEMM == . | U4SCHEMM == .b | U4SCHEDD == . | U4SCHEDD == .b | U4SCHEYY == . | U4SCHEYY == .b
replace U4SCHEYY = 2000 if U4SCHEMM == . | U4SCHEMM == .b | U4SCHEDD == . | U4SCHEDD == .b | U4SCHEYY == . | U4SCHEYY == .b





/* Save data */

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-temp2.dta", replace





/* Calculate everything */

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-temp2.dta", clear

// Round 1

// Combine DD, MM, YY variables into date objects

gen  wave1_assessment = mdy(C1ASMTMM, C1ASMTDD, C1ASMTYY)
gen  wave2_assessment = mdy(C2ASMTMM, C2ASMTDD, C2ASMTYY)
gen  wave3_assessment = mdy(C3ASMTMM, C3ASMTDD, C3ASMTYY)
gen  wave4_assessment = mdy(C4ASMTMM, C4ASMTDD, C4ASMTYY)

gen k_beg = mdy(U2SCHBMM, U2SCHBDD, U2SCHBYY)
gen k_end = mdy(U2SCHEMM, U2SCHEDD, U2SCHEYY)
gen first_beg = mdy(U4SCHBMM, U4SCHBDD, U4SCHBYY)
gen first_end = mdy(U4SCHEMM, U4SCHEDD, U4SCHEYY)

format wave1_assessment %td
format wave2_assessment %td
format wave3_assessment %td
format wave4_assessment %td

format k_beg %td
format k_end %td
format first_beg %td
format first_end %td

// Calculate exposures

gen k_exp_until_wave1 = (wave1_assessment - k_beg)/30
gen k_exp_until_wave2 = (wave2_assessment - k_beg)/30
gen k_exp_until_wave3 = (k_end - k_beg)/30
gen k_exp_until_wave4 = (k_end - k_beg)/30

gen s_exp_until_wave1 = 0
gen s_exp_until_wave2 = 0
gen s_exp_until_wave3 = (first_beg - k_end)/30
gen s_exp_until_wave4 = (first_beg - k_end)/30

gen first_exp_until_wave1 = 0
gen first_exp_until_wave2 = 0
gen first_exp_until_wave3 = (wave3_assessment - first_beg)/30
gen first_exp_until_wave4 = (wave4_assessment - first_beg)/30
	 
// Round 2

gen first_beg_temp = k_end if s_exp_until_wave3 < 0 | s_exp_until_wave4 < 0
gen k_end_temp = first_beg if s_exp_until_wave3 < 0 | s_exp_until_wave4 < 0

replace first_beg = first_beg_temp if s_exp_until_wave3 < 0 | s_exp_until_wave4 < 0

replace k_end = k_end_temp if s_exp_until_wave3 < 0 | s_exp_until_wave4 < 0
replace k_end = mdy(6,15,1999) if (s_exp_until_wave3 < 0 | s_exp_until_wave4 < 0) & k_end == mdy(9,1,1999)
format k_end %td

drop k_exp* first_exp* s_exp* first_beg_temp k_end_temp

gen k_exp_until_wave1 = (wave1_assessment - k_beg)/30
gen k_exp_until_wave2 = (wave2_assessment - k_beg)/30
gen k_exp_until_wave3 = (k_end - k_beg)/30
gen k_exp_until_wave4 = (k_end - k_beg)/30

gen s_exp_until_wave1 = 0
gen s_exp_until_wave2 = 0
gen s_exp_until_wave3 = (first_beg - k_end)/30
gen s_exp_until_wave4 = (first_beg - k_end)/30

gen first_exp_until_wave1 = 0
gen first_exp_until_wave2 = 0
gen first_exp_until_wave3 = (wave3_assessment - first_beg)/30
gen first_exp_until_wave4 = (wave4_assessment - first_beg)/30

// Round 3

replace k_beg = mdy(9,1,1998) if k_beg == mdy(9,1,1999) & (k_exp_until_wave3 < 0 | k_exp_until_wave4 < 0)
replace k_end = mdy(6,11,1999) if k_end == mdy(6,11,1998) & (k_exp_until_wave3 < 0 | k_exp_until_wave4 < 0)
format k_beg %td
format k_end %td

drop k_exp* first_exp* s_exp*

gen k_exp_until_wave1 = (wave1_assessment - k_beg)/30
gen k_exp_until_wave2 = (wave2_assessment - k_beg)/30
gen k_exp_until_wave3 = (k_end - k_beg)/30
gen k_exp_until_wave4 = (k_end - k_beg)/30

gen s_exp_until_wave1 = 0
gen s_exp_until_wave2 = 0
gen s_exp_until_wave3 = (first_beg - k_end)/30
gen s_exp_until_wave4 = (first_beg - k_end)/30

gen first_exp_until_wave1 = 0
gen first_exp_until_wave2 = 0
gen first_exp_until_wave3 = (wave3_assessment - first_beg)/30
gen first_exp_until_wave4 = (wave4_assessment - first_beg)/30

count if k_exp_until_wave1 <= 0 | ///
         k_exp_until_wave2 <= 0 | ///
         k_exp_until_wave3 <= 0 | ///
		 k_exp_until_wave4 <= 0
		 
count if s_exp_until_wave1 < 0 | ///
         s_exp_until_wave2 < 0 | ///
         s_exp_until_wave3 < 0 | ///
		 s_exp_until_wave4 < 0

count if first_exp_until_wave1 < 0 | ///
         first_exp_until_wave2 < 0 | ///
         first_exp_until_wave3 < 0 | ///
		 first_exp_until_wave4 < 0





/*** Save data ***/

drop _merge

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-temp3.dta", replace

log close





log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\1-generate-impact-measures\1-data-preparation.log", replace

/*** Prepare data for multilevel model and postestimation ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-temp3.dta", clear

global impact_main k_exp_until_wave1 k_exp_until_wave2 k_exp_until_wave3 k_exp_until_wave4 ///
s_exp_until_wave1 s_exp_until_wave2 s_exp_until_wave3 s_exp_until_wave4 ///
first_exp_until_wave1 first_exp_until_wave2 first_exp_until_wave3 first_exp_until_wave4

global impact_aux F4YRRND ///
P3SUMSCH ///
FKCHGSCH ///
R3R2SCHG ///
R4R2SCHG ///
R4R3SCHG ///
C1ASMTDD C2ASMTDD C3ASMTDD C4ASMTDD ///
C1ASMTMM C2ASMTMM C3ASMTMM C4ASMTMM ///
C1ASMTYY C2ASMTYY C3ASMTYY C4ASMTYY ///
U2SCHBDD U4SCHBDD ///
U2SCHBMM U4SCHBMM ///
U2SCHBYY U4SCHBYY ///
U2SCHEDD U4SCHEDD ///
U2SCHEMM U4SCHEMM ///
U2SCHEYY U4SCHEYY ///
wave1_assessment wave2_assessment wave3_assessment wave4_assessment ///
k_beg ///
k_end ///
first_beg ///
first_end ///
R4URBAN ///
S4MINOR ///
S4FLNCH ///
S4FLCH_I ///
S4RLNCH ///
S4RLCH_I ///
S4SCTYP ///
RACE

global idvars CHILDID ///
PARENTID ///
S1_ID S2_ID S3_ID S4_ID S5_ID S6_ID S7_ID ///
R3CCDSID R4CCDSID R5CCDSID R6CCDSID R7CCDSID ///
R3CCDLEA R4CCDLEA R5CCDLEA R6CCDLEA R7CCDLEA ///
R3SCHPIN R4SCHPIN R5SCHPIN R6SCHPIN R7SCHPIN ///
T1_ID T2_ID T4_ID T5_ID J61T_ID J62T_ID J71T_ID J72T_ID ///
tract1 tract2 tract3 tract4 tract5

global strings CHILDID ///
PARENTID ///
S1_ID S2_ID S3_ID S4_ID S5_ID S6_ID S7_ID ///
R3CCDSID R4CCDSID R5CCDSID R6CCDSID R7CCDSID ///
R3CCDLEA R4CCDLEA R5CCDLEA R6CCDLEA R7CCDLEA ///
R3SCHPIN R4SCHPIN R5SCHPIN R6SCHPIN R7SCHPIN ///
T1_ID T2_ID T4_ID T5_ID J61T_ID J62T_ID J71T_ID J72T_ID

global strings_na ///
R3CCDSID R4CCDSID R5CCDSID R6CCDSID R7CCDSID ///
R3CCDLEA R4CCDLEA R5CCDLEA R6CCDLEA R7CCDLEA ///
R3SCHPIN R4SCHPIN R5SCHPIN R6SCHPIN R7SCHPIN

keep k_exp_until_wave1 k_exp_until_wave2 k_exp_until_wave3 k_exp_until_wave4 ///
s_exp_until_wave1 s_exp_until_wave2 s_exp_until_wave3 s_exp_until_wave4 ///
first_exp_until_wave1 first_exp_until_wave2 first_exp_until_wave3 first_exp_until_wave4 ///
F4YRRND ///
P3SUMSCH ///
FKCHGSCH ///
R3R2SCHG ///
R4R2SCHG ///
R4R3SCHG ///
C1ASMTDD C2ASMTDD C3ASMTDD C4ASMTDD ///
C1ASMTMM C2ASMTMM C3ASMTMM C4ASMTMM ///
C1ASMTYY C2ASMTYY C3ASMTYY C4ASMTYY ///
U2SCHBDD U4SCHBDD ///
U2SCHBMM U4SCHBMM ///
U2SCHBYY U4SCHBYY ///
U2SCHEDD U4SCHEDD ///
U2SCHEMM U4SCHEMM ///
U2SCHEYY U4SCHEYY ///
wave1_assessment wave2_assessment wave3_assessment wave4_assessment ///
k_beg ///
k_end ///
first_beg ///
first_end ///
R4URBAN ///
S4MINOR ///
S4FLNCH ///
S4FLCH_I ///
S4RLNCH ///
S4RLCH_I ///
S4SCTYP ///
CHILDID ///
PARENTID ///
S1_ID S2_ID S3_ID S4_ID S5_ID S6_ID S7_ID ///
R3CCDSID R4CCDSID R5CCDSID R6CCDSID R7CCDSID ///
R3CCDLEA R4CCDLEA R5CCDLEA R6CCDLEA R7CCDLEA ///
R3SCHPIN R4SCHPIN R5SCHPIN R6SCHPIN R7SCHPIN ///
T1_ID T2_ID T4_ID T5_ID J61T_ID J62T_ID J71T_ID J72T_ID ///
tract1 tract2 tract3 tract4 tract5 ///
P3SMREQ ///
c1r4rtht_r c1r4mtht_r ///
c2r4rtht_r c2r4mtht_r ///
c3r4rtht_r c3r4mtht_r ///
c4r4rtht_r c4r4mtht_r ///
trct_disadv_index2 ///
RACE

gen F4YRRND_dup = F4YRRND

foreach var of global impact_main {
	replace `var' = .a if `var' == -1
	
	replace `var' = . if ///
	`var' == .b | `var' == -9 | ///
	`var' == .c | `var' == -7 | ///
	`var' == .d | `var' == -8 | ///
	`var' == -2
}

foreach var of global impact_aux {
	replace `var' = .a if `var' == -1
	
	replace `var' = . if ///
	`var' == .b | `var' == -9 | ///
	`var' == .c | `var' == -7 | ///
	`var' == .d | `var' == -8 | ///
	`var' == -2
}

foreach var of global strings {
	replace `var' = ".a" if `var' == "-1"
	
	replace `var' = "" if ///
	`var' == ".b" | `var' == "-9" | ///
	`var' == ".c" | `var' == "-7" | ///
	`var' == ".d" | `var' == "-8" | ///
	`var' == "-2"
}

keep k_exp_until_wave1 k_exp_until_wave2 k_exp_until_wave3 k_exp_until_wave4 ///
	 s_exp_until_wave1 s_exp_until_wave2 s_exp_until_wave3 s_exp_until_wave4 ///
	 first_exp_until_wave1 first_exp_until_wave2 first_exp_until_wave3 first_exp_until_wave4 ///
	 CHILDID ///
	 S1_ID S2_ID S3_ID S4_ID ///
	 F4YRRND ///
	 P3SUMSCH ///
	 FKCHGSCH R3R2SCHG R4R2SCHG R4R3SCHG ///
	 R4URBAN S4MINOR S4FLNCH S4FLCH_I S4RLNCH S4RLCH_I S4SCTYP ///
	 F4YRRND_dup ///
	 P3SMREQ ///
	 c1r4rtht_r c1r4mtht_r ///
	 c2r4rtht_r c2r4mtht_r ///
	 c3r4rtht_r c3r4mtht_r ///
	 c4r4rtht_r c4r4mtht_r ///
	 trct_disadv_index2 ///
	 RACE

rename c1r4rtht_r cr4rtht_r1
rename c2r4rtht_r cr4rtht_r2
rename c3r4rtht_r cr4rtht_r3
rename c4r4rtht_r cr4rtht_r4

rename c1r4mtht_r cr4mtht_r1
rename c2r4mtht_r cr4mtht_r2
rename c3r4mtht_r cr4mtht_r3
rename c4r4mtht_r cr4mtht_r4

rename S1_ID S_ID1
rename S2_ID S_ID2
rename S3_ID S_ID3
rename S4_ID S_ID4

rename R4URBAN  RURBAN4
rename S4MINOR  SMINOR4
rename S4FLNCH  SFLNCH4
rename S4FLCH_I SFLCH_I4
rename S4RLNCH  SRLNCH4
rename S4RLCH_I SRLCH_I4
rename S4SCTYP  SSCTYP4





/*** Save data ***/

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation.dta", replace





/*** Quick count ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation.dta", clear

count if cr4rtht_r1 != . & ///
		 cr4mtht_r1 != . & ///
		 cr4rtht_r2 != . & ///
		 cr4mtht_r2 != . & ///
		 cr4rtht_r3 != . & ///
		 cr4mtht_r3 != . & ///
		 cr4rtht_r4 != . & ///
		 cr4mtht_r4 != .

count if cr4rtht_r1 != . & ///
		 cr4mtht_r1 != . & ///
		 cr4rtht_r2 != . & ///
		 cr4mtht_r2 != . & ///
		 cr4rtht_r3 != . & ///
		 cr4mtht_r3 != . & ///
		 cr4rtht_r4 != . & ///
		 cr4mtht_r4 != . & ///
		 (F4YRRND_dup  == 2 | F4YRRND_dup  == .b) & ///
		 (P3SUMSCH == 2 | P3SMREQ == 3 | P3SMREQ == 2)

count if cr4rtht_r1 != . & ///
		 cr4mtht_r1 != . & ///
		 cr4rtht_r2 != . & ///
		 cr4mtht_r2 != . & ///
		 cr4rtht_r3 != . & ///
		 cr4mtht_r3 != . & ///
		 cr4rtht_r4 != . & ///
		 cr4mtht_r4 != . & ///
		 (F4YRRND_dup  == 2 | F4YRRND_dup  == .b) & ///
		 (P3SUMSCH == 2 | P3SMREQ == 3 | P3SMREQ == 2) & ///
		 (FKCHGSCH == 0 | FKCHGSCH >= .) & ///
		 (R3R2SCHG == 1 | R3R2SCHG >= .) & ///
		 (R4R2SCHG == 1 | R4R2SCHG >= .) & ///
		 (R4R3SCHG == 1 | R4R3SCHG >= .)

count if cr4rtht_r1 != . & ///
		 cr4mtht_r1 != . & ///
		 cr4rtht_r2 != . & ///
		 cr4mtht_r2 != . & ///
		 cr4rtht_r3 != . & ///
		 cr4mtht_r3 != . & ///
		 cr4rtht_r4 != . & ///
		 cr4mtht_r4 != . & ///
		 (F4YRRND_dup  == 2 | F4YRRND_dup  == .b) & ///
		 (P3SUMSCH == 2 | P3SMREQ == 3 | P3SMREQ == 2) & ///
		 (FKCHGSCH == 0 | FKCHGSCH >= .) & ///
		 (R3R2SCHG == 1 | R3R2SCHG >= .) & ///
		 (R4R2SCHG == 1 | R4R2SCHG >= .) & ///
		 (R4R3SCHG == 1 | R4R3SCHG >= .) & ///
		 k_exp_until_wave1 != . & ///
		 k_exp_until_wave2 != . & ///
		 k_exp_until_wave3 != . & ///
		 k_exp_until_wave4 != . & ///
		 s_exp_until_wave1 != . & ///
		 s_exp_until_wave2 != . & ///
		 s_exp_until_wave3 != . & ///
		 s_exp_until_wave4 != . & ///
		 first_exp_until_wave1 != . & ///
		 first_exp_until_wave2 != . & ///
		 first_exp_until_wave3 != . & ///
		 first_exp_until_wave4 != .

count if cr4rtht_r1 != . & ///
		 cr4rtht_r2 != . & ///
		 cr4rtht_r3 != . & ///
		 cr4rtht_r4 != . & ///
		 (F4YRRND_dup  == 2 | F4YRRND_dup  == .b) & ///
		 (P3SUMSCH == 2 | P3SMREQ == 3 | P3SMREQ == 2) & ///
		 (FKCHGSCH == 0 | FKCHGSCH >= .) & ///
		 (R3R2SCHG == 1 | R3R2SCHG >= .) & ///
		 (R4R2SCHG == 1 | R4R2SCHG >= .) & ///
		 (R4R3SCHG == 1 | R4R3SCHG >= .) & ///
		 k_exp_until_wave1 != . & ///
		 k_exp_until_wave2 != . & ///
		 k_exp_until_wave3 != . & ///
		 k_exp_until_wave4 != . & ///
		 s_exp_until_wave1 != . & ///
		 s_exp_until_wave2 != . & ///
		 s_exp_until_wave3 != . & ///
		 s_exp_until_wave4 != . & ///
		 first_exp_until_wave1 != . & ///
		 first_exp_until_wave2 != . & ///
		 first_exp_until_wave3 != . & ///
		 first_exp_until_wave4 != .
		 
count if cr4mtht_r1 != . & ///
		 cr4mtht_r2 != . & ///
		 cr4mtht_r3 != . & ///
		 cr4mtht_r4 != . & ///
		 (F4YRRND_dup  == 2 | F4YRRND_dup  == .b) & ///
		 (P3SUMSCH == 2 | P3SMREQ == 3 | P3SMREQ == 2) & ///
		 (FKCHGSCH == 0 | FKCHGSCH >= .) & ///
		 (R3R2SCHG == 1 | R3R2SCHG >= .) & ///
		 (R4R2SCHG == 1 | R4R2SCHG >= .) & ///
		 (R4R3SCHG == 1 | R4R3SCHG >= .) & ///
		 k_exp_until_wave1 != . & ///
		 k_exp_until_wave2 != . & ///
		 k_exp_until_wave3 != . & ///
		 k_exp_until_wave4 != . & ///
		 s_exp_until_wave1 != . & ///
		 s_exp_until_wave2 != . & ///
		 s_exp_until_wave3 != . & ///
		 s_exp_until_wave4 != . & ///
		 first_exp_until_wave1 != . & ///
		 first_exp_until_wave2 != . & ///
		 first_exp_until_wave3 != . & ///
		 first_exp_until_wave4 != .

log close





log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\1-generate-impact-measures\2-impact-measure-calculations.log", replace

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation.dta", clear


// ORIGINAL CODE TO COMPUTE DOWNEY GROWTH MODEL SAMPLE
drop RURBAN4 SMINOR4 SFLNCH4 SRLNCH4 SRLCH_I4 SSCTYP4

drop if S_ID3 == ""

drop if S_ID2 == ""

drop if S_ID1 == ""
drop if S_ID4 == ""

drop if (S_ID1 != S_ID2) | (S_ID1 != S_ID3) | (S_ID1 != S_ID4)

keep if F4YRRND_dup == 2 | F4YRRND_dup == .b

keep if	P3SUMSCH == 2 | P3SMREQ == 3 | P3SMREQ == 2

keep if	FKCHGSCH == 0
keep if	R3R2SCHG == 1
keep if	R4R2SCHG == 1
keep if	R4R3SCHG == 1


/*** 11.10.21 KW R&R WORK: COMPUTE # STUDENTS PER SCHOOL ON DOWNEY GROWTH MODEL SAMPLE ***/
// CREATE INDICATOR FOR # OF SCHOOLS KINDERGARTEN
sort S_ID2
by S_ID2: gen schl_num = 1 if _n == 1
replace schl_num = . if S_ID2 == "" 

// COMPUTE SUMMARIES OF SAMPLE STUDENTS PER SCHOOL AT EACH WAVE USED TO FIT DOWNEY MODEL
gen stu_num = 1 
bysort S_ID2: egen tot_stu = total(stu_num) 
sum tot_stu if schl_num == 1, det

// DROP INDICATOR FOR SCHOOLS AND DISADVANTAGE TERTILE 
drop schl_num stu_num tot_stu
/*** 11.10.21 KW R&R WORK: END OF EDITS ***/



drop F4YRRND F4YRRND_dup P3SUMSCH P3SMREQ FKCHGSCH R3R2SCHG R4R2SCHG R4R3SCHG

reshape long cr4rtht_r ///
			 cr4mtht_r ///
			 k_exp_until_wave ///
			 s_exp_until_wave ///
			 first_exp_until_wave ///
			 S_ID, ///
			 i(CHILDID) j(wave)

gen temp = (cr4rtht_r + 1.24777)/.517441
drop cr4rtht_r
rename temp cr4rtht_r

gen temp = (cr4mtht_r + 1.121686)/.4736506
drop cr4mtht_r
rename temp cr4mtht_r





// RE (mixed)

// cr4rtht_r - com
/* 2.19.21 GW - legacy code no longer used; imposed max number of iterations to speed up*/
/*
mixed cr4rtht_r ///
	  k_exp_until_wave s_exp_until_wave first_exp_until_wave ///
	  || S_ID: k_exp_until_wave s_exp_until_wave first_exp_until_wave, cov(un) ///
	  || CHILDID: k_exp_until_wave s_exp_until_wave first_exp_until_wave, cov(un) ///
	  mle difficult ltol(0.000001)
*/
mixed cr4rtht_r ///
	  k_exp_until_wave s_exp_until_wave first_exp_until_wave ///
	  || S_ID: k_exp_until_wave s_exp_until_wave first_exp_until_wave, cov(un) ///
	  || CHILDID: k_exp_until_wave s_exp_until_wave first_exp_until_wave, cov(un) ///
	  mle difficult iterate(10)
	  
predict b*, reffects

lincom k_exp_until_wave
gen re_k_read_mixed = r(estimate)

lincom s_exp_until_wave
gen re_s_read_mixed = r(estimate)

lincom first_exp_until_wave
gen re_first_read_mixed = r(estimate)

gen re_impact_read_mixed = (re_first_read_mixed + b3) - (re_s_read_mixed + b2)

gen re_impact_read_first_only_mixed = re_first_read_mixed + b3
gen re_impact_read_summer_only_mixed = re_s_read_mixed + b2

sum re_k_read_mixed, detail
sum re_s_read_mixed, detail
sum re_first_read_mixed, detail
sum re_impact_read_mixed, detail

drop b*



// cr4mtht_r
/* 2.19.21 GW - legacy code no longer used; imposed max number of iterations to speed up*/
/* 
mixed cr4mtht_r ///
	  k_exp_until_wave s_exp_until_wave first_exp_until_wave ///
	  || S_ID: k_exp_until_wave s_exp_until_wave first_exp_until_wave, cov(un) ///
	  || CHILDID: k_exp_until_wave s_exp_until_wave first_exp_until_wave, cov(un) ///
	  mle difficult ltol(0.000001)
*/

mixed cr4mtht_r ///
	  k_exp_until_wave s_exp_until_wave first_exp_until_wave ///
	  || S_ID: k_exp_until_wave s_exp_until_wave first_exp_until_wave, cov(un) ///
	  || CHILDID: k_exp_until_wave s_exp_until_wave first_exp_until_wave, cov(un) ///
	  mle difficult iterate(10)

predict b*, reffects

lincom k_exp_until_wave
gen re_k_math_mixed = r(estimate)

lincom s_exp_until_wave
gen re_s_math_mixed = r(estimate)

lincom first_exp_until_wave
gen re_first_math_mixed = r(estimate)

gen re_impact_math_mixed = (re_first_math_mixed + b3) - (re_s_math_mixed + b2)

gen re_impact_math_first_only_mixed = re_first_math_mixed + b3
gen re_impact_math_summer_only_mixed = re_s_math_mixed + b2

sum re_k_math_mixed, detail
sum re_s_math_mixed, detail
sum re_first_math_mixed, detail
sum re_impact_math_mixed, detail

drop b*





// RE (HLM)

glob drive "C:\Users\wodtke\Desktop\projects"
cd "${drive}\nhood_mediation_schl_qual\replication\HLM-reference\HLM-reference\generated-data-our-model\"

sysdir set PERSONAL "C:\Program Files (x86)\Stata15\ado\personal\" 


// Read error variances
sum cr4rtht_r if wave == 1
sum cr4rtht_r if wave == 2
sum cr4rtht_r if wave == 3
sum cr4rtht_r if wave == 4

gen rmvar=.
replace rmvar=(1-0.92)*((.9999999)^2) if wave==1
replace rmvar=(1-0.95)*((.9625655)^2) if wave==2
replace rmvar=(1-0.96)*((.9708409)^2) if wave==3
replace rmvar=(1-0.96)*((.8604676)^2) if wave==4

// Math error variances
sum cr4mtht_r if wave == 1
sum cr4mtht_r if wave == 2
sum cr4mtht_r if wave == 3
sum cr4mtht_r if wave == 4

gen mmvar=.
replace mmvar=(1-0.95)*((1)^2)        if wave==1
replace mmvar=(1-0.95)*((.9655152)^2) if wave==2
replace mmvar=(1-0.95)*((.9654395)^2) if wave==3
replace mmvar=(1-0.93)*((.8609416)^2) if wave==4

rename S_ID schoolid
rename CHILDID stdid
rename cr4rtht_r read
rename cr4mtht_r math
rename k_exp_until_wave kind
rename s_exp_until_wave sum
rename first_exp_until_wave gr1

replace RACE = 9999 if RACE == .
replace SFLCH_I4 = 9999 if SFLCH_I4 == .


sort schoolid stdid
hlm mkmdm using downey_nowt, type(hlm3) id3(schoolid) id2(stdid) l1(read math rmvar mmvar kind sum gr1) ///
	l2(RACE) ///
	l3(SFLCH_I4) miss(now) run replace
	
hlm mdmset downey_nowt.mdm

foreach s in read math {

	if "`s'"=="read" loc wt="rmvar"
	if "`s'"=="math" loc wt="mmvar"

	hlm hlm3 `s' int(int(int rand) rand) ///
		kind(int(int rand) rand) ///
		sum(int(int rand) rand) ///
		gr1(int(int rand) rand) rand, ///
		cmd(nowt_`s'_m1) pwgt(`wt') run replace res3
	matrix tau2 = e(tau2)
	loc int2 = tau2[1,1]
	loc kind2 = tau2[2,2]
	loc sum2 = tau2[3,3]
	loc gr12 = tau2[4,4]
	matrix tau3 = e(tau3)
	loc int3 = tau3[1,1]
	loc kind3 = tau3[2,2]
	loc sum3 = tau3[3,3]
	loc gr13 = tau3[4,4]
	estadd scalar int2 = `int2', replace
	estadd scalar kind2 = `kind2', replace
	estadd scalar sum2 = `sum2', replace
	estadd scalar gr12 = `gr12', replace
	estadd scalar int3 = `int3', replace
	estadd scalar kind3 = `kind3', replace
	estadd scalar sum3 = `sum3', replace
	estadd scalar gr13 = `gr13', replace
	est store m1`s'
}

rename schoolid L3ID

// Generate impact scores for read
merge n:1 L3ID using "nowt_read_m1_res3.dta", keepusing(EB00 EB10 EB20 EB30)

sum EB00
display (.3103829)^(1/2) 

sum EB10
display (.0011869)^(1/2)

sum EB20
display (.0025065)^(1/2) 

sum EB30
display (.0008617)^(1/2) 

gen re_impact_read_HLM = (.1697423 + EB30) - (.0017111 + EB20)
gen re_impact_read_first_only_HLM = .1697423 + EB30
gen re_impact_read_summer_only_HLM = .0017111 + EB20

sum re_impact_read_HLM, detail
sum re_impact_read_first_only_HLM, detail
sum re_impact_read_summer_only_HLM, detail

drop EB00 EB10 EB20 EB30 _merge

// Generate impact scores for math
merge n:1 L3ID using "nowt_math_m1_res3.dta", keepusing(EB00 EB10 EB20 EB30)

sum EB00
display (.2715867)^(1/2) 

sum EB10
display (.0007928)^(1/2)

sum EB20
display (.0031772)^(1/2) 

sum EB30
display (.0006087)^(1/2) 

gen re_impact_math_HLM = (.1501637  + EB30) - (.0380505 + EB20)
gen re_impact_math_first_only_HLM = .1501637  + EB30
gen re_impact_math_summer_only_HLM = .0380505 + EB20

sum re_impact_math_HLM, detail
sum re_impact_math_first_only_HLM, detail
sum re_impact_math_summer_only_HLM, detail

drop EB00 EB10 EB20 EB30 _merge

// Rename variables back to their original names
rename L3ID S_ID
rename stdid CHILDID
rename read cr4rtht_r
rename math cr4mtht_r
rename kind k_exp_until_wave
rename sum s_exp_until_wave
rename gr1 first_exp_until_wave

// Re-add RACE and SFLCH_I4 missing values
replace RACE = . if RACE == 9999
replace SFLCH_I4 = . if SFLCH_I4 == 9999

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-inspect.dta", replace





// Diagnostics

// Correlations
	 
corr re_impact_read_mixed re_impact_math_mixed re_impact_read_HLM re_impact_math_HLM

// Regressions

reg re_impact_read_mixed re_impact_math_mixed
reg re_impact_read_HLM   re_impact_math_HLM
reg re_impact_read_mixed re_impact_read_HLM
reg re_impact_math_mixed re_impact_math_HLM

// Scatter plots
	
scatter re_impact_read_mixed re_impact_math_mixed
graph export "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\figures-replicate-study\1-generate-impact-measures\re-read-vs-math-mixed.pdf", as(pdf) replace

scatter re_impact_read_HLM re_impact_math_HLM
graph export "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\figures-replicate-study\1-generate-impact-measures\re-read-vs-math-HLM.pdf", as(pdf) replace

scatter re_impact_read_mixed re_impact_read_HLM
graph export "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\figures-replicate-study\1-generate-impact-measures\re-read-mixed-vs-HLM.pdf", as(pdf) replace

scatter re_impact_math_mixed re_impact_math_HLM
graph export "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\figures-replicate-study\1-generate-impact-measures\re-math-mixed-vs-HLM.pdf", as(pdf) replace

log close
