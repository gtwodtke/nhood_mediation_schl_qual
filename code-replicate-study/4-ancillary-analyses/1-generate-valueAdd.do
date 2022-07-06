capture clear
capture log close

log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\4-ancillary-analyses\1-generate-valueAdd.log", replace

/*****************************
VALUE-ADDED MEASURE ESTIMATION
******************************/

/*** Read data ***/
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\8-merged-data-keep-ccd-pss-geolytics.dta", clear

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

gen F4YRRND_dup = F4YRRND

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


// LDV VALUE-ADDED ESTIMATES
drop if S_ID3 == ""
drop if (S_ID1 != S_ID2) | (S_ID2 != S_ID3) | (S_ID3 != S_ID4)

mixed cr4rtht_r4 ///
	  cr4rtht_r2 cr4rtht_r1 cr4mtht_r2 cr4mtht_r1 ///
	  i.GENDER i.RACE i.W1PARED ///
	  || S_ID3: , cov(id) ///
	  mle difficult
	  
predict valueAdd_read, reffects

mixed cr4mtht_r4 ///
	  cr4rtht_r2 cr4rtht_r1 cr4mtht_r2 cr4mtht_r1 ///
	  i.GENDER i.RACE i.W1PARED ///
	  || S_ID3: , cov(id) ///
	  mle difficult
	  
predict valueAdd_math, reffects

sum valueAdd_read valueAdd_math
corr valueAdd_read valueAdd_math trct_disadv_index2

keep CHILDID PARENTID S_ID1 S_ID2 S_ID3 S_ID4 valueAdd_read valueAdd_math

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\valueAdd-measures.dta", replace

log close
