log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\3-analyze-data\1-table-2.log", replace

/*** TABLE 2 ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\analytic-sample-post-mi-R.dta", clear

keep if _mi_m != 0

// n
codebook CHILDID

// k
codebook S1_ID S2_ID S3_ID S4_ID

// Treatment
sum trct_disadv_index2
gen mean_treat = .0509567
gen std_treat = 1.807812
gen trct_disadv_index2_std = (trct_disadv_index2-mean_treat)/std_treat
sum trct_disadv_index2_std

// School Poverty
sum nschlnch99_percent

// School Racial Composition
sum S4NONWHTPCT

// School Quality
sum re_impact_math re_impact_read
sum school_resources_std
sum school_disorder_std

// Gender (2 categories)
sum male female

// Race (5 categories)
sum white_non_hispanic ///
    black_or_aa_non_hispanic ///
    hispanic ///
    asian ///
	race_other

// Low Child Weight
sum childweightlow

log close
