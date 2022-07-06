/**************************************************
THE AVERAGE LEVEL OF WORK EXPERIENCE AMONG TEACHERS 
**************************************************/

/*
Suppressed
- D2-4-5-6-7SCHLYR
- D5-6-7YRSTCH

Not suppressed
- B1-2-4YRSPRE
- B1-2-4YRSKIN
- B1-2-4YRSFST
- B1-2-4YRS2T5
- B1-2-4YRS6PL
- B1-2-4YRSESL
- B1-2-4YRSBIL
- B1-2-4YRSSPE
- B1-2-4YRSPE
- B1-2-4YRSART

- B4KYRSTC
- B4-5YRSTC
- J61YRSTC
- J62YRSTC
- J71YRSTC
- J72YRSTC

- B1-2-4-5YRSCH
- B4KYRSCH
*/

// (1) One way is to add up years of experience in different grades
replace B1YRSPRE = .b if B1YRSPRE == -9 // NOT ASCERTAINED
replace B2YRSPRE = .b if B2YRSPRE == -9 // NOT ASCERTAINED
replace B4YRSPRE = .b if B4YRSPRE == -9 // NOT ASCERTAINED

replace B1YRSKIN = .b if B1YRSKIN == -9 // NOT ASCERTAINED
replace B2YRSKIN = .b if B2YRSKIN == -9 // NOT ASCERTAINED
replace B4YRSKIN = .b if B4YRSKIN == -9 // NOT ASCERTAINED

replace B1YRSFST = .b if B1YRSFST == -9 // NOT ASCERTAINED
replace B2YRSFST = .b if B2YRSFST == -9 // NOT ASCERTAINED
replace B4YRSFST = . if B4YRSFST < 0

replace B1YRS2T5 = .b if B1YRS2T5 == -9 // NOT ASCERTAINED
replace B2YRS2T5 = .b if B2YRS2T5 == -9 // NOT ASCERTAINED
replace B4YRS2T5 = .b if B4YRS2T5 == -9 // NOT ASCERTAINED

replace B1YRS6PL = .b if B1YRS6PL == -9 // NOT ASCERTAINED
replace B2YRS6PL = .b if B2YRS6PL == -9 // NOT ASCERTAINED
replace B4YRS6PL = .b if B4YRS6PL == -9 // NOT ASCERTAINED

replace B1YRSESL = .b if B1YRSESL == -9 // NOT ASCERTAINED
replace B2YRSESL = .b if B2YRSESL == -9 // NOT ASCERTAINED
replace B4YRSESL = .b if B4YRSESL == -9 // NOT ASCERTAINED

replace B1YRSBIL = .b if B1YRSBIL == -9 // NOT ASCERTAINED
replace B2YRSBIL = .b if B2YRSBIL == -9 // NOT ASCERTAINED
replace B4YRSBIL = .b if B4YRSBIL == -9 // NOT ASCERTAINED

replace B1YRSSPE = .b if B1YRSSPE == -9 // NOT ASCERTAINED
replace B2YRSSPE = .b if B2YRSSPE == -9 // NOT ASCERTAINED
replace B4YRSSPE = .b if B4YRSSPE == -9 // NOT ASCERTAINED

replace B1YRSPE = .b if B1YRSPE == -9 // NOT ASCERTAINED
replace B2YRSPE = .b if B2YRSPE == -9 // NOT ASCERTAINED
replace B4YRSPE = .b if B4YRSPE == -9 // NOT ASCERTAINED

replace B1YRSART = .b if B1YRSART == -9 // NOT ASCERTAINED
replace B2YRSART = .b if B2YRSART == -9 // NOT ASCERTAINED
replace B4YRSART = .b if B4YRSART == -9 // NOT ASCERTAINED

local nums 1 2 4
foreach i of local nums {
	gen teacher_experience_`i' = B`i'YRSPRE + B`i'YRSKIN + B`i'YRSFST + B`i'YRS2T5 + B`i'YRS6PL + ///
						         B`i'YRSESL + B`i'YRSBIL + B`i'YRSSPE + B`i'YRSPE + B`i'YRSART
}

// However, this gives us some teachers with A LOT of experience

// (2) Another way is to directly focus on years of experience as school teacher
replace B4KYRSTC = .b if B4KYRSTC == -9 // NOT ASCERTAINED
replace B4YRSTC = .b if B4YRSTC == -9 // NOT ASCERTAINED
replace B4YRSTC = B4KYRSTC if B4YRSTC >= . & B4KYRSTC < .
replace B4YRSTC = (B4YRSTC+B4KYRSTC)/2 if B4YRSTC != B4KYRSTC & B4YRSTC < . & B4KYRSTC < .

replace B5YRSTC = .b if B5YRSTC == -9 // NOT ASCERTAINED
replace B5YRSTC = .c if B5YRSTC == -7 // REFUSED

replace J61YRSTC = .b if J61YRSTC == -9 // NOT ASCERTAINED
replace J62YRSTC = .b if J62YRSTC == -9 // NOT ASCERTAINED
replace J61YRSTC = J62YRSTC if J61YRSTC >= . & J62YRSTC < .
replace J61YRSTC = (J61YRSTC+J62YRSTC)/2 if J61YRSTC != J62YRSTC & J61YRSTC < . & J62YRSTC < .

replace J71YRSTC = .b if J71YRSTC == -9 // NOT ASCERTAINED
replace J72YRSTC = .b if J72YRSTC == -9 // NOT ASCERTAINED
replace J71YRSTC = J72YRSTC if J71YRSTC >= . & J72YRSTC < .
replace J71YRSTC = (J71YRSTC+J72YRSTC)/2 if J71YRSTC != J72YRSTC & J71YRSTC < . & J72YRSTC < .

// As the only wave common to (1) and (2) above is wave 4, we can look at the correlation between the variables in wave 4
corr B4YRSTC teacher_experience_4

// As a separate variable, we can also look at experience at a particular school
replace B1YRSCH = .b if B1YRSCH == -9 // NOT ASCERTAINED

replace B2YRSCH = .b if B2YRSCH == -9 // NOT ASCERTAINED

replace B4YRSCH = . if B4YRSCH < 0
replace B4KYRSCH = . if B4KYRSCH < 0
replace B4YRSCH = B4KYRSCH if B4YRSCH == .
replace B4YRSCH = (B4YRSCH+B4KYRSCH)/2 if B4YRSCH != B4KYRSCH & B4YRSCH != . & B4KYRSCH != . 

replace B5YRSCH = .b if B5YRSCH == -9 // NOT ASCERTAINED

// SCHLYR and YRSTCH

replace D2SCHLYR = .b if D2SCHLYR == -9 // NOT ASCERTAINED
replace D4SCHLYR = .b if D4SCHLYR == -9 // NOT ASCERTAINED
replace D5SCHLYR = .b if D5SCHLYR == -9 // NOT ASCERTAINED
replace D6SCHLYR = .b if D6SCHLYR == -9 // NOT ASCERTAINED
replace D7SCHLYR = .b if D7SCHLYR == -9 // NOT ASCERTAINED

replace D5YRSTCH = .b if D5YRSTCH == -9 // NOT ASCERTAINED
replace D6YRSTCH = .b if D6YRSTCH == -9 // NOT ASCERTAINED
replace D7YRSTCH = .b if D7YRSTCH == -9 // NOT ASCERTAINED
