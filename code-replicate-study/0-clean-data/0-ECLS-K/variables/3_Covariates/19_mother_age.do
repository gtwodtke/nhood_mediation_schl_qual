/******************************************
MOTHER'S AGE AT THE TIME A SUBJECT WAS BORN 
******************************************/

/*
P1-2-4-5-6-7HMAGE
P1BMAGE

DOBMM 
DOBDD 
DOBYY

P4AGEBIR

R1-2_KAGE 
R3-4-5-6-7AGE

P1OLDMOM

P1HMAFB 
P1BMAFB
*/

// age of current mother (in years)
replace P1HMAGE = .a if P1HMAGE == -1 // NOT APPLICABLE
replace P1HMAGE = .b if P1HMAGE == -9 // NOT ASCERTAINED

replace P2HMAGE = .a if P2HMAGE == -1 // NOT APPLICABLE
replace P2HMAGE = .b if P2HMAGE == -9 // NOT ASCERTAINED

replace P4HMAGE = .a if P4HMAGE == -1 // NOT APPLICABLE
replace P4HMAGE = .b if P4HMAGE == -9 // NOT ASCERTAINED

replace P5HMAGE = .a if P5HMAGE == -1 // NOT APPLICABLE
replace P5HMAGE = .b if P5HMAGE == -9 // NOT ASCERTAINED

replace P6HMAGE = .a if P6HMAGE == -1 // NOT APPLICABLE
replace P6HMAGE = .b if P6HMAGE == -9 // NOT ASCERTAINED
replace P6HMAGE = .c if P6HMAGE == -7 // REFUSED
replace P6HMAGE = .d if P6HMAGE == -8 // DON'T KNOW

replace P7HMAGE = .a if P7HMAGE == -1 // NOT APPLICABLE
replace P7HMAGE = .b if P7HMAGE == -9 // NOT ASCERTAINED

// age of nonresident biological mother (in years)
replace P1BMAGE = .a if P1BMAGE == -1 // NOT APPLICABLE
replace P1BMAGE = .b if P1BMAGE == -9 // NOT ASCERTAINED

replace DOBMM = .b if DOBMM == -9 // NOT ASCERTAINED
replace DOBDD = .b if DOBDD == -9 // NOT ASCERTAINED
replace DOBYY = .b if DOBYY == -9 // NOT ASCERTAINED

gen childage = 1998 - DOBYY

gen magebirth = P1BMAGE - childage
replace magebirth = P1HMAGE - childage if P1BMAGE >= .
replace magebirth = . if magebirth < 0
