#delimit cr
capture log close 
capture clear all 

global data_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\" 
global log_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\5-eclsk11-analyses\" 

log using "${log_directory}6-multiple-impute-eclsk11mi.log", replace 

/******************
MULTIPLE IMPUTATION
******************/

/*** Read data ***/
use "${data_directory}\eclsk11\eclsk11v5.dta", clear

/*** Keep only observations in analytic sample ***/
drop if s3_id=="" 

/*** Generate Fall K school-level average abilities variable ***/
bysort s3_id: egen rdtheta1_mean = mean(rdtheta1)
bysort s3_id: egen mththeta1_mean = mean(mththeta1)
replace rdtheta1_mean=. if inlist(s3_id,"9993","9995","9997")
replace mththeta1_mean=. if inlist(s3_id,"9993","9995","9997")

/*** recode ***/
egen paredprac = rowmean(pprctnm1 preadbk1)
egen parschlinv = rowmean(ppta2 pconf2 pvolschl2)
gen snonwht4 = 1 - swht4
rename nhdadvg_2010 nhdadvg

/*** keep key variables ***/
keep /// 
	childid ///
	s1_id s2_id s3_id s4_id ///
	re_schlyr_read 	re_summer_read re_schlyr_math re_summer_math ///
	rdtheta1 rdtheta7 mththeta1 mththeta7 rdtheta1_mean mththeta1_mean ///
	gender race hhtot1 faminc2 marbrth brthwt pared2 par1emp1 par1age1 ///
	cogstim pardepres ownhome parinvolve ///
	sfrlnch4 snonwht4 ///
	nhdadvg 

/*** Replace >. with =. ***/
local vars_to_be_imputed ///
	re_schlyr_read 	re_summer_read re_schlyr_math re_summer_math ///
	rdtheta1 rdtheta7 mththeta1 mththeta7 rdtheta1_mean mththeta1_mean ///
	gender race hhtot1 faminc2 marbrth brthwt pared2 par1emp1 par1age1 ///
	cogstim pardepres ownhome parinvolve ///
	sfrlnch4 snonwht4 ///
	nhdadvg

foreach var of local vars_to_be_imputed {
    replace `var' = . if `var' > .
	}	

codebook 


/*** Multiple imputation ***/

/* mi set */
mi set flong

/* mi xtset */
mi xtset, clear

/* misstable sum */
misstable sum ///
	re_schlyr_read 	re_summer_read re_schlyr_math re_summer_math ///
	rdtheta1 rdtheta7 mththeta1 mththeta7 rdtheta1_mean mththeta1_mean ///
	gender race hhtot1 faminc2 marbrth brthwt pared2 par1emp1 par1age1 ///
	cogstim pardepres ownhome parinvolve ///
	sfrlnch4 snonwht4 ///
	nhdadvg

/* mi register */
mi register imputed ///
	re_schlyr_read 	re_summer_read re_schlyr_math re_summer_math ///
	rdtheta1 rdtheta7 mththeta1 mththeta7 rdtheta1_mean mththeta1_mean ///
	gender race hhtot1 faminc2 marbrth brthwt pared2 par1emp1 par1age1 ///
	cogstim pardepres ownhome parinvolve ///
	sfrlnch4 snonwht4 ///
	nhdadvg

/* mi impute */
set matsize 11000

mi impute chained ///
	(pmm, knn(10)) ///
		re_schlyr_read 	re_summer_read re_schlyr_math re_summer_math ///
		rdtheta1 rdtheta7 mththeta1 mththeta7 rdtheta1_mean mththeta1_mean ///
		hhtot1 faminc2 brthwt par1age1 cogstim pardepres ///
		sfrlnch4 snonwht4 ///
		nhdadvg ///
	(mlogit, augment) ///
		gender race marbrth pared2 par1emp1 ownhome ///
	(ologit) ///
		parinvolve ///
	, dots add(50) rseed(8675309)


/* Recode categorical variables */
tab race, gen(race_)
drop race race_1

tab pared2, gen(pared_)
drop pared2 pared_1

tab par1emp1, gen(paremp_)
drop par1emp1 paremp_1

gen re_impact_read=re_schlyr_read-re_summer_read
gen re_impact_math=re_schlyr_math-re_summer_math

gen re_impact2_read=re_schlyr_read-0.5*re_summer_read
gen re_impact2_math=re_schlyr_math-0.5*re_summer_math

drop *summer*

gen minum=_mi_m
drop _mi_id _mi_miss _mi_m

rename par1age1 parage

label drop gender 
label drop yes
label drop hh
*label drop P1READBK
*label drop P1NUMBRS

/* Save dataset */
saveold "${data_directory}\eclsk11\eclsk11mi.dta", replace v(12)

clear
log close
