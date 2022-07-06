#delimit cr
capture log close 
capture clear all 

global data_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\" 
global log_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\5-eclsk11-analyses\" 

log using "${log_directory}5-create-eclsk11v5.log", replace 

/**************************************************************************
PROGRAM NAME: 5-create-eclsk11v5.do
AUTHOR: KW
PURPOSE: Clean NCDB neighborhood data for 2010 and merge with eclsk11v4.dta
NOTES: GW revised on 11/29/2021
***************************************************************************/

/******************
INPUT RAW NCDB DATA
*******************/
import delimited "${data_directory}ncdb\ncdb_raw.csv", encoding(ISO-8859-1) 

/**********************************
KEEP ONLY 2010 VARS AND RENAME VARS
***********************************/
/* Keep only the relevant 2010 vars */
keep geo2010 trctpop1 educ81a educ111a educ121a educ151a educa1a educ161a educpp1a ///
ffh1ad ffh1an occ11a occ21a indemp1a povrat1ad povrat1an unempt1an unempt1ad ///
tothsun1a ownocc1a shrwht1n shrblk1n

/* Rename */
rename trctpop1 	trctpop_2010 
rename educ81a 		educ8_2010 
rename educ111a 	educ11_2010 
rename educ121a 	educ12_2010 
rename educ151a 	educ15_2010 
rename educa1a 		educa_2010 
rename educ161a		educ16_2010 
rename educpp1a		educpp_2010 
rename ffh1ad		ffhd_2010 
rename ffh1an		ffhn_2010 
rename occ11a 		occ1_2010 
rename occ21a 		occ2_2010 
rename indemp1a		indemp_2010 
rename povrat1ad	povratd_2010 
rename povrat1an	povratn_2010
rename unempt1an	unemptn_2010
rename unempt1ad	unemptd_2010 
rename tothsun1a	tothsun_2010 
rename ownocc1a 	ownocc_2010 
rename shrwht1n		shrwhtn_2010 
rename shrblk1n 	shrblkn_2010 

sum trctpop_2010-ownocc_2010
format geo2010 %12.0f

/**********
OUTPUT DATA
***********/
save "${data_directory}ncdb/ncdbv1.dta", replace  

/*******************
CREATE NEW VARIABLES
********************/
/***EDUCATIONAL COMPOSITION***/
gen nhlesshs_2010=(educ8_2010+educ11_2010)/educpp_2010 
gen nhhsgrad_2010=(educ12_2010)/educpp_2010 
gen nhsomcol_2010=(educ15_2010+educa_2010)/educpp_2010 
gen nhcolgrd_2010=(educ16_2010)/educpp_2010 
foreach v in nhlesshs_2010 nhhsgrad_2010 nhsomcol_2010 nhcolgrd_2010 { 
	replace `v'=. if inrange(`v',1,99) 
	} 
sum nhlesshs_2010-nhcolgrd_2010 

/***FEMALE-HEADED FAMILIES WITH CHILDREN***/
gen nhfemhd_2010=ffhn_2010/ffhd_2010 
replace nhfemhd_2010=. if nhfemhd_2010>1 
sum nhfemhd_2010 

/***OCCUPATIONAL COMPOSITION***/
gen nhoccmgr_2010=(occ1_2010+occ2_2010)/indemp_2010 
replace nhoccmgr_2010=. if nhoccmgr_2010>1 
sum nhoccmgr_2010 

/***POVERTY RATE***/
gen nhpovrt_2010=povratn_2010/povratd_2010 
sum nhpovrt_2010 

/***UNEMPLOYMENT RATE*/
gen nhunemprt_2010=unemptn_2010/unemptd_2010
sum nhunemprt_2010 

/***OWNER-OCCUPIED HOUSING***/
gen nhownocp_2010=ownocc_2010/tothsun_2010 
replace nhownocp_2010=. if nhownocp_2010>1 
sum nhownocp_2010 

/***RACIAL COMPOSITION***/
gen nhshrwht_2010=shrwhtn_2010/trctpop_2010 
replace nhshrwht_2010=. if nhshrwht_2010>1 
sum nhshrwht_2010 

gen nhshrblk_2010=shrblkn_2010/trctpop_2010 
replace nhshrblk_2010=. if nhshrblk_2010>1 
sum nhshrblk_2010 

/***COMPOSITE NH ADVANTAGE INDEX***/
pca nhlesshs_2010 nhcolgrd_2010 nhfemhd_2010 nhoccmgr_2010 nhpovrt_2010 nhunemprt_2010
predict nhdadvg_2010 
gen nhadvg_2010 = nhdadvg_2010*(-1)
centile nhdadvg_2010, c(10 20 30 40 50 60 70 80 90) 
centile nhadvg_2010, c(10 20 30 40 50 60 70 80 90) 
sum nhdadvg_2010 
sum nhadvg_2010

/*********************
SAVE NCDB CLEANED DATA
**********************/
save "${data_directory}ncdb/ncdbv1.dta", replace  
sum trctpop_2010-nhadvg_2010
clear

/*****************************************
MERGE NCDB CLEANED DATA WITH ECLSK11V4.DTA
******************************************/
/* Merge */ 
use "${data_directory}eclsk11\eclsk11v4.dta"
destring p2centrc, gen(geo2010)

merge m:1 geo2010 using "${data_directory}ncdb/ncdbv1.dta"
drop if _merge == 2
drop _merge 

** Rename census tract codes for home and school 
local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
rename f`i'centrc hcensus`i'
rename p`i'centrc scensus`i'
}

local nums 1 2 3 4 5 6 7 8 9
foreach i of local nums {
destring hcensus`i', replace
destring scensus`i', replace
}

/* Save as eclsk11v5 dataset */
saveold "${data_directory}\eclsk11\eclsk11v5.dta", replace v(12)

clear
log close
