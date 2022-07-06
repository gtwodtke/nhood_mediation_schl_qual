/****************************************************
HOUSEHOLD HEAD'S HIGHEST LEVEL OF COMPLETED EDUCATION 
****************************************************/

/*
Time invariant
- WKPARED (use this)
- WKMOMED
- WKDADED

Time variant
- W1-3-5-8PARED (use this)
- W1-3-5-8MOMED
- W1-3-5-8DADED
*/

replace WKPARED = . if WKPARED < 0

replace WKMOMED = .a if WKMOMED == -1 // NOT APPLICABLE
replace WKMOMED = .b if WKMOMED == -9 // NOT ASCERTAINED

replace WKDADED = .a if WKDADED == -1 // NOT APPLICABLE
replace WKDADED = .b if WKDADED == -9 // NOT ASCERTAINED

local nums 1 3 5 8
foreach i of local nums {
	replace W`i'PARED = . if W`i'PARED < 0
	replace W`i'MOMED = .a if W`i'MOMED == -1 // NOT APPLICABLE
	replace W`i'DADED = .a if W`i'DADED == -1 // NOT APPLICABLE
}

recode WKPARED (1 2 = 1) (3 = 2) (4 = 3) (5 = 4) (6 = 5) (7 8 9 = 6), gen(WKPARED_recoded)

label define education 1 "LESS THAN HS DIPLOMA" 2 "HIGH SCHOOL DIPLOMA/EQUIVALENT" 3 "VOC/TECH PROGRAM" 4 "SOME COLLEGE" 5 "BACHELOR'S DEGREE" 6 "GRADUATE"
			 
label values WKPARED_recoded education
