log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\0-clean-data\1-eclsk-merge-2.log", replace

/******************************************
ECLS-K MERGE PUBLIC AND RESTRICTED DATASETS
******************************************/

set maxvar 32000
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\ECLSK_Kto8_child_STATA_R.dta", clear

drop _merge ///
B1YRSPRE B1YRSKIN B1YRSFST B1YRS2T5 B1YRS6PL B1YRSESL B1YRSBIL B1YRSSPE B1YRSPE B1YRSART B1YRSCH ///
B1HGHSTD ///
DOBYY ///
S2ANUMCH S2BNUMCH ///
S2PCTHSP S2INDPCT S2ASNPCT S2BLKPCT S2PCFPCT S2WHTPCT ///
S2ELILNC ///
S2TCHFTE S2FTETOT
merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Base Year\base-year-extract-keep.dta"

drop _merge ///
B4HGHSTD ///
D4SCHLYR D4HGHSTD ///
E4GRADE ///
R4URBAN ///
S4MINOR ///
S4ANUMCH ///
S4HSPPCT S4ASNPCT S4BLKPCT S4WHTPCT S4INDPCT ///
S4ELILNC ///
S4FTETOT ///
R3CCDLEA R4CCDLEA R3CCDSID R4CCDSID R3SCHPIN R4SCHPIN R3STSID R4STSID 
merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\First Grade\first-grade-extract-keep.dta"

drop _merge ///
B5HGHSTD B5YRSTC B5YRSCH /// 
C5THIRD ///
D5SCHLYR D5YRSTCH D5HGHSTD ///
E5GRADE ///
P5HOWPAY ///
S5ANUMCH S5BNUMCH ///
S5HSPPCT S5ASNPCT S5BLKPCT S5WHTPCT S5INDPCT ///
S5ELILNC ///
R5CCDLEA R5CCDSID R5SCHPIN R5STSID 
merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Third Grade\third-grade-extract-keep.dta"

drop _merge ///
C6FIFTH ///
D6SCHLYR D6YRSTCH D6HGHSTD ///
E6ENRGR ///
J61YRSTC J62YRSTC ///
P6HOWPAY ///
S6ANUMCH S6BNUMCH ///
S6HSPPCT S6ASNPCT S6BLKPCT S6WHTPCT S6INDPCT ///
S6ELILNC S6FLCH_I ///
R6CCDLEA R6CCDSID R6SCHPIN R6STSID 
merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Fifth Grade\fifth-grade-extract-keep.dta"

drop _merge ///
D7HGHSTD D7SCHLYR D7YRSTCH ///
E7ENROL ///
J71YRSTC J72YRSTC ///
P7HOWPAY ///
S7ANUMCH ///
S7HSPPCT S7ASNPCT S7BLKPCT S7WHTPCT S7INDPCT ///
S7ELILNC S7FLCH_I ///
S7STRSAL ///
R7CCDLEA R7CCDSID R7SCHPIN R7STSID
merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Eighth Grade\eighth-grade-extract-keep.dta"

drop _merge ///
U2REPEAT ///
U2SCHBMM U2SCHBDD U2SCHBYY U2SCHEMM U2SCHEDD U2SCHEYY
merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Student Record Abstract\student-record-abstract-extract-keep.dta"

drop _merge ///
D2SCHLYR D2HGHSTD
merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Special Education\special-education-extract-keep.dta"

drop _merge
merge m:1 T2_ID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Salary and Benefits\salary-and-benefits-extract-keep.dta"

drop if _merge == 2

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\1-merged-data.dta", replace

log close
