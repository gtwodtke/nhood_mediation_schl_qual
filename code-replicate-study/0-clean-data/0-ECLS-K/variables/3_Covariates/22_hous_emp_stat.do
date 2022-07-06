/*********************************
HOUSEHOLD HEAD'S EMPLOYMENT STATUS 
*********************************/

/*
P1-4-5-6-7HMEMP
P1-4-5-6-7HDEMP
*/

local nums 1 4 5 6 7
foreach i of local nums {
	replace P`i'HMEMP = .a if P`i'HMEMP == -1 // NO MOTHER IN HOUSEHOLD
	replace P`i'HMEMP = .b if P`i'HMEMP == -9 // NOT ASCERTAINED
	
	replace P`i'HDEMP = .a if P`i'HDEMP == -1 // NO FATHER IN HOUSEHOLD
	replace P`i'HDEMP = .b if P`i'HDEMP == -9 // NOT ASCERTAINED
}

recode P1HMEMP (3 4 = 3), gen(P1HMEMP_recoded)
recode P1HDEMP (3 4 = 3), gen(P1HDEMP_recoded)

label define employment 1 "35 HOURS OR MORE PER WEEK" 2 "LESS THAN 35 HOURS PER WEEK" 3 "OTHER" 

label values P1HMEMP_recoded employment
label values P1HDEMP_recoded employment
