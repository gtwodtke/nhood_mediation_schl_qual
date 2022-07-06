/************************
ECLS-K GENERATE VARIABLES
************************/

set maxvar 32767

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\1-merged-data.dta", clear

set matsize 11000

set more off

// Mediator
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\1_impact_measure_variables" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\2_free_lunch" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\3_racial_comp" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\4_pup_tch_ratio" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\5_expenditure" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\6_work_exp" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\7_compensation" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\8_adv_degree" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\9_pupil_absen" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\1_Mediator\10_disrup_class" nostop

// Outcome
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\2_Outcome\11_read_achiev" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\2_Outcome\12_math_achiev" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\2_Outcome\13_locus" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\2_Outcome\14_self_con" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\2_Outcome\15_grade_rep" nostop

// Covariates
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\16_race" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\17_gender" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\18_bir_weight" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\19_mother_age" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\20_mother_marit" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\21_hous_lev_edu" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\22_hous_emp_stat" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\23_fam_income" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\24_home_own" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\25_mental_health" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\26_cog_stim" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\27_par_practices" nostop
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\variables\3_Covariates\28_hh_size" nostop

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\2-merged-data-with-new-variables.dta", replace
