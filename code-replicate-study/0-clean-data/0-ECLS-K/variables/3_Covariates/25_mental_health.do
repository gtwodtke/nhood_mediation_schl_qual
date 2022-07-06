/*******************************************
THE PRIMARY CAREGIVER'S MENTAL HEALTH STATUS 
*******************************************/

/*
P2-5-7BOTHER
P2-5-7APPETI
P2-5-7BLUE
P2-5-7KPMIND
P2-5-7DEPRES
P2-5-7EFFORT
P2-5-7FEARFL
P2-5-7RESTLS
P2-5-7TALKLS
P2-5-7LONELY
P2-5-7SAD
P2-5-7NOTGO

P2RPNDHP
P2RPRVHP
P2BFNFHP
P2BFRVHP
P2SFNDHP
P2SFRVHP
*/

local nums 2 5 7
foreach i of local nums {
	replace P`i'BOTHER = .a if P`i'BOTHER == -1 // NOT APPLICABLE
	replace P`i'BOTHER = .b if P`i'BOTHER == -9 // NOT ASCERTAINED
	replace P`i'BOTHER = .c if P`i'BOTHER == -7 // REFUSED
	replace P`i'BOTHER = .d if P`i'BOTHER == -8 // DON'T KNOW
	
	replace P`i'APPETI = .a if P`i'APPETI == -1 // NOT APPLICABLE
	replace P`i'APPETI = .b if P`i'APPETI == -9 // NOT ASCERTAINED
	replace P`i'APPETI = .c if P`i'APPETI == -7 // REFUSED
	replace P`i'APPETI = .d if P`i'APPETI == -8 // DON'T KNOW
	
	replace P`i'BLUE = .a if P`i'BLUE == -1 // NOT APPLICABLE
	replace P`i'BLUE = .b if P`i'BLUE == -9 // NOT ASCERTAINED
	replace P`i'BLUE = .c if P`i'BLUE == -7 // REFUSED
	replace P`i'BLUE = .d if P`i'BLUE == -8 // DON'T KNOW
	
	replace P`i'KPMIND = .a if P`i'KPMIND == -1 // NOT APPLICABLE
	replace P`i'KPMIND = .b if P`i'KPMIND == -9 // NOT ASCERTAINED
	replace P`i'KPMIND = .c if P`i'KPMIND == -7 // REFUSED
	replace P`i'KPMIND = .d if P`i'KPMIND == -8 // DON'T KNOW
	
	replace P`i'DEPRES = .a if P`i'DEPRES == -1 // NOT APPLICABLE
	replace P`i'DEPRES = .b if P`i'DEPRES == -9 // NOT ASCERTAINED
	replace P`i'DEPRES = .c if P`i'DEPRES == -7 // REFUSED
	replace P`i'DEPRES = .d if P`i'DEPRES == -8 // DON'T KNOW
	
	replace P`i'EFFORT = .a if P`i'EFFORT == -1 // NOT APPLICABLE
	replace P`i'EFFORT = .b if P`i'EFFORT == -9 // NOT ASCERTAINED
	replace P`i'EFFORT = .c if P`i'EFFORT == -7 // REFUSED
	replace P`i'EFFORT = .d if P`i'EFFORT == -8 // DON'T KNOW
	
	replace P`i'FEARFL = .a if P`i'FEARFL == -1 // NOT APPLICABLE
	replace P`i'FEARFL = .b if P`i'FEARFL == -9 // NOT ASCERTAINED
	replace P`i'FEARFL = .c if P`i'FEARFL == -7 // REFUSED
	replace P`i'FEARFL = .d if P`i'FEARFL == -8 // DON'T KNOW
	
	replace P`i'RESTLS = .a if P`i'RESTLS == -1 // NOT APPLICABLE
	replace P`i'RESTLS = .b if P`i'RESTLS == -9 // NOT ASCERTAINED
	replace P`i'RESTLS = .c if P`i'RESTLS == -7 // REFUSED
	replace P`i'RESTLS = .d if P`i'RESTLS == -8 // DON'T KNOW
	
	replace P`i'TALKLS = .a if P`i'TALKLS == -1 // NOT APPLICABLE
	replace P`i'TALKLS = .b if P`i'TALKLS == -9 // NOT ASCERTAINED
	replace P`i'TALKLS = .c if P`i'TALKLS == -7 // REFUSED
	replace P`i'TALKLS = .d if P`i'TALKLS == -8 // DON'T KNOW
	
	replace P`i'LONELY = .a if P`i'LONELY == -1 // NOT APPLICABLE
	replace P`i'LONELY = .b if P`i'LONELY == -9 // NOT ASCERTAINED
	replace P`i'LONELY = .c if P`i'LONELY == -7 // REFUSED
	replace P`i'LONELY = .d if P`i'LONELY == -8 // DON'T KNOW
	
	replace P`i'SAD = .a if P`i'SAD == -1 // NOT APPLICABLE
	replace P`i'SAD = .b if P`i'SAD == -9 // NOT ASCERTAINED
	replace P`i'SAD = .c if P`i'SAD == -7 // REFUSED
	replace P`i'SAD = .d if P`i'SAD == -8 // DON'T KNOW
	
	replace P`i'NOTGO = .a if P`i'NOTGO == -1 // NOT APPLICABLE
	replace P`i'NOTGO = .b if P`i'NOTGO == -9 // NOT ASCERTAINED
	replace P`i'NOTGO = .c if P`i'NOTGO == -7 // REFUSED
	replace P`i'NOTGO = .d if P`i'NOTGO == -8 // DON'T KNOW
}

// (1) One way is to sum up individual items
local nums 2 5 7
foreach i of local nums {
	gen pmh_scale_ver_one_`i' = P`i'BOTHER + P`i'APPETI + P`i'BLUE + P`i'KPMIND + ///
	P`i'DEPRES + P`i'EFFORT + P`i'FEARFL + P`i'RESTLS + /// 
	P`i'TALKLS + P`i'LONELY + P`i'SAD + P`i'NOTGO
}

// (2) One way is to take average of individual items
local nums 2 5 7
foreach i of local nums {
	egen pmh_scale_ver_two_`i' = rmean(P`i'BOTHER P`i'APPETI P`i'BLUE P`i'KPMIND ///
	P`i'DEPRES P`i'EFFORT P`i'FEARFL P`i'RESTLS P`i'TALKLS P`i'LONELY P`i'SAD P`i'NOTGO)
}
