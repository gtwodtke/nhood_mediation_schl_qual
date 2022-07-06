log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\0-clean-data\0-eclsk-merge-1.log", replace

/**********************
ECLS-K READ PUBLIC DATA
**********************/

/*

This step assumes that the corresponding child, school, and teacher .dat, .dct,
and .dat files for ECLS-K Kindergarten-Eighth Grade Public-use File have been 
downloaded from the NCES website from the link: https://nces.ed.gov/ecls/dataproducts.asp#K-8

In addition, the .dta errata file for theta scores needs to be downloaded as 
well from the same link.

*/

// clear
set more off
set maxvar 32767

// child
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\read\ECLSK_Kto8_child_STATA.do" nostop

// add errata to child
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\dta\eclsk_theta_errata.dta", clear
rename childid CHILDID 
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\eclsk_theta_errata2.dta", replace

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\dta\ECLSK_Kto8_child_STATA.dta", clear
merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\eclsk_theta_errata2.dta"
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\ECLSK_Kto8_child_STATA_R", replace

// teacher
clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\read\ECLSK_BaseYear_Teacher_STATA.do" nostop

// school
clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\read\ECLSK_BaseYear_School_STATA.do" nostop

log close
