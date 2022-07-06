/*********************
SUBJECT'S BIRTH WEIGHT 
*********************/

/*
P1-2-3-4WEIGHP
P1-2-3-4WEIGHO
*/

replace P1WEIGHP = .b if P1WEIGHP == -9 // NOT ASCERTAINED
replace P1WEIGHP = .c if P1WEIGHP == -7 // REFUSED
replace P1WEIGHP = .d if P1WEIGHP == -8 // DON'T KNOW

replace P2WEIGHP = .a if P2WEIGHP == -1 // NOT APPLICABLE
replace P2WEIGHP = .b if P2WEIGHP == -9 // NOT ASCERTAINED
replace P2WEIGHP = .d if P2WEIGHP == -8 // DON'T KNOW

replace P3WEIGHP = .a if P3WEIGHP == -1 // NOT APPLICABLE
replace P3WEIGHP = .c if P3WEIGHP == -7 // REFUSED
replace P3WEIGHP = .d if P3WEIGHP == -8 // DON'T KNOW

replace P4WEIGHP = .a if P4WEIGHP == -1 // NOT APPLICABLE
replace P4WEIGHP = .b if P4WEIGHP == -9 // NOT ASCERTAINED
replace P4WEIGHP = .c if P4WEIGHP == -7 // REFUSED
replace P4WEIGHP = .d if P4WEIGHP == -8 // DON'T KNOW

replace P1WEIGHO = .b if P1WEIGHO == -9 // NOT ASCERTAINED
replace P1WEIGHO = .c if P1WEIGHO == -7 // REFUSED
replace P1WEIGHO = .d if P1WEIGHO == -8 // DON'T KNOW

replace P2WEIGHO = .a if P2WEIGHO == -1 // NOT APPLICABLE
replace P2WEIGHO = .b if P2WEIGHO == -9 // NOT ASCERTAINED
replace P2WEIGHO = .d if P2WEIGHO == -8 // DON'T KNOW

replace P3WEIGHO = .a if P3WEIGHO == -1 // NOT APPLICABLE
replace P3WEIGHO = .d if P3WEIGHO == -8 // DON'T KNOW

replace P4WEIGHO = .a if P4WEIGHO == -1 // NOT APPLICABLE
replace P4WEIGHO = .b if P4WEIGHO == -9 // NOT ASCERTAINED
replace P4WEIGHO = .d if P4WEIGHO == -8 // DON'T KNOW
