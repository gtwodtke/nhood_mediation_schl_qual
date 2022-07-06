/*******************************************************
PARENTING PRACTICES AND INVOLVEMENT RELATED TO EDUCATION 
*******************************************************/

/*

// 1. Variables that can be found by searching HEQ in the layout file

// 1.a. The following can also be used for cognitive stimulation

P2NOENGL
P2DRAMA

P3SWIML
P3TMSPRT
P3IDSPRT
P3SCOUT
P3HISTOR
P3AMUSPK
P3BEACH
P3NTPARK
P3LRGCTY

P2CRAFTS, P3DOARTS

P2SPORT, P5SPTEVT

P2-5CONCRT, P3PLYCRT
P2-5MUSEUM, P3ARTSCI
P2-5ZOO, P3ZOOS

P2-4-5-6LIBRAR
P2-4-5-6DANCE, P3DANCEL
P2-4-5-6ATHLET
P2-4-5-6CLUB
P2-4-5-6MUSIC, P3MUSICL
P2-4-5-6ARTCRF
P2-4-5-6ORGANZ

P1-4-5-6CHLBOO

// 1.b. The following are probably not suitable for cognitive stimulation

P3VISLIB
P3STHLIB
P3VISBKS
P3STHBKS

P7GPARUL
P7HWKRUL
P7CHKHWK
P7RPTCRD
P7HLPSCI

P4-5RLBRCRD

P5-6TIMEHW

P4-5-6CLBRCRD
P4-5-6VLIBLY

P5-6-7HELPR
P5-6-7HELPM
P5-6-7OFTDHW
P5-6-7PLCHW

// 2. Variables that can be found by searching PIQ in the layout file

// 2.a. The following are similar to the variables mentioned by Greenman et al.

P2OFTEN1
P2OFTEN2
P2OFTEN4
P2OFTEN5
P2OFTEN6
P2OFTEN7

P3BTSNGT
P3ATTBTS

P1-4-5-6MTEACH

P2-4-5-6PAR14

P2-4-5-6-7ATTENB
P2-4-5-6-7ATTENP
P2-4-5-6-7PARGRP
P2-4-5-6-7ATTENS
P2-4-5-6-7VOLUNT
P2-4-5-6-7FUNDRS

// 2.b. The following are not mentioned by Greenman et al.

P2PARADV
P2OFTEN3

*/

// alpha command for wave 2 variables

global parprac_vars P2NOENGL P2DRAMA P2CRAFTS P2SPORT P2CONCRT P2MUSEUM P2ZOO ///
P2LIBRAR P2DANCE P2ATHLET P2CLUB P2MUSIC P2ARTCRF P2ORGANZ P2PAR14 P2ATTENB ///
P2ATTENP P2PARGRP P2ATTENS P2VOLUNT P2FUNDRS P2PARADV

foreach v of global parprac_vars {
	replace `v' = .a if `v' == -1 // NOT APPLICABLE
	replace `v' = .b if `v' == -9 // NOT ASCERTAINED
	replace `v' = .c if `v' == -7 // REFUSED
	replace `v' = .d if `v' == -8 // DON'T KNOW
}

replace P2NOENGL = 0 if P2NOENGL == 2
replace P2DRAMA = 0 if P2DRAMA == 2
replace P2CRAFTS = 0 if P2CRAFTS == 2
replace P2SPORT = 0 if P2SPORT == 2
replace P2CONCRT = 0 if P2CONCRT == 2
replace P2MUSEUM = 0 if P2MUSEUM == 2
replace P2ZOO = 0 if P2ZOO == 2
replace P2LIBRAR = 0 if P2LIBRAR == 2
replace P2DANCE = 0 if P2DANCE == 2
replace P2ATHLET = 0 if P2ATHLET == 2
replace P2CLUB = 0 if P2CLUB  == 2
replace P2MUSIC = 0 if P2MUSIC == 2
replace P2ARTCRF = 0 if P2ARTCRF == 2
replace P2ORGANZ = 0 if P2ORGANZ == 2
replace P2PAR14 = 0 if P2PAR14 == 2
replace P2ATTENB = 0 if P2ATTENB == 2
replace P2ATTENP = 0 if P2ATTENP == 2
replace P2PARGRP = 0 if P2PARGRP == 2
replace P2ATTENS = 0 if P2ATTENS == 2
replace P2VOLUNT = 0 if P2VOLUNT == 2
replace P2FUNDRS = 0 if P2FUNDRS == 2
replace P2PARADV = 0 if P2PARADV == 2

alpha P2NOENGL P2DRAMA P2CRAFTS P2SPORT P2CONCRT P2MUSEUM P2ZOO ///
P2LIBRAR P2DANCE P2ATHLET P2CLUB P2MUSIC P2ARTCRF P2ORGANZ P2PAR14 P2ATTENB ///
P2ATTENP P2PARGRP P2ATTENS P2VOLUNT P2FUNDRS P2PARADV, std gen(parprac_scale)

// pca command for wave 2 variables

global parprac_vars P2NOENGL P2DRAMA P2CRAFTS P2SPORT P2CONCRT P2MUSEUM P2ZOO ///
P2LIBRAR P2DANCE P2ATHLET P2CLUB P2MUSIC P2ARTCRF P2ORGANZ P2PAR14 P2ATTENB ///
P2ATTENP P2PARGRP P2ATTENS P2VOLUNT P2FUNDRS P2PARADV

foreach v of global parprac_vars {
	replace `v' = .a if `v' == -1 // NOT APPLICABLE
	replace `v' = .b if `v' == -9 // NOT ASCERTAINED
	replace `v' = .c if `v' == -7 // REFUSED
	replace `v' = .d if `v' == -8 // DON'T KNOW
}

replace P2NOENGL = 0 if P2NOENGL == 2
replace P2DRAMA = 0 if P2DRAMA == 2
replace P2CRAFTS = 0 if P2CRAFTS == 2
replace P2SPORT = 0 if P2SPORT == 2
replace P2CONCRT = 0 if P2CONCRT == 2
replace P2MUSEUM = 0 if P2MUSEUM == 2
replace P2ZOO = 0 if P2ZOO == 2
replace P2LIBRAR = 0 if P2LIBRAR == 2
replace P2DANCE = 0 if P2DANCE == 2
replace P2ATHLET = 0 if P2ATHLET == 2
replace P2CLUB = 0 if P2CLUB  == 2
replace P2MUSIC = 0 if P2MUSIC == 2
replace P2ARTCRF = 0 if P2ARTCRF == 2
replace P2ORGANZ = 0 if P2ORGANZ == 2
replace P2PAR14 = 0 if P2PAR14 == 2
replace P2ATTENB = 0 if P2ATTENB == 2
replace P2ATTENP = 0 if P2ATTENP == 2
replace P2PARGRP = 0 if P2PARGRP == 2
replace P2ATTENS = 0 if P2ATTENS == 2
replace P2VOLUNT = 0 if P2VOLUNT == 2
replace P2FUNDRS = 0 if P2FUNDRS == 2
replace P2PARADV = 0 if P2PARADV == 2

pca P2NOENGL P2DRAMA P2CRAFTS P2SPORT P2CONCRT P2MUSEUM P2ZOO ///
P2LIBRAR P2DANCE P2ATHLET P2CLUB P2MUSIC P2ARTCRF P2ORGANZ P2PAR14 P2ATTENB ///
P2ATTENP P2PARGRP P2ATTENS P2VOLUNT P2FUNDRS P2PARADV

predict parprac_factor
