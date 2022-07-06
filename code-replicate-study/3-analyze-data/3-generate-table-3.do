log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\3-analyze-data\2-table-3.log", replace

/*** TABLE 3 ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\analytic-sample-post-mi-R.dta", clear

keep if _mi_m != 0

sum cogstim_scale

sum magebirth

sum parprac_scale

sum pmh_scale_ver_one_2

sum P2INCOME

sum P1HTOTAL

// WKPARED (6 categories)
sum less_than_hs_diploma ///
    high_school_diploma_equivalent ///
    voc_tech_program ///
    some_college ///
    bachelor_s_degree ///
	graduate

// mmarriedbirth (2 categories)
sum mmarriedbirth

// P1HDEMP (3 categories)
sum d_thirty_five_hrs_or_more_pw ///
    d_less_than_thirty_five_hrs_pw ///
	d_emp_other

// P1HMEMP (3 categories)
sum m_thirty_five_hrs_or_more_pw ///
    m_less_than_thirty_five_hrs_pw ///
	m_emp_other

log close
