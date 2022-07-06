/******************************************************************************/
/************** VARIABLES NEEDED FOR IMPACT MEASURE CALCULATIONS **************/
/******************************************************************************/

log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\0-clean-data\2-impact-measure-variables.log", replace

/*******************/
/***** OUTCOME *****/
/*******************/

/* READING SCORES */

forval i=1/7 {	
	replace C`i'R4RSCL = .a if C`i'R4RSCL == -1 // NOT APPLICABLE
	replace C`i'R4RTSC = .a if C`i'R4RTSC == -1 // NOT APPLICABLE
	
	replace C`i'R4RSCL = .b if C`i'R4RSCL == -9 // NOT ASCERTAINED
	replace C`i'R4RTSC = .b if C`i'R4RTSC == -9 // NOT ASCERTAINED
}

/* MATH SCORES */

forval i=1/7 {
	replace C`i'R4MSCL = .a if C`i'R4MSCL == -1 // NOT APPLICABLE
	replace C`i'R4MTSC = .a if C`i'R4MTSC == -1 // NOT APPLICABLE
	
	replace C`i'R4MSCL = .b if C`i'R4MSCL == -9 // NOT ASCERTAINED
	replace C`i'R4MTSC = .b if C`i'R4MTSC == -9 // NOT ASCERTAINED
}





/***************************************/
/***** WHAT TO EXCLUDE FROM SAMPLE *****/
/***************************************/

/* YEAR ROUND SCHOOLS */

replace F4YRRND = .b if F4YRRND == -9 // NOT ASCERTAINED

/* KIDS THAT ATTENDED SUMMER SCHOOL */

replace P3SUMSCH = .a if P3SUMSCH == -1 // NOT APPLICABLE
replace P3SUMSCH = .b if P3SUMSCH == -9 // NOT ASCERTAINED
replace P3SUMSCH = .c if P3SUMSCH == -7 // REFUSED

/* KIDS THAT TRANSFERRED SCHOOLS */

replace FKCHGSCH = . if FKCHGSCH < 0

replace R3R2SCHG = .b if R3R2SCHG == -9 // NOT ASCERTAINED

replace R4R2SCHG = .a if R4R2SCHG == -1 // NOT APPLICABLE
replace R4R2SCHG = .b if R4R2SCHG == -9 // NOT ASCERTAINED

replace R4R3SCHG = .a if R4R3SCHG == -1 // NOT APPLICABLE
replace R4R3SCHG = .b if R4R3SCHG == -9 // NOT ASCERTAINED





/*********************************************************************/
/***** CLEAN VARIABLES NECESSARY FOR EXPOSURE CALCULATIONS LATER *****/
/*********************************************************************/

/* Wave 1 assessment date */
replace C1ASMTDD = . if C1ASMTDD < 0
replace C1ASMTMM = . if C1ASMTMM < 0
replace C1ASMTYY = . if C1ASMTYY < 0

/* Wave 2 assessment date */
replace C2ASMTDD = . if C2ASMTDD < 0
replace C2ASMTMM = . if C2ASMTMM < 0
replace C2ASMTYY = . if C2ASMTYY < 0

/* Wave 3 assessment date */
replace C3ASMTDD = .b if C3ASMTDD == -9 // NOT ASCERTAINED
replace C3ASMTMM = .b if C3ASMTMM == -9 // NOT ASCERTAINED
replace C3ASMTYY = .b if C3ASMTYY == -9 // NOT ASCERTAINED

/* Wave 4 assessment date */
replace C4ASMTDD = . if C4ASMTDD < 0
replace C4ASMTMM = . if C4ASMTMM < 0
replace C4ASMTYY = . if C4ASMTYY < 0

/* Kindergarten school year beginning date (SUPPRESSED) */
replace U2SCHBDD = .b if U2SCHBDD == -9 // NOT ASCERTAINED
replace U2SCHBMM = .b if U2SCHBMM == -9 // NOT ASCERTAINED
replace U2SCHBYY = .b if U2SCHBYY == -9 // NOT ASCERTAINED

/* Kindergarten school year ending date (SUPPRESSED) */
replace U2SCHEDD = .b if U2SCHEDD == -9 // NOT ASCERTAINED
replace U2SCHEMM = .b if U2SCHEMM == -9 // NOT ASCERTAINED
replace U2SCHEYY = .b if U2SCHEYY == -9 // NOT ASCERTAINED

/* First grade school year beginning date */
replace U4SCHBDD = .b if U4SCHBDD == -9 // NOT ASCERTAINED
replace U4SCHBMM = .b if U4SCHBMM == -9 // NOT ASCERTAINED
replace U4SCHBYY = .b if U4SCHBYY == -9 // NOT ASCERTAINED

/* First grade school year ending date */
replace U4SCHEDD = .b if U4SCHEDD == -9 // NOT ASCERTAINED
replace U4SCHEMM = .b if U4SCHEMM == -9 // NOT ASCERTAINED
replace U4SCHEYY = .b if U4SCHEYY == -9 // NOT ASCERTAINED





/*********************************/
/***** SCHOOL-LEVEL CONTROLS *****/
/*********************************/

/* SCHOOL'S LOCATION (URBAN, RURAL, OR SUBURBAN) */

replace R4URBAN = .a if R4URBAN == -1 // NOT APPLICABLE
replace R4URBAN = .b if R4URBAN == -9 // NOT ASCERTAINED
// 3 categories

/* ETHNIC COMPOSITION (PERCENTAGE MINORITY) */

replace S4MINOR = .b if S4MINOR == -9 // NOT ASCERTAINED
// 5 categories

/* POVERTY LEVEL (% OF STUDENTS RECEIVING FREE OR REDUCED-PRICED LUNCHES) */

// Free lunch variables
// S4FLNCH 
// S4FLCH_I 
// IFS4FLCH 

replace S4FLNCH = .b if S4FLNCH == -9 // NOT ASCERTAINED
replace S4FLCH_I = .a if S4FLNCH == -1 // NOT APPLICABLE

replace S4FLCH_I = S4FLNCH if (S4FLCH_I == .a | S4FLCH_I == .) & S4FLNCH != .b & S4FLNCH != .
// continuous

// Reduced lunch variables
// S4RLNCH 
// S4RLCH_I 
// IFS4RLCH

replace S4RLNCH = .b if S4RLNCH == -9 // NOT ASCERTAINED
replace S4RLCH_I = .a if S4RLCH_I == -1 // NOT APPLICABLE

replace S4RLCH_I = S4RLNCH if (S4RLCH_I == .a | S4RLCH_I == .) & S4RLNCH != .b & S4RLNCH != .
// continuous

/* SECTOR (PUBLIC, CATHOLIC, NON-CATHOLIC RELIGIOUS, OR SECULAR PRIVATE) */

// S4SCTYP
replace S4SCTYP = .b if S4SCTYP == -9 // NOT ASCERTAINED
// 4 categories

log close
