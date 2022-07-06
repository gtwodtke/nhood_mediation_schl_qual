/*************************************************
THE PROPORTION OF TEACHERS WITH AN ADVANCED DEGREE 
*************************************************/

/*
Suppressed
- D2-4-5-6-7HGHSTD

Not suppressed
- B1-2-4-5HGHSTD
*/

replace B1HGHSTD = .b if B1HGHSTD == -9 // NOT ASCERTAINED
replace B2HGHSTD = .b if B2HGHSTD == -9 // NOT ASCERTAINED
replace B4HGHSTD = .b if B4HGHSTD == -9 // NOT ASCERTAINED
replace B5HGHSTD = .b if B5HGHSTD == -9 // NOT ASCERTAINED

replace D2HGHSTD = .b if D2HGHSTD == -9 // NOT ASCERTAINED
replace D4HGHSTD = .b if D4HGHSTD == -9 // NOT ASCERTAINED
replace D5HGHSTD = .b if D5HGHSTD == -9 // NOT ASCERTAINED
replace D6HGHSTD = .b if D6HGHSTD == -9 // NOT ASCERTAINED
replace D7HGHSTD = .b if D7HGHSTD == -9 // NOT ASCERTAINED
