log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\2-multiple-impute.log", replace

/******************
MULTIPLE IMPUTATION
******************/

/*** Read data ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-inspect.dta", clear





/*** Keep crucial variables ***/

rename re_impact_math_HLM                  re_impact_math
rename re_impact_math_first_only_HLM       re_impact_math_first_only
rename re_impact_math_summer_only_HLM      re_impact_math_summer_only

rename re_impact_read_HLM                  re_impact_read
rename re_impact_read_first_only_HLM       re_impact_read_first_only
rename re_impact_read_summer_only_HLM      re_impact_read_summer_only

keep CHILDID ///
     wave ///
     S_ID ///
     re_impact_math ///
	 re_impact_math_first_only ///
	 re_impact_math_summer_only ///
     re_impact_read ///
	 re_impact_read_first_only ///
	 re_impact_read_summer_only





/*** Reshape from long to wide ***/

reshape wide S_ID, i(CHILDID) j(wave)

rename S_ID1 S1_ID
rename S_ID2 S2_ID
rename S_ID3 S3_ID
rename S_ID4 S4_ID





/*** Merge to full dataset ***/

merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\impact-measure-estimation-temp3.dta"





/*** Generate school disorder measure: components ***/

recode A4ABSEN (8 10 15 18 20 = 7), gen(A4ABSEN_r)
bysort S4_ID: egen A4ABSEN_r_sch = mean(A4ABSEN_r)

recode A4BEHVR (1 = 5) (2 = 4) (3 = 3) (4 = 2) (5 = 1), gen(A4BEHVR_r)
bysort S4_ID: egen A4BEHVR_r_sch = mean(A4BEHVR_r)





/*** Generate school resources measure: components ***/

// Pupil/teacher ratio (higher = worse)
codebook nschtpr99
codebook npschtpr99
gen puptchr99 = nschtpr99
replace puptchr99 = npschtpr99 if puptchr99 >= .

// Number of years been school teacher (higher = better)
codebook B4YRSTC
bysort S4_ID: egen B4YRSTC_sch = mean(B4YRSTC)

// Teacher salary (higher = better)
// codebook YKMERPAY // Merit pay
// codebook YKEMPBEN // Employee benefits
codebook YKBASSAL // Base salary
bysort S4_ID: egen YKBASSAL_sch = mean(YKBASSAL)

// Teacher highest degree (higher = better)
codebook B4HGHSTD
recode B4HGHSTD (1 2 3 4 = 0) (5 6 7 = 1), gen(advdeg) // consider 4 also as 1?
bysort S4_ID: egen advdeg_sch = mean(advdeg)

// Per pupil expenditures (higher = better) 
codebook ndstexp99

misstable summarize nschtpr99 npschtpr99 puptchr99 ///
                    B4YRSTC B4YRSTC_sch ///
                    YKBASSAL YKBASSAL_sch ///
					B4HGHSTD advdeg advdeg_sch ///
					ndstexp99
					
pwcorr puptchr99 B4YRSTC_sch YKBASSAL_sch advdeg_sch ndstexp99





/*** Generate CCD mediator in percentages ***/

gen nschlnch99_percent = nschlnch99*100





/*** Generate low child weight at birth variable ***/

gen childweight = 16*P1WEIGHP + P1WEIGHO

gen childweightlow = .
replace childweightlow = 0 if childweight >= 88 & childweight < .
replace childweightlow = 1 if childweight < 88





/*** Keep only observations in analytic sample ***/

drop if S3_ID == ""





/*** Manually fill missing impact measures
     using information from kids in same school ***/

bysort S4_ID: egen re_impact_read_s_m = mean(re_impact_read)
replace re_impact_read = re_impact_read_s_m if re_impact_read == .
replace re_impact_read = . if inlist(S4_ID,"9995","9996","9997")

bysort S4_ID: egen re_impact_read_fo_s_m = mean(re_impact_read_first_only)
replace re_impact_read_first_only = re_impact_read_fo_s_m if re_impact_read_first_only == .
replace re_impact_read_first_only = . if inlist(S4_ID,"9995","9996","9997")

bysort S4_ID: egen re_impact_read_so_s_m = mean(re_impact_read_summer_only)
replace re_impact_read_summer_only = re_impact_read_so_s_m if re_impact_read_summer_only == .
replace re_impact_read_summer_only = . if inlist(S4_ID,"9995","9996","9997")


bysort S4_ID: egen re_impact_math_s_m = mean(re_impact_math)
replace re_impact_math = re_impact_math_s_m if re_impact_math == .
replace re_impact_math = . if inlist(S4_ID,"9995","9996","9997")

bysort S4_ID: egen re_impact_math_fo_s_m = mean(re_impact_math_first_only)
replace re_impact_math_first_only = re_impact_math_fo_s_m if re_impact_math_first_only == .
replace re_impact_math_first_only = . if inlist(S4_ID,"9995","9996","9997")

bysort S4_ID: egen re_impact_math_so_s_m = mean(re_impact_math_summer_only)
replace re_impact_math_summer_only = re_impact_math_so_s_m if re_impact_math_summer_only == .
replace re_impact_math_summer_only = . if inlist(S4_ID,"9995","9996","9997")




/*** Generate Fall K school-level average abilities variable ***/
bysort S4_ID: egen c1r4rtht_r_mean = mean(c1r4rtht_r)
bysort S4_ID: egen c1r4mtht_r_mean = mean(c1r4mtht_r)

replace c1r4rtht_r_mean = . if inlist(S4_ID,"9995","9996","9997")
replace c1r4mtht_r_mean = . if inlist(S4_ID,"9995","9996","9997")


/*** 11.10.21 KW R&R WORK: COMPUTE # SCHOOLS DESCRIPTIVE STATUS ***/
// CREATE INDICATOR FOR # OF SCHOOLS KINDERGARTEN
sort S2_ID
by S2_ID: gen schl_num = 1 if _n == 1
replace schl_num = . if S2_ID == "" 

// CREATE INDICATOR FOR # OF SCHOOLS 1ST GRADE
sort S4_ID
by S4_ID: gen schl_num1 = 1 if _n == 1
replace schl_num1 = . if S4_ID == "" 

// CREATE NEIGHBORHOOD DISADVANTAGE TERTILE VARIABLE
xtile nhood3 = trct_disadv_index2, nq(3)

// COMPUTE # UNIQUE SCHOOLS IN EACH TERTILE OF NEIGHBORHOOD DISADVANTAGE
** KINDERGARTEN WAVE SCHOOLS
tabulate nhood3 if schl_num == 1

** 1ST GRADE WAVE SCHOOLS
tabulate nhood3 if schl_num1 == 1

// DROP INDICATOR FOR SCHOOLS AND DISADVANTAGE TERTILE 
drop schl_num schl_num1 nhood3
/*** 11.10.21 KW R&R WORK: END OF EDITS ***/



/*** 11.10.21 KW R&R WORK: COMPUTE # STUDENTS PER SCHOOL FOR FULL ANALYTIC SAMPLE ACROSS WAVES 1-4 ***/
// COMPUTE SUMMARIES OF SAMPLE STUDENTS PER SCHOOL AT EACH WAVE USED TO FIT DOWNEY MODEL
** W1 - KINDERGARTEN FALL 
sort S1_ID
by S1_ID: gen schl_num = 1 if _n == 1
replace schl_num = . if S1_ID == "" 

gen stu_num = 1 
bysort S1_ID: egen tot_stu = total(stu_num) 
sum tot_stu if schl_num == 1, det
drop schl_num stu_num tot_stu

** W2 - KINDERGARTEN SPRING
sort S2_ID
by S2_ID: gen schl_num = 1 if _n == 1
replace schl_num = . if S2_ID == "" 

gen stu_num = 1 
bysort S2_ID: egen tot_stu = total(stu_num) 
sum tot_stu if schl_num == 1, det
drop schl_num stu_num tot_stu

** W3 - 1ST GRADE FALL
sort S3_ID
by S3_ID: gen schl_num = 1 if _n == 1
replace schl_num = . if S3_ID == "" 

gen stu_num = 1 
bysort S3_ID: egen tot_stu = total(stu_num) 
sum tot_stu if schl_num == 1, det
drop schl_num stu_num tot_stu

** W4 - 1ST GRADE FALL
sort S4_ID
by S4_ID: gen schl_num = 1 if _n == 1
replace schl_num = . if S4_ID == "" 

gen stu_num = 1 
bysort S4_ID: egen tot_stu = total(stu_num) 
sum tot_stu if schl_num == 1, det
drop schl_num stu_num tot_stu
/*** 11.10.21 KW R&R WORK: END OF EDITS ***/



 


/*** Save data (analytic sample)  ***/

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\analytic-sample-pre-mi.dta", replace





/*** Multiple imputation ***/

/* Read data */

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\analytic-sample-pre-mi.dta", clear





/* mi set */

mi set flong





/* mi xtset */

mi xtset, clear





/*** Replace >. with =. ***/

local vars_to_be_imputed ///
      c5r4mtht_r c5r4rtht_r c6r4mtht_r c6r4rtht_r c7r4mtht_r c7r4rtht_r ///
	  re_impact_math_first_only ///
	  re_impact_math_summer_only ///
	  re_impact_read_first_only ///
	  re_impact_read_summer_only ///
	  puptchr99 B4YRSTC_sch YKBASSAL_sch advdeg_sch ndstexp99 ///
	  A4ABSEN_r_sch A4BEHVR_r_sch ///
	  nschlnch99_percent ///
	  S4NONWHTPCT ///
      trct_disadv_index2 ///
	  c1r4rtht_r_mean c1r4mtht_r_mean ///
	  c1r4mtht_r c1r4rtht_r ///
      cogstim_scale /// 
      magebirth ///
      parprac_scale ///
      pmh_scale_ver_one_2 ///
      GENDER mmarriedbirth childweightlow ///
      RACE ///
      WKPARED P1HDEMP P1HMEMP ///
	  P2INCOME P1HTOTAL  ///
	  c2r4mtht_r c2r4rtht_r c3r4mtht_r c3r4rtht_r c4r4mtht_r c4r4rtht_r ///
	  S4FLCH_I nschlnch99 ///
	  cogstim_factor ///
	  parprac_factor ///
	  P1WEIGHO P1WEIGHP childweight ///
	  pmh_scale_ver_two_2 ///
	  pmarriedbirth ///
	  W1PARED ///
	  re_impact_math re_impact_read

foreach var of local vars_to_be_imputed {
    replace `var' = . if `var' > .
}





/* misstable sum */

misstable sum ///
          c5r4mtht_r c5r4rtht_r c6r4mtht_r c6r4rtht_r c7r4mtht_r c7r4rtht_r ///
	      re_impact_math_first_only ///
	      re_impact_math_summer_only ///
	      re_impact_read_first_only ///
	      re_impact_read_summer_only ///
	      puptchr99 B4YRSTC_sch YKBASSAL_sch advdeg_sch ndstexp99 ///
	      A4ABSEN_r_sch A4BEHVR_r_sch ///
	      nschlnch99_percent ///
	      S4NONWHTPCT ///
          trct_disadv_index2 ///
	      c1r4rtht_r_mean c1r4mtht_r_mean ///
	      c1r4mtht_r c1r4rtht_r ///
          cogstim_scale /// 
          magebirth ///
          parprac_scale ///
          pmh_scale_ver_one_2 ///
          GENDER mmarriedbirth childweightlow ///
          RACE ///
          WKPARED P1HDEMP P1HMEMP ///
	      P2INCOME P1HTOTAL  ///
	      c2r4mtht_r c2r4rtht_r c3r4mtht_r c3r4rtht_r c4r4mtht_r c4r4rtht_r ///
	      S4FLCH_I nschlnch99 ///
	      cogstim_factor ///
	      parprac_factor ///
	      P1WEIGHO P1WEIGHP childweight ///
	      pmh_scale_ver_two_2 ///
	      pmarriedbirth ///
	      W1PARED ///
	      re_impact_math re_impact_read





/* mi register */

mi register imputed ///
   c5r4mtht_r c5r4rtht_r c6r4mtht_r c6r4rtht_r c7r4mtht_r c7r4rtht_r ///
   re_impact_math_first_only ///
   re_impact_math_summer_only ///
   re_impact_read_first_only ///
   re_impact_read_summer_only ///
   puptchr99 B4YRSTC_sch YKBASSAL_sch advdeg_sch ndstexp99 ///
   A4ABSEN_r_sch A4BEHVR_r_sch ///
   nschlnch99_percent ///
   S4NONWHTPCT ///
   trct_disadv_index2 ///
   c1r4rtht_r_mean c1r4mtht_r_mean ///
   c1r4mtht_r c1r4rtht_r ///
   cogstim_scale /// 
   magebirth ///
   parprac_scale ///
   pmh_scale_ver_one_2 ///
   GENDER mmarriedbirth childweightlow ///
   RACE ///
   WKPARED P1HDEMP P1HMEMP ///
   P2INCOME P1HTOTAL  ///
   c2r4mtht_r c2r4rtht_r c3r4mtht_r c3r4rtht_r c4r4mtht_r c4r4rtht_r





/* mi impute */

set matsize 11000

mi impute chained ///
   (pmm, knn(5)) ///
	   c5r4mtht_r c5r4rtht_r c6r4mtht_r c6r4rtht_r c7r4mtht_r c7r4rtht_r ///
       re_impact_math_first_only ///
       re_impact_math_summer_only ///
       re_impact_read_first_only ///
       re_impact_read_summer_only ///
       puptchr99 B4YRSTC_sch YKBASSAL_sch advdeg_sch ndstexp99 ///
       A4ABSEN_r_sch A4BEHVR_r_sch ///
       nschlnch99_percent ///
       S4NONWHTPCT ///
       trct_disadv_index2 ///
       c1r4rtht_r_mean c1r4mtht_r_mean ///
       c1r4mtht_r c1r4rtht_r ///
       cogstim_scale /// 
       magebirth ///
       parprac_scale ///
       pmh_scale_ver_one_2 ///
       P2INCOME P1HTOTAL  ///
       c2r4mtht_r c2r4rtht_r c3r4mtht_r c3r4rtht_r c4r4mtht_r c4r4rtht_r ///
   (mlogit, augment) ///
	   GENDER ///
	   mmarriedbirth ///
	   childweightlow ///
	   RACE ///
	   P1HMEMP ///
	   P1HDEMP ///
	   WKPARED ///
   , dots add(50) rseed(123)





/* Recode categorical variables */

drop RACE_recoded P1HMEMP_recoded P1HDEMP_recoded WKPARED_recoded
label drop race employment education



recode RACE (6 7 8 = 6), gen(RACE_recoded)

label define race 1 "WHITE, NON-HISPANIC" 2 "BLACK OR AFRICAN AMERICAN, NON-HISPANIC" 3 "HISPANIC, RACE SPECIFIED" 4 "HISPANIC, RACE NOT SPECIFIED" 5 "ASIAN" 6 "OTHER"

label values RACE_recoded race

tab RACE
tab RACE_recoded



recode P1HMEMP (3 4 = 3), gen(P1HMEMP_recoded)
recode P1HDEMP (3 4 = 3), gen(P1HDEMP_recoded)

label define employment 1 "35 HOURS OR MORE PER WEEK" 2 "LESS THAN 35 HOURS PER WEEK" 3 "OTHER" 

label values P1HMEMP_recoded employment
label values P1HDEMP_recoded employment

tab P1HMEMP
tab P1HMEMP_recoded

tab P1HDEMP
tab P1HDEMP_recoded



recode WKPARED (1 2 = 1) (3 = 2) (4 = 3) (5 = 4) (6 = 5) (7 8 9 = 6), gen(WKPARED_recoded)

label define education 1 "LESS THAN HS DIPLOMA" 2 "HIGH SCHOOL DIPLOMA/EQUIVALENT" 3 "VOC/TECH PROGRAM" 4 "SOME COLLEGE" 5 "BACHELOR'S DEGREE" 6 "GRADUATE"
			 
label values WKPARED_recoded education

tab WKPARED
tab WKPARED_recoded





/* Regenerate impact score */

gen re_impact_math_ver1 = re_impact_math_first_only - re_impact_math_summer_only
gen re_impact_read_ver1 = re_impact_read_first_only - re_impact_read_summer_only

gen re_impact_math_ver2 = re_impact_math_first_only - .5*re_impact_math_summer_only
gen re_impact_read_ver2 = re_impact_read_first_only - .5*re_impact_read_summer_only

gen re_impact_math_ver3 = re_impact_math_first_only
gen re_impact_read_ver3 = re_impact_read_first_only





/*** Generate school disorder measure ***/

//                   Mean        Std. Dev. 
sum A4ABSEN_r_sch // .9172837    .7041561
sum A4BEHVR_r_sch // 2.60292     .6434299

gen A4ABSEN_r_sch_std = (A4ABSEN_r_sch - .9172837) / .7041561
gen A4BEHVR_r_sch_std = (A4BEHVR_r_sch - 2.60292) / .6434299

corr A4ABSEN_r_sch_std A4BEHVR_r_sch_std // 0.1704

gen school_disorder = (A4ABSEN_r_sch_std + A4BEHVR_r_sch_std) / 2

sum school_disorder

gen school_disorder_std = (school_disorder - .0000203) / .7649801





/*** Generate school resources measure ***/

pca puptchr99 B4YRSTC_sch YKBASSAL_sch advdeg_sch ndstexp99, cor com(1) 
/*

Principal components/correlation                 Number of obs    =    305,328
                                                 Number of comp.  =          1
                                                 Trace            =          5
    Rotation: (unrotated = principal)            Rho              =     0.3046

    --------------------------------------------------------------------------
       Component |   Eigenvalue   Difference         Proportion   Cumulative
    -------------+------------------------------------------------------------
           Comp1 |      1.52302      .274176             0.3046       0.3046
           Comp2 |      1.24885       .20731             0.2498       0.5544
           Comp3 |      1.04154      .324129             0.2083       0.7627
           Comp4 |       .71741       .24823             0.1435       0.9062
           Comp5 |       .46918            .             0.0938       1.0000
    --------------------------------------------------------------------------

Principal components (eigenvectors) 

    --------------------------------------
        Variable |    Comp1 | Unexplained 
    -------------+----------+-------------
       puptchr99 |  -0.3468 |       .8168 
     B4YRSTC_sch |   0.3756 |       .7851 
    YKBASSAL_sch |   0.4575 |       .6812 
      advdeg_sch |   0.3630 |       .7993 
       ndstexp99 |   0.6305 |       .3945 
    --------------------------------------

*/

predict school_resources

sum school_resources

gen school_resources_std = (school_resources - 7.96e-10) / 1.234109





/* Save dataset */

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\analytic-sample-post-mi.dta", replace

log close
