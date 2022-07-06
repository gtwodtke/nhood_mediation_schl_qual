/************
FAMILY INCOME 
************/

/*
Continuous
- P2INCOME
- W1INCOME 
- WKINCOME
- P4-5-6-7TINCTH

Ordinal
- P4-5-6-7INCCAT
- W1-3-5-8INCCAT
- P2INCLOW
- P2INCHI

- P2-4-5-6-7HILOW
*/

local nums 4 5 6 7
foreach i of local nums {
	replace P`i'INCCAT = .a if P`i'INCCAT == -1 // NOT APPLICABLE
	replace P`i'INCCAT = .b if P`i'INCCAT == -9 // NOT ASCERTAINED
	replace P`i'INCCAT = .c if P`i'INCCAT == -7 // REFUSED
	replace P`i'INCCAT = .d if P`i'INCCAT == -8 // DON'T KNOW
}

replace P4INCCAT = W1INCCAT if P4INCCAT >= .
replace P5INCCAT = W3INCCAT if P5INCCAT >= .
replace P6INCCAT = W5INCCAT if P6INCCAT >= .
replace P7INCCAT = W8INCCAT if P7INCCAT >= .

local nums 4 5 6 7
foreach i of local nums {
	replace P`i'INCCAT = 2500 if P`i'INCCAT == 1
	replace P`i'INCCAT = 7500 if P`i'INCCAT == 2
	replace P`i'INCCAT = 12500 if P`i'INCCAT == 3
	replace P`i'INCCAT = 17500 if P`i'INCCAT == 4
	replace P`i'INCCAT = 22500 if P`i'INCCAT == 5
	replace P`i'INCCAT = 27500 if P`i'INCCAT == 6
	replace P`i'INCCAT = 32500 if P`i'INCCAT == 7
	replace P`i'INCCAT = 37500 if P`i'INCCAT == 8
	replace P`i'INCCAT = 45000 if P`i'INCCAT == 9
	replace P`i'INCCAT = 62500 if P`i'INCCAT == 10
	replace P`i'INCCAT = 87500 if P`i'INCCAT == 11
	replace P`i'INCCAT = 150000 if P`i'INCCAT == 12
	replace P`i'INCCAT = 300000 if P`i'INCCAT == 13
}

replace P2INCOME = .a if P2INCOME == -1
replace P2INCOME = .b if P2INCOME == -9
replace P2INCOME = .c if P2INCOME == -7
replace P2INCOME = .d if P2INCOME == -8
