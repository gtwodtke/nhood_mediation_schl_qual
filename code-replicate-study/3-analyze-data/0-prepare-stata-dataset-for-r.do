/**************************
PREPARE STATA DATASET FOR R
**************************/

/*** Read data ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\analytic-sample-post-mi.dta", clear


/*** Generate dummies for categorical variables ***/

// GENDER

tab GENDER
tab GENDER, nolabel

gen male = .
replace male = 1 if GENDER == 1
replace male = 0 if GENDER != 1

gen female = .
replace female = 1 if GENDER == 2
replace female = 0 if GENDER != 2



// RACE

tab RACE_recoded
tab RACE_recoded, nolabel

gen white_non_hispanic = .
replace white_non_hispanic = 1 if RACE_recoded == 1
replace white_non_hispanic = 0 if RACE_recoded != 1

gen black_or_aa_non_hispanic = .
replace black_or_aa_non_hispanic = 1 if RACE_recoded == 2
replace black_or_aa_non_hispanic = 0 if RACE_recoded != 2

gen hispanic = .
replace hispanic = 1 if RACE_recoded == 3 | RACE_recoded == 4
replace hispanic = 0 if RACE_recoded != 3 & RACE_recoded != 4

gen asian = .
replace asian = 1 if RACE_recoded == 5
replace asian = 0 if RACE_recoded != 5

gen race_other = .
replace race_other = 1 if RACE_recoded == 6
replace race_other = 0 if RACE_recoded != 6



// WKPARED

tab WKPARED_recoded
tab WKPARED_recoded, nolabel

gen less_than_hs_diploma = . 
replace less_than_hs_diploma = 1 if WKPARED_recoded == 1
replace less_than_hs_diploma = 0 if WKPARED_recoded != 1

gen high_school_diploma_equivalent = .
replace high_school_diploma_equivalent = 1 if WKPARED_recoded == 2
replace high_school_diploma_equivalent = 0 if WKPARED_recoded != 2

gen voc_tech_program = .
replace voc_tech_program = 1 if WKPARED_recoded == 3
replace voc_tech_program = 0 if WKPARED_recoded != 3

gen some_college = .
replace some_college = 1 if WKPARED_recoded == 4
replace some_college = 0 if WKPARED_recoded != 4

gen bachelor_s_degree = .
replace bachelor_s_degree = 1 if WKPARED_recoded == 5
replace bachelor_s_degree = 0 if WKPARED_recoded != 5

gen graduate = .
replace graduate = 1 if WKPARED_recoded == 6
replace graduate = 0 if WKPARED_recoded != 6



// P1HDEMP

tab P1HDEMP_recoded
tab P1HDEMP_recoded, nolabel

gen d_thirty_five_hrs_or_more_pw = .
replace d_thirty_five_hrs_or_more_pw = 1 if P1HDEMP_recoded == 1
replace d_thirty_five_hrs_or_more_pw = 0 if P1HDEMP_recoded != 1

gen d_less_than_thirty_five_hrs_pw = .
replace d_less_than_thirty_five_hrs_pw = 1 if P1HDEMP_recoded == 2
replace d_less_than_thirty_five_hrs_pw = 0 if P1HDEMP_recoded != 2

gen d_emp_other = .
replace d_emp_other = 1 if P1HDEMP_recoded == 3
replace d_emp_other = 0 if P1HDEMP_recoded != 3



// P1HMEMP

tab P1HMEMP_recoded
tab P1HMEMP_recoded, nolabel

gen m_thirty_five_hrs_or_more_pw = .
replace m_thirty_five_hrs_or_more_pw = 1 if P1HMEMP_recoded == 1
replace m_thirty_five_hrs_or_more_pw = 0 if P1HMEMP_recoded != 1

gen m_less_than_thirty_five_hrs_pw = .
replace m_less_than_thirty_five_hrs_pw = 1 if P1HMEMP_recoded == 2
replace m_less_than_thirty_five_hrs_pw = 0 if P1HMEMP_recoded != 2

gen m_emp_other = .
replace m_emp_other = 1 if P1HMEMP_recoded == 3
replace m_emp_other = 0 if P1HMEMP_recoded != 3


/*** Keep only the necessary variables ***/

drop re_impact_math re_impact_read

rename re_impact_math_ver1 re_impact_math
rename re_impact_read_ver1 re_impact_read

keep c1r4rtht_r c1r4mtht_r c2r4rtht_r c2r4mtht_r c3r4rtht_r c3r4mtht_r c4r4rtht_r c4r4mtht_r c5r4rtht_r c5r4mtht_r c6r4rtht_r c6r4mtht_r c7r4rtht_r c7r4mtht_r ///
	 re_impact_math re_impact_read ///
	 re_impact_math_ver2 re_impact_read_ver2 ///
	 re_impact_math_ver3 re_impact_read_ver3 ///
	 re_impact_read_first_only re_impact_read_summer_only re_impact_math_first_only re_impact_math_summer_only ///
	 puptchr99 B4YRSTC_sch YKBASSAL_sch advdeg_sch ndstexp99 school_resources school_resources_std ///
	 A4ABSEN_r_sch A4BEHVR_r_sch school_disorder school_disorder_std ///
     nschlnch99_percent ///
	 S4NONWHTPCT ///
     trct_disadv_index2 ///
     cogstim_scale magebirth parprac_scale pmh_scale_ver_one_2 P2INCOME P1HTOTAL ///
	 mmarriedbirth ///
	 childweightlow ///
     GENDER male female ///
	 RACE_recoded white_non_hispanic black_or_aa_non_hispanic hispanic asian race_other ///
	 P1HMEMP_recoded m_thirty_five_hrs_or_more_pw m_less_than_thirty_five_hrs_pw m_emp_other ///
	 P1HDEMP_recoded d_thirty_five_hrs_or_more_pw d_less_than_thirty_five_hrs_pw d_emp_other ///
	 WKPARED_recoded less_than_hs_diploma high_school_diploma_equivalent voc_tech_program some_college bachelor_s_degree graduate ///
	 c1r4rtht_r_mean c1r4mtht_r_mean ///
	 S1_ID S2_ID S3_ID S4_ID ///
	 CHILDID ///
	 _mi_id _mi_miss _mi_m ///
	 C1CW0 C2CW0 C3CW0 C4CW0





/*** Save dataset in an old format ***/

saveold "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\analytic-sample-post-mi-R.dta", replace version(12)
