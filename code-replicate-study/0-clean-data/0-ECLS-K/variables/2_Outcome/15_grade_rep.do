/***************
GRADE REPETITION 
***************/

/*
Suppressed
- C5THIRD 
- C6FIFTH
- U2REPEAT
- E4-5GRADE
- E6ENRGR
- E7ENROL

Not suppressed
- T4-5-6-7GLVL
- C5-6GRADE
- C5-6INGRAD

- A1-4REPK
- A4REP1ST
- A5REPEAT
- A1AREPK
- A1PREPK
- A1DREPK
*/

// Grade repetition indicators for different waves
gen repeat4 = 0
replace repeat4 = 1 if T4GLVL < 4
replace repeat4 = . if T4GLVL == -9 | T4GLVL == 6 | T4GLVL == .

gen repeat5 = 0
replace repeat5 = 1 if T5GLVL < 4
replace repeat5 = . if T5GLVL == -9 | T5GLVL == 7 | T5GLVL == . 

gen repeat6 = 0
replace repeat6 = 1 if T6GLVL < 5
replace repeat6 = . if T6GLVL == -9 | T6GLVL == 9 | T6GLVL == .

gen repeat7 = 0
replace repeat7 = 1 if T7GLVL < 8
replace repeat7 = . if T7GLVL == 13 | T7GLVL == . 

// (1) One way is to assign 1 if student repeated a grade at any point
gen repeat_ver_one = 0
replace repeat_ver_one = 1 if repeat4 == 1 | repeat5 == 1 | repeat6 == 1 | repeat7 == 1
replace repeat_ver_one = . if repeat4 == . | repeat5 == . | repeat6 == . | repeat7 == . 

// (2) Another way is to assign 1, 2, 3, or 4 depending on how many times student is behind his/her peers
gen repeat_ver_two = 0
replace repeat_ver_two = 4 if repeat4 == 1 & repeat5 == 1 & repeat6 == 1 & repeat7 == 1
replace repeat_ver_two = 3 if (repeat4 == 0 & repeat5 == 1 & repeat6 == 1 & repeat7 == 1) | ///
							  (repeat4 == 1 & repeat5 == 0 & repeat6 == 1 & repeat7 == 1) | ///
							  (repeat4 == 1 & repeat5 == 1 & repeat6 == 0 & repeat7 == 1) | ///
							  (repeat4 == 1 & repeat5 == 1 & repeat6 == 1 & repeat7 == 0)
replace repeat_ver_two = 2 if (repeat4 == 1 & repeat5 == 1 & repeat6 == 0 & repeat7 == 0) | ///
							  (repeat4 == 1 & repeat5 == 0 & repeat6 == 0 & repeat7 == 1) | ///
							  (repeat4 == 0 & repeat5 == 0 & repeat6 == 1 & repeat7 == 1) | ///
							  (repeat4 == 0 & repeat5 == 1 & repeat6 == 0 & repeat7 == 1) | ///
							  (repeat4 == 1 & repeat5 == 0 & repeat6 == 1 & repeat7 == 0) | ///
							  (repeat4 == 0 & repeat5 == 1 & repeat6 == 1 & repeat7 == 0)
replace repeat_ver_two = 1 if (repeat4 == 0 & repeat5 == 0 & repeat6 == 0 & repeat7 == 1) | ///
							  (repeat4 == 0 & repeat5 == 0 & repeat6 == 1 & repeat7 == 0) | ///
							  (repeat4 == 0 & repeat5 == 1 & repeat6 == 0 & repeat7 == 0) | ///
							  (repeat4 == 1 & repeat5 == 0 & repeat6 == 0 & repeat7 == 0)
replace repeat_ver_two = . if repeat_ver_one == .

// C5THIRD, C6FIFTH, U2REPEAT, E4-5GRADE, E6ENRGR, E7ENROL

replace C5THIRD = .b if C5THIRD == -9 // NOT ASCERTAINED
replace C6FIFTH = . if C6FIFTH < 0

replace U2REPEAT = .b if U2REPEAT == -9 // NOT ASCERTAINED

replace E4GRADE = .b if E4GRADE == -9 // NOT ASCERTAINED

replace E5GRADE = .a if E5GRADE == -1 // NOT APPLICABLE
replace E5GRADE = .b if E5GRADE == -9 // NOT ASCERTAINED

replace E6ENRGR = .b if E6ENRGR == -9 // NOT ASCERTAINED

replace E7ENROL = .b if E7ENROL == -9 // NOT ASCERTAINED
