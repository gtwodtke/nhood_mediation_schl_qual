/*******************
HOMEOWNERSHIP STATUS 
*******************/

/*
P4-5HOUSIT

P7OWNRNT
*/

replace P4HOUSIT = .b if P4HOUSIT == -9 // NOT ASCERTAINED
replace P4HOUSIT = .c if P4HOUSIT == -7 // REFUSED
replace P4HOUSIT = .d if P4HOUSIT == -8 // DON'T KNOW

replace P5HOUSIT = .b if P5HOUSIT == -9 // NOT ASCERTAINED
replace P5HOUSIT = .c if P5HOUSIT == -7 // REFUSED
replace P5HOUSIT = .d if P5HOUSIT == -8 // DON'T KNOW

replace P7OWNRNT = .b if P7OWNRNT == -9 // NOT ASCERTAINED
replace P7OWNRNT = .c if P7OWNRNT == -7 // REFUSED
replace P7OWNRNT = .d if P7OWNRNT == -8 // DON'T KNOW

gen P7OWNRNT_new = P7OWNRNT
replace P7OWNRNT_new = 1 if P7OWNRNT == 1
replace P7OWNRNT_new = 0 if P7OWNRNT == 2 | P7OWNRNT == 3
