/****************************************************
PSS GENERATE VARIABLES AFTER MERGING WITH ECLS-K, CCD
****************************************************/

/*** INPUT DATA ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\6-merged-data-keep-ccd-pss-temp.dta", clear

/*** CREATE SCHOOL RACIAL COMPOSITION VARIABLES ***/

// PERCENT BLACK

gen npschblk99=black99/member99
replace npschblk99=. if (npschblk99>-999 & npschblk99<0) | (npschblk99>1 & npschblk99<999) 
label variable npschblk99 "PRIVATE SCHOOL PERCENT BLACK - 1999" 

gen npschblk01=black01/member01 
replace npschblk01=. if (npschblk01>-999 & npschblk01<0) | (npschblk01>1 & npschblk01<999) 
label variable npschblk01 "PRIVATE SCHOOL PERCENT BLACK - 2001" 

gen npschblk03=black03/member03
replace npschblk03=. if (npschblk03>-999 & npschblk03<0) | (npschblk03>1 & npschblk03<999) 
label variable npschblk03 "PRIVATE SCHOOL PERCENT BLACK - 2003" 

gen npschblk06=black06/member06
replace npschblk06=. if (npschblk06>-999 & npschblk06<0) | (npschblk06>1 & npschblk06<999) 
label variable npschblk06 "PRIVATE SCHOOL PERCENT BLACK - 2006" 

// PERCENT NON-HISPANIC WHITE

gen npschwht99=white99/member99 
replace npschwht99=. if (npschwht99>-999 & npschwht99<0) | (npschwht99>1 & npschwht99<999) 
label variable npschwht99 "PRIVATE SCHOOL PERCENT NON-HISPANIC WHITE - 1999" 

gen npschwht01=white01/member01 
replace npschwht01=. if (npschwht01>-999 & npschwht01<0) | (npschwht01>1 & npschwht01<999) 
label variable npschwht01 "PRIVATE SCHOOL PERCENT NON-HISPANIC WHITE - 2001" 

gen npschwht03=white03/member03 
replace npschwht03=. if (npschwht03>-999 & npschwht03<0) | (npschwht03>1 & npschwht03<999) 
label variable npschwht03 "PRIVATE SCHOOL PERCENT NON-HISPANIC WHITE - 2003" 

gen npschwht06=white06/member06
replace npschwht06=. if (npschwht06>-999 & npschwht06<0) | (npschwht06>1 & npschwht06<999) 
label variable npschwht06 "PRIVATE SCHOOL PERCENT NON-HISPANIC WHITE - 2006" 

// PERCENT ASIAN OR PACIFIC ISLANDER

gen npschasian99=asian99/member99
replace npschasian99=. if (npschasian99>-999 & npschasian99<0) | (npschasian99>1 & npschasian99<999) 
label variable npschasian99 "PRIVATE SCHOOL PERCENT ASIAN OR PACIFIC ISLANDER - 1999" 

gen npschasian01=asian01/member01 
replace npschasian01=. if (npschasian01>-999 & npschasian01<0) | (npschasian01>1 & npschasian01<999) 
label variable npschasian01 "PRIVATE SCHOOL PERCENT ASIAN OR PACIFIC ISLANDER - 2001" 

gen npschasian03=asian03/member03
replace npschasian03=. if (npschasian03>-999 & npschasian03<0) | (npschasian03>1 & npschasian03<999) 
label variable npschasian03 "PRIVATE SCHOOL PERCENT ASIAN OR PACIFIC ISLANDER - 2003" 

gen npschasian06=asian06/member06
replace npschasian06=. if (npschasian06>-999 & npschasian06<0) | (npschasian06>1 & npschasian06<999) 
label variable npschasian06 "PRIVATE SCHOOL PERCENT ASIAN OR PACIFIC ISLANDER - 2006" 

// PERCENT AMERICAN INDIAN OR ALASKA NATIVE

gen npscham99=am99/member99
replace npscham99=. if (npscham99>-999 & npscham99<0) | (npscham99>1 & npscham99<999) 
label variable npscham99 "PRIVATE SCHOOL PERCENT AMERICAN INDIAN OR ALASKA NATIVE - 1999" 

gen npscham01=am01/member01
replace npscham01=. if (npscham01>-999 & npscham01<0) | (npscham01>1 & npscham01<999) 
label variable npscham01 "PRIVATE SCHOOL PERCENT AMERICAN INDIAN OR ALASKA NATIVE - 2001" 

gen npscham03=am03/member03
replace npscham03=. if (npscham03>-999 & npscham03<0) | (npscham03>1 & npscham03<999) 
label variable npscham03 "PRIVATE SCHOOL PERCENT AMERICAN INDIAN OR ALASKA NATIVE - 2003" 

gen npscham06=am06/member06 
replace npscham06=. if (npscham06>-999 & npscham06<0) | (npscham06>1 & npscham06<999) 
label variable npscham06 "PRIVATE SCHOOL PERCENT AMERICAN INDIAN OR ALASKA NATIVE - 2006" 

// PERCENT HISPANIC

gen npschhisp99=hisp99/member99
replace npschhisp99=. if (npschhisp99>-999 & npschhisp99<0) | (npschhisp99>1 & npschhisp99<999) 
label variable npschhisp99 "PRIVATE SCHOOL PERCENT HISPANIC - 1999" 

gen npschhisp01=hisp01/member01
replace npschhisp01=. if (npschhisp01>-999 & npschhisp01<0) | (npschhisp01>1 & npschhisp01<999) 
label variable npschhisp01 "PRIVATE SCHOOL PERCENT HISPANIC - 2001" 

gen npschhisp03=hisp03/member03
replace npschhisp03=. if (npschhisp03>-999 & npschhisp03<0) | (npschhisp03>1 & npschhisp03<999) 
label variable npschhisp03 "PRIVATE SCHOOL PERCENT HISPANIC - 2003" 

gen npschhisp06=hisp06/member06
replace npschhisp06=. if (npschhisp06>-999 & npschhisp06<0) | (npschhisp06>1 & npschhisp06<999) 
label variable npschhisp06 "PRIVATE SCHOOL PERCENT HISPANIC - 2006" 

/*** CREATE SCHOOL TEACHER-PUPIL RATIO VARIABLES ***/

gen npschtpr99=member99/fte99
replace npschtpr99=. if npschtpr99<1 | npschtpr99>40 
label variable npschtpr99 "PRIVATE SCHOOL TEACHER-PUPIL RATIO - 1999" 

gen npschtpr01=member01/fte01 
replace npschtpr01=. if npschtpr01<1 | npschtpr01>40 
label variable npschtpr01 "PRIVATE SCHOOL TEACHER-PUPIL RATIO - 2001" 

gen npschtpr03=member03/fte03 
replace npschtpr03=. if npschtpr03<1 | npschtpr03>40 
label variable npschtpr03 "PRIVATE SCHOOL TEACHER-PUPIL RATIO - 2003" 

gen npschtpr06=member06/fte06
replace npschtpr06=. if npschtpr06<1 | npschtpr06>40 
label variable npschtpr06 "PRIVATE SCHOOL TEACHER-PUPIL RATIO - 2006" 

/*** SAVE DATA ***/

save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\7-merged-data-keep-ccd-pss.dta", replace
