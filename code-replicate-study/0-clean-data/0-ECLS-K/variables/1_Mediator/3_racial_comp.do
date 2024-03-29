/*************************
STUDENT RACIAL COMPOSITION 
*************************/

/*
Suppressed
- S2PCTHSP
- S4-5-6-7HSPPCT

- S2-4-5-6-7INDPCT

- S2PCFPCT
- S2-4-5-6-7ASNPCT 

- S2-4-5-6-7BLKPCT 

- S2-4-5-6-7WHTPCT
*/

replace S2PCTHSP = .b if S2PCTHSP == -9 // NOT ASCERTAINED
replace S4HSPPCT = .b if S4HSPPCT == -9 // NOT ASCERTAINED
replace S4HSPPCT = .d if S4HSPPCT == -8 // DON'T KNOW
replace S5HSPPCT = .b if S5HSPPCT == -9 // NOT ASCERTAINED
replace S6HSPPCT = .b if S6HSPPCT == -9 // NOT ASCERTAINED
replace S7HSPPCT = .b if S7HSPPCT == -9 // NOT ASCERTAINED

replace S2INDPCT = .b if S2INDPCT == -9 // NOT ASCERTAINED
replace S4INDPCT = .b if S4INDPCT == -9 // NOT ASCERTAINED
replace S4INDPCT = .d if S4INDPCT == -8 // DON'T KNOW
replace S5INDPCT = .b if S5INDPCT == -9 // NOT ASCERTAINED
replace S6INDPCT = .b if S6INDPCT == -9 // NOT ASCERTAINED
replace S7INDPCT = .b if S7INDPCT == -9 // NOT ASCERTAINED

replace S2PCFPCT = .b if S2PCFPCT == -9 // NOT ASCERTAINED
replace S2ASNPCT = .b if S2ASNPCT == -9 // NOT ASCERTAINED
replace S4ASNPCT = .b if S4ASNPCT == -9 // NOT ASCERTAINED
replace S4ASNPCT = .d if S4ASNPCT == -8 // DON'T KNOW
replace S5ASNPCT = .b if S5ASNPCT == -9 // NOT ASCERTAINED
replace S6ASNPCT = .b if S6ASNPCT == -9 // NOT ASCERTAINED
replace S7ASNPCT = .b if S7ASNPCT == -9 // NOT ASCERTAINED

replace S2BLKPCT = .b if S2BLKPCT == -9 // NOT ASCERTAINED
replace S4BLKPCT = .b if S4BLKPCT == -9 // NOT ASCERTAINED
replace S4BLKPCT = .d if S4BLKPCT == -8 // DON'T KNOW
replace S5BLKPCT = .b if S5BLKPCT == -9 // NOT ASCERTAINED
replace S6BLKPCT = .b if S6BLKPCT == -9 // NOT ASCERTAINED
replace S7BLKPCT = .b if S7BLKPCT == -9 // NOT ASCERTAINED

replace S2WHTPCT = .b if S2WHTPCT == -9 // NOT ASCERTAINED
replace S4WHTPCT = .b if S4WHTPCT == -9 // NOT ASCERTAINED
replace S4WHTPCT = .d if S4WHTPCT == -8 // DON'T KNOW
replace S5WHTPCT = .b if S5WHTPCT == -9 // NOT ASCERTAINED
replace S6WHTPCT = .b if S6WHTPCT == -9 // NOT ASCERTAINED
replace S7WHTPCT = .b if S7WHTPCT == -9 // NOT ASCERTAINED

gen S2PCFASNPCT = S2PCFPCT + S2ASNPCT

gen S4NONWHTPCT = 100 - S4WHTPCT
