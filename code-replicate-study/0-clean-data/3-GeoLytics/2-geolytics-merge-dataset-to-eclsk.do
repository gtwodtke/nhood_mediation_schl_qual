log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\0-clean-data\6-geolytics-merge.log", replace

/********************************
GEOLYTICS MERGE DATASET TO ECLS-K
********************************/

/*

GeoLytics 1998 --> ECLS-K Fall 1998   (Round 1)
GeoLytics 1999 --> ECLS-K Spring 1999 (Round 2)
GeoLytics 1999 --> ECLS-K Fall 1999   (Round 3)
GeoLytics 2000 --> ECLS-K Spring 2000 (Round 4)
GeoLytics 2002 --> ECLS-K Spring 2002 (Round 5)

*/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child-all.dta", clear

destring tract1, replace
destring tract2, replace
destring tract3, replace
destring tract4, replace
destring tract5, replace

keep childid tract1 tract2 tract3 tract4 tract5

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child-all-keep.dta", replace

reshape long tract, i(childid) j(round)
rename tract geo2000
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Geocode\child-all-keep-long.dta", replace

merge m:1 geo2000 round using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\GeoLytics\ncdb_2000_cleaner.dta"

drop if _merge == 2
drop _merge

rename geo2000 tract

global stubs trct_pop trct_age0_17 trct_age65_up trct_age18_64 trct_lesshs ///
trct_hsgrad trct_colgrad trct_ffh trct_prof_mgr trct_poverty trct_wht ///
trct_blk trct_hsp trct_unemprt trct_welfare trct_disadv_index

reshape wide tract $stubs stusab ucounty councd region, i(childid) j(round)

rename childid CHILDID

merge 1:1 CHILDID using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\7-merged-data-keep-ccd-pss.dta"

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\8-merged-data-keep-ccd-pss-geolytics.dta", replace

log close
