/**********************************************************************************************************
THE PROPORTION OF STUDENTS WHO ARE ELIGIBLE FOR A FREE LUNCH THROUGH THE U.S. NATIONAL SCHOOL LUNCH PROGRAM 
**********************************************************************************************************/

/*
Suppressed
- S2-4-5-6-7ELILNC

Not suppressed
- S2-4-5-6-7FLCH_I 

- S2-4-5-6-7ANUMCH
- S2-4-5-6BNUMCH
*/

/* Existing Free Lunch Variables */

replace S2ELILNC = .b if S2ELILNC == -9 // NOT ASCERTAINED

replace S4ELILNC = .b if S4ELILNC == -9 // NOT ASCERTAINED
replace S4ELILNC = .d if S4ELILNC == -8 // DON'T KNOW

replace S5ELILNC = .b if S5ELILNC == -9 // NOT ASCERTAINED
replace S5ELILNC = .c if S5ELILNC == -7 // REFUSED
replace S5ELILNC = .d if S5ELILNC == -8 // DON'T KNOW

replace S6ELILNC = .b if S6ELILNC == -9 // NOT ASCERTAINED
replace S6ELILNC = .d if S6ELILNC == -8 // DON'T KNOW

replace S7ELILNC = .b if S7ELILNC == -9 // NOT ASCERTAINED
replace S7ELILNC = .d if S7ELILNC == -8 // DON'T KNOW

replace S2FLCH_I = .a if S2FLCH_I == -1 // NOT APPLICABLE
replace S4FLCH_I = .a if S4FLCH_I == -1 // NOT APPLICABLE
replace S5FLCH_I = .a if S5FLCH_I == -1 // NOT APPLICABLE
replace S6FLCH_I = .a if S6FLCH_I == -1 // NOT APPLICABLE
replace S7FLCH_I = .a if S7FLCH_I == -1 // NOT APPLICABLE

/* School Population */

replace S2ANUMCH = .b if S2ANUMCH == -9 // NOT ASCERTAINED
replace S4ANUMCH = .b if S4ANUMCH == -9 // NOT ASCERTAINED
replace S5ANUMCH = .b if S5ANUMCH == -9 // NOT ASCERTAINED
replace S6ANUMCH = .b if S6ANUMCH == -9 // NOT ASCERTAINED
replace S7ANUMCH = .b if S7ANUMCH == -9 // NOT ASCERTAINED

replace S2BNUMCH = .b if S2BNUMCH == -9 // NOT ASCERTAINED

replace S4BNUMCH = .b if S4BNUMCH == -9 // NOT ASCERTAINED
replace S4BNUMCH = .d if S4BNUMCH == -8 // DON'T KNOW

replace S5BNUMCH = .b if S5BNUMCH == -9 // NOT ASCERTAINED

replace S6BNUMCH = .b if S6BNUMCH == -9 // NOT ASCERTAINED
replace S6BNUMCH = .d if S6BNUMCH == -8 // DON'T KNOW

gen S2NUMCH = S2ANUMCH + S2BNUMCH
gen S4NUMCH = S4ANUMCH + S4BNUMCH
gen S5NUMCH = S5ANUMCH + S5BNUMCH
gen S6NUMCH = S6ANUMCH + S6BNUMCH
gen S7NUMCH = S7ANUMCH

/* New Free Lunch Variables */

gen S2FLNCH_u = (S2ELILNC / S2NUMCH) * 100
gen S4FLNCH_u = (S4ELILNC / S4NUMCH) * 100
gen S5FLNCH_u = (S5ELILNC / S5NUMCH) * 100
gen S6FLNCH_u = (S6ELILNC / S6NUMCH) * 100
gen S7FLNCH_u = (S7ELILNC / S7NUMCH) * 100

replace S2FLNCH_u = S2FLCH_I if S2FLNCH_u == .
replace S4FLNCH_u = S4FLCH_I if S4FLNCH_u == .
replace S5FLNCH_u = S5FLCH_I if S5FLNCH_u == .
replace S6FLNCH_u = S6FLCH_I if S6FLNCH_u == .
replace S7FLNCH_u = S7FLCH_I if S7FLNCH_u == .
