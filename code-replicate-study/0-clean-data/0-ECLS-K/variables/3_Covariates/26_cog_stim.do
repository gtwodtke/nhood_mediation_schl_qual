/**************************************************************************
THE LEVEL OF COGNITIVE STIMULATION PROVIDED IN A SUBJECT'S HOME ENVIRONMENT 
**************************************************************************/

/*

// Variables to consider

// Similar to the ones mentioned in the HOME scale

P1CHLAUD

P2NOENGL
P2DRAMA

P3DOWRIT
P3HISTOR
P3AMUSPK
P3BEACH
P3NTPARK
P3LRGCTY
P3RDBKTC
P3SWIML
P3TMSPRT
P3IDSPRT
P3SCOUT
P3DISCTV

P5RECMAG
P5RECNEW

P2CRAFTS, P3DOARTS

P2SPORT, P5SPTEVT

P2-5ZOO, P3ZOOS

P1-4-5TELLST
P1-4-5NATURE
P1-4-5BUILD
P1-4-5READBO

P2-5CONCRT, P3PLYCRT
P2-5MUSEUM, P3ARTSCI

P4-5RDWRNM, P3DOMATH

P1-4-5-6CHLBOO

P2-4-5-6LIBRAR
P2-4-5-6DANCE, P3DANCEL
P2-4-5-6ATHLET
P2-4-5-6CLUB
P2-4-5-6MUSIC, P3MUSICL
P2-4-5-6ARTCRF
P2-4-5-6ORGANZ

P1-2-4-5-6CHREAD

// Not mentioned in the HOME scale

P1CHLPIC
P1CHSESA

P2CULTUR
P2TCHMAT
P2ARTPRG
P2NONEDU

P3FAMWCH
P3RDALON
P3FAMCHO
P3OUTACT
P3PRTPLY
P3CRDGAM
P3DOARTS
P3COMGAM
P3COMEDU
P3CHLPRM
P3CRTOON
P3CHLVDO
P3EDUPRM
P3SPORTS
P3SITCOM
P3SOAPS
P3TLKSHO
P3NEWSHO

P5NEWMAG
P5BOOKS
P5LETNOT
P5INTRNT
P5HASDIC
P5HASCAL

P1-4-5SINGSO
P1-4-5HELPAR
P1-4-5CHORES
P1-4-5GAMES
P1-4-5BUILD
P1-4-5SPORT

P5-6INTACC
P5-6CMPINT
P5-6TVHOME

P3-4-5HWLGRD

P4-5-6CMPEDU

P2-4-5-6HOMECM
P2-4-5-6COMPWK

*/

// alpha command for wave 1 variables

global cogstim_vars P1READBO P1TELLST P1SINGSO P1HELPAR P1CHORES P1GAMES ///
P1NATURE P1BUILD P1SPORT P1CHLBOO P1CHLAUD P1CHLPIC P1CHREAD P1CHSESA

foreach v of global cogstim_vars {
	replace `v' = .b if `v' == -9 // NOT ASCERTAINED
	replace `v' = .c if `v' == -7 // REFUSED
	replace `v' = .d if `v' == -8 // DON'T KNOW
}

replace P1CHSESA = 2 if P1CHSESA == 3
replace P1CHSESA = 0 if P1CHSESA == 2

alpha P1READBO P1TELLST P1SINGSO P1HELPAR P1CHORES P1GAMES P1NATURE P1BUILD ///
P1SPORT P1CHLBOO P1CHLAUD P1CHLPIC P1CHREAD P1CHSESA, std gen(cogstim_scale)

// pca command for wave 1 variables

global cogstim_vars P1READBO P1TELLST P1SINGSO P1HELPAR P1CHORES P1GAMES /// 
P1NATURE P1BUILD P1SPORT P1CHLBOO P1CHLAUD P1CHLPIC P1CHREAD P1CHSESA

foreach v of global cogstim_vars {
	replace `v' = .b if `v' == -9 // NOT ASCERTAINED
	replace `v' = .c if `v' == -7 // REFUSED
	replace `v' = .d if `v' == -8 // DON'T KNOW
}

replace P1CHSESA = 2 if P1CHSESA == 3
replace P1CHSESA = 0 if P1CHSESA == 2

pca P1READBO P1TELLST P1SINGSO P1HELPAR P1CHORES P1GAMES P1NATURE P1BUILD ///
P1SPORT P1CHLBOO P1CHLAUD P1CHLPIC P1CHREAD P1CHSESA

predict cogstim_factor
