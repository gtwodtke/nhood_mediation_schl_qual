/*****************************************************
MOTHER'S MARITAL STATUS AT THE TIME A SUBJECT WAS BORN 
*****************************************************/

/*
WKHMOMAR

WKBMOMAR

W1MOMAR (use this)
*/

replace WKHMOMAR = .a if WKHMOMAR == -1 // NOT APPLICABLE
replace WKHMOMAR = .b if WKHMOMAR == -9 // NOT ASCERTAINED

replace WKBMOMAR = .a if WKBMOMAR == -1 // NOT APPLICABLE
replace WKBMOMAR = .b if WKBMOMAR == -9 // NOT ASCERTAINED

replace W1MOMAR = .b if W1MOMAR == -9 // NOT ASCERTAINED

gen mmarriedbirth = .
replace mmarriedbirth = WKBMOMAR
replace mmarriedbirth = WKHMOMAR if WKBMOMAR >= .
replace mmarriedbirth = 0 if mmarriedbirth == 2

gen pmarriedbirth = W1MOMAR // biological parents married at time of birth or not
