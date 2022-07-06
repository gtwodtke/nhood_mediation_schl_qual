#delimit cr
capture log close 
capture clear all 

global data_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\eclsk11\" 
global log_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\5-eclsk11-analyses\" 

log using "${log_directory}2-create-eclsk11v2.log", replace 


/******************************************************************
PROGRAM NAME: 2-create-eclsk11v2.do
AUTHOR: KW
PURPOSE: Use master data file from ECLS-K 2011 pull to clean data
NOTES: GW revised on 11/19/2021
*******************************************************************/
use "${data_directory}eclsk11v1.dta"

/*****************
MISSING DATA CODES 
******************/
/* 
.i item nonresponse: 	includes -7 Refused, -8 Don't know, and -9 Not ascertained 
.p panel attrition:		includes . or " " which represents either panel attrition or a sample member who skipped 
						answering anything that entire wave 
. system missing: 		includes all other type of missing data, including -1 not applicable/legit skip and 
						-4 admin. error and -5 item not asked in school administrator questionnaire B
*/

/**********************
SURVEY WAVES SUFFIX KEY 
***********************/
/* 
GRADE		 SUFFIX			SEASN		SCHL YR		
Kindergarten 	1			Fall     	2010-11  	  
Kindergarten 	2			Spring   	2010-11		
1st grade	 	3			Fall     	2011-12 
1st grade	 	4			Spring   	2011-12  	
2nd grade	 	5			Fall     	2012-13  	
2nd grade	 	6			Spring   	2012-13  	
3rd grade		7			All year 	2013-14		
4th grade		8			All year 	2014-15		
5th grade		9			All year 	2015-16		
*/


/*cog stim scale*/
global cogstim_vars P1BUILD P1CHORES P1CHREAD P1GAMES P1NATURE P1NUMBRS P1READBK P1SINGSO P1SPORT P1TELLST

foreach v of global cogstim_vars {
	replace `v' = .b if `v' == -9 // NOT ASCERTAINED
	replace `v' = .c if `v' == -7 // REFUSED
	replace `v' = .d if `v' == -8 // DON'T KNOW
	tab `v', missing
}

alpha $cogstim_vars, std detail

pca $cogstim_vars

predict cogstim

/*parental depression*/
global depres_vars P2APPETI	P2BLUE P2BOTHER	P2DEPRES P2EFFORT P2FEARFL P2KPMIND	P2LONELY P2NOTGO P2RESTLS P2SAD P2TALKLS

foreach v of global depres_vars {
	replace `v' = .a if `v' == -1 // NOT APPLICABLE
	replace `v' = .b if `v' == -9 // NOT ASCERTAINED
	replace `v' = .c if `v' == -7 // REFUSED
	replace `v' = .d if `v' == -8 // DON'T KNOW
	tab `v', missing
	}

alpha $depres_vars, std detail

pca $depres_vars

predict pardepres

/*homeownership*/
replace P4HOUSIT = .b if P4HOUSIT == -9 // NOT ASCERTAINED
replace P4HOUSIT = .c if P4HOUSIT == -7 // REFUSED
replace P4HOUSIT = .d if P4HOUSIT == -8 // DON'T KNOW
tab P4HOUSIT, missing

recode P4HOUSIT (1=1) (2 3 4 5 6 91 = 0), gen(ownhome)

/*********************************************************
CLEAN STUDENT-LEVEL ACADEMIC ACHIEVEMENT OUTCOME VARIABLES  
**********************************************************/
rename *, lower

/* MATH TEST THETA KF-5TH GRADE */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums { 
	replace x`i'mthetk5 = .i if x`i'mthetk5 == -7 | x`i'mthetk5 == -8 | x`i'mthetk5 == -9
	replace x`i'mthetk5 = .p if x`i'mthetk5 == . 
	rename x`i'mthetk5 mththeta`i'
}
label variable mththeta1 "Math test score theta, Kindergarten Fall"
label variable mththeta2 "Math test score theta, Kindergarten Spring"
label variable mththeta3 "Math test score theta, 1st grade Fall"
label variable mththeta4 "Math test score theta, 1st grade Spring"
label variable mththeta5 "Math test score theta, 2nd grade Fall"
label variable mththeta6 "Math test score theta, 2nd grade Spring"
label variable mththeta7 "Math test score theta, 3rd grade"
label variable mththeta8 "Math test score theta, 4th grade"
label variable mththeta9 "Math test score theta, 5th grade"

/* READING TEST THETA KF-5TH GRADE */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums { 
	replace x`i'rthetk5 = .i if x`i'rthetk5 == -7 | x`i'rthetk5 == -8 | x`i'rthetk5 == -9
	replace x`i'rthetk5 = .p if x`i'rthetk5 == . 
	rename x`i'rthetk5 rdtheta`i'
}
label variable rdtheta1 "Reading test score theta, Kindergarten Fall"
label variable rdtheta2 "Reading test score theta, Kindergarten Spring"
label variable rdtheta3 "Reading test score theta, 1st grade Fall"
label variable rdtheta4 "Reading test score theta, 1st grade Spring"
label variable rdtheta5 "Reading test score theta, 2nd grade Fall"
label variable rdtheta6 "Reading test score theta, 2nd grade Spring"
label variable rdtheta7 "Reading test score theta, 3rd grade"
label variable rdtheta8 "Reading test score theta, 4th grade"
label variable rdtheta9 "Reading test score theta, 5th grade"

/* SCIENCE TEST THETA KF-5TH GRADE */ 
local nums 2 3 4 5 6 7 8 9
foreach i of local nums { 
	replace x`i'sthetk5 = .i if x`i'sthetk5 == -7 | x`i'sthetk5 == -8 | x`i'sthetk5 == -9
	replace x`i'sthetk5 = .p if x`i'sthetk5 == . 
	rename x`i'sthetk5 sctheta`i'
}
label variable sctheta2 "Science test score theta, Kindergarten Spring"
label variable sctheta3 "Science test score theta, 1st grade Fall"
label variable sctheta4 "Science test score theta, 1st grade Spring"
label variable sctheta5 "Science test score theta, 2nd grade Fall"
label variable sctheta6 "Science test score theta, 2nd grade Spring"
label variable sctheta7 "Science test score theta, 3rd grade"
label variable sctheta8 "Science test score theta, 4th grade"
label variable sctheta9 "Science test score theta, 5th grade"

/*********************************************************
CLEAN STUDENT-LEVEL EMOTIONAL/BEHAVIORAL OUTCOME VARIABLES  
**********************************************************/
/* Teacher report - externalizing */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums { 
	replace x`i'tchext = .i if x`i'tchext == -7 | x`i'tchext == -8 | x`i'tchext == -9
	replace x`i'tchext = .p if x`i'tchext == . 
	replace x`i'tchext = . if x`i'tchext == -1 | x`i'tchext == -4 | x`i'tchext == -5
	rename x`i'tchext extrn`i'
}
label variable extrn1 "Teacher report child externalizing behaviors, Kindergarten Fall"
label variable extrn2 "Teacher report child externalizing behaviors, Kindergarten Spring"
label variable extrn3 "Teacher report child externalizing behaviors, 1st grade Fall"
label variable extrn4 "Teacher report child externalizing behaviors, 1st grade Spring"
label variable extrn5 "Teacher report child externalizing behaviors, 2nd grade Fall"
label variable extrn6 "Teacher report child externalizing behaviors, 2nd grade Spring"
label variable extrn7 "Teacher report child externalizing behaviors, 3rd grade"
label variable extrn8 "Teacher report child externalizing behaviors, 4th grade"
label variable extrn9 "Teacher report child externalizing behaviors, 5th grade"

/* Teacher report - internalizing */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace x`i'tchint = .i if x`i'tchint == -7 | x`i'tchint == -8 | x`i'tchint == -9
	replace x`i'tchint = .p if x`i'tchint == . 
	replace x`i'tchint = . if x`i'tchint == -1 | x`i'tchint == -4 | x`i'tchint == -5
	rename x`i'tchint intrn`i'
}
label variable intrn1 "Teacher report child internalizing behaviors, Kindergarten Fall"
label variable intrn2 "Teacher report child internalizing behaviors, Kindergarten Spring"
label variable intrn3 "Teacher report child internalizing behaviors, 1st grade Fall"
label variable intrn4 "Teacher report child internalizing behaviors, 1st grade Spring"
label variable intrn5 "Teacher report child internalizing behaviors, 2nd grade Fall"
label variable intrn6 "Teacher report child internalizing behaviors, 2nd grade Spring"
label variable intrn7 "Teacher report child internalizing behaviors, 3rd grade"
label variable intrn8 "Teacher report child internalizing behaviors, 4th grade"
label variable intrn9 "Teacher report child internalizing behaviors, 5th grade"

/* Teacher report - child eager to learn */ 
local nums 1 2 3 4 5 6 7 
foreach i of local nums {
	replace t`i'shows = .i if t`i'shows == -7 | t`i'shows == -8 | t`i'shows == -9
	replace t`i'shows = .p if t`i'shows == . 
	replace t`i'shows = . if t`i'shows == -1 | t`i'shows == -4 | t`i'shows == -5
	rename t`i'shows egrlrn`i'
}
label variable egrlrn1 "Teacher report child eager to learn, Kindergarten Fall"
label variable egrlrn2 "Teacher report child eager to learn, Kindergarten Spring"
label variable egrlrn3 "Teacher report child eager to learn, 1st grade Fall"
label variable egrlrn4 "Teacher report child eager to learn, 1st grade Spring"
label variable egrlrn5 "Teacher report child eager to learn, 2nd grade Fall"
label variable egrlrn6 "Teacher report child eager to learn, 2nd grade Spring"
label variable egrlrn7 "Teacher report child eager to learn, 3rd grade"

local nums 8 9  
foreach i of local nums {
	replace g`i'shows = .i if g`i'shows == -7 | g`i'shows == -8 | g`i'shows == -9
	replace g`i'shows = .p if g`i'shows == . 
	replace g`i'shows = . if g`i'shows == -1 | g`i'shows == -4 | g`i'shows == -5
	rename g`i'shows egrlrn`i'
}
label variable egrlrn8 "Teacher report child eager to learn, 4th grade"
label variable egrlrn9 "Teacher report child eager to learn, 5th grade"

/* Teacher report - child works independently */
local nums 1 2 3 4 5 6 7 
foreach i of local nums {
	replace t`i'works = .i if t`i'works == -7 | t`i'works == -8 | t`i'works == -9
	replace t`i'works = .p if t`i'works == . 
	replace t`i'works = . if t`i'works == -1 | t`i'works == -4 | t`i'works == -5
	rename t`i'works wrksind`i'
}
label variable wrksind1 "Teacher report child works independently, Kindergarten Fall"
label variable wrksind2 "Teacher report child works independently, Kindergarten Spring"
label variable wrksind3 "Teacher report child works independently, 1st grade Fall"
label variable wrksind4 "Teacher report child works independently, 1st grade Spring"
label variable wrksind5 "Teacher report child works independently, 2nd grade Fall"
label variable wrksind6 "Teacher report child works independently, 2nd grade Spring"
label variable wrksind7 "Teacher report child works independently, 3rd grade"

local nums 8 9  
foreach i of local nums {
	replace g`i'works = .i if g`i'works == -7 | g`i'works == -8 | g`i'works == -9
	replace g`i'works = .p if g`i'works == . 
	replace g`i'works = . if g`i'works == -1 | g`i'works == -4 | g`i'works == -5
	rename g`i'works wrksind`i'
}
label variable wrksind8 "Teacher report child works independently, 4th grade"
label variable wrksind9 "Teacher report child works independently, 5th grade"

/* Observations - motivation level */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace c`i'motiva = .i if c`i'motiva == -7 | c`i'motiva == -8 | c`i'motiva == -9
	replace c`i'motiva = .p if c`i'motiva == . 
	replace c`i'motiva = . if c`i'motiva == -1 | c`i'motiva == -4 | c`i'motiva == -5
	rename c`i'motiva mtvt`i'
}
label variable mtvt1 "Observation - child motivated, Kindergarten Fall"
label variable mtvt2 "Observation - child motivated, Kindergarten Spring"
label variable mtvt3 "Observation - child motivated, 1st grade Fall"
label variable mtvt4 "Observation - child motivated, 1st grade Spring"
label variable mtvt5 "Observation - child motivated, 2nd grade Fall"
label variable mtvt6 "Observation - child motivated, 2nd grade Spring"
label variable mtvt7 "Observation - child motivated, 3rd grade"
label variable mtvt8 "Observation - child motivated, 4th grade"
label variable mtvt9 "Observation - child motivated, 5th grade"

/* Observations - cooperation */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace c`i'cooper = .i if c`i'cooper == -7 | c`i'cooper == -8 | c`i'cooper == -9
	replace c`i'cooper = .p if c`i'cooper == . 
	replace c`i'cooper = . if c`i'cooper == -1 | c`i'cooper == -4 | c`i'cooper == -5
	rename c`i'cooper cooper`i'
}
label variable cooper1 "Observation - child cooperates, Kindergarten Fall"
label variable cooper2 "Observation - child cooperates, Kindergarten Spring"
label variable cooper3 "Observation - child cooperates, 1st grade Fall"
label variable cooper4 "Observation - child cooperates, 1st grade Spring"
label variable cooper5 "Observation - child cooperates, 2nd grade Fall"
label variable cooper6 "Observation - child cooperates, 2nd grade Spring"
label variable cooper7 "Observation - child cooperates, 3rd grade"
label variable cooper8 "Observation - child cooperates, 4th grade"
label variable cooper9 "Observation - child cooperates, 5th grade"

/* Observations - attention level */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace c`i'attlvl = .i if c`i'attlvl == -7 | c`i'attlvl == -8 | c`i'attlvl == -9
	replace c`i'attlvl = .p if c`i'attlvl == . 
	replace c`i'attlvl = . if c`i'attlvl == -1 | c`i'attlvl == -4 | c`i'attlvl == -5
	rename c`i'attlvl attn`i'
}
label variable attn1 "Observation - child attention level, Kindergarten Fall"
label variable attn2 "Observation - child attention level, Kindergarten Spring"
label variable attn3 "Observation - child attention level, 1st grade Fall"
label variable attn4 "Observation - child attention level, 1st grade Spring"
label variable attn5 "Observation - child attention level, 2nd grade Fall"
label variable attn6 "Observation - child attention level, 2nd grade Spring"
label variable attn7 "Observation - child attention level, 3rd grade"
label variable attn8 "Observation - child attention level, 4th grade"
label variable attn9 "Observation - child attention level, 5th grade"

/*******************************************
CLEAN STUDENT-LEVEL HEALTH OUTCOME VARIABLES  
********************************************/
/* Parent report of child health K-5 */ 
local nums 1 2 4 6 7 8 9 
foreach i of local nums { 
	replace p`i'hscale = .i if p`i'hscale == -7 | p`i'hscale == -8 | p`i'hscale == -9
	replace p`i'hscale = .p if p`i'hscale == . 
	replace p`i'hscale = . if p`i'hscale == -1 | p`i'hscale == -4 | p`i'hscale == -5
	rename p`i'hscale hlthscale`i'
}
label variable hlthscale1 "Parent report of child health scale, Kindergarten Fall"
label variable hlthscale2 "Parent report of child health scale, Kindergarten Spring"
label variable hlthscale4 "Parent report of child health scale, 1st grade Fall"
label variable hlthscale6 "Parent report of child health scale, 2nd grade Spring"
label variable hlthscale7 "Parent report of child health scale, 3rd grade"
label variable hlthscale8 "Parent report of child health scale, 4th grade"
label variable hlthscale9 "Parent report of child health scale, 5th grade"

/* Child diagnosed with asthma */ 
label define yes 0 "No" 1 "Yes"
local nums 4 6 7 8 9 
foreach i of local nums { 
	replace p`i'asthma = .i if p`i'asthma == -7 | p`i'asthma == -8 | p`i'asthma == -9
	replace p`i'asthma = .p if p`i'asthma == . 
	replace p`i'asthma = . if p`i'asthma == -1 | p`i'asthma == -4 | p`i'asthma == -5
	replace p`i'asthma = 0 if p`i'asthma == 2
	label values p`i'asthma yes
	rename p`i'asthma asthma`i'
}
label variable asthma4 "Child ever diagnosed with asthma, 1st grade Fall"
label variable asthma6 "Child ever diagnosed with asthma, 2nd grade Spring"
label variable asthma7 "Child ever diagnosed with asthma, 3rd grade"
label variable asthma8 "Child ever diagnosed with asthma, 4th grade"
label variable asthma9 "Child ever diagnosed with asthma, 5th grade"

/************************
CLEAN META-DATA VARIABLES  
*************************/
/* Sampling stratum */ 
rename w1c0str strat

/* Normalized sampling weights */ 
sum w1c0
gen sampwt = w1c0/r(mean)
sum sampwt

/* Fall subsample participant */ 
rename x3fallsmp fllsmp
label variable fllsmp "Selected for inclusion fall subsample, fall 1st grade" 
label define fllsmp 0 "Not selected fall subsample" 1 "Selected for fall subsample"
replace fllsmp = 0 if fllsmp == 3
replace fllsmp = 1 if fllsmp == 2
label values fllsmp fllsmp 

/***************************************
CLEAN STUDENT-LEVEL FAMILY/SES VARIABLES  
****************************************/
/* Family income */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace x`i'inccat_i = .p if x`i'inccat_i == .
	replace x`i'inccat_i = .i if x`i'inccat_i == -7 | x`i'inccat_i == -8 | x`i'inccat_i == -9
	replace x`i'inccat_i = . if x`i'inccat_i == -1
	replace x`i'inccat_i = 2500 if x`i'inccat_i == 1 
	replace x`i'inccat_i = 7500 if x`i'inccat_i == 2 
	replace x`i'inccat_i = 12500 if x`i'inccat_i == 3
	replace x`i'inccat_i = 17500 if x`i'inccat_i == 4
	replace x`i'inccat_i = 22500 if x`i'inccat_i == 5
	replace x`i'inccat_i = 27500 if x`i'inccat_i == 6
	replace x`i'inccat_i = 32500 if x`i'inccat_i == 7
	replace x`i'inccat_i = 37500 if x`i'inccat_i == 8
	replace x`i'inccat_i = 42500 if x`i'inccat_i == 9
	replace x`i'inccat_i = 47500 if x`i'inccat_i == 10
	replace x`i'inccat_i = 52500 if x`i'inccat_i == 11
	replace x`i'inccat_i = 575000 if x`i'inccat_i == 12
	replace x`i'inccat_i = 62500 if x`i'inccat_i == 13
	replace x`i'inccat_i = 67500 if x`i'inccat_i == 14
	replace x`i'inccat_i = 72500 if x`i'inccat_i == 15
	replace x`i'inccat_i = 77500 if x`i'inccat_i == 16
	replace x`i'inccat_i = 150000 if x`i'inccat_i == 17
	replace x`i'inccat_i = 260000 if x`i'inccat_i == 18
	rename x`i'inccat_i faminc`i'
}

*Deflate to be in 2010 wave 1 dollars 
replace faminc2 = faminc2/(224.939/218.056)
replace faminc4 = faminc4/(229.594/218.056)
replace faminc6 = faminc6/(232.957/218.056)
replace faminc7 = faminc7/(236.736/218.056)
replace faminc8 = faminc8/(237.017/218.056)
replace faminc9 = faminc9/(240.007/218.056)

label variable faminc2 "Family income in 2010 $s, Kindergarten Spring"
label variable faminc4 "Family income in 2010 $s, 1st grade Fall"
label variable faminc6 "Family income in 2010 $s, 2nd grade Spring"
label variable faminc7 "Family income in 2010 $s, 3rd grade"
label variable faminc8 "Family income in 2010 $s, 4th grade"
label variable faminc9 "Family income in 2010 $s, 5th grade"

/* Parent education */ 
* PARENT 1 HIGHEST EDUCATION LEVEL ACROSS WAVES 
rename x12par1ed_i x2par1ed_i
label define pared 0 "Less than high school diploma" 1 "High school diploma or equivalent" ///
2 "Vocational/technical degree or some college" 3 "Bachelor's degree" 4 "Graduate degree"
local nums 2 4 7 8 9
foreach i of local nums {
	replace x`i'par1ed_i = .p if x`i'par1ed_i == .
	replace x`i'par1ed_i = .i if x`i'par1ed_i == -7 | x`i'par1ed_i == -8 | x`i'par1ed_i == -9
	replace x`i'par1ed_i = . if x`i'par1ed_i == -1
	replace x`i'par1ed_i = 0 if x`i'par1ed_i == 1 | x`i'par1ed_i == 2
	replace x`i'par1ed_i = 1 if x`i'par1ed_i == 3
	replace x`i'par1ed_i = 2 if x`i'par1ed_i == 4 | x`i'par1ed_i == 5
	replace x`i'par1ed_i = 3 if x`i'par1ed_i == 6 | x`i'par1ed_i == 7
	replace x`i'par1ed_i = 4 if x`i'par1ed_i == 8 | x`i'par1ed_i == 9
	label values x`i'par1ed_i pared 
	rename x`i'par1ed_i par1ed`i'
}

label variable par1ed2 "Parent 1 highest education, Kindergarten Spring"
label variable par1ed4 "Parent 1 highest education, 1st grade Fall"
label variable par1ed7 "Parent 1 highest education, 3rd grade"
label variable par1ed8 "Parent 1 highest education, 4th grade"
label variable par1ed9 "Parent 1 highest education, 5th grade"

* PARENT 2 HIGHEST EDUCATION LEVEL ACROSS WAVES 
rename x12par2ed_i x2par2ed_i
local nums 2 4 7 8 9
foreach i of local nums {
	replace x`i'par2ed_i = .p if x`i'par2ed_i == .
	replace x`i'par2ed_i = .i if x`i'par2ed_i == -7 | x`i'par2ed_i == -8 | x`i'par2ed_i == -9
	replace x`i'par2ed_i = . if x`i'par2ed_i == -1
	replace x`i'par2ed_i = 0 if x`i'par2ed_i == 1 | x`i'par2ed_i == 2
	replace x`i'par2ed_i = 1 if x`i'par2ed_i == 3
	replace x`i'par2ed_i = 2 if x`i'par2ed_i == 4 | x`i'par2ed_i == 5
	replace x`i'par2ed_i = 3 if x`i'par2ed_i == 6 | x`i'par2ed_i == 7
	replace x`i'par2ed_i = 4 if x`i'par2ed_i == 8 | x`i'par2ed_i == 9
	label values x`i'par2ed_i pared 
	rename x`i'par2ed_i par2ed`i'
}

label variable par2ed2 "Parent 2 highest education, Kindergarten Spring"
label variable par2ed4 "Parent 2 highest education, 1st grade Fall"
label variable par2ed7 "Parent 2 highest education, 3rd grade"
label variable par2ed8 "Parent 2 highest education, 4th grade"
label variable par2ed9 "Parent 2 highest education, 5th grade"

* HIGHEST PARENT EDUCATION LEVEL ACROSS WAVES
local nums 2 4 7 8 9
foreach i of local nums {
	gen pared`i' = max(par1ed`i', par2ed`i')
	label values pared`i' pared
}
label variable pared2 "Parent highest education, Kindergarten Spring"
label variable pared4 "Parent highest education, 1st grade Fall"
label variable pared7 "Parent highest education, 3rd grade"
label variable pared8 "Parent highest education, 4th grade"
label variable pared9 "Parent highest education, 5th grade"

/* Parent occupation */
* PARENT 1 AVERAGE OCCUPATIONAL PRESTIGE SCORE 
local nums 1 4 6 9
foreach i of local nums { 
	replace x`i'par1scr_i = .p if x`i'par1scr_i == . 
	replace x`i'par1scr_i = .i if x`i'par1scr_i == -7 | x`i'par1scr_i == -8 | x`i'par1scr_i ==-9
	replace x`i'par1scr_i = . if x`i'par1scr_i == -1
	rename x`i'par1scr_i par1occ`i'
}
label variable par1occ1 "Parent 1 average occupational prestige, Kindergarten Fall"
label variable par1occ4 "Parent 1 average occupational prestige, 1st grade Spring"
label variable par1occ6 "Parent 1 average occupational prestige, 2nd grade Spring"
label variable par1occ9 "Parent 1 average occupational prestige, 5th grade"

* PARENT 2 AVERAGE OCCUPATIONAL PRESTIGE SCORE 
local nums 1 4 6 9
foreach i of local nums { 
	replace x`i'par2scr_i = .p if x`i'par2scr_i == . 
	replace x`i'par2scr_i = .i if x`i'par2scr_i == -7 | x`i'par2scr_i == -8 | x`i'par2scr_i ==-9
	replace x`i'par2scr_i = . if x`i'par2scr_i == -1
	rename x`i'par2scr_i par2occ`i'
}
label variable par2occ1 "Parent 2 average occupational prestige, Kindergarten Fall"
label variable par2occ4 "Parent 2 average occupational prestige, 1st grade Spring"
label variable par2occ6 "Parent 2 average occupational prestige, 2nd grade Spring"
label variable par2occ9 "Parent 2 average occupational prestige, 5th grade"

* HIGHEST PARENT AVERAGE OCCUPATIONAL PRESTIGE SCORE 
local nums 1 4 6 9
foreach i of local nums { 
	gen parocc`i' = max(par1occ`i', par2occ`i')
}
label variable parocc1 "Highest parent average occupational prestige, Kindergarten Fall"
label variable parocc4 "Highest parent average occupational prestige, 1st grade Spring"
label variable parocc6 "Highest parent average occupational prestige, 2nd grade Spring"
label variable parocc9 "Highest parent average occupational prestige, 5th grade"

/* Employment status */ 
* PARENT 1 EMPLOYMENT STATUS 
rename x1par1emp x1par1emp_i
label define emp 0 "Not in the labor force" 1 "Less than 35 hours per week" 2 "35 or more hours per week"
local nums 1 4 6 9 
foreach i of local nums { 
	replace x`i'par1emp_i = .p if x`i'par1emp_i == . 
	replace x`i'par1emp_i = .i if x`i'par1emp_i == -7 | x`i'par1emp_i == -8 | x`i'par1emp_i == -9
	replace x`i'par1emp_i = . if x`i'par1emp_i == -1
	replace x`i'par1emp_i = 0 if x`i'par1emp_i == 3 | x`i'par1emp_i == 4
	replace x`i'par1emp_i = 3 if x`i'par1emp_i == 2
	replace x`i'par1emp_i = 2 if x`i'par1emp_i == 1
	replace x`i'par1emp_i = 1 if x`i'par1emp_i == 3
	label values x`i'par1emp_i emp
	rename x`i'par1emp_i par1emp`i'
}
label variable par1emp1 "Parent 1 employment status, Kindergarten Fall"
label variable par1emp4 "Parent 1 employment status, 1st grade Spring"
label variable par1emp6 "Parent 1 employment status, 2nd grade Spring"
label variable par1emp9 "Parent 1 employment status, 5th grade"

* PARENT 2 EMPLOYMENT STATUS
rename x1par2emp x1par2emp_i
local nums 1 4 6 9 
foreach i of local nums { 
	replace x`i'par2emp_i = .p if x`i'par2emp_i == . 
	replace x`i'par2emp_i = .i if x`i'par2emp_i == -7 | x`i'par2emp_i == -8 | x`i'par2emp_i == -9
	replace x`i'par2emp_i = . if x`i'par2emp_i == -1
	replace x`i'par2emp_i = 0 if x`i'par2emp_i == 3 | x`i'par2emp_i == 4
	replace x`i'par2emp_i = 3 if x`i'par2emp_i == 2
	replace x`i'par2emp_i = 2 if x`i'par2emp_i == 1
	replace x`i'par2emp_i = 1 if x`i'par2emp_i == 3
	label values x`i'par2emp_i emp
	rename x`i'par2emp_i par2emp`i'
}
label variable par2emp1 "Parent 2 employment status, Kindergarten Fall"
label variable par2emp4 "Parent 2 employment status, 1st grade Spring"
label variable par2emp6 "Parent 2 employment status, 2nd grade Spring"
label variable par2emp9 "Parent 2 employment status, 5th grade"

/* Family structure */ 
* TOTAL NUMBER OF PEOPLE IN HOUSEHOLD
label define hh 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7 or more"
local nums 1 2 4 6 7 8 9
foreach i of local nums {
	replace x`i'htotal = .p if x`i'htotal == .
	replace x`i'htotal = .i if x`i'htotal == -7 | x`i'htotal ==-8 | x`i'htotal == -9
	replace x`i'htotal = . if x`i'htotal ==-1 
	replace x`i'htotal = 7 if x`i'htotal > 7 & x`i'htotal < 30
	label values x`i'htotal hh
	rename x`i'htotal hhtot`i'
}
label variable hhtot1 "Total number of people in household, Kindergarten Fall"
label variable hhtot2 "Total number of people in household, Kindergarten Spring"
label variable hhtot4 "Total number of people in household, 1st grade Spring"
label variable hhtot6 "Total number of people in household, 2nd grade Spring"
label variable hhtot7 "Total number of people in household, 3rd grade"
label variable hhtot8 "Total number of people in household, 4th grade"
label variable hhtot9 "Total number of people in household, 5th grade"

* PARENTS RESIDING IN HOUSEHOLD
local nums 1 2 4 6 7 8 9 
foreach i of local nums{
	replace x`i'hparnt = .p if x`i'hparnt == . 
	replace x`i'hparnt = .i if x`i'hparnt == -7 | x`i'hparnt == -8 | x`i'hparnt ==-9
	replace x`i'hparnt = . if x`i'hparnt ==-1 
	replace x`i'hparnt = 0 if x`i'hparnt == 2 | x`i'hparnt == 3 | x`i'hparnt == 4
	label values x`i'hparnt yes
	rename x`i'hparnt hhprnt`i'
}
label variable hhprnt1 "Two biological parents in household, Kindergarten Fall"
label variable hhprnt2 "Two biological parents in household, Kindergarten Spring"
label variable hhprnt4 "Two biological parents in household, 1st grade Spring"
label variable hhprnt6 "Two biological parents in household, 2nd grade Spring"
label variable hhprnt7 "Two biological parents in household, 3rd grade"
label variable hhprnt8 "Two biological parents in household, 4th grade"
label variable hhprnt9 "Two biological parents in household, 5th grade"

* NUMBER OF SIBLINGS IN HOUSEHOLD 
local nums 1 2 4 6 7 8 9
foreach i of local nums {
	replace x`i'numsib = .p if x`i'numsib == .
	replace x`i'numsib = .i if x`i'numsib == -7 | x`i'numsib ==-8 | x`i'numsib == -9
	replace x`i'numsib = . if x`i'numsib ==-1 
	replace x`i'numsib = 7 if x`i'numsib > 7 & x`i'numsib < 30
	label values x`i'numsib hh
	rename x`i'numsib sibtot`i'
}
label variable sibtot1 "Number of siblings in household, Kindergarten Fall"
label variable sibtot2 "Number of siblings in household, Kindergarten Spring"
label variable sibtot4 "Number of siblings in household, 1st grade Spring"
label variable sibtot6 "Number of siblings in household, 2nd grade Spring"
label variable sibtot7 "Number of siblings in household, 3rd grade"
label variable sibtot8 "Number of siblings in household, 4th grade"
label variable sibtot9 "Number of siblings in household, 5th grade"

/* Parent race/ethnicity */ 
* PARENT 1
label define race 1 "White, Non-Hispanic" 2 "Black/African American, Non-Hispanic" ///
3 "Hispanic" 4 "Asian, Non-Hispanic" 5 "other" 
rename x1par1rac par1race
replace par1race = .i if par1race == -9
replace par1race = .p if par1race == . 
replace par1race = 3 if par1race == 4
replace par1race = 4 if par1race == 5
replace par1race = 5 if par1race == 6 | par1race == 7 | par1race == 8
label values par1race race
label variable par1race "Parent 1 race/ethnicity"

* PARENT 2 
rename x1par2rac par2race
replace par2race = .i if par2race == -9
replace par2race = .p if par2race == .
replace par2race = . if par2race == -1 
replace par2race = 3 if par2race == 4
replace par2race = 4 if par2race == 5
replace par2race = 5 if par2race == 6 | par2race == 7 | par2race == 8
label values par2race race
label variable par2race "Parent 2 race/ethnicity"

/* Parent marital status */ 
label define mar 0 "Not currently married" 1 "Currently married"
local nums 1 2 4 6 7 8 9
foreach i of local nums {
	replace p`i'curmar = .p if p`i'curmar == . 
	replace p`i'curmar = .i if p`i'curmar == -7 | p`i'curmar == -8 | p`i'curmar ==-9
	replace p`i'curmar = . if p`i'curmar == -1 
	replace p`i'curmar = 0 if p`i'curmar == 2 | p`i'curmar == 3 | p`i'curmar == 4 | p`i'curmar == 5
	replace p`i'curmar = 1 if p`i'curmar == 6
	label values p`i'curmar mar
	rename p`i'curmar married`i'
}
label variable married1 "Parent current marital status, Kindergarten Fall"
label variable married2 "Parent current marital status, Kindergarten Spring"
label variable married4 "Parent current marital status, 1st grade Spring"
label variable married6 "Parent current marital status, 2nd grade Spring"
label variable married7 "Parent current marital status, 3rd grade"
label variable married8 "Parent current marital status, 4th grade"
label variable married9 "Parent current marital status, 5th grade"

/* Mother married at time of birth */ 
rename x12momar marbrth
replace marbrth = .i if marbrth == -9
replace marbrth = 0 if marbrth == 2 
label values marbrth yes
label variable marbrth "Mother was married at time of birth"

/* Parent age */ 
* PARENT 1 
rename x1par1age par1age1 
replace par1age1 = .i if par1age1 == -9
replace par1age1 = .p if par1age1 == .
label variable par1age1 "Parent 1 age in years, Kindergarten Fall"

* PARENT 2
rename x1par2age par2age1 
replace par2age1 = .i if par2age1 == -9
replace par2age1 = .p if par2age1 == .
replace par2age1 = . if par2age1 == -1
label variable par2age1 "Parent 2 age in years, Kindergarten Fall"

/* Parent educational expectations for child */ 
label define exp 0 "No postsecondary attendance" 1 "Some postsecondary schooling" ///
2 "Bachelor's degree" 3 "Graduate degree"
local nums 1 7 9 
foreach i of local nums { 
	replace p`i'expect = .i if p`i'expect == -7 | p`i'expect == -8 | p`i'expect == -9
	replace p`i'expect = .p if p`i'expect == . 
	replace p`i'expect = . if p`i'expect == -1
	replace p`i'expect = 0 if p`i'expect == 1 | p`i'expect== 2
	replace p`i'expect = 1 if p`i'expect == 3 | p`i'expect == 4
	replace p`i'expect = 2 if p`i'expect == 5 
	replace p`i'expect = 3 if p`i'expect == 6 | p`i'expect == 7
	label values p`i'expect exp
	rename p`i'expect p1exp`i'
}
label variable p1exp1 "Parent 1 educational expectations, Kindergarten Fall"
label variable p1exp7 "Parent 1 educational expectations, 3rd grade"
label variable p1exp9 "Parent 1 educational expectations, 5th grade"

/* Parent involvement */ 
* READS BOOKS TO CHILD 
rename p3rdbktc p3readbk
rename p5rdbktc p5readbk
local nums 1 3 4 5 6
foreach i of local nums { 
	replace p`i'readbk = .i if p`i'readbk == -7 | p`i'readbk == -8 | p`i'readbk == -9
	replace p`i'readbk = .p if p`i'readbk == . 
	replace p`i'readbk = . if p`i'readbk == -1
	rename p`i'readbk preadbk`i'
}
label variable preadbk1 "Parent reads books to child, Kindergarten Fall"
label variable preadbk3 "Parent reads books to child, 1st grade Fall"
label variable preadbk4 "Parent reads books to child, 1st grade Spring"
label variable preadbk5 "Parent reads books to child, 2nd grade Fall"
label variable preadbk6 "Parent reads books to child, 2nd grade Spring"

* FREQUENCY PRACTICE READ/WRITE #S 
rename p1numbrs p1practc
local nums 1 6 8 9 
foreach i of local nums { 
	replace p`i'practc = .i if p`i'practc == -7 | p`i'practc == -8 | p`i'practc == -9
	replace p`i'practc = .p if p`i'practc == . 
	replace p`i'practc = . if p`i'practc == -1
	rename p`i'practc pprctnm`i'
}
label variable pprctnm1 "Parent practices numbers with child, Kindergarten Fall"
label variable pprctnm6 "Parent practices numbers with child, 2nd grade Spring"
label variable pprctnm8 "Parent practices numbers with child, 4th grade"
label variable pprctnm9 "Parent practices numbers with child, 5th grade"

* PARENT ATTENDED BACK TO SCHOOL NIGHT
local nums 2 4 6 7 8 9 
foreach i of local nums { 
	replace p`i'attenb = .i if p`i'attenb == -7 | p`i'attenb == -8 | p`i'attenb == -9 
	replace p`i'attenb = .p if p`i'attenb == . 
	replace p`i'attenb = . if p`i'attenb == -1
	replace p`i'attenb = 0 if p`i'attenb == 2 
	label values p`i'attenb yes 
	rename p`i'attenb pbkschl`i'
}
label variable pbkschl2 "Parent attend back to school night, Kindergarten Spring"
label variable pbkschl4 "Parent attend back to school night, 1st grade Spring"
label variable pbkschl6 "Parent attend back to school night, 2nd grade Spring"
label variable pbkschl7 "Parent attend back to school night, 3rd grade"
label variable pbkschl8 "Parent attend back to school night, 4th grade"
label variable pbkschl9 "Parent attend back to school night, 5th grade"

* PARENT ATTENDED PTA/PTO MEETING
local nums 2 4 6 7 8 9 
foreach i of local nums { 
	replace p`i'attenp = .i if p`i'attenp == -7 | p`i'attenp == -8 | p`i'attenp == -9 
	replace p`i'attenp = .p if p`i'attenp == . 
	replace p`i'attenp = . if p`i'attenp == -1
	replace p`i'attenp = 0 if p`i'attenp == 2 
	label values p`i'attenp yes 
	rename p`i'attenp ppta`i'
}
label variable ppta2 "Parent attend PTA/PTO meeting, Kindergarten Spring"
label variable ppta4 "Parent attend PTA/PTO meeting, 1st grade Spring"
label variable ppta6 "Parent attend PTA/PTO meeting, 2nd grade Spring"
label variable ppta7 "Parent attend PTA/PTO meeting, 3rd grade"
label variable ppta8 "Parent attend PTA/PTO meeting, 4th grade"
label variable ppta9 "Parent attend PTA/PTO meeting, 5th grade"

* PARENT ATTENDED PARENT-TEACHER CONFERENCES
local nums 2 4 6 7 8 9 
foreach i of local nums { 
	replace p`i'ptconf = .i if p`i'ptconf == -7 | p`i'ptconf == -8 | p`i'ptconf == -9 
	replace p`i'ptconf = .p if p`i'ptconf == . 
	replace p`i'ptconf = . if p`i'ptconf == -1
	replace p`i'ptconf = 0 if p`i'ptconf == 2 
	label values p`i'ptconf yes 
	rename p`i'ptconf pconf`i'
}
label variable pconf2 "Parent attend parent-teacher conference, Kindergarten Spring"
label variable pconf4 "Parent attend parent-teacher conference, 1st grade Spring"
label variable pconf6 "Parent attend parent-teacher conference, 2nd grade Spring"
label variable pconf7 "Parent attend parent-teacher conference, 3rd grade"
label variable pconf8 "Parent attend parent-teacher conference, 4th grade"
label variable pconf9 "Parent attend parent-teacher conference, 5th grade"

* PARENT ATTENDED SCHOOL EVENT 
local nums 2 4 6 7 8 9 
foreach i of local nums { 
	replace p`i'attens = .i if p`i'attens == -7 | p`i'attens == -8 | p`i'attens == -9 
	replace p`i'attens = .p if p`i'attens == . 
	replace p`i'attens = . if p`i'attens == -1
	replace p`i'attens = 0 if p`i'attens == 2 
	label values p`i'attens yes 
	rename p`i'attens pattschl`i'
}
label variable pattschl2 "Parent attend school event, Kindergarten Spring"
label variable pattschl4 "Parent attend school event, 1st grade Spring"
label variable pattschl6 "Parent attend school event, 2nd grade Spring"
label variable pattschl7 "Parent attend school event, 3rd grade"
label variable pattschl8 "Parent attend school event, 4th grade"
label variable pattschl9 "Parent attend school event, 5th grade"

* PARENT VOLUNTEERED AT SCHOOL
local nums 2 4 6 7 8 9 
foreach i of local nums { 
	replace p`i'volsch = .i if p`i'volsch == -7 | p`i'volsch == -8 | p`i'volsch == -9 
	replace p`i'volsch = .p if p`i'volsch == . 
	replace p`i'volsch = . if p`i'volsch == -1
	replace p`i'volsch = 0 if p`i'volsch == 2 
	label values p`i'volsch yes 
	rename p`i'volsch pvolschl`i'
}
label variable pvolschl2 "Parent volunteered at school event, Kindergarten Spring"
label variable pvolschl4 "Parent volunteered at school event, 1st grade Spring"
label variable pvolschl6 "Parent volunteered at school event, 2nd grade Spring"
label variable pvolschl7 "Parent volunteered at school event, 3rd grade"
label variable pvolschl8 "Parent volunteered at school event, 4th grade"
label variable pvolschl9 "Parent volunteered at school event, 5th grade"

/************************************
CLEAN STUDENT-LEVEL CONTROL VARIABLES  
*************************************/
/* Student gender */ 
rename x_chsex_r gender
label variable gender "Child composite gender" 
replace gender = .i if gender == -9
replace gender = 0 if gender == 2 
label define gender 0 "Female" 1 "Male" 
label values gender gender

/* Student race/ethnicity */ 
rename x_racethp_r crace
gen race = . 
label variable race "Child composite race/ethnicity" 
replace race = 1 if crace == 1
replace race = 2 if crace == 2 
replace race = 3 if crace == 3 | crace == 4
replace race = 4 if crace == 5
replace race = 5 if crace == 6 | crace == 7 | crace == 8

label values race race
drop crace

/* Student birth weight */ 
rename p1weigho brthwt
replace brthwt = .i if brthwt == -7 | brthwt == -8 | brthwt == -9
replace brthwt = .p if brthwt == .
replace brthwt = . if brthwt == -1 | brthwt == -4 | brthwt == -5

/* Student first time kindergarten */ 
rename x1firkdg frstk
replace frstk = .i if frstk == -9
replace frstk = 0 if frstk == 2
label values frstk yes
	
/* Home language */ 
rename x12langst x1langst
local nums 4 6 1  
foreach i of local nums {
	replace x`i'langst = .i if x`i'langst == -7 | x`i'langst == -8 | x`i'langst == -9
	replace x`i'langst = .p if x`i'langst == . 
	replace x`i'langst = . if x`i'langst == -1 | x`i'langst == -4 | x`i'langst == -5
	replace x`i'langst = 2 if x`i'langst == 3
	rename x`i'langst lang`i'
}
label variable lang1 "Home language English, Kindergarten Fall"
label variable lang4 "Home language English, 1st grade Spring"
label variable lang6 "Home language English, 2nd grade Spring"

/* Family receive WIC */ 
local nums 1 2 
foreach i of local nums {
	replace p`i'wicchd = .i if p`i'wicchd == -7 | p`i'wicchd == -8 | p`i'wicchd == -9
	replace p`i'wicchd = .p if p`i'wicchd == . 
	replace p`i'wicchd = . if p`i'wicchd == -1 | p`i'wicchd == -4 | p`i'wicchd == -5
	replace p`i'wicchd = 0 if p`i'wicchd == 2
	rename p`i'wicchd wichh`i'
	label values wichh`i' yes
}
tabulate wichh1 wichh2, mi
gen wichh = . 
replace wichh = 0 if wichh1 == 0
replace wichh = 0 if wichh2 == 0 
replace wichh = 1 if wichh1 == 1 
replace wichh = 1 if wichh2 == 1 
label variable wichh "Family received WIC ever" 

/* Mother received WIC when pregnant */ 
local nums 1 2 
foreach i of local nums {
	replace p`i'wicmom = .i if p`i'wicmom == -7 | p`i'wicmom == -8 | p`i'wicmom == -9
	replace p`i'wicmom = .p if p`i'wicmom == . 
	replace p`i'wicmom = . if p`i'wicmom == -1 | p`i'wicmom == -4 | p`i'wicmom == -5
	replace p`i'wicmom = 0 if p`i'wicmom == 2
	rename p`i'wicmom wicp`i'
	label values wicp`i' yes
}
tabulate wicp1 wicp2, mi
gen wicp = . 
replace wicp = 0 if wicp1 == 0 
replace wicp = 0 if wicp2 == 0 
replace wicp = 1 if wicp1 == 1 
replace wicp = 1 if wicp2 == 1 
label variable wicp "Mother received WIC when pregnant"

/* Family receive foodstamps */ 
local nums 1 2 4 6 8 9 
foreach i of local nums { 
	replace p`i'fstamp = .i if p`i'fstamp == -7 | p`i'fstamp == -8 | p`i'fstamp == -9
	replace p`i'fstamp = .p if p`i'fstamp == . 
	replace p`i'fstamp = . if p`i'fstamp == -1 | p`i'fstamp == -4 | p`i'fstamp == -5
	replace p`i'fstamp = 0 if p`i'fstamp == 2
	rename p`i'fstamp fstmp`i'
	label values fstmp`i' yes
}
label variable fstmp1 "Family received foodstamps in past 12 months, Kindergarten Fall"
label variable fstmp2 "Family received foodstamps in past 12 months, Kindergarten Spring"
label variable fstmp4 "Family received foodstamps in past 12 months, 1st grade Spring"
label variable fstmp6 "Family received foodstamps in past 12 months, 2nd grade Spring"
label variable fstmp8 "Family received foodstamps in past 12 months, 4th grade"
label variable fstmp9 "Family received foodstamps in past 12 months, 5th grade"

/* Family receive TANF */ 
local nums 1 2 4 6 8 9 
foreach i of local nums { 
	replace p`i'tanf = .i if p`i'tanf == -7 | p`i'tanf == -8 | p`i'tanf == -9
	replace p`i'tanf = .p if p`i'tanf == . 
	replace p`i'tanf = . if p`i'tanf == -1 | p`i'tanf == -4 | p`i'tanf == -5
	replace p`i'tanf = 0 if p`i'tanf == 2
	rename p`i'tanf tanf`i'
	label values tanf`i' yes
}
label variable tanf1 "Family received TANF ever, Kindergarten Fall"
label variable tanf2 "Family received TANF ever, Kindergarten Spring"
label variable tanf4 "Family received TANF ever, 1st grade Spring"
label variable tanf6 "Family received TANF ever, 2nd grade Spring"
label variable tanf8 "Family received TANF ever, 4th grade"
label variable tanf9 "Family received TANF ever, 5th grade"

/* Student age */ 
rename x1kage_r x1age
rename x2kage_r x2age
local nums 1 2 3 4 5 6 7 8 9 
foreach i of local nums { 
	replace x`i'age = .i if x`i'age == -7 | x`i'age == -8 | x`i'age == -9
	replace x`i'age = .p if x`i'age == . 
	replace x`i'age = . if x`i'age == -1 | x`i'age == -4 | x`i'age == -5
	rename x`i'age age`i'
}
label variable age1 "Child assessment age in months, Kindergarten Fall"
label variable age2 "Child assessment age in months, Kindergarten Spring"
label variable age3 "Child assessment age in months, 1st grade Fall"
label variable age4 "Child assessment age in months, 1st grade Spring"
label variable age6 "Child assessment age in months, 2nd grade Spring"
label variable age8 "Child assessment age in months, 4th grade"
label variable age9 "Child assessment age in months, 5th grade"

/* Indicator for students who were held back */ 
tabulate t3grade 
gen hldbck = . 
replace hldbck = 0 if t3grade == 3 | t3grade == 4 | t3grade == 5
replace hldbck = 1 if t3grade == 1 | t3grade == 2
label variable hldbck "Student was held back in Kindergarten"

/* Students attended summer school between K and 1st grade */ 
rename p3sumsch smschl3
replace smschl3 = .i if smschl3 == -9 | smschl3 == -7
replace smschl3 = 0 if smschl3 == 2
label values smschl3 yes
label variable smschl3 "Child attended summer school after kindergarten"

/**************************************************
CLEAN SCHOOL-LEVEL STUDENT CHARACTERISTIC VARIABLES  
***************************************************/
/* Total school enrollment */ 
rename x2kenrls x2enrls 
local nums 2 4 6 7 8 9 
foreach i of local nums { 
	replace x`i'enrls = .i if x`i'enrls == -7 | x`i'enrls == -8 | x`i'enrls == -9
	replace x`i'enrls = .p if x`i'enrls == .
	replace x`i'enrls = . if x`i'enrls == -1 | x`i'enrls == -4 | x`i'enrls ==-5
	rename x`i'enrls stotenrl`i'
}
label variable stotenrl2 "School total enrollment, Kindergarten Spring"
label variable stotenrl4 "School total enrollment, 1st grade Spring"
label variable stotenrl6 "School total enrollment, 2nd grade Spring"
label variable stotenrl7 "School total enrollment, 3rd grade"
label variable stotenrl8 "School total enrollment, 4th grade"
label variable stotenrl9 "School total enrollment, 5th grade"

/* Average daily attendance */ 
replace s4ada = .i if s4ada == -7 | s4ada == -8 | s4ada == -9
replace s4ada = .p if s4ada == .
replace s4ada = . if s4ada == -1 | s4ada == -4 | s4ada == -5
replace s4ada = s4ada/100
sum s4ada, det

*Drop observations with values that were probably % missing
replace s4ada = . if s4ada > 0.01 & s4ada <.25
sum s4ada, det

*Censor at 1st percentile for remaining issues that seem like data entry issue 
replace s4ada = .85 if s4ada < r(p1)

rename s4ada sattnd4
label variable sattnd4 "School - % of average daily attendance" 


/* Racial composition of students */ 
* % HISPANIC STUDENTS 
local nums 2 4 6 7 8 9
foreach i of local nums { 
	replace s`i'hisppt = .i if s`i'hisppt == -7 | s`i'hisppt == -8 | s`i'hisppt == -9
	replace s`i'hisppt = .p if s`i'hisppt == . 
	replace s`i'hisppt = . if s`i'hisppt == -1 | s`i'hisppt == -4 | s`i'hisppt == -5
	replace s`i'hisppt = s`i'hisppt/100
	rename s`i'hisppt shspnc`i'
}
label variable shspnc2 "% students in school Hispanic/Latino, Kindergarten Spring"
label variable shspnc4 "% students in school Hispanic/Latino, 1st grade Spring"
label variable shspnc6 "% students in school Hispanic/Latino, 2nd grade Spring"
label variable shspnc7 "% students in school Hispanic/Latino, 3rd grade"
label variable shspnc8 "% students in school Hispanic/Latino, 4th grade"
label variable shspnc9 "% students in school Hispanic/Latino, 5th grade"

* % BLACK STUDENTS 
local nums 2 4 6 7 8 9
foreach i of local nums { 
	replace s`i'blacpt = .i if s`i'blacpt == -7 | s`i'blacpt == -8 | s`i'blacpt == -9
	replace s`i'blacpt = .p if s`i'blacpt == . 
	replace s`i'blacpt = . if s`i'blacpt == -1 | s`i'blacpt == -4 | s`i'blacpt == -5
	replace s`i'blacpt = s`i'blacpt/100
	rename s`i'blacpt sblk`i'
}
label variable sblk2 "% students in school Black/African American, Kindergarten Spring"
label variable sblk4 "% students in school Black/African American, 1st grade Spring"
label variable sblk6 "% students in school Black/African American, 2nd grade Spring"
label variable sblk7 "% students in school Black/African American, 3rd grade"
label variable sblk8 "% students in school Black/African American, 4th grade"
label variable sblk9 "% students in school Black/African American, 5th grade"

* % WHITE STUDENTS 
local nums 2 4 6 7 8 9
foreach i of local nums { 
	replace s`i'whitpt = .i if s`i'whitpt == -7 | s`i'whitpt == -8 | s`i'whitpt == -9
	replace s`i'whitpt = .p if s`i'whitpt == . 
	replace s`i'whitpt = . if s`i'whitpt == -1 | s`i'whitpt == -4 | s`i'whitpt == -5
	replace s`i'whitpt = s`i'whitpt/100
	rename s`i'whitpt swht`i'
}
label variable swht2 "% students in school White, Kindergarten Spring"
label variable swht4 "% students in school White, 1st grade Spring"
label variable swht6 "% students in school White, 2nd grade Spring"
label variable swht7 "% students in school White, 3rd grade"
label variable swht8 "% students in school White, 4th grade"
label variable swht9 "% students in school White, 5th grade"

/* % of Students bussed to integrate */ 
replace s2bussed = .i if s2bussed == -9
replace s2bussed = .p if s2bussed == . 
replace s2bussed = s2bussed/100
rename s2bussed sbus2
label variable sbus2 "% students bussed in to integrate school"

/* % of Students ELL */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'totell = .i if s`i'totell == -7 | s`i'totell == -8 | s`i'totell == -9
	replace s`i'totell = .p if s`i'totell == . 
	replace s`i'totell = . if s`i'totell == -1 | s`i'totell == -4 | s`i'totell == -5
	replace s`i'totell = s`i'totell/100
	rename s`i'totell stotell`i'
}
label variable stotell2 "% students in school ELL, Kindergarten Spring"
label variable stotell4 "% students in school ELL, 1st grade Spring"
label variable stotell6 "% students in school ELL, 2nd grade Spring"
label variable stotell7 "% students in school ELL, 3rd grade"
label variable stotell8 "% students in school ELL, 4th grade"
label variable stotell9 "% students in school ELL, 5th grade"

*Set observation to missing if values over 100% 
replace stotell4 = . if stotell4 > 1

/* % of Students in G/T program */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'gifpct = .i if s`i'gifpct == -7 | s`i'gifpct == -8 | s`i'gifpct == -9
	replace s`i'gifpct = .p if s`i'gifpct == . 
	replace s`i'gifpct = . if s`i'gifpct == -1 | s`i'gifpct == -4 | s`i'gifpct == -5
	replace s`i'gifpct = s`i'gifpct/100
	rename s`i'gifpct sgif`i'
}
label variable sgif2 "% students in G/T program, Kindergarten Spring"
label variable sgif4 "% students in G/T program, 1st grade Spring"
label variable sgif6 "% students in G/T program, 2nd grade Spring"
label variable sgif7 "% students in G/T program, 3rd grade"
label variable sgif8 "% students in G/T program, 4th grade"
label variable sgif9 "% students in G/T program, 5th grade"

/* % of students in special education */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'spdpct = .i if s`i'spdpct == -7 | s`i'spdpct == -8 | s`i'spdpct == -9
	replace s`i'spdpct = .p if s`i'spdpct == . 
	replace s`i'spdpct = . if s`i'spdpct == -1 | s`i'spdpct == -4 | s`i'spdpct == -5
	replace s`i'spdpct = s`i'spdpct/100
	rename s`i'spdpct sspced`i'
}
label variable sspced2 "% students in special education, Kindergarten Spring"
label variable sspced4 "% students in special education, 1st grade Spring"
label variable sspced6 "% students in special education, 2nd grade Spring"
label variable sspced7 "% students in special education, 3rd grade"
label variable sspced8 "% students in special education, 4th grade"
label variable sspced9 "% students in special education, 5th grade"

/* % of Students eligible free or reduced lunch */ 
* FREE OR REDUCED LUNCH VARIABLE
local nums 6 7 8 9 
foreach i of local nums {
	replace x`i'frmeal_i = .i if x`i'frmeal_i == -7 | x`i'frmeal_i == -8 | x`i'frmeal_i == -9
	replace x`i'frmeal_i = .p if x`i'frmeal_i == .
	replace x`i'frmeal_i = . if x`i'frmeal_i == -1 | x`i'frmeal_i == -4 | x`i'frmeal_i == -5
	replace x`i'frmeal_i = . if x`i'frmeal_i > 100 & x`i'frmeal_i < 6000 /* KW: I can't figure out why, but there are a few values above 100 for some of these waves, so maybe just an error? */
	replace x`i'frmeal_i = x`i'frmeal_i/100
	rename x`i'frmeal_i sfrlnch`i'
}
label variable sfrlnch6 "% students eligible free or reduced lunch, 2nd grade Spring"
label variable sfrlnch7 "% students eligible free or reduced lunch, 3rd grade"
label variable sfrlnch8 "% students eligible free or reduced lunch, 4th grade"
label variable sfrlnch9 "% students eligible free or reduced lunch, 5th grade"

* CREATE FREE/REDUCED LUNCH COMBINED VARIABLE FOR OTHER WAVES
replace x2flch2_i = .i if x2flch2_i == -7 | x2flch2_i == -8 | x2flch2_i == -9
replace x2flch2_i = .p if x2flch2_i == .
replace x2flch2_i = . if x2flch2_i == -1 | x2flch2_i == -4 | x2flch2_i == -5
replace x2rlch2_i = .i if x2rlch2_i == -7 | x2rlch2_i == -8 | x2rlch2_i == -9
replace x2rlch2_i = .p if x2rlch2_i == .
replace x2rlch2_i = . if x2rlch2_i == -1 | x2rlch2_i == -4 | x2rlch2_i == -5
gen sfrlnch2 = x2flch2_i + x2rlch2_i
tabulate sfrlnch2
replace sfrlnch2 = . if sfrlnch2 > 100 & sfrlnch2 < 6000
replace sfrlnch2 = sfrlnch2/100
sum sfrlnch2 
sum sfrlnch9 /* KW: sfrlnch2 has a similar mean and SD as the wave 9 version, so this seems right */
label variable sfrlnch2 "% students eligible free or reduced lunch, Kindergarten Spring" 

replace x4fmeal_i = .i if x4fmeal_i == -7 | x4fmeal_i == -8 | x4fmeal_i == -9
replace x4fmeal_i = .p if x4fmeal_i == .
replace x4fmeal_i = . if x4fmeal_i == -1 | x4fmeal_i == -4 | x4fmeal_i == -5
replace x4rmeal_i = .i if x4rmeal_i == -7 | x4rmeal_i == -8 | x4rmeal_i == -9
replace x4rmeal_i = .p if x4rmeal_i == .
replace x4rmeal_i = . if x4rmeal_i == -1 | x4rmeal_i == -4 | x4rmeal_i == -5
gen sfrlnch4 = x4fmeal_i + x4rmeal_i
tabulate sfrlnch4
replace sfrlnch4 = . if sfrlnch4 > 100 & sfrlnch4 < 6000
replace sfrlnch4 = sfrlnch4/100
sum sfrlnch4 
label variable sfrlnch4 "% students eligible free or reduced lunch, 1st grade Spring" 

/**************************************************
CLEAN SCHOOL-LEVEL TEACHER CHARACTERISTIC VARIABLES  
***************************************************/
/* Teacher highest level of education */ 
label define ed 0 "Bachelor's degree" 1 "Graduate degree"
local nums 1 4 6 7 8 9
foreach i of local nums {
	replace a`i'hghstd = .i if a`i'hghstd == -7 | a`i'hghstd == -8 | a`i'hghstd == -9
	replace a`i'hghstd = .p if a`i'hghstd == .
	replace a`i'hghstd = . if a`i'hghstd == -1 | a`i'hghstd == -4 | a`i'hghstd == -5
	replace a`i'hghstd = . if a`i'hghstd == 2 | a`i'hghstd == 3 | a`i'hghstd == 4 /* A few said HS diploma, some college, or Associate's degree, but under 1%, so recoded to missing for now */
	replace a`i'hghstd = 0 if a`i'hghstd == 5 
	replace a`i'hghstd = 1 if a`i'hghstd == 6 | a`i'hghstd == 7
	label values a`i'hghstd ed
	rename a`i'hghstd ted`i'
}
label variable ted1 "Teacher highest education, Kindergarten Fall"
label variable ted4 "Teacher highest education, 1st grade Spring"
label variable ted6 "Teacher highest education, 2nd grade Spring"
label variable ted7 "Teacher highest education, 3rd grade"
label variable ted8 "Teacher highest education, 4th grade"
label variable ted9 "Teacher highest education, 5th grade"

/* Teacher years taught total */ 
local nums 1 4 6 7 8 9 
foreach i of local nums {
	replace a`i'yrstch = .i if a`i'yrstch == -7 | a`i'yrstch == -8 | a`i'yrstch == -9
	replace a`i'yrstch = .p if a`i'yrstch == .
	replace a`i'yrstch = . if a`i'yrstch == -1 | a`i'yrstch == -4 | a`i'yrstch == -5
	rename a`i'yrstch tyrstch`i'
}
label variable tyrstch1 "Teacher total years teaching, Kindergarten Fall"
label variable tyrstch4 "Teacher total years teaching, 1st grade Spring"
label variable tyrstch6 "Teacher total years teaching, 2nd grade Spring"
label variable tyrstch7 "Teacher total years teaching, 3rd grade"
label variable tyrstch8 "Teacher total years teaching, 4th grade"
label variable tyrstch9 "Teacher total years teaching, 5th grade"

/* Teacher years taught at this school */ 
local nums 1 4 6 
foreach i of local nums {
	replace a`i'yrsch = .i if a`i'yrsch == -7 | a`i'yrsch == -8 | a`i'yrsch == -9
	replace a`i'yrsch = .p if a`i'yrsch == .
	replace a`i'yrsch = . if a`i'yrsch == -1 | a`i'yrsch == -4 | a`i'yrsch == -5
	rename a`i'yrsch tyrsch`i'
}
label variable tyrstch1 "Teacher years teaching at this school, Kindergarten Fall"
label variable tyrstch4 "Teacher years teaching at this school, 1st grade Spring"
label variable tyrstch6 "Teacher years teaching at this school, 2nd grade Spring"

/* Teacher national board exam status */ 
local nums 1 4 6 
foreach i of local nums {
	replace a`i'natexm = .i if a`i'natexm == -7 | a`i'natexm == -8 | a`i'natexm == -9
	replace a`i'natexm = .p if a`i'natexm == .
	replace a`i'natexm = . if a`i'natexm == -1 | a`i'natexm == -4 | a`i'natexm == -5
	replace a`i'natexm = 0 if a`i'natexm == 1 | a`i'natexm == 3 | a`i'natexm == 4
	replace a`i'natexm = 1 if a`i'natexm == 2
	label values a`i'natexm yes
	rename a`i'natexm tnexm`i'
}
label variable tnexm1 "Teacher took and passed national board exam, Kindergarten Fall"
label variable tnexm4 "Teacher took and passed national board exam, 1st grade Spring"
label variable tnexm6 "Teacher took and passed national board exam, 2nd grade Spring"

/* Teacher certification type */ 
label define cert 0 "No certification" 1 "Regular/state certification" 2 "Other form of certification"
local nums 1 4 6 7 8 9 
foreach i of local nums {
	replace a`i'statct = .i if a`i'statct == -7 | a`i'statct == -8 | a`i'statct == -9
	replace a`i'statct = .p if a`i'statct == .
	replace a`i'statct = . if a`i'statct == -1 | a`i'statct == -4 | a`i'statct == -5
	replace a`i'statct = 0 if a`i'statct == 5
	replace a`i'statct = 2 if a`i'statct == 3 | a`i'statct == 4
	label values a`i'statct cert
	rename a`i'statct tcrt`i'
}
label variable tcrt1 "Teacher certification type, Kindergarten Fall"
label variable tcrt4 "Teacher certification type, 1st grade Spring"
label variable tcrt6 "Teacher certification type, 2nd grade Spring"
label variable tcrt7 "Teacher certification type, 3rd grade"
label variable tcrt8 "Teacher certification type, 4th grade"
label variable tcrt9 "Teacher certification type, 5th grade"

/* Teacher gender */ 
local nums 1 4 6 7 8 9
foreach i of local nums {
	replace a`i'tgend = .i if a`i'tgend == -7 | a`i'tgend == -8 | a`i'tgend == -9
	replace a`i'tgend = .p if a`i'tgend == .
	replace a`i'tgend = . if a`i'tgend == -1 | a`i'tgend == -4 | a`i'tgend == -5
	replace a`i'tgend = 0 if a`i'tgend == 2
	label values a`i'tgend gender
	rename a`i'tgend tgender`i'
}
label variable tgender1 "Teacher gender, Kindergarten Fall"
label variable tgender4 "Teacher gender, 1st grade Spring"
label variable tgender6 "Teacher gender, 2nd grade Spring"
label variable tgender7 "Teacher gender, 3rd grade"
label variable tgender8 "Teacher gender, 4th grade"
label variable tgender9 "Teacher gender, 5th grade"

/* Teacher race/ethnicity */ 
local nums 1 4 6 7 8 9
foreach i of local nums {
	gen trace`i' = .
	replace trace`i' = 1 if a`i'white == 1
	replace trace`i' = 2 if a`i'black == 1
	replace trace`i' = 3 if a`i'hisp == 1 
	replace trace`i' = 4 if a`i'asian == 1
	replace trace`i' = 5 if a`i'aminan == 1 | a`i'hawpi == 1
	label values trace`i' race 
}
label variable trace1 "Teacher race/ethnicity, Kindergarten Fall"
label variable trace4 "Teacher race/ethnicity, 1st grade Spring"
label variable trace6 "Teacher race/ethnicity, 2nd grade Spring"
label variable trace7 "Teacher race/ethnicity, 3rd grade"
label variable trace8 "Teacher race/ethnicity, 4th grade"
label variable trace9 "Teacher race/ethnicity, 5th grade"

/****************************************************
CLEAN SCHOOL-LEVEL PRINCIPAL CHARACTERISTIC VARIABLES  
*****************************************************/
/* Principal years at school */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'ryyemp = .i if s`i'ryyemp == -7 | s`i'ryyemp == -8 | s`i'ryyemp == -9
	replace s`i'ryyemp = .p if s`i'ryyemp == .
	replace s`i'ryyemp = . if s`i'ryyemp == -1 | s`i'ryyemp == -4 | s`i'ryyemp == -5
	rename s`i'ryyemp pyrssch`i'
}
label variable pyrssch2 "Principal years at school, Kindergarten Spring"
label variable pyrssch4 "Principal years at school, 1st grade Spring"
label variable pyrssch6 "Principal years at school, 2nd grade Spring"
label variable pyrssch7 "Principal years at school, 3rd grade Spring"
label variable pyrssch8 "Principal years at school, 4th grade Spring"
label variable pyrssch9 "Principal years at school, 5th grade"

/* Principal years teaching */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'ystch = .i if s`i'ystch == -7 | s`i'ystch == -8 | s`i'ystch == -9
	replace s`i'ystch = .p if s`i'ystch == .
	replace s`i'ystch = . if s`i'ystch == -1 | s`i'ystch == -4 | s`i'ystch == -5
	rename s`i'ystch pyrstch`i'
}
label variable pyrstch2 "Principal years teaching, Kindergarten Spring"
label variable pyrstch4 "Principal years teaching, 1st grade Spring"
label variable pyrstch6 "Principal years teaching, 2nd grade Spring"
label variable pyrstch7 "Principal years teaching, 3rd grade Spring"
label variable pyrstch8 "Principal years teaching, 4th grade Spring"
label variable pyrstch9 "Principal years teaching, 5th grade"

/* Principal years as principal */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'totpri = .i if s`i'totpri == -7 | s`i'totpri == -8 | s`i'totpri == -9
	replace s`i'totpri = .p if s`i'totpri == .
	replace s`i'totpri = . if s`i'totpri == -1 | s`i'totpri == -4 | s`i'totpri == -5
	rename s`i'totpri pyrspr`i'
}
label variable pyrspr2 "Principal years as principal, Kindergarten Spring"
label variable pyrspr4 "Principal years as principal, 1st grade Spring"
label variable pyrspr6 "Principal years as principal, 2nd grade Spring"
label variable pyrspr7 "Principal years as principal, 3rd grade Spring"
label variable pyrspr8 "Principal years as principal, 4th grade Spring"
label variable pyrspr9 "Principal years as principal, 5th grade"

/* Principal highest education level */ 
label define pred 0 "Bachelor's degree" 1 "Master's degree" 2 "Graduate degree beyond Master's"
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'edlvl = .i if s`i'edlvl == -7 | s`i'edlvl == -8 | s`i'edlvl == -9
	replace s`i'edlvl = .p if s`i'edlvl == .
	replace s`i'edlvl = . if s`i'edlvl == -1 | s`i'edlvl == -4 | s`i'edlvl == -5
	replace s`i'edlvl = . if s`i'edlvl == 1 | s`i'edlvl == 2
	replace s`i'edlvl = 0 if s`i'edlvl == 3 | s`i'edlvl == 4
	replace s`i'edlvl = 1 if s`i'edlvl == 5
	replace s`i'edlvl = 2 if s`i'edlvl == 6 | s`i'edlvl == 7
	label values s`i'edlvl pred
	rename s`i'edlvl ped`i'
}
label variable ped2 "Principal highest education level, Kindergarten Spring"
label variable ped4 "Principal highest education level, 1st grade Spring"
label variable ped6 "Principal highest education level, 2nd grade Spring"
label variable ped7 "Principal highest education level, 3rd grade"
label variable ped8 "Principal highest education level, 4th grade"
label variable ped9 "Principal highest education level, 5th grade"

/* Principal race/ethnicity */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	gen prace`i' = .
	replace prace`i' = 1 if s`i'white == 1
	replace prace`i' = 2 if s`i'black == 1
	replace prace`i' = 3 if s`i'hisp == 1 
	replace prace`i' = 4 if s`i'asian == 1
	replace prace`i' = 5 if s`i'aminan == 1 | s`i'hawpi == 1
	label values prace`i' race 
}
label variable prace2 "Principal race/ethnicity, Kindergarten Spring"
label variable prace4 "Principal race/ethnicity, 1st grade Spring"
label variable prace6 "Principal race/ethnicity, 2nd grade Spring"
label variable prace7 "Principal race/ethnicity, 3rd grade"
label variable prace8 "Principal race/ethnicity, 4th grade"
label variable prace9 "Principal race/ethnicity, 5th grade"

/* Principal gender */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'gender = .i if s`i'gender == -7 | s`i'gender == -8 | s`i'gender == -9
	replace s`i'gender = .p if s`i'gender == .
	replace s`i'gender = . if s`i'gender == -1 | s`i'gender == -4 | s`i'gender == -5
	replace s`i'gender = 0 if s`i'gender == 2
	label values s`i'gender gender
	rename s`i'gender pgender`i'
}
label variable pgender2 "Principal gender, Kindergarten Fall"
label variable pgender4 "Principal gender, 1st grade Spring"
label variable pgender6 "Principal gender, 2nd grade Spring"
label variable pgender7 "Principal gender, 3rd grade"
label variable pgender8 "Principal gender, 4th grade"
label variable pgender9 "Principal gender, 5th grade"

/***********************************
CLEAN SCHOOL-LEVEL FINANCE VARIABLES  
************************************/
/* Funding levels decreased since last year */ 
rename s2fundlv s2funddc
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'funddc = .i if s`i'funddc == -7 | s`i'funddc == -8 | s`i'funddc == -9
	replace s`i'funddc = .p if s`i'funddc == . 
	replace s`i'funddc = . if s`i'funddc == -1 | s`i'funddc == -4 | s`i'funddc == -5
	rename s`i'funddc sfnddc`i'
}
replace sfnddc2 = 0 if sfnddc2 == 2 
label values sfnddc2 yes 

local nums 4 6 7 8 9 
foreach i of local nums {
	replace sfnddc`i' = 0 if sfnddc`i' == 1
	replace sfnddc`i' = 1 if sfnddc`i' == 2 | sfnddc`i' == 3 | sfnddc`i' == 4
	label values sfnddc`i' yes
}
label variable sfnddc2 "School funding decreased from last year, Kindergarten Spring"
label variable sfnddc4 "School funding decreased from last year, 1st grade Spring"
label variable sfnddc6 "School funding decreased from last year, 2nd grade Spring"
label variable sfnddc7 "School funding decreased from last year, 3rd grade"
label variable sfnddc8 "School funding decreased from last year, 4th grade"
label variable sfnddc9 "School funding decreased from last year, 5th grade"

/* Received Title 1 funds */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'tt1 = .i if s`i'tt1 == -7 | s`i'tt1 == -8 | s`i'tt1 == -9
	replace s`i'tt1 = .p if s`i'tt1 == .
	replace s`i'tt1 = . if s`i'tt1 == -1 | s`i'tt1 == -4 | s`i'tt1 == -5
	replace s`i'tt1 = 0 if s`i'tt1 == 2 
	label values s`i'tt1 yes
	rename s`i'tt1 ttlone`i'
}
label variable ttlone2 "School received Title 1 funds, Kindergarten Spring"
label variable ttlone4 "School received Title 1 funds, 1st grade Spring"
label variable ttlone6 "School received Title 1 funds, 2nd grade Spring"
label variable ttlone7 "School received Title 1 funds, 3rd grade"
label variable ttlone8 "School received Title 1 funds, 4th grade"
label variable ttlone9 "School received Title 1 funds, 5th grade"

/* Staff salaries increased since last year */ 
local nums 4 6 7 8 9
foreach i of local nums {
	replace s`i'csalin = .i if s`i'csalin == -7 | s`i'csalin == -8 | s`i'csalin == -9
	replace s`i'csalin = .p if s`i'csalin == .
	replace s`i'csalin = . if s`i'csalin == -1 | s`i'csalin == -4 | s`i'csalin == -5
	replace s`i'csalin = 0 if s`i'csalin == 1
	replace s`i'csalin = 1 if s`i'csalin == 2 | s`i'csalin == 3 | s`i'csalin == 4
	label values s`i'csalin yes
	rename s`i'csalin sstffinc`i'
}
label variable sstffinc4 "School staff salaries increased, 1st grade Spring"
label variable sstffinc6 "School staff salaries increased, 2nd grade Spring"
label variable sstffinc7 "School staff salaries increased, 3rd grade"
label variable sstffinc8 "School staff salaries increased, 4th grade"
label variable sstffinc9 "School staff salaries increased, 5th grade"

/* Staff salaries decreased since last year */ 
local nums 4 6 7 8 9 
foreach i of local nums {
	replace s`i'csalde = .i if s`i'csalde == -7 | s`i'csalde == -8 | s`i'csalde == -9
	replace s`i'csalde = .p if s`i'csalde == .
	replace s`i'csalde = . if s`i'csalde == -1 | s`i'csalde == -4 | s`i'csalde == -5
	replace s`i'csalde = 0 if s`i'csalde == 1
	replace s`i'csalde = 1 if s`i'csalde == 2 | s`i'csalde == 3 | s`i'csalde == 4
	label values s`i'csalde yes
	rename s`i'csalde sstffdec`i'
}
label variable sstffdec4 "School staff salaries decreased, 1st grade Spring"
label variable sstffdec6 "School staff salaries decreased, 2nd grade Spring"
label variable sstffdec7 "School staff salaries decreased, 3rd grade"
label variable sstffdec8 "School staff salaries decreased, 4th grade"
label variable sstffdec9 "School staff salaries decreased, 5th grade"

/* Staff salaries frozen from last year */ 
local nums 4 6 7 8 9 
foreach i of local nums {
	replace s`i'cslyfz = .i if s`i'cslyfz == -7 | s`i'cslyfz == -8 | s`i'cslyfz == -9
	replace s`i'cslyfz = .p if s`i'cslyfz == .
	replace s`i'cslyfz = . if s`i'cslyfz == -1 | s`i'cslyfz == -4 | s`i'cslyfz == -5
	replace s`i'cslyfz = 0 if s`i'cslyfz == 2
	label values s`i'cslyfz yes
	rename s`i'cslyfz sstfffrz`i'
}
label variable sstfffrz4 "School staff salaries frozen, 1st grade Spring"
label variable sstfffrz6 "School staff salaries frozen, 2nd grade Spring"
label variable sstfffrz7 "School staff salaries frozen, 3rd grade"
label variable sstfffrz8 "School staff salaries frozen, 4th grade"
label variable sstfffrz9 "School staff salaries frozen, 5th grade"

/**************************************************
CLEAN SCHOOL-LEVEL SCHOOL CHARACTERISTICS VARIABLES  
***************************************************/
/* Year round school */ 
rename x12yrrnd x2yrrnd
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace x`i'yrrnd = .i if x`i'yrrnd == -7 | x`i'yrrnd == -8 | x`i'yrrnd == -9
	replace x`i'yrrnd = .p if x`i'yrrnd == .
	replace x`i'yrrnd = . if x`i'yrrnd == -1 | x`i'yrrnd == -4 | x`i'yrrnd == -5
	label values x`i'yrrnd yes
	rename x`i'yrrnd syrrnd`i'
}
label variable syrrnd2 "School goes year round, Kindergarten Spring"
label variable syrrnd4 "School goes year round, 1st grade Spring"
label variable syrrnd6 "School goes year round, 2nd grade Spring"
label variable syrrnd7 "School goes year round, 3rd grade"
label variable syrrnd8 "School goes year round, 4th grade"
label variable syrrnd9 "School goes year round, 5th grade"

/* Public or private school */ 
label define pub 0 "Private school" 1 "Public school"
local nums 1 2 3 4 5 6 7 8 9 
foreach i of local nums {
	replace x`i'pubpri = .i if x`i'pubpri == -7 | x`i'pubpri == -8 | x`i'pubpri ==-9
	replace x`i'pubpri = .p if x`i'pubpri == .
	replace x`i'pubpri = . if x`i'pubpri == -1 | x`i'pubpri == -4 | x`i'pubpri == -5
	replace x`i'pubpri = 0 if x`i'pubpri == 2
	label values x`i'pubpri pub
	rename x`i'pubpri spblc`i'
}
label variable spblc1 "School is a public school, Kindergarten Fall"
label variable spblc2 "School is a public school, Kindergarten Spring"
label variable spblc3 "School is a public school, 1st grade Fall"
label variable spblc4 "School is a public school, 1st grade Spring"
label variable spblc5 "School is a public school, 2nd grade Fall"
label variable spblc6 "School is a public school, 2nd grade Spring"
label variable spblc7 "School is a public school, 3rd grade"
label variable spblc8 "School is a public school, 4th grade"
label variable spblc9 "School is a public school, 5th grade"

/* School type */ 
rename x1ksctyp x1sctyp
rename x2ksctyp x2sctyp
local nums 1 2 4 6 7 8 9 
foreach i of local nums {
	replace x`i'sctyp = .i if x`i'sctyp == -7 | x`i'sctyp == -8 | x`i'sctyp ==-9
	replace x`i'sctyp = .p if x`i'sctyp == .
	replace x`i'sctyp = . if x`i'sctyp == -1 | x`i'sctyp == -4 | x`i'sctyp == -5
	rename x`i'sctyp stype`i'
}
label variable stype1 "School is a public school, Kindergarten Fall"
label variable stype2 "School is a public school, Kindergarten Spring"
label variable stype4 "School is a public school, 1st grade Spring"
label variable stype6 "School is a public school, 2nd grade Spring"
label variable stype7 "School is a public school, 3rd grade"
label variable stype8 "School is a public school, 4th grade"
label variable stype9 "School is a public school, 5th grade"

/* Lowest grade at school */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace x`i'lowgrd = .i if x`i'lowgrd == -7 | x`i'lowgrd == -8 | x`i'lowgrd ==-9
	replace x`i'lowgrd = .p if x`i'lowgrd == .
	replace x`i'lowgrd = . if x`i'lowgrd == -1 | x`i'lowgrd == -4 | x`i'lowgrd == -5
	replace x`i'lowgrd = . if x`i'lowgrd == 15
	rename x`i'lowgrd slowgrd`i'
}
label variable slowgrd2 "School lowest grade level, Kindergarten Spring"
label variable slowgrd4 "School lowest grade level, 1st grade Spring"
label variable slowgrd6 "School lowest grade level, 2nd grade Spring"
label variable slowgrd7 "School lowest grade level, 3rd grade"
label variable slowgrd8 "School lowest grade level, 4th grade"
label variable slowgrd9 "School lowest grade level, 5th grade"

replace slowgrd4 = 0 if slowgrd4 == 1 
replace slowgrd4 = 1 if slowgrd4 == 2 | slowgrd4 == 3 | slowgrd4 == 4 | slowgrd4 == 6
label define slowgrd4 0 "Pre-Kindergarten" 1 "Kindergarten or higher" 
label values slowgrd4 slowgrd4

/* Highest grade at school */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace x`i'higgrd = .i if x`i'higgrd == -7 | x`i'higgrd == -8 | x`i'higgrd ==-9
	replace x`i'higgrd = .p if x`i'higgrd == .
	replace x`i'higgrd = . if x`i'higgrd == -1 | x`i'higgrd == -4 | x`i'higgrd == -5
	replace x`i'higgrd = . if x`i'higgrd == 15
	rename x`i'higgrd shighgrd`i'
}
label variable shighgrd2 "School highest grade level, Kindergarten Spring"
label variable shighgrd4 "School highest grade level, 1st grade Spring"
label variable shighgrd6 "School highest grade level, 2nd grade Spring"
label variable shighgrd7 "School highest grade level, 3rd grade"
label variable shighgrd8 "School highest grade level, 4th grade"
label variable shighgrd9 "School highest grade level, 5th grade"

replace shighgrd4 = 0 if shighgrd4 <8 
replace shighgrd4 = 1 if shighgrd4 > 7 & shighgrd4 < 16
label define shighgrd4 0 "5th grade or lower" 1 "6th grade or higher" 
label values shighgrd4 shighgrd4 

/************************************************
CLEAN SCHOOL-LEVEL ORGANIZATIN OF ROOMS VARIABLES  
*************************************************/
/* Cafeteria meets school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4cafeok = s2cafeok if s4cafeok == -5

local nums 2 4 6 
foreach i of local nums {
	replace s`i'cafeok = .i if s`i'cafeok == -7 | s`i'cafeok == -8 | s`i'cafeok ==-9
	replace s`i'cafeok = .p if s`i'cafeok == .
	replace s`i'cafeok = . if s`i'cafeok == -1 | s`i'cafeok == -4 | s`i'cafeok == -5
	rename s`i'cafeok scafeok`i'
}
label variable scafeok2 "School cafeteria meets needs, Kindergarten Spring"
label variable scafeok4 "School cafeteria meets needs, 1st grade Spring"
label variable scafeok6 "School cafeteria meets needs, 2nd grade Spring"

label define ok 0 "Not always adequate" 1 "Always adequate"
replace scafeok4 = 0 if scafeok4 == 1 | scafeok4 == 2 | scafeok4 == 3 | scafeok4 == 4
replace scafeok4 = 1 if scafeok4 == 5
label values scafeok4 ok
replace scafeok6 = 0 if scafeok6 == 1 | scafeok6 == 2 | scafeok6 == 3 | scafeok6 == 4
replace scafeok6 = 1 if scafeok6 == 5
label values scafeok6 ok

label define ok2 0 "Does not have" 1 "Not always adequate" 2 "Always adequate"
replace scafeok2 = 0 if scafeok2 == 1
replace scafeok2 = 1 if scafeok2 == 2 | scafeok2 == 3 | scafeok2 == 4
replace scafeok2 = 2 if scafeok2 == 5
label values scafeok2 ok2

/* Computer lab meets school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4compok = s2compok if s4compok == -5

local nums 2 4 6 7
foreach i of local nums {
	replace s`i'compok = .i if s`i'compok == -7 | s`i'compok == -8 | s`i'compok ==-9
	replace s`i'compok = .p if s`i'compok == .
	replace s`i'compok = . if s`i'compok == -1 | s`i'compok == -4 | s`i'compok == -5
	rename s`i'compok scompok`i'
}
label variable scompok2 "School computer lab meets needs, Kindergarten Spring"
label variable scompok4 "School computer lab meets needs, 1st grade Spring"
label variable scompok6 "School computer lab meets needs, 2nd grade Spring"

replace scompok4 = 0 if scompok4 == 1 | scompok4 == 2 | scompok4 == 3 | scompok4 == 4
replace scompok4 = 1 if scompok4 == 5
label values scompok4 ok
replace scompok6 = 0 if scompok6 == 1 | scompok6 == 2 | scompok6 == 3 | scompok6 == 4
replace scompok6 = 1 if scompok6 == 5
label values scompok6 ok
replace scompok7 = 0 if scompok7 == 1 | scompok7 == 2 | scompok7 == 3 | scompok7 == 4
replace scompok7 = 1 if scompok7 == 5
label values scompok7 ok

replace scompok2 = 0 if scompok2 == 1
replace scompok2 = 1 if scompok2 == 2 | scompok2 == 3 | scompok2 == 4
replace scompok2 = 2 if scompok2 == 5
label values scompok2 ok2

/* Library meets school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4lbryok = s2lbryok if s4lbryok == -5

local nums 2 4 6 7
foreach i of local nums {
	replace s`i'lbryok = .i if s`i'lbryok == -7 | s`i'lbryok == -8 | s`i'lbryok ==-9
	replace s`i'lbryok = .p if s`i'lbryok == .
	replace s`i'lbryok = . if s`i'lbryok == -1 | s`i'lbryok == -4 | s`i'lbryok == -5
	rename s`i'lbryok slibok`i'
}
label variable slibok2 "School library meets needs, Kindergarten Spring"
label variable slibok4 "School library meets needs, 1st grade Spring"
label variable slibok6 "School library meets needs, 2nd grade Spring"
label variable slibok7 "School library meets needs, 3rd grade"

replace slibok4 = 0 if slibok4 == 1 | slibok4 == 2 | slibok4 == 3 | slibok4 == 4
replace slibok4 = 1 if slibok4 == 5
label values slibok4 ok
replace slibok6 = 0 if slibok6 == 1 | slibok6 == 2 | slibok6 == 3 | slibok6 == 4
replace slibok6 = 1 if slibok6 == 5
label values slibok6 ok
replace slibok7 = 0 if slibok7 == 1 | slibok7 == 2 | slibok7 == 3 | slibok7 == 4
replace slibok7 = 1 if slibok7 == 5
label values slibok7 ok

replace slibok2 = 0 if slibok2 == 1
replace slibok2 = 1 if slibok2 == 2 | slibok2 == 3 | slibok2 == 4
replace slibok2 = 2 if slibok2 == 5
label values slibok2 ok2

/* Art room meets school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4artok = s2artok if s4artok == -5

local nums 2 4 6 
foreach i of local nums {
	replace s`i'artok = .i if s`i'artok == -7 | s`i'artok == -8 | s`i'artok ==-9
	replace s`i'artok = .p if s`i'artok == .
	replace s`i'artok = . if s`i'artok == -1 | s`i'artok == -4 | s`i'artok == -5
	rename s`i'artok sartok`i'
}
label variable sartok2 "School art room meets needs, Kindergarten Spring"
label variable sartok4 "School art room meets needs, 1st grade Spring"
label variable sartok6 "School art room meets needs, 2nd grade Spring"

replace sartok4 = 0 if sartok4 == 1 | sartok4 == 2 | sartok4 == 3 | sartok4 == 4
replace sartok4 = 1 if sartok4 == 5
label values sartok4 ok
replace sartok6 = 0 if sartok6 == 1 | sartok6 == 2 | sartok6 == 3 | sartok6 == 4
replace sartok6 = 1 if sartok6 == 5
label values sartok6 ok

replace sartok2 = 0 if sartok2 == 1
replace sartok2 = 1 if sartok2 == 2 | sartok2 == 3 | sartok2 == 4
replace sartok2 = 2 if sartok2 == 5
label values sartok2 ok2

/* Gymnasium meets school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4gymok = s2gymok if s4gymok == -5

local nums 2 4 6 7
foreach i of local nums {
	replace s`i'gymok = .i if s`i'gymok == -7 | s`i'gymok == -8 | s`i'gymok ==-9
	replace s`i'gymok = .p if s`i'gymok == .
	replace s`i'gymok = . if s`i'gymok == -1 | s`i'gymok == -4 | s`i'gymok == -5
	rename s`i'gymok sgymok`i'
}
label variable sgymok2 "School gymnasium meets needs, Kindergarten Spring"
label variable sgymok4 "School gymnasium meets needs, 1st grade Spring"
label variable sgymok6 "School gymnasium meets needs, 2nd grade Spring"
label variable sgymok7 "School gymnasium meets needs, 3rd grade"

replace sgymok4 = 0 if sgymok4 == 1 | sgymok4 == 2 | sgymok4 == 3 | sgymok4 == 4
replace sgymok4 = 1 if sgymok4 == 5
label values sgymok4 ok
replace sgymok6 = 0 if sgymok6 == 1 | sgymok6 == 2 | sgymok6 == 3 | sgymok6 == 4
replace sgymok6 = 1 if sgymok6 == 5
label values sgymok6 ok
replace sgymok7 = 0 if sgymok7 == 1 | sgymok7 == 2 | sgymok7 == 3 | sgymok7 == 4
replace sgymok7 = 1 if sgymok7 == 5
label values sgymok7 ok

replace sgymok2 = 0 if sgymok2 == 1
replace sgymok2 = 1 if sgymok2 == 2 | sgymok2 == 3 | sgymok2 == 4
replace sgymok2 = 2 if sgymok2 == 5
label values sgymok2 ok2

/* Music room meets school needs */
** Replace W4 with W2 data when W4 data == -5 
replace s4muscok = s2muscok if s4muscok == -5
 
local nums 2 4 6 
foreach i of local nums {
	replace s`i'muscok = .i if s`i'muscok == -7 | s`i'muscok == -8 | s`i'muscok ==-9
	replace s`i'muscok = .p if s`i'muscok == .
	replace s`i'muscok = . if s`i'muscok == -1 | s`i'muscok == -4 | s`i'muscok == -5
	rename s`i'muscok smusok`i'
}
label variable smusok2 "School music room meets needs, Kindergarten Spring"
label variable smusok4 "School music room meets needs, 1st grade Spring"
label variable smusok6 "School music room meets needs, 2nd grade Spring"

replace smusok4 = 0 if smusok4 == 1 | smusok4 == 2 | smusok4 == 3 | smusok4 == 4
replace smusok4 = 1 if smusok4 == 5
label values smusok4 ok
replace smusok6 = 0 if smusok6 == 1 | smusok6 == 2 | smusok6 == 3 | smusok6 == 4
replace smusok6 = 1 if smusok6 == 5
label values smusok6 ok

replace smusok2 = 0 if smusok2 == 1
replace smusok2 = 1 if smusok2 == 2 | smusok2 == 3 | smusok2 == 4
replace smusok2 = 2 if smusok2 == 5
label values smusok2 ok2

/* Playground meets school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4playok = s2playok if s4playok == -5

local nums 2 4 6 7
foreach i of local nums {
	replace s`i'playok = .i if s`i'playok == -7 | s`i'playok == -8 | s`i'playok ==-9
	replace s`i'playok = .p if s`i'playok == .
	replace s`i'playok = . if s`i'playok == -1 | s`i'playok == -4 | s`i'playok == -5
	rename s`i'playok splayok`i'
}
label variable splayok2 "School playground meets needs, Kindergarten Spring"
label variable splayok4 "School playground meets needs, 1st grade Spring"
label variable splayok6 "School playground meets needs, 2nd grade Spring"
label variable splayok7 "School playground meets needs, 3rd grade"

replace splayok4 = 0 if splayok4 == 1 | splayok4 == 2 | splayok4 == 3 | splayok4 == 4
replace splayok4 = 1 if splayok4 == 5
label values splayok4 ok
replace splayok6 = 0 if splayok6 == 1 | splayok6 == 2 | splayok6 == 3 | splayok6 == 4
replace splayok6 = 1 if splayok6 == 5
label values splayok6 ok
replace splayok7 = 0 if splayok7 == 1 | splayok7 == 2 | splayok7 == 3 | splayok7 == 4
replace splayok7 = 1 if splayok7 == 5
label values splayok7 ok

replace splayok2 = 0 if splayok2 == 1
replace splayok2 = 1 if splayok2 == 2 | splayok2 == 3 | splayok2 == 4
replace splayok2 = 2 if splayok2 == 5
label values splayok2 ok2

/* Classrooms meet school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4clssok = s2clssok if s4clssok == -5

local nums 2 4 6 7
foreach i of local nums {
	replace s`i'clssok = .i if s`i'clssok == -7 | s`i'clssok == -8 | s`i'clssok ==-9
	replace s`i'clssok = .p if s`i'clssok == .
	replace s`i'clssok = . if s`i'clssok == -1 | s`i'clssok == -4 | s`i'clssok == -5
	rename s`i'clssok sclssok`i'
}
label variable sclssok2 "School classrooms meet needs, Kindergarten Spring"
label variable sclssok4 "School classrooms meet needs, 1st grade Spring"
label variable sclssok6 "School classrooms meet needs, 2nd grade Spring"
label variable sclssok7 "School classrooms meet needs, 3rd grade"

replace sclssok4 = 0 if sclssok4 == 1 | sclssok4 == 2 | sclssok4 == 3 | sclssok4 == 4
replace sclssok4 = 1 if sclssok4 == 5
label values sclssok4 ok
replace sclssok6 = 0 if sclssok6 == 1 | sclssok6 == 2 | sclssok6 == 3 | sclssok6 == 4
replace sclssok6 = 1 if sclssok6 == 5
label values sclssok6 ok
replace sclssok7 = 0 if sclssok7 == 1 | sclssok7 == 2 | sclssok7 == 3 | sclssok7 == 4
replace sclssok7 = 1 if sclssok7 == 5
label values sclssok7 ok

replace sclssok2 = 0 if sclssok2 == 1
replace sclssok2 = 1 if sclssok2 == 2 | sclssok2 == 3 | sclssok2 == 4
replace sclssok2 = 2 if sclssok2 == 5
label values sclssok2 ok2

/* Auditorium meets school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4audtok = s2audtok if s4audtok == -5

local nums 2 4 6 
foreach i of local nums {
	replace s`i'audtok = .i if s`i'audtok == -7 | s`i'audtok == -8 | s`i'audtok ==-9
	replace s`i'audtok = .p if s`i'audtok == .
	replace s`i'audtok = . if s`i'audtok == -1 | s`i'audtok == -4 | s`i'audtok == -5
	rename s`i'audtok saudok`i'
}
label variable saudok2 "School auditorium meets needs, Kindergarten Spring"
label variable saudok4 "School auditorium meets needs, 1st grade Spring"
label variable saudok6 "School auditorium meets needs, 2nd grade Spring"

replace saudok4 = 0 if saudok4 == 1 | saudok4 == 2 | saudok4 == 3 | saudok4 == 4
replace saudok4 = 1 if saudok4 == 5
label values saudok4 ok
replace saudok6 = 0 if saudok6 == 1 | saudok6 == 2 | saudok6 == 3 | saudok6 == 4
replace saudok6 = 1 if saudok6 == 5
label values saudok6 ok

replace saudok2 = 0 if saudok2 == 1
replace saudok2 = 1 if saudok2 == 2 | saudok2 == 3 | saudok2 == 4
replace saudok2 = 2 if saudok2 == 5
label values saudok2 ok2

/* Multi-use room meets school needs */ 
** Replace W4 with W2 data when W4 data == -5 
replace s4multok = s2multok if s4multok == -5

local nums 2 4 6 
foreach i of local nums {
	replace s`i'multok = .i if s`i'multok == -7 | s`i'multok == -8 | s`i'multok ==-9
	replace s`i'multok = .p if s`i'multok == .
	replace s`i'multok = . if s`i'multok == -1 | s`i'multok == -4 | s`i'multok == -5
	rename s`i'multok smultok`i'
}
label variable smultok2 "School multi-use room meets needs, Kindergarten Spring"
label variable smultok4 "School multi-use room meets needs, 1st grade Spring"
label variable smultok6 "School multi-use room meets needs, 2nd grade Spring"

replace smultok4 = 0 if smultok4 == 1 | smultok4 == 2 | smultok4 == 3 | smultok4 == 4
replace smultok4 = 1 if smultok4 == 5
label values smultok4 ok
replace smultok6 = 0 if smultok6 == 1 | smultok6 == 2 | smultok6 == 3 | smultok6 == 4
replace smultok6 = 1 if smultok6 == 5
label values smultok6 ok

replace smultok2 = 0 if smultok2 == 1
replace smultok2 = 1 if smultok2 == 2 | smultok2 == 3 | smultok2 == 4
replace smultok2 = 2 if smultok2 == 5
label values smultok2 ok2

/****************************************
CLEAN SCHOOL STAFF ORGANIZATION VARIABLES  
*****************************************/
/* Number regular classroom teachers - full-time */ 
rename s2rtchfl s2rgtchf
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'rgtchf = .i if s`i'rgtchf == -7 | s`i'rgtchf == -8 | s`i'rgtchf ==-9
	replace s`i'rgtchf = .p if s`i'rgtchf == .
	replace s`i'rgtchf = . if s`i'rgtchf == -1 | s`i'rgtchf == -4 | s`i'rgtchf == -5
	rename s`i'rgtchf strgl`i'
}
label variable strgl2 "School # of regular classroom teachers, Kindergarten Spring"
label variable strgl4 "School # of regular classroom teachers, 1st grade Spring"
label variable strgl6 "School # of regular classroom teachers, 2nd grade Spring"
label variable strgl7 "School # of regular classroom teachers, 3rd grade"
label variable strgl8 "School # of regular classroom teachers, 4th grade"
label variable strgl9 "School # of regular classroom teachers, 5th grade"

/* # elective teachers - full-time */ 
rename s2msarfl selctv2
replace selctv2 = .i if selctv2 == -7 | selctv2 == -8 | selctv2 ==-9
replace selctv2 = .p if selctv2 == .
replace selctv2 = . if selctv2 == -1 | selctv2 == -4 | selctv2 == -5

/* # drama, music, art teachers - full-time */ 
local nums 4 6 7 8 9
foreach i of local nums {
	replace s`i'artstf = .i if s`i'artstf == -7 | s`i'artstf == -8 | s`i'artstf ==-9
	replace s`i'artstf = .p if s`i'artstf == .
	replace s`i'artstf = . if s`i'artstf == -1 | s`i'artstf == -4 | s`i'artstf == -5
	rename s`i'artstf sartstf`i'
}
label variable sartstf4 "School # of drama/music/art teachers, 1st grade Spring"
label variable sartstf6 "School # of drama/music/art teachers, 2nd grade Spring"
label variable sartstf7 "School # of drama/music/art teachers, 3rd grade"
label variable sartstf8 "School # of drama/music/art teachers, 4th grade"
label variable sartstf9 "School # of drama/music/art teachers, 5th grade"

/* # gym, health teachers - full-time */ 
local nums 4 6 7 8 9
foreach i of local nums {
	replace s`i'gymtf = .i if s`i'gymtf == -7 | s`i'gymtf == -8 | s`i'gymtf ==-9
	replace s`i'gymtf = .p if s`i'gymtf == .
	replace s`i'gymtf = . if s`i'gymtf == -1 | s`i'gymtf == -4 | s`i'gymtf == -5
	rename s`i'gymtf sgymstf`i'
}
label variable sgymstf4 "School # of gym/health teachers, 1st grade Spring"
label variable sgymstf6 "School # of gym/health teachers, 2nd grade Spring"
label variable sgymstf7 "School # of gym/health teachers, 3rd grade"
label variable sgymstf8 "School # of gym/health teachers, 4th grade"
label variable sgymstf9 "School # of gym/health teachers, 5th grade"

/* # special education teachers - full-time */ 
rename s2spedfl s2spedf
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'spedf = .i if s`i'spedf == -7 | s`i'spedf == -8 | s`i'spedf ==-9
	replace s`i'spedf = .p if s`i'spedf == .
	replace s`i'spedf = . if s`i'spedf == -1 | s`i'spedf == -4 | s`i'spedf == -5
	rename s`i'spedf spedstf`i'
}
label variable spedstf2 "School # of special education teachers, Kindergarten Spring"
label variable spedstf4 "School # of special education teachers, 1st grade Spring"
label variable spedstf6 "School # of special education teachers, 2nd grade Spring"
label variable spedstf7 "School # of special education teachers, 3rd grade"
label variable spedstf8 "School # of special education teachers, 4th grade"
label variable spedstf9 "School # of special education teachers, 5th grade"

/* # ESL/bilingual teachers - full-time */ 
rename s2eslfl s2eslf
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'eslf = .i if s`i'eslf == -7 | s`i'eslf == -8 | s`i'eslf ==-9
	replace s`i'eslf = .p if s`i'eslf == .
	replace s`i'eslf = . if s`i'eslf == -1 | s`i'eslf == -4 | s`i'eslf == -5
	rename s`i'eslf seslstf`i'
}
label variable seslstf2 "School # of ESL teachers, Kindergarten Spring"
label variable seslstf4 "School # of ESL teachers, 1st grade Spring"
label variable seslstf6 "School # of ESL teachers, 2nd grade Spring"
label variable seslstf7 "School # of ESL teachers, 3rd grade"
label variable seslstf8 "School # of ESL teachers, 4th grade"
label variable seslstf9 "School # of ESL teachers, 5th grade"

/* # Reading teachers/specialists - full-time */ 
rename s2readfl s2rdtcyn
local nums 2 7 8 9
foreach i of local nums {
	replace s`i'rdtcyn = .i if s`i'rdtcyn == -7 | s`i'rdtcyn == -8 | s`i'rdtcyn ==-9
	replace s`i'rdtcyn = .p if s`i'rdtcyn == .
	replace s`i'rdtcyn = . if s`i'rdtcyn == -1 | s`i'rdtcyn == -4 | s`i'rdtcyn == -5
	rename s`i'rdtcyn srdstf`i'
}
label variable srdstf2 "School # of reading teachers, Kindergarten Spring"

drop srdstf7 srdstf8 srdstf9 

/* # Gifted/talented teachers - full-time */ 
rename s2giftfl s2giftf
local nums 2 4 6 
foreach i of local nums {
	replace s`i'giftf = .i if s`i'giftf == -7 | s`i'giftf == -8 | s`i'giftf ==-9
	replace s`i'giftf = .p if s`i'giftf == .
	replace s`i'giftf = . if s`i'giftf == -1 | s`i'giftf == -4 | s`i'giftf == -5
	rename s`i'giftf sgftstf`i'
}
label variable sgftstf2 "School # of G/T teachers, Kindergarten Spring"
label variable sgftstf4 "School # of G/T teachers, 1st grade Spring"
label variable sgftstf6 "School # of G/T teachers, 2nd grade Spring"

/* # School nurses/health professionals - full-time */ 
rename s2nursfl s2nursf
local nums 2 4 6 
foreach i of local nums {
	replace s`i'nursf = .i if s`i'nursf == -7 | s`i'nursf == -8 | s`i'nursf ==-9
	replace s`i'nursf = .p if s`i'nursf == .
	replace s`i'nursf = . if s`i'nursf == -1 | s`i'nursf == -4 | s`i'nursf == -5
	rename s`i'nursf snrsstf`i'
}
label variable snrsstf2 "School # of nurses, Kindergarten Spring"
label variable snrsstf4 "School # of nurses, 1st grade Spring"
label variable snrsstf6 "School # of nurses, 2nd grade Spring"

/* # School psychologists/social workers - full-time */ 
rename s2psycfl s2psycf
local nums 2 4 6 
foreach i of local nums {
	replace s`i'psycf = .i if s`i'psycf == -7 | s`i'psycf == -8 | s`i'psycf ==-9
	replace s`i'psycf = .p if s`i'psycf == .
	replace s`i'psycf = . if s`i'psycf == -1 | s`i'psycf == -4 | s`i'psycf == -5
	rename s`i'psycf spsyfstf`i'
}
label variable spsyfstf2 "School # of full-time psychologists/social workers, Kindergarten Spring"
label variable spsyfstf4 "School # of full-time psychologists/social workers, 1st grade Spring"
label variable spsyfstf6 "School # of full-time psychologists/social workers, 2nd grade Spring"

/* # School psychologists/social workers - part-time */ 
rename s2psycpt s2psycp
local nums 2 4 6 
foreach i of local nums {
	replace s`i'psycp = .i if s`i'psycp == -7 | s`i'psycp == -8 | s`i'psycp ==-9
	replace s`i'psycp = .p if s`i'psycp == .
	replace s`i'psycp = . if s`i'psycp == -1 | s`i'psycp == -4 | s`i'psycp == -5
	rename s`i'psycp spsypstf`i'
}
label variable spsypstf2 "School # of part-time psychologists/social workers, Kindergarten Spring"
label variable spsypstf4 "School # of part-time psychologists/social workers, 1st grade Spring"
label variable spsypstf6 "School # of part-time psychologists/social workers, 2nd grade Spring"

/* # Para professionals - full-time */ 
rename s2parafl s2paraf
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'paraf = .i if s`i'paraf == -7 | s`i'paraf == -8 | s`i'paraf ==-9
	replace s`i'paraf = .p if s`i'paraf == .
	replace s`i'paraf = . if s`i'paraf == -1 | s`i'paraf == -4 | s`i'paraf == -5
	rename s`i'paraf sparastf`i'
}
label variable sparastf2 "School # of para professionals, Kindergarten Spring"
label variable sparastf4 "School # of para professionals, 1st grade Spring"
label variable sparastf6 "School # of para professionals, 2nd grade Spring"
label variable sparastf7 "School # of para professionals, 3rd grade"
label variable sparastf8 "School # of para professionals, 4th grade"
label variable sparastf9 "School # of para professionals, 5th grade"

/* # Librarians - full-time */ 
rename s2librfl s2librf
local nums 2 4 6 
foreach i of local nums {
	replace s`i'librf = .i if s`i'librf == -7 | s`i'librf == -8 | s`i'librf ==-9
	replace s`i'librf = .p if s`i'librf == .
	replace s`i'librf = . if s`i'librf == -1 | s`i'librf == -4 | s`i'librf == -5
	rename s`i'librf slibstf`i'
}
label variable slibstf2 "School # of full-time librarians, Kindergarten Spring"
label variable slibstf4 "School # of full-time librarians, 1st grade Spring"
label variable slibstf6 "School # of full-time librarians, 2nd grade Spring"

/* # Computer teachers - full-time */ 
local nums 4 6 
foreach i of local nums {
	replace s`i'ctechf = .i if s`i'ctechf == -7 | s`i'ctechf == -8 | s`i'ctechf ==-9
	replace s`i'ctechf = .p if s`i'ctechf == .
	replace s`i'ctechf = . if s`i'ctechf == -1 | s`i'ctechf == -4 | s`i'ctechf == -5
	rename s`i'ctechf scmpstf`i'
}
label variable scmpstf4 "School # of computer teachers, 1st grade Spring"
label variable scmpstf6 "School # of computer teachers, 2nd grade Spring"

/* # New teachers this year */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'tebegn = .i if s`i'tebegn == -7 | s`i'tebegn == -8 | s`i'tebegn ==-9
	replace s`i'tebegn = .p if s`i'tebegn == .
	replace s`i'tebegn = . if s`i'tebegn == -1 | s`i'tebegn == -4 | s`i'tebegn == -5
	rename s`i'tebegn snewt`i'
}
label variable snewt2 "School # of new teachers this year, Kindergarten Spring"
label variable snewt4 "School # of new teachers this year, 1st grade Spring"
label variable snewt6 "School # of new teachers this year, 2nd grade Spring"
label variable snewt7 "School # of new teachers this year, 3rd grade"
label variable snewt8 "School # of new teachers this year, 4th grade"
label variable snewt9 "School # of new teachers this year, 5th grade"

/* # Teachers left this year */ 
local nums 2 4 6 7 8 9
foreach i of local nums {
	replace s`i'teleft = .i if s`i'teleft == -7 | s`i'teleft == -8 | s`i'teleft ==-9
	replace s`i'teleft = .p if s`i'teleft == .
	replace s`i'teleft = . if s`i'teleft == -1 | s`i'teleft == -4 | s`i'teleft == -5
	rename s`i'teleft slftt`i'
}
label variable slftt2 "School # of teachers left this year, Kindergarten Spring"
label variable slftt4 "School # of teachers left this year, 1st grade Spring"
label variable slftt6 "School # of teachers left this year, 2nd grade Spring"
label variable slftt7 "School # of teachers left this year, 3rd grade"
label variable slftt8 "School # of teachers left this year, 4th grade"
label variable slftt9 "School # of teachers left this year, 5th grade"

/* Total number teachers */ 
local nums 2 4 6 9
foreach i of local nums {
	replace s`i'numtot = .i if s`i'numtot == -7 | s`i'numtot == -8 | s`i'numtot ==-9
	replace s`i'numtot = .p if s`i'numtot == .
	replace s`i'numtot = . if s`i'numtot == -1 | s`i'numtot == -4 | s`i'numtot == -5
	rename s`i'numtot stnum`i'
}
label variable stnum2 "School # of total teachers, Kindergarten Spring"
label variable stnum4 "School # of total teachers, 1st grade Spring"
label variable stnum6 "School # of total teachers, 2nd grade Spring"
label variable stnum9 "School # of total teachers, 5th grade"

/* School administrator sets priorities */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'setpri = .i if a`i'setpri == -7 | a`i'setpri == -8 | a`i'setpri ==-9
	replace a`i'setpri = .p if a`i'setpri == .
	replace a`i'setpri = . if a`i'setpri == -1 | a`i'setpri == -4 | a`i'setpri == -5
	rename a`i'setpri sapri`i'
}
label variable sapri2 "Teacher feels school admin. sets priorities, Kindergarten Spring"
label variable sapri4 "Teacher feels school admin. sets priorities, 1st grade Spring"
label variable sapri6 "Teacher feels school admin. sets priorities, 2nd grade Spring"
label variable sapri7 "Teacher feels school admin. sets priorities, 3rd grade"
label variable sapri8 "Teacher feels school admin. sets priorities, 4th grade"
label variable sapri9 "Teacher feels school admin. sets priorities, 5th grade"

/* School administrator encourages staff */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'encour = .i if a`i'encour == -7 | a`i'encour == -8 | a`i'encour ==-9
	replace a`i'encour = .p if a`i'encour == .
	replace a`i'encour = . if a`i'encour == -1 | a`i'encour == -4 | a`i'encour == -5
	rename a`i'encour saenc`i'
}
label variable saenc2 "Teacher feels school admin. encourages staff, Kindergarten Spring"
label variable saenc4 "Teacher feels school admin. encourages staff, 1st grade Spring"
label variable saenc6 "Teacher feels school admin. encourages staff, 2nd grade Spring"
label variable saenc7 "Teacher feels school admin. encourages staff, 3rd grade"
label variable saenc8 "Teacher feels school admin. encourages staff, 4th grade"
label variable saenc9 "Teacher feels school admin. encourages staff, 5th grade"

/* Consensus on expectations */ 
local nums 4 6 7 8 9 
foreach i of local nums {
	replace a`i'cnsnss = .i if a`i'cnsnss == -7 | a`i'cnsnss == -8 | a`i'cnsnss ==-9
	replace a`i'cnsnss = .p if a`i'cnsnss == .
	replace a`i'cnsnss = . if a`i'cnsnss == -1 | a`i'cnsnss == -4 | a`i'cnsnss == -5
	rename a`i'cnsnss sacns`i'
}
label variable sacns4 "Teacher feels school consensus expectations, 1st grade Spring"
label variable sacns6 "Teacher feels school consensus expectations, 2nd grade Spring"
label variable sacns7 "Teacher feels school consensus expectations, 3rd grade"
label variable sacns8 "Teacher feels school consensus expectations, 4th grade"
label variable sacns9 "Teacher feels school consensus expectations, 5th grade"

/* Hours per week administrator works with teachers */ 
local nums 2 4 6 
foreach i of local nums {
	replace s`i'instru = .i if s`i'instru == -7 | s`i'instru == -8 | s`i'instru ==-9
	replace s`i'instru = .p if s`i'instru == .
	replace s`i'instru = . if s`i'instru == -1 | s`i'instru == -4 | s`i'instru == -5
	rename s`i'instru sainst`i'
}
label variable sainst2 "Hours school admin. works with teachers, Kindergarten Spring"
label variable sainst4 "Hours school admin. works with teachers, 1st grade Spring"
label variable sainst6 "Hours school admin. works with teachers, 2nd grade Spring"

* Censor outliers at 99th percentile
sum sainst4, det
replace sainst4 = 40 if sainst4 > 40 & sainst4 < 100

/* Professional development available for teachers */ 
local nums 2 4 6 7  
foreach i of local nums {
	replace s`i't3prdv = .i if s`i't3prdv == -7 | s`i't3prdv == -8 | s`i't3prdv ==-9
	replace s`i't3prdv = .p if s`i't3prdv == .
	replace s`i't3prdv = . if s`i't3prdv == -1 | s`i't3prdv == -4 | s`i't3prdv == -5
	rename s`i't3prdv spd`i'
}
label variable spd2 "School offers professional development, Kindergarten Spring"
label variable spd4 "School offers professional development, 1st grade Spring"
label variable spd6 "School offers professional development, 2nd grade Spring"
label variable spd7 "School offers professional development, 3rd grade"

replace spd4 = 0 if spd4 == 2 
label values spd4 yes

/* Teacher enjoys job */ 
local nums 1 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'enjoy = .i if a`i'enjoy == -7 | a`i'enjoy == -8 | a`i'enjoy ==-9
	replace a`i'enjoy = .p if a`i'enjoy == .
	replace a`i'enjoy = . if a`i'enjoy == -1 | a`i'enjoy == -4 | a`i'enjoy == -5
	rename a`i'enjoy tenjy`i'
}
label variable tenjy1 "Teacher enjoys job, Kindergarten Fall"
label variable tenjy2 "Teacher enjoys job, Kindergarten Spring"
label variable tenjy4 "Teacher enjoys job, 1st grade Spring"
label variable tenjy6 "Teacher enjoys job, 2nd grade Spring"
label variable tenjy7 "Teacher enjoys job, 3rd grade"
label variable tenjy8 "Teacher enjoys job, 4th grade"
label variable tenjy9 "Teacher enjoys job, 5th grade"

/* Teacher feels they can make a difference */ 
local nums 1 2 4 6 
foreach i of local nums {
	replace a`i'mkdiff = .i if a`i'mkdiff == -7 | a`i'mkdiff == -8 | a`i'mkdiff ==-9
	replace a`i'mkdiff = .p if a`i'mkdiff == .
	replace a`i'mkdiff = . if a`i'mkdiff == -1 | a`i'mkdiff == -4 | a`i'mkdiff == -5
	rename a`i'mkdiff tmkdff`i'
}
label variable tmkdff1 "Teacher feels can make difference, Kindergarten Fall"
label variable tmkdff2 "Teacher feels can make difference, Kindergarten Spring"
label variable tmkdff4 "Teacher feels can make difference, 1st grade Spring"
label variable tmkdff6 "Teacher feels can make difference, 2nd grade Spring"

/* Teacher would choose teaching again */ 
local nums 1 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'teach = .i if a`i'teach == -7 | a`i'teach == -8 | a`i'teach ==-9
	replace a`i'teach = .p if a`i'teach == .
	replace a`i'teach = . if a`i'teach == -1 | a`i'teach == -4 | a`i'teach == -5
	rename a`i'teach tchstch`i'
}
label variable tchstch1 "Teacher would choose teaching again, Kindergarten Fall"
label variable tchstch2 "Teacher would choose teaching again, Kindergarten Spring"
label variable tchstch4 "Teacher would choose teaching again, 1st grade Spring"
label variable tchstch6 "Teacher would choose teaching again, 2nd grade Spring"
label variable tchstch7 "Teacher would choose teaching again, 3rd grade"
label variable tchstch8 "Teacher would choose teaching again, 4th grade"
label variable tchstch9 "Teacher would choose teaching again, 5th grade"

/* Teacher accepted at school */ 
local nums 2 4 6 
foreach i of local nums {
	replace a`i'accptd = .i if a`i'accptd == -7 | a`i'accptd == -8 | a`i'accptd ==-9
	replace a`i'accptd = .p if a`i'accptd == .
	replace a`i'accptd = . if a`i'accptd == -1 | a`i'accptd == -4 | a`i'accptd == -5
	rename a`i'accptd tacpt`i'
}
label variable tacpt2 "Teacher is accepted at school, Kindergarten Spring"
label variable tacpt4 "Teacher is accepted at school, 1st grade Spring"
label variable tacpt6 "Teacher is accepted at school, 2nd grade Spring"

/* Staff learn new ideas */ 
local nums 2 4 6 
foreach i of local nums {
	replace a`i'cntnlr = .i if a`i'cntnlr == -7 | a`i'cntnlr == -8 | a`i'cntnlr ==-9
	replace a`i'cntnlr = .p if a`i'cntnlr == .
	replace a`i'cntnlr = . if a`i'cntnlr == -1 | a`i'cntnlr == -4 | a`i'cntnlr == -5
	rename a`i'cntnlr tideas`i'
}
label variable tideas2 "Staff learn new ideas, Kindergarten Spring"
label variable tideas4 "Staff learn new ideas, 1st grade Spring"
label variable tideas6 "Staff learn new ideas, 2nd grade Spring"

/* Teachers feel paper work interferes with teaching */ 
local nums 2 4 6 
foreach i of local nums {
	replace a`i'paprwr = .i if a`i'paprwr == -7 | a`i'paprwr == -8 | a`i'paprwr ==-9
	replace a`i'paprwr = .p if a`i'paprwr == .
	replace a`i'paprwr = . if a`i'paprwr == -1 | a`i'paprwr == -4 | a`i'paprwr == -5
	rename a`i'paprwr tppwrk`i'
}
label variable tppwrk2 "Teacher paper work interferes with teaching, Kindergarten Spring"
label variable tppwrk4 "Teacher paper work interferes with teaching, 1st grade Spring"
label variable tppwrk6 "Teacher paper work interferes with teaching, 2nd grade Spring"

/* Teachers feel there is cooperation among staff */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'copstf = .i if a`i'copstf == -7 | a`i'copstf == -8 | a`i'copstf ==-9
	replace a`i'copstf = .p if a`i'copstf == .
	replace a`i'copstf = . if a`i'copstf == -1 | a`i'copstf == -4 | a`i'copstf == -5
	rename a`i'copstf tcoop`i'
}
label variable tcoop2 "Teacher feels cooperation among staff, Kindergarten Spring"
label variable tcoop4 "Teacher feels cooperation among staff, 1st grade Spring"
label variable tcoop6 "Teacher feels cooperation among staff, 2nd grade Spring"
label variable tcoop7 "Teacher feels cooperation among staff, 3rd grade"
label variable tcoop8 "Teacher feels cooperation among staff, 4th grade"
label variable tcoop9 "Teacher feels cooperation among staff, 5th grade"

/* Teachers feel that staff is recognized */ 
local nums 2 4 6 
foreach i of local nums {
	replace a`i'recjob = .i if a`i'recjob == -7 | a`i'recjob == -8 | a`i'recjob ==-9
	replace a`i'recjob = .p if a`i'recjob == .
	replace a`i'recjob = . if a`i'recjob == -1 | a`i'recjob == -4 | a`i'recjob == -5
	rename a`i'recjob tstfrec`i'
}
label variable tstfrec2 "Teacher feels staff recognized, Kindergarten Spring"
label variable tstfrec4 "Teacher feels staff recognized, 1st grade Spring"
label variable tstfrec6 "Teacher feels staff recognized, 2nd grade Spring"

/* Teachers feel that academic standards at school was low */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'stndlo = .i if a`i'stndlo == -7 | a`i'stndlo == -8 | a`i'stndlo ==-9
	replace a`i'stndlo = .p if a`i'stndlo == .
	replace a`i'stndlo = . if a`i'stndlo == -1 | a`i'stndlo == -4 | a`i'stndlo == -5
	rename a`i'stndlo tlstd`i'
}
label variable tlstd2 "Teacher thinks low academic standards, Kindergarten Spring"
label variable tlstd4 "Teacher thinks low academic standards, 1st grade Spring"
label variable tlstd6 "Teacher thinks low academic standards, 2nd grade Spring"
label variable tlstd7 "Teacher thinks low academic standards, 3rd grade"
label variable tlstd8 "Teacher thinks low academic standards, 4th grade"
label variable tlstd9 "Teacher thinks low academic standards, 5th grade"

/* Teachers feel that faculty agree with the mission */ 
local nums 2 4 6 
foreach i of local nums {
	replace a`i'missio = .i if a`i'missio == -7 | a`i'missio == -8 | a`i'missio ==-9
	replace a`i'missio = .p if a`i'missio == .
	replace a`i'missio = . if a`i'missio == -1 | a`i'missio == -4 | a`i'missio == -5
	rename a`i'missio tmssn`i'
}
label variable tmssn2 "Faculty agree with school mission, Kindergarten Spring"
label variable tmssn4 "Faculty agree with school mission, 1st grade Spring"
label variable tmssn6 "Faculty agree with school mission, 2nd grade Spring"

/* Teachers absenteeism is a problem */
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'absent = .i if s`i'absent == -7 | s`i'absent == -8 | s`i'absent ==-9
	replace s`i'absent = .p if s`i'absent == .
	replace s`i'absent = . if s`i'absent == -1 | s`i'absent == -4 | s`i'absent == -5
	rename s`i'absent tabsnt`i'
}
label variable tabsnt2 "Principal rates teacher absenteeism, Kindergarten Spring"
label variable tabsnt4 "Principal rates teacher absenteeism, 1st grade Spring"
label variable tabsnt6 "Principal rates teacher absenteeism, 2nd grade Spring"
label variable tabsnt7 "Principal rates teacher absenteeism, 3rd grade"
label variable tabsnt8 "Principal rates teacher absenteeism, 4th grade"
label variable tabsnt9 "Principal rates teacher absenteeism, 5th grade"

/******************************************
CLEAN SCHOOL-LEVEL SCHOOL CLIMATE VARIABLES  
*******************************************/
/* How often is theft a problem at school */ 
label define oft 0 "At least once a month" 1 "Happens on occasion" 2 "Never happens"
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'theft = .i if s`i'theft == -7 | s`i'theft == -8 | s`i'theft ==-9
	replace s`i'theft = .p if s`i'theft == .
	replace s`i'theft = . if s`i'theft == -1 | s`i'theft == -4 | s`i'theft == -5
	replace s`i'theft = 0 if s`i'theft == 2 | s`i'theft == 3
	replace s`i'theft = 1 if s`i'theft == 4
	replace s`i'theft = 2 if s`i'theft == 5
	label values s`i'theft oft
	rename s`i'theft sthft`i'
}
label variable sthft2 "How often theft problem at school, Kindergarten Spring"
label variable sthft4 "How often theft problem at school, 1st grade Spring"
label variable sthft6 "How often theft problem at school, 2nd grade Spring"
label variable sthft7 "How often theft problem at school, 3rd grade"
label variable sthft8 "How often theft problem at school, 4th grade"
label variable sthft9 "How often theft problem at school, 5th grade"

/* How often is physical conflict a problem at school */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'conflc = .i if s`i'conflc == -7 | s`i'conflc == -8 | s`i'conflc ==-9
	replace s`i'conflc = .p if s`i'conflc == .
	replace s`i'conflc = . if s`i'conflc == -1 | s`i'conflc == -4 | s`i'conflc == -5
	replace s`i'conflc = 0 if s`i'conflc == 2 | s`i'conflc == 3
	replace s`i'conflc = 1 if s`i'conflc == 4
	replace s`i'conflc = 2 if s`i'conflc == 5
	label values s`i'conflc oft
	rename s`i'conflc scnfl`i'
}
label variable scnfl2 "How often physical conflict problem at school, Kindergarten Spring"
label variable scnfl4 "How often physical conflict problem at school, 1st grade Spring"
label variable scnfl6 "How often physical conflict problem at school, 2nd grade Spring"
label variable scnfl7 "How often physical conflict problem at school, 3rd grade"
label variable scnfl8 "How often physical conflict problem at school, 4th grade"
label variable scnfl9 "How often physical conflict problem at school, 5th grade"

/* How often is alcohol use a problem at school */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'alcohl = .i if s`i'alcohl == -7 | s`i'alcohl == -8 | s`i'alcohl ==-9
	replace s`i'alcohl = .p if s`i'alcohl == .
	replace s`i'alcohl = . if s`i'alcohl == -1 | s`i'alcohl == -4 | s`i'alcohl == -5
	replace s`i'alcohl = 0 if s`i'alcohl == 2 | s`i'alcohl == 3
	replace s`i'alcohl = 1 if s`i'alcohl == 4
	replace s`i'alcohl = 2 if s`i'alcohl == 5
	label values s`i'alcohl oft
	rename s`i'alcohl salchl`i'
}
label variable salchl2 "How often alcohol use problem at school, Kindergarten Spring"
label variable salchl4 "How often alcohol use problem at school, 1st grade Spring"
label variable salchl6 "How often alcohol use problem at school, 2nd grade Spring"
label variable salchl7 "How often alcohol use problem at school, 3rd grade"
label variable salchl8 "How often alcohol use problem at school, 4th grade"
label variable salchl9 "How often alcohol use problem at school, 5th grade"

/* How often is illegal drug use a problem */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'drgfrq = .i if s`i'drgfrq == -7 | s`i'drgfrq == -8 | s`i'drgfrq ==-9
	replace s`i'drgfrq = .p if s`i'drgfrq == .
	replace s`i'drgfrq = . if s`i'drgfrq == -1 | s`i'drgfrq == -4 | s`i'drgfrq == -5
	replace s`i'drgfrq = 0 if s`i'drgfrq == 2 | s`i'drgfrq == 3
	replace s`i'drgfrq = 1 if s`i'drgfrq == 4
	replace s`i'drgfrq = 2 if s`i'drgfrq == 5
	label values s`i'drgfrq oft
	rename s`i'drgfrq sdrg`i'
}
label variable sdrg2 "How often drug use problem at school, Kindergarten Spring"
label variable sdrg4 "How often drug use problem at school, 1st grade Spring"
label variable sdrg6 "How often drug use problem at school, 2nd grade Spring"
label variable sdrg7 "How often drug use problem at school, 3rd grade"
label variable sdrg8 "How often drug use problem at school, 4th grade"
label variable sdrg9 "How often drug use problem at school, 5th grade"

/* How often is vandalism a problem */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'vandal = .i if s`i'vandal == -7 | s`i'vandal == -8 | s`i'vandal ==-9
	replace s`i'vandal = .p if s`i'vandal == .
	replace s`i'vandal = . if s`i'vandal == -1 | s`i'vandal == -4 | s`i'vandal == -5
	replace s`i'vandal = 0 if s`i'vandal == 2 | s`i'vandal == 3
	replace s`i'vandal = 1 if s`i'vandal == 4
	replace s`i'vandal = 2 if s`i'vandal == 5
	label values s`i'vandal oft
	rename s`i'vandal svndl`i'
}
label variable svndl2 "How often vandalism problem at school, Kindergarten Spring"
label variable svndl4 "How often vandalism problem at school, 1st grade Spring"
label variable svndl6 "How often vandalism problem at school, 2nd grade Spring"
label variable svndl7 "How often vandalism problem at school, 3rd grade"
label variable svndl8 "How often vandalism problem at school, 4th grade"
label variable svndl9 "How often vandalism problem at school, 5th grade"

/* How often is bullying a problem */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'bully = .i if s`i'bully == -7 | s`i'bully == -8 | s`i'bully ==-9
	replace s`i'bully = .p if s`i'bully == .
	replace s`i'bully = . if s`i'bully == -1 | s`i'bully == -4 | s`i'bully == -5
	replace s`i'bully = 0 if s`i'bully == 2 | s`i'bully == 3
	replace s`i'bully = 1 if s`i'bully == 4
	replace s`i'bully = 2 if s`i'bully == 5
	label values s`i'bully oft
	rename s`i'bully sblly`i'
}
label variable sblly2 "How often bullying problem at school, Kindergarten Spring"
label variable sblly4 "How often bullying problem at school, 1st grade Spring"
label variable sblly6 "How often bullying problem at school, 2nd grade Spring"
label variable sblly7 "How often bullying problem at school, 3rd grade"
label variable sblly8 "How often bullying problem at school, 4th grade"
label variable sblly9 "How often bullying problem at school, 5th grade"

/* How often is classroom disorder a problem */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'disord = .i if s`i'disord == -7 | s`i'disord == -8 | s`i'disord ==-9
	replace s`i'disord = .p if s`i'disord == .
	replace s`i'disord = . if s`i'disord == -1 | s`i'disord == -4 | s`i'disord == -5
	replace s`i'disord = 0 if s`i'disord == 2 | s`i'disord == 3
	replace s`i'disord = 1 if s`i'disord == 4
	replace s`i'disord = 2 if s`i'disord == 5
	label values s`i'disord oft
	rename s`i'disord sdsrd`i'
}
label variable sdsrd2 "How often classroom disorder problem at school, Kindergarten Spring"
label variable sdsrd4 "How often classroom disorder problem at school, 1st grade Spring"
label variable sdsrd6 "How often classroom disorder problem at school, 2nd grade Spring"
label variable sdsrd7 "How often classroom disorder problem at school, 3rd grade"
label variable sdsrd8 "How often classroom disorder problem at school, 4th grade"
label variable sdsrd9 "How often classroom disorder problem at school, 5th grade"

* Rating of classroom behavior */ 
rename a1dbehvr a1behvr
rename a2dbehvr a2behvr
rename g8behvr a8behvr
rename g9behvr a9behvr
label define beh 0 "Group misbehaves frequently" 1 "Group misbehaves occasionally" 2 "Group behaves well"
local nums 1 2 6 7 8 9
foreach i of local nums {
	replace a`i'behvr = .i if a`i'behvr == -7 | a`i'behvr == -8 | a`i'behvr ==-9
	replace a`i'behvr = .p if a`i'behvr == .
	replace a`i'behvr = . if a`i'behvr == -1 | a`i'behvr == -4 | a`i'behvr == -5
	replace a`i'behvr = 0 if a`i'behvr == 1 | a`i'behvr == 2
	replace a`i'behvr = 1 if a`i'behvr == 3
	replace a`i'behvr = 2 if a`i'behvr == 4 | a`i'behvr == 5
	label values a`i'behvr beh
	rename a`i'behvr tclssbhv`i'
}
label variable tclssbhv1 "Rating of classroom behavior, Kindergarten Fall"
label variable tclssbhv2 "Rating of classroom behavior, Kindergarten Spring"
label variable tclssbhv6 "Rating of classroom behavior, 2nd grade Spring"
label variable tclssbhv7 "Rating of classroom behavior, 3rd grade"
label variable tclssbhv8 "Rating of classroom behavior, 4th grade"
label variable tclssbhv9 "Rating of classroom behavior, 5th grade"

/*******************************************************
CLEAN SCHOOL-LEVEL SCHOOL-FAMILY COMMUNICATION VARIABLES  
********************************************************/
/* Parents support school staff */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'psupp = .i if a`i'psupp == -7 | a`i'psupp == -8 | a`i'psupp ==-9
	replace a`i'psupp = .p if a`i'psupp == .
	replace a`i'psupp = . if a`i'psupp == -1 | a`i'psupp == -4 | a`i'psupp == -5
	rename a`i'psupp spsupp`i'
}
label variable spsupp2 "Parents support school staff, Kindergarten Spring"
label variable spsupp4 "Parents support school staff, 1st grade Spring"
label variable spsupp6 "Parents support school staff, 2nd grade Spring"
label variable spsupp7 "Parents support school staff, 3rd grade"
label variable spsupp8 "Parents support school staff, 4th grade"
label variable spsupp9 "Parents support school staff, 5th grade"

/* Frequency of report cards */ 
rename s2rprtcd s2rptcrd
label define freq 0 "Less than 2 times per year" 1 "2-3 times per year" 2 "4-6 times per year" ///
3 "7 or more times per year"
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'rptcrd = .i if s`i'rptcrd == -7 | s`i'rptcrd == -8 | s`i'rptcrd ==-9
	replace s`i'rptcrd = .p if s`i'rptcrd == .
	replace s`i'rptcrd = . if s`i'rptcrd == -1 | s`i'rptcrd == -4 | s`i'rptcrd == -5
	replace s`i'rptcrd = 0 if s`i'rptcrd == 1 | s`i'rptcrd == 2
	replace s`i'rptcrd = 1 if s`i'rptcrd == 3 
	replace s`i'rptcrd = 2 if s`i'rptcrd == 4
	replace s`i'rptcrd = 3 if s`i'rptcrd == 5
	label values s`i'rptcrd freq
	rename s`i'rptcrd srptcrd`i'
}
label variable srptcrd2 "Frequency school sends report cards, Kindergarten Spring"
label variable srptcrd4 "Frequency school sends report cards, 1st grade Spring"
label variable srptcrd6 "Frequency school sends report cards, 2nd grade Spring"
label variable srptcrd7 "Frequency school sends report cards, 3rd grade"
label variable srptcrd8 "Frequency school sends report cards, 4th grade"
label variable srptcrd9 "Frequency school sends report cards, 5th grade"

/* Frequency of information on tests sent home */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'sttest = .i if s`i'sttest == -7 | s`i'sttest == -8 | s`i'sttest ==-9
	replace s`i'sttest = .p if s`i'sttest == .
	replace s`i'sttest = . if s`i'sttest == -1 | s`i'sttest == -4 | s`i'sttest == -5
	rename s`i'sttest ststinf`i'
}
label variable ststinf2 "Frequency school sends test info, Kindergarten Spring"
label variable ststinf4 "Frequency school sends test info, 1st grade Spring"
label variable ststinf6 "Frequency school sends test info, 2nd grade Spring"
label variable ststinf7 "Frequency school sends test info, 3rd grade"
label variable ststinf8 "Frequency school sends test info, 4th grade"
label variable ststinf9 "Frequency school sends test info, 5th grade"

/* Frequency of parent-teacher conferences */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'ptconf = .i if s`i'ptconf == -7 | s`i'ptconf == -8 | s`i'ptconf ==-9
	replace s`i'ptconf = .p if s`i'ptconf == .
	replace s`i'ptconf = . if s`i'ptconf == -1 | s`i'ptconf == -4 | s`i'ptconf == -5
	replace s`i'ptconf = 0 if s`i'ptconf == 1 | s`i'ptconf == 2
	replace s`i'ptconf = 1 if s`i'ptconf == 3 
	replace s`i'ptconf = 2 if s`i'ptconf == 4
	replace s`i'ptconf = 3 if s`i'ptconf == 5
	label values s`i'ptconf freq
	rename s`i'ptconf sptcnf`i'
}
label variable sptcnf2 "Frequency parent-teacher conferences, Kindergarten Spring"
label variable sptcnf4 "Frequency parent-teacher conferences, 1st grade Spring"
label variable sptcnf6 "Frequency parent-teacher conferences, 2nd grade Spring"
label variable sptcnf7 "Frequency parent-teacher conferences, 3rd grade"
label variable sptcnf8 "Frequency parent-teacher conferences, 4th grade"
label variable sptcnf9 "Frequency parent-teacher conferences, 5th grade"

/* Translators for LM/LEP parents */ 
replace s4transl = s2transl if s4transl == -5

local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace s`i'transl = .i if s`i'transl == -7 | s`i'transl == -8 | s`i'transl ==-9
	replace s`i'transl = .p if s`i'transl == .
	replace s`i'transl = . if s`i'transl == -1 | s`i'transl == -4 | s`i'transl == -5
	replace s`i'transl = 0 if s`i'transl == 2
	label values s`i'transl yes
	rename s`i'transl strnsl`i'
}
label variable strnsl2 "School has translators, Kindergarten Spring"
label variable strnsl4 "School has translators, 1st grade Spring"
label variable strnsl6 "School has translators, 2nd grade Spring"
label variable strnsl7 "School has translators, 3rd grade"
label variable strnsl8 "School has translators, 4th grade"
label variable strnsl9 "School has translators, 5th grade"

/* Hours per week principal meets with parents */ 
local nums 2 4 6 
foreach i of local nums {
	replace s`i'talkpt = .i if s`i'talkpt == -7 | s`i'talkpt == -8 | s`i'talkpt ==-9
	replace s`i'talkpt = .p if s`i'talkpt == .
	replace s`i'talkpt = . if s`i'talkpt == -1 | s`i'talkpt == -4 | s`i'talkpt == -5
	rename s`i'talkpt sprnpar`i'
}
label variable sprnpar2 "Hours per week principal meets parents, Kindergarten Spring"
label variable sprnpar4 "Hours per week principal meets parents, 1st grade Spring"
label variable sprnpar6 "Hours per week principal meets parents, 2nd grade Spring"

* Censor at 99th percentile 
replace sprnpar4 = 25 if sprnpar4 > 25 & sprnpar4 < 100

/* School has community support */ 
local nums 2 4 6 7
foreach i of local nums {
	replace s`i'spprt = .i if s`i'spprt == -7 | s`i'spprt == -8 | s`i'spprt ==-9
	replace s`i'spprt = .p if s`i'spprt == .
	replace s`i'spprt = . if s`i'spprt == -1 | s`i'spprt == -4 | s`i'spprt == -5
	rename s`i'spprt sspprt`i'
}
label variable sspprt2 "School has community support, Kindergarten Spring"
label variable sspprt4 "School has community support, 1st grade Spring"
label variable sspprt6 "School has community support, 2nd grade Spring"
label variable sspprt7 "School has community support, 3rd grade"

/****************************************************
CLEAN SCHOOL-LEVEL CURRICULUM & INSTRUCTION VARIABLES  
*****************************************************/
/* How often focus on reading & language arts */ 
label define oft2 0 "Less than 3 days a week" 1 "3-4 days a week" 2 "5 days a week"
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'oftrdl = .i if a`i'oftrdl == -7 | a`i'oftrdl == -8 | a`i'oftrdl ==-9
	replace a`i'oftrdl = .p if a`i'oftrdl == .
	replace a`i'oftrdl = . if a`i'oftrdl == -1 | a`i'oftrdl == -4 | a`i'oftrdl == -5
	replace a`i'oftrdl = 0 if a`i'oftrdl == 1 | a`i'oftrdl == 2 | a`i'oftrdl == 3 | a`i'oftrdl == 4
	replace a`i'oftrdl = 1 if a`i'oftrdl == 5 | a`i'oftrdl == 6
	replace a`i'oftrdl = 2 if a`i'oftrdl == 7
	label values a`i'oftrdl oft2
	rename a`i'oftrdl tord`i'
}
label variable tord2 "How often teacher focuses reading, Kindergarten Spring"
label variable tord4 "How often teacher focuses reading, 1st grade Spring"
label variable tord6 "How often teacher focuses reading, 2nd grade Spring"
label variable tord7 "How often teacher focuses reading, 3rd grade"
label variable tord8 "How often teacher focuses reading, 4th grade"
label variable tord9 "How often teacher focuses reading, 5th grade"

/* How often focus on math */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'oftmth = .i if a`i'oftmth == -7 | a`i'oftmth == -8 | a`i'oftmth ==-9
	replace a`i'oftmth = .p if a`i'oftmth == .
	replace a`i'oftmth = . if a`i'oftmth == -1 | a`i'oftmth == -4 | a`i'oftmth == -5
	replace a`i'oftmth = 0 if a`i'oftmth == 1 | a`i'oftmth == 2 | a`i'oftmth == 3 | a`i'oftmth == 4
	replace a`i'oftmth = 1 if a`i'oftmth == 5 | a`i'oftmth == 6
	replace a`i'oftmth = 2 if a`i'oftmth == 7
	label values a`i'oftmth oft2
	rename a`i'oftmth tomth`i'
}
label variable tomth2 "How often teacher focuses math, Kindergarten Spring"
label variable tomth4 "How often teacher focuses math, 1st grade Spring"
label variable tomth6 "How often teacher focuses math, 2nd grade Spring"
label variable tomth7 "How often teacher focuses math, 3rd grade"
label variable tomth8 "How often teacher focuses math, 4th grade"
label variable tomth9 "How often teacher focuses math, 5th grade"

/* How often focus on social studies */ 
replace a4oftsoc = .i if a4oftsoc == -7 | a4oftsoc == -8 | a4oftsoc == -9
replace a4oftsoc = .p if a4oftsoc == .
replace a4oftsoc = . if a4oftsoc == -1 | a4oftsoc == -4 | a4oftsoc == -5
replace a4oftsoc = 0 if a4oftsoc == 1 | a4oftsoc == 2 | a4oftsoc == 3 | a4oftsoc == 4
replace a4oftsoc = 1 if a4oftsoc == 5 | a4oftsoc == 6
replace a4oftsoc = 2 if a4oftsoc == 7
label values a4oftsoc oft2
rename a4oftsoc tosoc4
label variable tosoc4 "How often teacher focuses on social studies, 1st grade Spring"

/* How often focus on science */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'oftsci = .i if a`i'oftsci == -7 | a`i'oftsci == -8 | a`i'oftsci ==-9
	replace a`i'oftsci = .p if a`i'oftsci == .
	replace a`i'oftsci = . if a`i'oftsci == -1 | a`i'oftsci == -4 | a`i'oftsci == -5
	replace a`i'oftsci = 0 if a`i'oftsci == 1 | a`i'oftsci == 2 | a`i'oftsci == 3 | a`i'oftsci == 4
	replace a`i'oftsci = 1 if a`i'oftsci == 5 | a`i'oftsci == 6
	replace a`i'oftsci = 2 if a`i'oftsci == 7
	label values a`i'oftsci oft2
	rename a`i'oftsci tosci`i'
}
label variable tosci2 "How often teacher focuses science, Kindergarten Spring"
label variable tosci4 "How often teacher focuses science, 1st grade Spring"
label variable tosci6 "How often teacher focuses science, 2nd grade Spring"
label variable tosci7 "How often teacher focuses science, 3rd grade"
label variable tosci8 "How often teacher focuses science, 4th grade"
label variable tosci9 "How often teacher focuses science, 5th grade"

/* How often focus on music */ 
label define oft3 0 "Less than 2 days a week" 1 "2 days a week" 2 "3 or more days a week"
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'oftmus = .i if a`i'oftmus == -7 | a`i'oftmus == -8 | a`i'oftmus ==-9
	replace a`i'oftmus = .p if a`i'oftmus == .
	replace a`i'oftmus = . if a`i'oftmus == -1 | a`i'oftmus == -4 | a`i'oftmus == -5
	replace a`i'oftmus = 0 if a`i'oftmus == 1 | a`i'oftmus == 2 | a`i'oftmus == 3 
	replace a`i'oftmus = 1 if a`i'oftmus == 4
	replace a`i'oftmus = 2 if a`i'oftmus == 5 | a`i'oftmus == 6 | a`i'oftmus == 7
	label values a`i'oftmus oft3
	rename a`i'oftmus tomus`i'
}
label variable tomus2 "How often teacher focuses music, Kindergarten Spring"
label variable tomus4 "How often teacher focuses music, 1st grade Spring"
label variable tomus6 "How often teacher focuses music, 2nd grade Spring"
label variable tomus7 "How often teacher focuses music, 3rd grade"
label variable tomus8 "How often teacher focuses music, 4th grade"
label variable tomus9 "How often teacher focuses music, 5th grade"

/* How often focus on art */
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'oftart = .i if a`i'oftart == -7 | a`i'oftart == -8 | a`i'oftart ==-9
	replace a`i'oftart = .p if a`i'oftart == .
	replace a`i'oftart = . if a`i'oftart == -1 | a`i'oftart == -4 | a`i'oftart == -5
	replace a`i'oftart = 0 if a`i'oftart == 1 | a`i'oftart == 2 | a`i'oftart == 3 
	replace a`i'oftart = 1 if a`i'oftart == 4
	replace a`i'oftart = 2 if a`i'oftart == 5 | a`i'oftart == 6 | a`i'oftart == 7
	label values a`i'oftart oft3
	rename a`i'oftart toart`i'
}
label variable toart2 "How often teacher focuses art, Kindergarten Spring"
label variable toart4 "How often teacher focuses art, 1st grade Spring"
label variable toart6 "How often teacher focuses art, 2nd grade Spring"
label variable toart7 "How often teacher focuses art, 3rd grade"
label variable toart8 "How often teacher focuses art, 4th grade"
label variable toart9 "How often teacher focuses art, 5th grade"

/* How often focus on physical education */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'oftpe = .i if a`i'oftpe == -7 | a`i'oftpe == -8 | a`i'oftpe ==-9
	replace a`i'oftpe = .p if a`i'oftpe == .
	replace a`i'oftpe = . if a`i'oftpe == -1 | a`i'oftpe == -4 | a`i'oftpe == -5
	replace a`i'oftpe = 0 if a`i'oftpe == 1 | a`i'oftpe == 2 | a`i'oftpe == 3 
	replace a`i'oftpe = 1 if a`i'oftpe == 4
	replace a`i'oftpe = 2 if a`i'oftpe == 5 | a`i'oftpe == 6 | a`i'oftpe == 7
	label values a`i'oftpe oft3
	rename a`i'oftpe togym`i'
}
label variable togym2 "How often teacher focuses gym, Kindergarten Spring"
label variable togym4 "How often teacher focuses gym, 1st grade Spring"
label variable togym6 "How often teacher focuses gym, 2nd grade Spring"
label variable togym7 "How often teacher focuses gym, 3rd grade"
label variable togym8 "How often teacher focuses gym, 4th grade"
label variable togym9 "How often teacher focuses gym, 5th grade"

/* How often focus on dance */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'oftdan = .i if a`i'oftdan == -7 | a`i'oftdan == -8 | a`i'oftdan ==-9
	replace a`i'oftdan = .p if a`i'oftdan == .
	replace a`i'oftdan = . if a`i'oftdan == -1 | a`i'oftdan == -4 | a`i'oftdan == -5
	replace a`i'oftdan = 0 if a`i'oftdan == 1 | a`i'oftdan == 2 | a`i'oftdan == 3 
	replace a`i'oftdan = 1 if a`i'oftdan == 4
	replace a`i'oftdan = 2 if a`i'oftdan == 5 | a`i'oftdan == 6 | a`i'oftdan == 7
	label values a`i'oftdan oft3
	rename a`i'oftdan todan`i'
}
label variable todan2 "How often teacher focuses dance, Kindergarten Spring"
label variable todan4 "How often teacher focuses dance, 1st grade Spring"
label variable todan6 "How often teacher focuses dance, 2nd grade Spring"
label variable todan7 "How often teacher focuses dance, 3rd grade"
label variable todan8 "How often teacher focuses dance, 4th grade"
label variable todan9 "How often teacher focuses dance, 5th grade"

/* How often focus on theater */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'ofthtr = .i if a`i'ofthtr == -7 | a`i'ofthtr == -8 | a`i'ofthtr ==-9
	replace a`i'ofthtr = .p if a`i'ofthtr == .
	replace a`i'ofthtr = . if a`i'ofthtr == -1 | a`i'ofthtr == -4 | a`i'ofthtr == -5
	replace a`i'ofthtr = 0 if a`i'ofthtr == 1 | a`i'ofthtr == 2 | a`i'ofthtr == 3 
	replace a`i'ofthtr = 1 if a`i'ofthtr == 4
	replace a`i'ofthtr = 2 if a`i'ofthtr == 5 | a`i'ofthtr == 6 | a`i'ofthtr == 7
	label values a`i'ofthtr oft3
	rename a`i'ofthtr tothtr`i'
}
label variable tothtr2 "How often teacher focuses theater, Kindergarten Spring"
label variable tothtr4 "How often teacher focuses theater, 1st grade Spring"
label variable tothtr6 "How often teacher focuses theater, 2nd grade Spring"
label variable tothtr7 "How often teacher focuses theater, 3rd grade"
label variable tothtr8 "How often teacher focuses theater, 4th grade"
label variable tothtr9 "How often teacher focuses theater, 5th grade"

/* How often focus on foreign language */ 
local nums 4 6 7 8 9 
foreach i of local nums {
	replace a`i'oftfln = .i if a`i'oftfln == -7 | a`i'oftfln == -8 | a`i'oftfln ==-9
	replace a`i'oftfln = .p if a`i'oftfln == .
	replace a`i'oftfln = . if a`i'oftfln == -1 | a`i'oftfln == -4 | a`i'oftfln == -5
	replace a`i'oftfln = 0 if a`i'oftfln == 1 | a`i'oftfln == 2 | a`i'oftfln == 3 
	replace a`i'oftfln = 1 if a`i'oftfln == 4
	replace a`i'oftfln = 2 if a`i'oftfln == 5 | a`i'oftfln == 6 | a`i'oftfln == 7
	label values a`i'oftfln oft3
	rename a`i'oftfln tofln`i'
}
label variable tofln4 "How often teacher focuses foreign language, 1st grade Spring"
label variable tofln6 "How often teacher focuses foreign language, 2nd grade Spring"
label variable tofln7 "How often teacher focuses foreign language, 3rd grade"
label variable tofln8 "How often teacher focuses foreign language, 4th grade"
label variable tofln9 "How often teacher focuses foreign language, 5th grade"

/* Time spent on reading & language arts */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txrdla = .i if a`i'txrdla == -7 | a`i'txrdla == -8 | a`i'txrdla ==-9
	replace a`i'txrdla = .p if a`i'txrdla == .
	replace a`i'txrdla = . if a`i'txrdla == -1 | a`i'txrdla == -4 | a`i'txrdla == -5
	rename a`i'txrdla ttrd`i'
}
label variable ttrd2 "Teacher time spent on reading, Kindergarten Spring"
label variable ttrd4 "Teacher time spent on reading, 1st grade Spring"
label variable ttrd6 "Teacher time spent on reading, 2nd grade Spring"
label variable ttrd7 "Teacher time spent on reading, 3rd grade"
label variable ttrd8 "Teacher time spent on reading, 4th grade"
label variable ttrd9 "Teacher time spent on reading, 5th grade"

/* Time spent on math */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txmth = .i if a`i'txmth == -7 | a`i'txmth == -8 | a`i'txmth ==-9
	replace a`i'txmth = .p if a`i'txmth == .
	replace a`i'txmth = . if a`i'txmth == -1 | a`i'txmth == -4 | a`i'txmth == -5
	rename a`i'txmth ttmth`i'
}
label variable ttmth2 "Teacher time spent on math, Kindergarten Spring"
label variable ttmth4 "Teacher time spent on math, 1st grade Spring"
label variable ttmth6 "Teacher time spent on math, 2nd grade Spring"
label variable ttmth7 "Teacher time spent on math, 3rd grade"
label variable ttmth8 "Teacher time spent on math, 4th grade"
label variable ttmth9 "Teacher time spent on math, 5th grade"

/* Time spent on social studies */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txsoc = .i if a`i'txsoc == -7 | a`i'txsoc == -8 | a`i'txsoc ==-9
	replace a`i'txsoc = .p if a`i'txsoc == .
	replace a`i'txsoc = . if a`i'txsoc == -1 | a`i'txsoc == -4 | a`i'txsoc == -5
	rename a`i'txsoc ttsoc`i'
}
label variable ttsoc2 "Teacher time spent on social studies, Kindergarten Spring"
label variable ttsoc4 "Teacher time spent on social studies, 1st grade Spring"
label variable ttsoc6 "Teacher time spent on social studies, 2nd grade Spring"
label variable ttsoc7 "Teacher time spent on social studies, 3rd grade"
label variable ttsoc8 "Teacher time spent on social studies, 4th grade"
label variable ttsoc9 "Teacher time spent on social studies, 5th grade"

/* Time spent on science */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txsci = .i if a`i'txsci == -7 | a`i'txsci == -8 | a`i'txsci ==-9
	replace a`i'txsci = .p if a`i'txsci == .
	replace a`i'txsci = . if a`i'txsci == -1 | a`i'txsci == -4 | a`i'txsci == -5
	rename a`i'txsci ttsci`i'
}
label variable ttsci2 "Teacher time spent on science, Kindergarten Spring"
label variable ttsci4 "Teacher time spent on science, 1st grade Spring"
label variable ttsci6 "Teacher time spent on science, 2nd grade Spring"
label variable ttsci7 "Teacher time spent on science, 3rd grade"
label variable ttsci8 "Teacher time spent on science, 4th grade"
label variable ttsci9 "Teacher time spent on science, 5th grade"

/* Time spent on music */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txmus = .i if a`i'txmus == -7 | a`i'txmus == -8 | a`i'txmus ==-9
	replace a`i'txmus = .p if a`i'txmus == .
	replace a`i'txmus = . if a`i'txmus == -1 | a`i'txmus == -4 | a`i'txmus == -5
	rename a`i'txmus ttmus`i'
}
label variable ttmus2 "Teacher time spent on music, Kindergarten Spring"
label variable ttmus4 "Teacher time spent on music, 1st grade Spring"
label variable ttmus6 "Teacher time spent on music, 2nd grade Spring"
label variable ttmus7 "Teacher time spent on music, 3rd grade"
label variable ttmus8 "Teacher time spent on music, 4th grade"
label variable ttmus9 "Teacher time spent on music, 5th grade"

/* Time spent on art */
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txart = .i if a`i'txart == -7 | a`i'txart == -8 | a`i'txart ==-9
	replace a`i'txart = .p if a`i'txart == .
	replace a`i'txart = . if a`i'txart == -1 | a`i'txart == -4 | a`i'txart == -5
	rename a`i'txart ttart`i'
}
label variable ttart2 "Teacher time spent on art, Kindergarten Spring"
label variable ttart4 "Teacher time spent on art, 1st grade Spring"
label variable ttart6 "Teacher time spent on art, 2nd grade Spring"
label variable ttart7 "Teacher time spent on art, 3rd grade"
label variable ttart8 "Teacher time spent on art, 4th grade"
label variable ttart9 "Teacher time spent on art, 5th grade"

/* Time spent on physical education */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txpe = .i if a`i'txpe == -7 | a`i'txpe == -8 | a`i'txpe ==-9
	replace a`i'txpe = .p if a`i'txpe == .
	replace a`i'txpe = . if a`i'txpe == -1 | a`i'txpe == -4 | a`i'txpe == -5
	rename a`i'txpe ttgym`i'
}
label variable ttgym2 "Teacher time spent on gym, Kindergarten Spring"
label variable ttgym4 "Teacher time spent on gym, 1st grade Spring"
label variable ttgym6 "Teacher time spent on gym, 2nd grade Spring"
label variable ttgym7 "Teacher time spent on gym, 3rd grade"
label variable ttgym8 "Teacher time spent on gym, 4th grade"
label variable ttgym9 "Teacher time spent on gym, 5th grade"

/* Time spent on dance */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txdan = .i if a`i'txdan == -7 | a`i'txdan == -8 | a`i'txdan ==-9
	replace a`i'txdan = .p if a`i'txdan == .
	replace a`i'txdan = . if a`i'txdan == -1 | a`i'txdan == -4 | a`i'txdan == -5
	rename a`i'txdan ttdan`i'
}
label variable ttdan2 "Teacher time spent on dance, Kindergarten Spring"
label variable ttdan4 "Teacher time spent on dance, 1st grade Spring"
label variable ttdan6 "Teacher time spent on dance, 2nd grade Spring"
label variable ttdan7 "Teacher time spent on dance, 3rd grade"
label variable ttdan8 "Teacher time spent on dance, 4th grade"
label variable ttdan9 "Teacher time spent on dance, 5th grade"

/* Time spent on theater */ 
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txthtr = .i if a`i'txthtr == -7 | a`i'txthtr == -8 | a`i'txthtr ==-9
	replace a`i'txthtr = .p if a`i'txthtr == .
	replace a`i'txthtr = . if a`i'txthtr == -1 | a`i'txthtr == -4 | a`i'txthtr == -5
	rename a`i'txthtr ttthtr`i'
}
label variable ttthtr2 "Teacher time spent on theater, Kindergarten Spring"
label variable ttthtr4 "Teacher time spent on theater, 1st grade Spring"
label variable ttthtr6 "Teacher time spent on theater, 2nd grade Spring"
label variable ttthtr7 "Teacher time spent on theater, 3rd grade"
label variable ttthtr8 "Teacher time spent on theater, 4th grade"
label variable ttthtr9 "Teacher time spent on theater, 5th grade"

/* Time spent on foreign language */ 
rename a2txfor a2txfln
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'txfln = .i if a`i'txfln == -7 | a`i'txfln == -8 | a`i'txfln ==-9
	replace a`i'txfln = .p if a`i'txfln == .
	replace a`i'txfln = . if a`i'txfln == -1 | a`i'txfln == -4 | a`i'txfln == -5
	rename a`i'txfln ttfln`i'
}
label variable ttfln2 "Teacher time spent on foreign language, Kindergarten Spring"
label variable ttfln4 "Teacher time spent on foreign language, 1st grade Spring"
label variable ttfln6 "Teacher time spent on foreign language, 2nd grade Spring"
label variable ttfln7 "Teacher time spent on foreign language, 3rd grade"
label variable ttfln8 "Teacher time spent on foreign language, 4th grade"
label variable ttfln9 "Teacher time spent on foreign language, 5th grade"

/* Time spent on small group activities */ 
rename a2smlgrp a2wksgrp
rename g8wksgrp a8wksgrp
rename g9wksgrp a9wksgrp
local nums 2 4 6 8 9 
foreach i of local nums {
	replace a`i'wksgrp = .i if a`i'wksgrp == -7 | a`i'wksgrp == -8 | a`i'wksgrp ==-9
	replace a`i'wksgrp = .p if a`i'wksgrp == .
	replace a`i'wksgrp = . if a`i'wksgrp == -1 | a`i'wksgrp == -4 | a`i'wksgrp == -5
	rename a`i'wksgrp ttsgrp`i'
}
label variable ttsgrp2 "Teacher time spent on small groups, Kindergarten Spring"
label variable ttsgrp4 "Teacher time spent on small groups, 1st grade Spring"
label variable ttsgrp6 "Teacher time spent on small groups, 2nd grade Spring"
label variable ttsgrp8 "Teacher time spent on small groups, 4th grade"
label variable ttsgrp9 "Teacher time spent on small groups, 5th grade"

/* Time spent on large group activities */ 
rename g8wklgrp a8wklgrp
rename g9wklgrp a9wklgrp
local nums 4 6 8 9 
foreach i of local nums {
	replace a`i'wklgrp = .i if a`i'wklgrp == -7 | a`i'wklgrp == -8 | a`i'wklgrp ==-9
	replace a`i'wklgrp = .p if a`i'wklgrp == .
	replace a`i'wklgrp = . if a`i'wklgrp == -1 | a`i'wklgrp == -4 | a`i'wklgrp == -5
	rename a`i'wklgrp ttlgrp`i'
}
label variable ttlgrp4 "Teacher time spent on large groups, 1st grade Spring"
label variable ttlgrp6 "Teacher time spent on large groups, 2nd grade Spring"
label variable ttlgrp8 "Teacher time spent on large groups, 4th grade"
label variable ttlgrp9 "Teacher time spent on large groups, 5th grade"

/* Time spent on individual activities */ 
rename a2indvdl a2wkindv
rename g8wkindv a8wkindv
rename g9wkindv a9wkindv
local nums 2 4 6 8 9 
foreach i of local nums {
	replace a`i'wkindv = .i if a`i'wkindv == -7 | a`i'wkindv == -8 | a`i'wkindv ==-9
	replace a`i'wkindv = .p if a`i'wkindv == .
	replace a`i'wkindv = . if a`i'wkindv == -1 | a`i'wkindv == -4 | a`i'wkindv == -5
	rename a`i'wkindv ttindv`i'
}
label variable ttindv2 "Teacher time spent on individual activities, Kindergarten Spring"
label variable ttindv4 "Teacher time spent on individual activities, 1st grade Spring"
label variable ttindv6 "Teacher time spent on individual activities, 2nd grade Spring"
label variable ttindv8 "Teacher time spent on individual activities, 4th grade"
label variable ttindv9 "Teacher time spent on individual activities, 5th grade"

/* Time spent working independently */
rename g8wkindp a8wkindp
rename g9wkindp a9wkindp
local nums 4 6 8 9 
foreach i of local nums {
	replace a`i'wkindp = .i if a`i'wkindp == -7 | a`i'wkindp == -8 | a`i'wkindp ==-9
	replace a`i'wkindp = .p if a`i'wkindp == .
	replace a`i'wkindp = . if a`i'wkindp == -1 | a`i'wkindp == -4 | a`i'wkindp == -5
	rename a`i'wkindp ttindp`i'
}
label variable ttindp4 "Teacher time spent on independently working, 1st grade Spring"
label variable ttindp6 "Teacher time spent on independently working, 2nd grade Spring"
label variable ttindp8 "Teacher time spent on independently working, 4th grade"
label variable ttindp9 "Teacher time spent on independently working, 5th grade"

/* Time spent working with peers */ 
rename g8wkpeer a8wkpeer
rename g9wkpeer a9wkpeer
local nums 4 6 8 9 
foreach i of local nums {
	replace a`i'wkpeer = .i if a`i'wkpeer == -7 | a`i'wkpeer == -8 | a`i'wkpeer ==-9
	replace a`i'wkpeer = .p if a`i'wkpeer == .
	replace a`i'wkpeer = . if a`i'wkpeer == -1 | a`i'wkpeer == -4 | a`i'wkpeer == -5
	rename a`i'wkpeer ttpeer`i'
}
label variable ttpeer4 "Teacher time spent working with peers, 1st grade Spring"
label variable ttpeer6 "Teacher time spent working with peers, 2nd grade Spring"
label variable ttpeer8 "Teacher time spent working with peers, 4th grade"
label variable ttpeer9 "Teacher time spent working with peers, 5th grade"

/* Teacher importance evaluating child relative to class */ 
rename a2toclas a2toclss
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'toclss = .i if a`i'toclss == -7 | a`i'toclss == -8 | a`i'toclss ==-9
	replace a`i'toclss = .p if a`i'toclss == .
	replace a`i'toclss = . if a`i'toclss == -1 | a`i'toclss == -4 | a`i'toclss == -5
	rename a`i'toclss tevlclss`i'
}
label variable tevlclss2 "Teacher importance evaluating child relative to class, Kindergarten Spring"
label variable tevlclss4 "Teacher importance evaluating child relative to class, 1st grade Spring"
label variable tevlclss6 "Teacher importance evaluating child relative to class, 2nd grade Spring"
label variable tevlclss7 "Teacher importance evaluating child relative to class, 3rd grade"
label variable tevlclss8 "Teacher importance evaluating child relative to class, 4th grade"
label variable tevlclss9 "Teacher importance evaluating child relative to class, 5th grade"

/* Teacher importance evaluating child relative to standards */ 
rename a2tostnd a2tostdr
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'tostdr = .i if a`i'tostdr == -7 | a`i'tostdr == -8 | a`i'tostdr ==-9
	replace a`i'tostdr = .p if a`i'tostdr == .
	replace a`i'tostdr = . if a`i'tostdr == -1 | a`i'tostdr == -4 | a`i'tostdr == -5
	rename a`i'tostdr tevlstd`i'
}
label variable tevlstd2 "Teacher importance evaluating child relative to standards, Kindergarten Spring"
label variable tevlstd4 "Teacher importance evaluating child relative to standards, 1st grade Spring"
label variable tevlstd6 "Teacher importance evaluating child relative to standards, 2nd grade Spring"
label variable tevlstd7 "Teacher importance evaluating child relative to standards, 3rd grade"
label variable tevlstd8 "Teacher importance evaluating child relative to standards, 4th grade"
label variable tevlstd9 "Teacher importance evaluating child relative to standards, 5th grade"

/* Teacher importance evaluating child improvement */ 
rename a2imprvm a2impprg
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'impprg = .i if a`i'impprg == -7 | a`i'impprg == -8 | a`i'impprg ==-9
	replace a`i'impprg = .p if a`i'impprg == .
	replace a`i'impprg = . if a`i'impprg == -1 | a`i'impprg == -4 | a`i'impprg == -5
	rename a`i'impprg tevlimp`i'
}
label variable tevlimp2 "Teacher importance evaluating child on improvement, Kindergarten Spring"
label variable tevlimp4 "Teacher importance evaluating child on improvement, 1st grade Spring"
label variable tevlimp6 "Teacher importance evaluating child on improvement, 2nd grade Spring"
label variable tevlimp7 "Teacher importance evaluating child on improvement, 3rd grade"
label variable tevlimp8 "Teacher importance evaluating child on improvement, 4th grade"
label variable tevlimp9 "Teacher importance evaluating child on improvement, 5th grade"

/* Teacher importance evaluating child effort */ 
rename a2effo a2effrt
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'effrt = .i if a`i'effrt == -7 | a`i'effrt == -8 | a`i'effrt ==-9
	replace a`i'effrt = .p if a`i'effrt == .
	replace a`i'effrt = . if a`i'effrt == -1 | a`i'effrt == -4 | a`i'effrt == -5
	rename a`i'effrt tevleff`i'
}
label variable tevleff2 "Teacher importance evaluating child on effort, Kindergarten Spring"
label variable tevleff4 "Teacher importance evaluating child on effort, 1st grade Spring"
label variable tevleff6 "Teacher importance evaluating child on effort, 2nd grade Spring"
label variable tevleff7 "Teacher importance evaluating child on effort, 3rd grade"
label variable tevleff8 "Teacher importance evaluating child on effort, 4th grade"
label variable tevleff9 "Teacher importance evaluating child on effort, 5th grade"

/* Teacher importance evaluating child class participation */ 
rename a2claspa a2clspar
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'clspar = .i if a`i'clspar == -7 | a`i'clspar == -8 | a`i'clspar ==-9
	replace a`i'clspar = .p if a`i'clspar == .
	replace a`i'clspar = . if a`i'clspar == -1 | a`i'clspar == -4 | a`i'clspar == -5
	rename a`i'clspar tevlpart`i'
}
label variable tevlpart2 "Teacher importance evaluating child on participation, Kindergarten Spring"
label variable tevlpart4 "Teacher importance evaluating child on participation, 1st grade Spring"
label variable tevlpart6 "Teacher importance evaluating child on participation, 2nd grade Spring"
label variable tevlpart7 "Teacher importance evaluating child on participation, 3rd grade"
label variable tevlpart8 "Teacher importance evaluating child on participation, 4th grade"
label variable tevlpart9 "Teacher importance evaluating child on participation, 5th grade"

/* Teacher importance evaluating child class behavior */ 
rename a2attnd a2clsbhv
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'clsbhv = .i if a`i'clsbhv == -7 | a`i'clsbhv == -8 | a`i'clsbhv ==-9
	replace a`i'clsbhv = .p if a`i'clsbhv == .
	replace a`i'clsbhv = . if a`i'clsbhv == -1 | a`i'clsbhv == -4 | a`i'clsbhv == -5
	rename a`i'clsbhv tevlbhv`i'
}
label variable tevlbhv2 "Teacher importance evaluating child on behavior, Kindergarten Spring"
label variable tevlbhv4 "Teacher importance evaluating child on behavior, 1st grade Spring"
label variable tevlbhv6 "Teacher importance evaluating child on behavior, 2nd grade Spring"
label variable tevlbhv7 "Teacher importance evaluating child on behavior, 3rd grade"
label variable tevlbhv8 "Teacher importance evaluating child on behavior, 4th grade"
label variable tevlbhv9 "Teacher importance evaluating child on behavior, 5th grade"

/* Teacher importance evaluating child cooperation */ 
rename a2coprtv a2cooprt
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'cooprt = .i if a`i'cooprt == -7 | a`i'cooprt == -8 | a`i'cooprt ==-9
	replace a`i'cooprt = .p if a`i'cooprt == .
	replace a`i'cooprt = . if a`i'cooprt == -1 | a`i'cooprt == -4 | a`i'cooprt == -5
	rename a`i'cooprt tevlcoop`i'
}
label variable tevlcoop2 "Teacher importance evaluating child on cooperation, Kindergarten Spring"
label variable tevlcoop4 "Teacher importance evaluating child on cooperation, 1st grade Spring"
label variable tevlcoop6 "Teacher importance evaluating child on cooperation, 2nd grade Spring"
label variable tevlcoop7 "Teacher importance evaluating child on cooperation, 3rd grade"
label variable tevlcoop8 "Teacher importance evaluating child on cooperation, 4th grade"
label variable tevlcoop9 "Teacher importance evaluating child on cooperation, 5th grade"

/* Teacher evaluates ability to take directions */ 
rename a2fllwdr a2flldir
local nums 2 4 6 7 8 9 
foreach i of local nums {
	replace a`i'flldir = .i if a`i'flldir == -7 | a`i'flldir == -8 | a`i'flldir ==-9
	replace a`i'flldir = .p if a`i'flldir == .
	replace a`i'flldir = . if a`i'flldir == -1 | a`i'flldir == -4 | a`i'flldir == -5
	rename a`i'flldir tevldir`i'
}
label variable tevldir2 "Teacher evaluates children on following directions, Kindergarten Spring"
label variable tevldir4 "Teacher evaluates children on following directions, 1st grade Spring"
label variable tevldir6 "Teacher evaluates children on following directions, 2nd grade Spring"
label variable tevldir7 "Teacher evaluates children on following directions, 3rd grade"
label variable tevldir8 "Teacher evaluates children on following directions, 4th grade"
label variable tevldir9 "Teacher evaluates children on following directions, 5th grade"

/* Teacher importance evaluating child ability by standardized tests */ 
rename a2stndrd a2stntst
local nums 2 4 6 
foreach i of local nums {
	replace a`i'stntst = .i if a`i'stntst == -7 | a`i'stntst == -8 | a`i'stntst ==-9
	replace a`i'stntst = .p if a`i'stntst == .
	replace a`i'stntst = . if a`i'stntst == -1 | a`i'stntst == -4 | a`i'stntst == -5
	rename a`i'stntst tevltst`i'
}
label variable tevltst2 "Teacher importance evaluating child on standardized tests, Kindergarten Spring"
label variable tevltst4 "Teacher importance evaluating child on standardized tests, 1st grade Spring"
label variable tevltst6 "Teacher importance evaluating child on standardized tests, 2nd grade Spring"

/* Teacher evaluates ability by classroom tests */ 
rename a2tchrmd a2tstqz
local nums 2 4 6 
foreach i of local nums {
	replace a`i'tstqz = .i if a`i'tstqz == -7 | a`i'tstqz == -8 | a`i'tstqz ==-9
	replace a`i'tstqz = .p if a`i'tstqz == .
	replace a`i'tstqz = . if a`i'tstqz == -1 | a`i'tstqz == -4 | a`i'tstqz == -5
	rename a`i'tstqz tevlqz`i'
}
label variable tevlqz2 "Teacher evaluates children on class tests, Kindergarten Spring"
label variable tevlqz4 "Teacher evaluates children on class tests, 1st grade Spring"
label variable tevlqz6 "Teacher evaluates children on class tests, 2nd grade Spring"

/* Teacher rating of classroom behavior */ 
rename a4behvr tbhvr4
replace tbhvr4 = .i if tbhvr4 == -7 | tbhvr4 == -8 | tbhvr4 == -9
replace tbhvr4 = .p if tbhvr4 == .
replace tbhvr4 = . if tbhvr4 == -1 | tbhvr4 == -4 | tbhvr4 == -5
label variable tbhvr4 "Teacher rating of classroom behavior, 1st grade Spring"

/* Teacher gives individual or group projects */ 
rename a2igrprj a2projct
local nums 2 4 6 
foreach i of local nums {
	replace a`i'projct = .i if a`i'projct == -7 | a`i'projct == -8 | a`i'projct ==-9
	replace a`i'projct = .p if a`i'projct == .
	replace a`i'projct = . if a`i'projct == -1 | a`i'projct == -4 | a`i'projct == -5
	rename a`i'projct tevlprj`i'
}
label variable tevlprj2 "Teacher assigns projects, Kindergarten Spring"
label variable tevlprj4 "Teacher assigns projects, 1st grade Spring"
label variable tevlprj6 "Teacher assigns projects, 2nd grade Spring"

/* Teacher gives worksheets */ 
rename a2wrksht a2wrksts
local nums 2 4 6 
foreach i of local nums {
	replace a`i'wrksts = .i if a`i'wrksts == -7 | a`i'wrksts == -8 | a`i'wrksts ==-9
	replace a`i'wrksts = .p if a`i'wrksts == .
	replace a`i'wrksts = . if a`i'wrksts == -1 | a`i'wrksts == -4 | a`i'wrksts == -5
	rename a`i'wrksts tevlwrksh`i'
}
label variable tevlwrksh2 "Teacher assigns worksheets, Kindergarten Spring"
label variable tevlwrksh4 "Teacher assigns worksheets, 1st grade Spring"
label variable tevlwrksh6 "Teacher assigns worksheets, 2nd grade Spring"

/* Teacher gives work samples */ 
rename a2wrksmp a2wrksam
local nums 2 4 6 
foreach i of local nums {
	replace a`i'wrksam = .i if a`i'wrksam == -7 | a`i'wrksam == -8 | a`i'wrksam ==-9
	replace a`i'wrksam = .p if a`i'wrksam == .
	replace a`i'wrksam = . if a`i'wrksam == -1 | a`i'wrksam == -4 | a`i'wrksam == -5
	rename a`i'wrksam tevlwrksa`i'
}
label variable tevlwrksa2 "Teacher provides work samples, Kindergarten Spring"
label variable tevlwrksa4 "Teacher provides work samples, 1st grade Spring"
label variable tevlwrksa6 "Teacher provides work samples, 2nd grade Spring"

/* Teacher assigns achievement groups - reading */ 
local nums 2 4 6 
foreach i of local nums {
	replace a`i'divrd = .i if a`i'divrd == -7 | a`i'divrd == -8 | a`i'divrd ==-9
	replace a`i'divrd = .p if a`i'divrd == .
	replace a`i'divrd = . if a`i'divrd == -1 | a`i'divrd == -4 | a`i'divrd == -5
	rename a`i'divrd tachrd`i'
}
label variable tachrd2 "Teacher uses achievement groups - reading, Kindergarten Spring"
label variable tachrd4 "Teacher uses achievement groups - reading, 1st grade Spring"
label variable tachrd6 "Teacher uses achievement groups - reading, 2nd grade Spring"

/* Teacher assigns achievement groups - math */ 
local nums 2 4 6 
foreach i of local nums {
	replace a`i'divmth = .i if a`i'divmth == -7 | a`i'divmth == -8 | a`i'divmth ==-9
	replace a`i'divmth = .p if a`i'divmth == .
	replace a`i'divmth = . if a`i'divmth == -1 | a`i'divmth == -4 | a`i'divmth == -5
	rename a`i'divmth tachmth`i'
}
label variable tachmth2 "Teacher uses achievement groups - reading, Kindergarten Spring"
label variable tachmth4 "Teacher uses achievement groups - reading, 1st grade Spring"
label variable tachmth6 "Teacher uses achievement groups - reading, 2nd grade Spring"

/* Teacher assigns daily homework */ 
rename a1hmwrk a1dpwhmwk
rename g8dpwhmwk a8dpwhmwk
rename g9dpwhmwk a9dpwhmwk
local nums 1 4 6 7 8 9 
foreach i of local nums {
	replace a`i'dpwhmwk = .i if a`i'dpwhmwk == -7 | a`i'dpwhmwk == -8 | a`i'dpwhmwk ==-9
	replace a`i'dpwhmwk = .p if a`i'dpwhmwk == .
	replace a`i'dpwhmwk = . if a`i'dpwhmwk == -1 | a`i'dpwhmwk == -4 | a`i'dpwhmwk == -5
	rename a`i'dpwhmwk thw`i'
}
label variable thw1 "Teacher assigns daily homework, Kindergarten Fall"
label variable thw4 "Teacher assigns daily homework, 1st grade Spring"
label variable thw6 "Teacher assigns daily homework, 2nd grade Spring"
label variable thw7 "Teacher assigns daily homework, 3rd grade"
label variable thw8 "Teacher assigns daily homework, 4th grade"
label variable thw9 "Teacher assigns daily homework, 5th grade"

/* 1st grade teacher taught X topic in class */ 
label define days2 0 "Never or hardly ever" 1 "1-2 times per month" 2 "1-2 times per week" 3 "Almost every day"
foreach x of varlist a4usebsl-a4useanth {
	replace `x' = .i if `x' == -7 | `x' == -8 | `x' == -9
	replace `x' = .p if `x' == .
	replace `x' = . if `x' == -1 | `x' == -4 | `x' == -5
	replace `x' = 0 if `x' == 1
	replace `x' = 1 if `x' == 2
	replace `x' = 2 if `x' == 3
	replace `x' = 3 if `x' == 4
	label values `x' days2
	rename `x' `x'4
}

label define days1 0 "not taught" 1 "1-10 days" 2 "11-20 days" 3 "21-40 days" 4 "41-80 days" 5 "More than 80 days"
foreach x of varlist a4mainid-a4triquad {
	replace `x' = .i if `x' == -7 | `x' == -8 | `x' == -9
	replace `x' = .p if `x' == .
	replace `x' = . if `x' == -1 | `x' == -4 | `x' == -5
	replace `x' = 0 if `x' == 1
	replace `x' = 1 if `x' == 2
	replace `x' = 2 if `x' == 3
	replace `x' = 3 if `x' == 4
	replace `x' = 4 if `x' == 5
	replace `x' = 5 if `x' == 6
	label values `x' days1
	rename `x' `x'4
}

label define days 0 "not taught" 1 "1-5 days" 2 "6-10 days" 3 "11- 15 days" 4 "16-20 days" 5 "More than 20 days"
foreach x of varlist a4sensobs-a4grpchrt {
	replace `x' = .i if `x' == -7 | `x' == -8 | `x' == -9
	replace `x' = .p if `x' == .
	replace `x' = . if `x' == -1 | `x' == -4 | `x' == -5
	replace `x' = 0 if `x' == 1
	replace `x' = 1 if `x' == 2
	replace `x' = 2 if `x' == 3
	replace `x' = 3 if `x' == 4
	replace `x' = 4 if `x' == 5
	replace `x' = 5 if `x' == 6
	label values `x' days
	rename `x' `x'4
}

label define taught 0 "Not taught in teacher's class" 1 "Taught in teacher's class"
foreach x of varlist a4sttmtr-a4crevnt {
	replace `x' = .i if `x' == -7 | `x' == -8 | `x' == -9
	replace `x' = .p if `x' == .
	replace `x' = . if `x' == -1 | `x' == -4 | `x' == -5
	replace `x' = 0 if `x' == 2 
	label values `x' taught
	rename `x' `x'4
}

/***********************
CLEAN LOCATION VARIABLES    
************************/
/* Region */
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace x`i'region = .i if x`i'region == -7 | x`i'region == -8 | x`i'region == -9
	replace x`i'region = .p if x`i'region == .
	replace x`i'region = . if x`i'region == -1 | x`i'region == -4 | x`i'region == -5
}

/* Locale */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace x`i'locale = .i if x`i'locale == -7 | x`i'locale == -8 | x`i'locale == -9
	replace x`i'locale = .p if x`i'locale == .
	replace x`i'locale = . if x`i'locale == -1 | x`i'locale == -4 | x`i'locale == -5
}

/* school ZIP codes */
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace f`i'schzip = "" if f`i'schzip == "-7" | f`i'schzip == "-8" | f`i'schzip == "-9"
	replace f`i'schzip = "" if f`i'schzip == "-1" | f`i'schzip == "-4" | f`i'schzip == "-5"
}

/* Home ZIP codes */
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace p`i'homzip = "" if p`i'homzip == "-7" | p`i'homzip == "-8" | p`i'homzip == "-9"
	replace p`i'homzip = "" if p`i'homzip == "-1" | p`i'homzip == "-4" | p`i'homzip == "-5"
}

/* School census tracts */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace f`i'centr = "" if f`i'centr == "-7" | f`i'centr == "-8" | f`i'centr == "-9"
	replace f`i'centr = "" if f`i'centr == "-1" | f`i'centr == "-4" | f`i'centr == "-5"
}

/* Home census tracts */ 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
	replace p`i'centr = "" if p`i'centr == "-7" | p`i'centr == "-8" | p`i'centr == "-9"
	replace p`i'centr = "" if p`i'centr == "-1" | p`i'centr == "-4" | p`i'centr == "-5"
}

/*parental involvement*/
egen parinvolve=rowtotal(ppta2 pconf2 pvolschl2 pattschl2 pbkschl2)

/***********************************************
DROP REMAINING VARIABLES NOT NEEDED FOR ANALYSIS   
************************************************/
drop p2tincth p4tincth_i p6tincth_i p7tincth_i p8tincth_i p9tincth_i x1attnfs x2attnfs x4attnfs ///
x_hisp_r x_white_r x_black_r x_asian_r x_aminan_r x_hawpi_r x_multr_r p2tincth p4tincth_i ///
ifp4tincth p6tincth_i ifp6tincth p7tincth_i ifp7tincth p8tincth_i ifp8tincth p9tincth_i ifp9tincth ///
x1par1occ_i x4par1occ_i x6par1occ_i x9par1occ_i x1par2occ_i x4par2occ_i x6par2occ_i x9par2occ_i ///
x1less18 x2less18 x4less18_r x6less18 x7less18 x8less18 x9less18 ///
x1plss x2plss x3plss x4plss x1plart x2plart x3plart x4plart x9langst x4par1rac x6par1rac x7par1rac /// 
x8par1rac x9par1rac ifx12par1ed ifx1par1scr ifx4par1occ ifx4par1scr ifx6par1occ ifx6par1scr ///
ifx9par1occ ifx9par1scr x2par2rac x4par2rac x6par2rac x7par2rac x8par2rac x9par2rac ifx12par2ed ///
ifx1par2scr ifx4par2occ ifx4par2scr ifx6par2occ ifx6par2scr ifx9par2occ ifx9par2scr ifx2inccat ///
x2flch2_i x2rlch2_i x4fmeal_i x4rmeal_i x7frmealflg x8frmealflg x9frmealflg ifx2flch2 ifx2rlch2 ///
ifx4fmeal ifx4rmeal ifx6frmeal ifx7frmeal ifx8frmeal ifx9frmeal t2grade t3grade ///
p1sex_1 p1mom_1 p1dad_1 p1sex_2 p1mom_2 p1dad_2 p1numpla p2sex_1 p2mom_1 p2dad_1 p2sex_2 ///
p2mom_2 p2dad_2 p4sex_1 p4mom_1 p4dad_1 p4sex_2 p4mom_2 p4dad_2 p4numpla p6sex_1 p6mom_1 ///
p6dad_1 p6sex_2 p6mom_2 p6dad_2 p7sex_1 p7mom_1 p7dad_1 p7sex_2 p7mom_2 p7dad_2 p8sex_1 ///
p8mom_1 p8dad_1 p8sex_2 p8mom_2 p8dad_2 p9sex_1 p9mom_1 p9dad_1 p9sex_2 p9mom_2 p9dad_2 ///
a1smlgrp a1readar a1listnc a1wrtcnt a1mathar a1playar a1watrsa a1compar a1sciar a1dramar ///
a1artare a1timdis t1cmpsen t1reads t1write t1solve t1strat a2txtbk a2manipu a2audiov ///
a2video a2compeq a2softwa a2paper a2copier a2clsspc a2blndwd a4kdbehvr a4kwkindp ///
a4kwkindv a4kwkpeer a4kwksgrp a4kwklgrp a4kreadar a4klistnc a4kwrtcnt a4kmathar ///
a4kpuzblk a4kwtrsand a4kcompar a4ksciar a4kdramar a4kartare a4koftrdl a4koftmth ///
a4koftsci a4koftmus a4koftart a4koftpe a4koftdan a4kofthtr a4koftfln a4ktxrdla a4ktxmth ///
a4ktxsoc a4ktxsci a4ktxmus a4ktxart a4ktxpe a4ktxdan a4ktxthtr a4ktxfln a4kdivrd ///
a4kdivmth a4kdpwhmwk a4ktoclss a4ktostdr a4kimpprg a4keffrt a4kclspar a4kclsbhv ///
a4kcooprt a4kflldir a4kstntst a4ktstqz a4kprojct a4kwrksts a4kwrksam a4kaccptd x4kattnfs ///
a4kcntnlr a4kpaprwr a4kpsupp a4kcopstf a4krecjob a4kstndlo a4kmissio a4ksetpri x4ktchint ///
a4kencour a4kenjoy a4kmkdiff a4kcnsnss a4ktgend a4khisp a4kaminan a4kasian a4kblack ///
a4khawpi a4kwhite a4khghstd a4kyrsch a4kyrstch a4knatexm a4kstatct x2par1rac ///
t4kcmpsen t4kreads t4kwrite t4ksolve t4kstrat t4kshows t4kworks a7wtbuse x4ktchext ///
g8enjact m8behvr m8wkindp m8wkindv m8wkpeer m8wksgrp m8wklgrp m8dpwhmwk n8behvr ///
n8wkindp n8wkindv n8wkpeer n8wksgrp n8wklgrp n8dpwhmwk g9enjact m9behvr m9wkindp ///
m9wkindv m9wkpeer m9wksgrp m9wklgrp m9dpwhmwk n9behvr n9wkindp n9wkindv n9wkpeer ///
n9wksgrp n9wklgrp n9dpwhmwk s7giftyn s7mathyn s7nursyn s7psycyn s7libryn s7ctecyn ///
s8giftyn s8mathyn s8nursyn s8psycyn s8libryn s8ctecyn s9giftyn s9mathyn s9nursyn ///
s9psycyn s9libryn s9ctecyn a8tgendz a9tgendz x_raceth_r x2par1rac s2instcm ///
a1black a4black a6black a7black a8black a8blackz a9black a9blackz a1hisp a4hisp ///
a6hisp a7hisp a8hisp a8hispz a9hisp a9hispz a1aminan a4aminan a6aminan a7aminan ///
a8aminan a8aminanz a9aminan a9aminanz a1white a4white a6white a7white a8white ///
a8whitez a9white a9whitez a1asian a4asian a6asian a7asian a8asian a8asianz ///
a9asian a9asianz a1hawpi a4hawpi a6hawpi a7hawpi a8hawpi a8hawpiz a9hawpi a9hawpiz ///
s2cnsnss s4cnsnss s6cnsnss a8oftrdlz a8oftmthz a8oftsciz a8oftmusz a8oftartz ///
a8oftpez a8oftdanz a8ofthtrz a8oftflnz a9oftrdlz a9oftmthz a9oftsciz a9oftmusz ///
a9oftartz a9oftpez a9oftdanz a9ofthtrz a9oftflnz a8txrdlaz a8txmthz a8txsocz ///
a8txsciz a8txmusz a8txartz a8txpez a8txdanz a8txthtrz a8txflnz a8toclssz ///
a8tostdrz a8impprgz a8effrtz a8clsparz a8clsbhvz a8cooprtz a8flldirz a8psuppz ///
a8copstfz a8cnsnssz a8setpriz a8encourz a8enjoyz a8teachz a8yrstchz a8hghstdz ///
a9txrdlaz a9txmthz a9txsocz a9txsciz a9txmusz a9txartz a9txpez a9txdanz a9txthtrz ///
a9txflnz a9toclssz a9tostdrz a9impprgz a9effrtz a9clsparz a9clsbhvz a9cooprtz ///
a9flldirz a9psuppz a9copstfz a9cnsnssz a9stndloz a9setpriz a9encourz a9enjoyz ///
a9teachz a9yrstchz a9hghstdz s2hisp s4hisp s6hisp s7hisp s8hisp s9hisp s2black ///
s4black s6black s7black s8black s9black s2white s4white s6white s7white s8white ///
s9white s2asian s4asian s6asian s7asian s8asian s9asian s2aminan s4aminan ///
s6aminan s7aminan s8aminan s9aminan s2hawpi s4hawpi s6hawpi s7hawpi s8hawpi ///
s9hawpi s2white s4white s6white s7white s8white s9white a1timdis ///
stotenrl2 stotenrl6 stotenrl7 stotenrl8 stotenrl9 p1prmlng p9prmlng ///
t2cmpsen t2reads t2write t2solve t2strat p1oldmom a8stndloz p4prmlng p6prmlng 

drop w1a0-w9c79p_9t790

/************************
SAVE AS NEW STATA DATASET  
*************************/
save "${data_directory}eclsk11v2.dta", replace

clear all 
log close















