#delimit ;
capture log close ;
capture clear ;
capture program drop all ;
set more off ;

global input "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\GeoLytics\" ;
global output "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\GeoLytics\" ;
global library "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\GeoLytics\" ;

/**********************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Name: v01_create_ncdb_raw
Purpose: read in 2000 ncdb data
Notes:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
***********************************/

/********************************
INPUT AND MERGE RAW NCDB2000 DATA
*********************************/
insheet using "${input}NCDB2000_RAW_1.csv", clear ;
describe ;
sort geo2000 ;
save "${output}temp_ncdb_1.dta", replace ;

insheet using "${input}NCDB2000_RAW_2.csv", clear ;
describe ;
sort geo2000 ;
save "${output}temp_ncdb_2.dta", replace ;

use "${input}temp_ncdb_1.dta", clear ;
merge geo2000 using "${input}temp_ncdb_2.dta" ;
tab _merge ;
drop _merge ;
sort geo2000 ;
tab check ;
drop check ;

/***************
RENAME VARIABLES
****************/
rename	adult0n		adultn_2000	;
rename	adult7n		adultn_1970	;
rename	adult8n		adultn_1980	;
rename	adult9n		adultn_1990	;
rename	child0n		childn_2000	;
rename	child7n		childn_1970	;
rename	child8n		childn_1980	;
rename	child9n		childn_1990	;
rename	cmepr0d		cmeprd_2000	;
rename	cmepr0n		cmeprn_2000	;
rename	cmepr7d		cmeprd_1970	;
rename	cmepr7n		cmeprn_1970	;
rename	cmepr8d		cmeprd_1980	;
rename	cmepr8n		cmeprn_1980	;
rename	cmepr9d		cmeprd_1990	;
rename	cmepr9n		cmeprn_1990	;
rename	educ110		educ11_2000	;
rename	educ117		educ11_1970	;
rename	educ118		educ11_1980	;
rename	educ119		educ11_1990	;
rename	educ120		educ12_2000	;
rename	educ127		educ12_1970	;
rename	educ128		educ12_1980	;
rename	educ129		educ12_1990	;
rename	educ150		educ15_2000	;
rename	educ157		educ15_1970	;
rename	educ158		educ15_1980	;
rename	educ159		educ15_1990	;
rename	educ160		educ16_2000	;
rename	educ167		educ16_1970	;
rename	educ168		educ16_1980	;
rename	educ169		educ16_1990	;
rename	educ80		educ8_2000	;
rename	educ87		educ8_1970	;
rename	educ88		educ8_1980	;
rename	educ89		educ8_1990	;
rename	educpp0		educpp_2000	;
rename	educpp7		educpp_1970	;
rename	educpp8		educpp_1980	;
rename	educpp9		educpp_1990	;
rename	faltmx7		faltmx_1970	;
rename	faltmx8		faltmx_1980	;
rename	faltmxb9	faltmx_1990	;
rename	favinc0d	favincd_2000	;
rename	favinc7d	favincd_1970	;
rename	favinc8d	favincd_1980	;
rename	favinc9d	favincd_1990	;
rename	fay0m200	faltmx_2000		;
rename	ffh0d		ffhd_2000	;
rename	ffh0n		ffhn_2000	;
rename	ffh7d		ffhd_1970	;
rename	ffh7n		ffhn_1970	;
rename	ffh8d		ffhd_1980	;
rename	ffh8n		ffhn_1980	;
rename	ffh9d		ffhd_1990	;
rename	ffh9n		ffhn_1990	;
rename	fnoprt0d	fnoprtd_2000	;
rename	fnoprt7d	fnoprtd_1970	;
rename	fnoprt8d	fnoprtd_1980	;
rename	fnoprt9d	fnoprtd_1990	;
rename	forborn0	forborn_2000	;
rename	forborn7	forborn_1970	;
rename	forborn8	forborn_1980	;
rename	forborn9	forborn_1990	;
rename	hsdrop0d	hsdropd_2000	;
rename	hsdrop0n	hsdropn_2000	;
rename	hsdrop7d	hsdropd_1970	;
rename	hsdrop7n	hsdropn_1970	;
rename	hsdrop8d	hsdropd_1980	;
rename	hsdrop8n	hsdropn_1980	;
rename	hsdrop9d	hsdropd_1990	;
rename	hsdrop9n	hsdropn_1990	;
rename	mnoprt0d	mnoprtd_2000	;
rename	mnoprt7d	mnoprtd_1970	;
rename	mnoprt8d	mnoprtd_1980	;
rename	mnoprt9d	mnoprtd_1990	;
rename	natborn0	natborn_2000	;
rename	natborn7	natborn_1970	;
rename	natborn8	natborn_1980	;
rename	natborn9	natborn_1990	;
rename	occ10		occ1_2000	;
rename	occ17		occ1_1970	;
rename	occ18		occ1_1980	;
rename	occ19		occ1_1990	;
rename	occ20		occ2_2000	;
rename	occ27		occ2_1970	;
rename	occ28		occ2_1980	;
rename	occ29		occ2_1990	;
rename	occhu0		occhu_2000	;
rename	occhu7		occhu_1970	;
rename	occhu8		occhu_1980	;
rename	occhu9		occhu_1990	;
rename	old0n		oldn_2000	;
rename	old7n		oldn_1970	;
rename	old8n		oldn_1980	;
rename	old9n		oldn_1990	;
rename	ownocc0		ownocc_2000	;
rename	ownocc7		ownocc_1970	;
rename	ownocc8		ownocc_1980	;
rename	ownocc9		ownocc_1990	;
rename	povrat0d	povratd_2000	;
rename	povrat0n	povratn_2000	;
rename	povrat7d	povratd_1970	;
rename	povrat7n	povratn_1970	;
rename	povrat8d	povratd_1980	;
rename	povrat8n	povratn_1980	;
rename	povrat9d	povratd_1990	;
rename	povrat9n	povratn_1990	;
rename	shr0d		shrd_2000	;
rename	shr7d		shrd_1970	;
rename	shr8d		shrd_1980	;
rename	shr9d		shrd_1990	;
rename	shrblk0n	shrblkn_2000	;
rename	shrblk7n	shrblkn_1970	;
rename	shrblk8n	shrblkn_1980	;
rename	shrblk9n	shrblkn_1990	;
rename	shrhsp0n	shrhspn_2000	;
rename	shrhsp7n	shrhspn_1970	;
rename	shrhsp8n	shrhspn_1980	;
rename	shrhsp9n	shrhspn_1990	;
rename	shrwht0n	shrwhtn_2000	;
rename	shrwht7n	shrwhtn_1970	;
rename	shrwht8n	shrwhtn_1980	;
rename	shrwht9n	shrwhtn_1990	;
rename	smhse0d		smhsed_2000	;
rename	smhse0n		smhsen_2000	;
rename	smhse7d		smhsed_1970	;
rename	smhse7n		smhsen_1970	;
rename	smhse8d		smhsed_1980	;
rename	smhse8n		smhsen_1980	;
rename	smhse9d		smhsed_1990	;
rename	smhse9n		smhsen_1990	;
rename	tothsun0	tothsun_2000	;
rename	tothsun7	tothsun_1970	;
rename	tothsun8	tothsun_1980	;
rename	tothsun9	tothsun_1990	;
rename	trctpop0	trctpop_2000	;
rename	trctpop7	trctpop_1970	;
rename	trctpop8	trctpop_1980	;
rename	trctpop9	trctpop_1990	;
rename	unempt0d	unemptd_2000	;
rename	unempt0n	unemptn_2000	;
rename	unempt7d	unemptd_1970	;
rename	unempt7n	unemptn_1970	;
rename	unempt8d	unemptd_1980	;
rename	unempt8n	unemptn_1980	;
rename	unempt9d	unemptd_1990	;
rename	unempt9n	unemptn_1990	;
rename	welfar0d	welfard_2000	;
rename	welfar0n	welfarn_2000	;
rename	welfar7d	welfard_1970	;
rename	welfar7n	welfarn_1970	;
rename	welfar8d	welfard_1980	;
rename	welfar8n	welfarn_1980	;
rename	welfar9d	welfard_1990	;
rename	welfar9n	welfarn_1990	;

/*****************************************
LINEAR INTERPOLATION FOR INTERCENSAL YEARS
******************************************/
capture program drop interpolate ;
program define interpolate ;
	local var `1' ;
	local start_year `2' ;
	local end_year `3' ;
	local j=`start_year' + 1 ;
	local x=.9 ;
	local y=.1 ;
	while `j' <= `start_year' + 9 { ;
		gen `var'_`j' = `x'*`var'_`start_year'  + `y'*`var'_`end_year' ;
		local j = `j' + 1 ;
		local x = `x' - .1 ;
		local y = `y' + .1 ;
		} ;
end ;

capture macro drop vars ;
global vars 	
		adultn
		childn
		cmeprd
		cmeprn
		educ11
		educ12
		educ15
		educ16
		educ8
		educpp
		faltmx
		favincd
		ffhd
		ffhn
		fnoprtd
		forborn
		hsdropd
		hsdropn
		mnoprtd
		natborn
		occ1
		occ2
		occhu
		oldn
		ownocc
		povratd
		povratn
		shrd
		shrblkn
		shrhspn
		shrwhtn
		smhsed
		smhsen
		tothsun
		trctpop
		unemptd
		unemptn
		welfard
		welfarn
		;

foreach x of global vars { ; interpolate `x' 1970 1980 ; } ;
foreach x of global vars { ; interpolate `x' 1980 1990 ; } ;
foreach x of global vars { ; interpolate `x' 1990 2000 ; } ;

/*********************************
LINEAR EXTRAPOLATION FOR 2001-2005
**********************************/
foreach x of global vars { ;
	gen constant=`x'_1990 ;
	gen slope=(`x'_2000-`x'_1990)/(2000-1990) ;
	forval i=2001/2005 { ;
		gen `x'_`i'=constant+slope*(`i'-1990) ;
		} ;
	drop constant slope ;
	} ;

/***********
RESHAPE LONG
************/
capture macro drop stubs ;
global stubs 			
		adultn_
		childn_
		cmeprd_
		cmeprn_
		educ11_
		educ12_
		educ15_
		educ16_
		educ8_
		educpp_
		faltmx_
		favincd_
		ffhd_
		ffhn_
		fnoprtd_
		forborn_
		hsdropd_
		hsdropn_
		mnoprtd_
		natborn_
		occ1_
		occ2_
		occhu_
		oldn_
		ownocc_
		povratd_
		povratn_
		shrd_
		shrblkn_
		shrhspn_
		shrwhtn_
		smhsed_
		smhsen_
		tothsun_
		trctpop_
		unemptd_
		unemptn_
		welfard_
		welfarn_
		;

reshape long $stubs, i(geo2000) j(year) ;
keep if year>=1995 ;

keep 		
		geo2000
		year
		stusab
		ucounty 
		councd 
		region
		adultn_
		childn_
		cmeprd_
		cmeprn_
		educ11_
		educ12_
		educ15_
		educ16_
		educ8_
		educpp_
		faltmx_
		favincd_
		ffhd_
		ffhn_
		fnoprtd_
		forborn_
		hsdropd_
		hsdropn_
		mnoprtd_
		natborn_
		occ1_
		occ2_
		occhu_
		oldn_
		ownocc_
		povratd_
		povratn_
		shrd_
		shrblkn_
		shrhspn_
		shrwhtn_
		smhsed_
		smhsen_
		tothsun_
		trctpop_
		unemptd_
		unemptn_
		welfard_
		welfarn_
		;

/**********
RENAME VARS
***********/
rename	adultn_		adultn	;
rename	childn_		childn	;
rename	cmeprd_		cmeprd	;
rename	cmeprn_		cmeprn	;
rename	educ11_		educ11	;
rename	educ12_		educ12	;
rename	educ15_		educ15	;
rename	educ16_		educ16	;
rename	educ8_		educ8	;
rename	educpp_		educpp	;
rename	faltmx_		faltmx	;
rename	favincd_	favincd	;
rename	ffhd_		ffhd	;
rename	ffhn_		ffhn	;
rename	fnoprtd_	fnoprtd	;
rename	forborn_	forborn	;
rename	hsdropd_	hsdropd	;
rename	hsdropn_	hsdropn	;
rename	mnoprtd_	mnoprtd	;
rename	natborn_	natborn	;
rename	occ1_		occ1	;
rename	occ2_		occ2	;
rename	occhu_		occhu	;
rename	oldn_		oldn	;
rename	ownocc_		ownocc	;
rename	povratd_	povratd	;
rename	povratn_	povratn	;
rename	shrd_		shrd	;
rename	shrblkn_	shrblkn	;
rename	shrhspn_	shrhspn	;
rename	shrwhtn_	shrwhtn	;
rename	smhsed_		smhsed	;
rename	smhsen_		smhsen	;
rename	tothsun_	tothsun	;
rename	unemptd_	unemptd	;
rename	unemptn_	unemptn	;
rename	welfard_	welfard	;
rename	welfarn_	welfarn	;
rename	trctpop_	trct_pop ;

/**************
CREATE NEW VARS
***************/
/********************
Age Structure
-proportion age 0-17
-proportion age 18-64
-proportion age 65+
*********************/
gen trct_age0_17=childn/trct_pop ;
replace trct_age0_17=0 if trct_age0_17<0 ;
replace trct_age0_17=1 if trct_age0_17>1 ;
gen trct_age65_up=oldn/trct_pop ;
replace trct_age65_up=0 if trct_age65_up<0 ;
replace trct_age65_up=1 if trct_age65_up>1 ;
gen trct_age18_64 = 1-((oldn+childn)/trct_pop) ;
replace trct_age18_64=0 if trct_age18_64<0 ;
replace trct_age18_64=1 if trct_age18_64>1 ;
sum trct_age0_17-trct_age18_64 ;

/******************************************************
Education
-proportion of persons age 25+ with out HS diploma
-proportion of persons age 25+ with HS diploma
-proportion of persons age 25+ with some college
-proportion of persons age 25+ with with college degree
*******************************************************/
gen trct_lesshs=(educ8+educ11)/educpp ;
replace trct_lesshs=0 if trct_lesshs<0 ;
replace trct_lesshs=1 if trct_lesshs>1 ;
gen trct_hsgrad=educ12/educpp ;
replace trct_hsgrad=0 if trct_hsgrad<0 ;
replace trct_hsgrad=1 if trct_hsgrad>1 ;
gen trct_colgrad=educ16/educpp ;
replace trct_colgrad=0 if trct_colgrad<0 ;
replace trct_colgrad=1 if trct_colgrad>1 ;
sum trct_lesshs-trct_colgrad ;

/**********************************************************
Female Headed Families
-proportion of famlies with children that are female-headed
***********************************************************/
gen trct_ffh=ffhn/ffhd ;
replace trct_ffh=0 if trct_ffh<0 ;
replace trct_ffh=1 if trct_ffh>1 ;
sum trct_ffh ;

/*****************************************************************
Occupational Structure
-proportion of persons 16+ with professional/managerial occupation
******************************************************************/
gen trct_prof_mgr=(occ1+occ2)/(mnoprtd+fnoprtd) ;
replace trct_prof_mgr=0 if trct_prof_mgr<0 ;
replace trct_prof_mgr=1 if trct_prof_mgr>1 ;
sum trct_prof_mgr ;

/********************************************
Poverty
-proportion of individuals below poverty line
*********************************************/
gen trct_poverty=povratn/povratd ;
replace trct_poverty=0 if trct_poverty<0 ;
replace trct_poverty=1 if trct_poverty>1 ;
sum trct_poverty ;

/*******************
Racial structure
-proportion white
-proportion black
-proportion hispanic
********************/
gen trct_wht=shrwhtn/shrd ;
replace trct_wht=0 if trct_wht<0 ;
replace trct_wht=1 if trct_wht>1 ;
gen trct_blk=shrblkn/shrd ;
replace trct_blk=0 if trct_blk<0 ;
replace trct_blk=1 if trct_blk>1 ;
gen trct_hsp=shrhspn/shrd ;
replace trct_hsp=0 if trct_hsp<0 ;
replace trct_hsp=1 if trct_hsp>1 ;
sum trct_wht-trct_hsp ;

/*********************************************************
Unemployment rate
-proportion age 16+ in civilian labor force and unemployed
**********************************************************/
gen trct_unemprt=unemptn/unemptd ;
replace trct_unemprt=0 if trct_unemprt<0 ;
replace trct_unemprt=1 if trct_unemprt>1 ;
sum trct_unemprt ;

/******************************************************
Welfare
-proportion of households with public assistance income
*******************************************************/
gen trct_welfare=welfarn/welfard ;
replace trct_welfare=0 if trct_welfare<0 ;
replace trct_welfare=1 if trct_welfare>1 ;
sum trct_welfare ;

/********
DROP VARS
*********/
drop 
	adultn 
	childn 
	cmeprd 
	cmeprn 
	educ11 
	educ12 
	educ15 
	educ16
	educ8
	educpp
	faltmx
	favincd
	ffhd
	ffhn
	fnoprtd
	forborn
	hsdropd
	hsdropn
	mnoprtd
	natborn
	occ1
	occ2
	occhu
	oldn
	ownocc
	smhsed
	smhsen
	tothsun
	welfard
	welfarn
	;

/************************************
NEIGHBORHOOD DISADVANTAGE INDEX - PCA
*************************************/
pca trct_poverty trct_unemprt trct_welfare trct_ffh trct_lesshs trct_colgrad trct_prof_mgr, cor com(1) ;
predict trct_disadv_index ;

/***********
RESHAPE DATA
***********/
keep 
 	geo2000 
	year 
	stusab
	ucounty 
	councd 
	region 
	trct_pop
	trct_age0_17 
	trct_age65_up 
	trct_age18_64 
	trct_lesshs 
	trct_hsgrad 
	trct_colgrad 
	trct_ffh 
	trct_prof_mgr 
	trct_poverty 
	trct_wht 
	trct_blk 
	trct_hsp 
	trct_unemprt 
	trct_welfare
	trct_disadv_index
	;
	
/********
SAVE DATA
*********/

saveold "${output}ncdb_2000_clean.dta", replace ;
erase "${output}temp_ncdb_1.dta" ;
erase "${output}temp_ncdb_2.dta" ;
codebook ;

/***********
RESHAPE DATA
***********/
#delimit cr

capture macro drop stubs
global stubs trct_pop trct_age0_17 trct_age65_up trct_age18_64 trct_lesshs ///
trct_hsgrad trct_colgrad trct_ffh trct_prof_mgr trct_poverty trct_wht ///
trct_blk trct_hsp trct_unemprt trct_welfare trct_disadv_index

reshape wide $stubs, i(geo2000) j(year)
foreach v of global stubs {
	drop `v'1995 `v'1996 `v'1997 `v'2001 `v'2003 `v'2004 `v'2005
	rename `v'1998 `v'1
	rename `v'1999 `v'2
	gen			   `v'3	= `v'2
	rename `v'2000 `v'4
	rename `v'2002 `v'5
} 

reshape long $stubs, i(geo2000) j(round)

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\GeoLytics\ncdb_2000_cleaner.dta", replace
