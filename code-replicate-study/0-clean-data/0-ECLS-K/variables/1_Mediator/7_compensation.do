/*****************************************
THE AVERAGE COMPENSATION LEVEL OF TEACHERS 
*****************************************/

/*
S2-4LOSLRY
S2-4HISLRY

S7STRSAL
*/

replace S2LOSLRY = .b if S2LOSLRY == -9 // NOT ASCERTAINED

replace S4LOSLRY = .b if S4LOSLRY == -9 // NOT ASCERTAINED
replace S4LOSLRY = .d if S4LOSLRY == -8 // DON'T KNOW

replace S2HISLRY = .b if S2HISLRY == -9 // NOT ASCERTAINED

replace S4HISLRY = .b if S4HISLRY == -9 // NOT ASCERTAINED
replace S4HISLRY = .d if S4HISLRY == -8 // DON'T KNOW

replace S7STRSAL = .b if S7STRSAL == -9 // NOT ASCERTAINED
replace S7STRSAL = .c if S7STRSAL == -7 // REFUSED

// YK Variables

replace YKBASSAL = .b if YKBASSAL == -9 // NOT ASCERTAINED
replace YKMERPAY = .b if YKMERPAY == -9 // NOT ASCERTAINED
replace YKEMPBEN = .b if YKEMPBEN == -9 // NOT ASCERTAINED
