/**************************************************
ECLS-K KEEP ONLY NECESSARY VARIABLES IN MERGED DATA
**************************************************/

set maxvar 32000
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\2-merged-data-with-new-variables.dta", clear

keep CHILDID PARENTID S1_ID S2_ID S3_ID S4_ID S5_ID S6_ID S7_ID ///
C1R4RSCL C2R4RSCL C3R4RSCL C4R4RSCL C5R4RSCL C6R4RSCL C7R4RSCL ///
C1R4RTSC C2R4RTSC C3R4RTSC C4R4RTSC C5R4RTSC C6R4RTSC C7R4RTSC ///
C1R4MSCL C2R4MSCL C3R4MSCL C4R4MSCL C5R4MSCL C6R4MSCL C7R4MSCL ///
C1R4MTSC C2R4MTSC C3R4MTSC C4R4MTSC C5R4MTSC C6R4MTSC C7R4MTSC ///
F4YRRND ///
P3SUMSCH ///
FKCHGSCH R3R2SCHG R4R2SCHG R4R3SCHG ///
C1ASMTDD C1ASMTMM C1ASMTYY C2ASMTDD C2ASMTMM C2ASMTYY ///
C3ASMTDD C3ASMTMM C3ASMTYY C4ASMTDD C4ASMTMM C4ASMTYY ///
U2SCHBDD U2SCHBMM U2SCHBYY U2SCHEDD U2SCHEMM U2SCHEYY ///
U4SCHBDD U4SCHBMM U4SCHBYY U4SCHEDD U4SCHEMM U4SCHEYY ///
R4URBAN ///
S4MINOR ///
S4FLNCH S4FLCH_I ///
S4RLNCH S4RLCH_I ///
S4SCTYP ///
S2ELILNC S4ELILNC S5ELILNC S6ELILNC S7ELILNC ///
S2FLCH_I S4FLCH_I S5FLCH_I S6FLCH_I S7FLCH_I ///
S2ANUMCH S4ANUMCH S5ANUMCH S6ANUMCH S7ANUMCH ///
S2BNUMCH S4BNUMCH S5BNUMCH S6BNUMCH ///
S2NUMCH S4NUMCH S5NUMCH S6NUMCH S7NUMCH ///
S2FLNCH_u S4FLNCH_u S5FLNCH_u S6FLNCH_u S7FLNCH_u ///
S2PCTHSP ///
S4HSPPCT S5HSPPCT S6HSPPCT S7HSPPCT ///
S2INDPCT S4INDPCT S5INDPCT S6INDPCT S7INDPCT ///
S2PCFPCT ///
S2ASNPCT S4ASNPCT S5ASNPCT S6ASNPCT S7ASNPCT ///
S2BLKPCT S4BLKPCT S5BLKPCT S6BLKPCT S7BLKPCT ///
S2WHTPCT S4WHTPCT S5WHTPCT S6WHTPCT S7WHTPCT ///
S2PCFASNPCT ///
S2TCHFTE S4TCHFTE puptch_ver_one_2 puptch_ver_one_4 ///
S2FTETOT S4FTETOT ///
P2HOWPAY P4HOWPAY P5HOWPAY P6HOWPAY P7HOWPAY ///
B1YRSPRE B2YRSPRE B4YRSPRE B1YRSKIN B2YRSKIN B4YRSKIN ///
B1YRSFST B2YRSFST B4YRSFST B1YRS2T5 B2YRS2T5 B4YRS2T5 ///
B1YRS6PL B2YRS6PL B4YRS6PL B1YRSESL B2YRSESL B4YRSESL ///
B1YRSBIL B2YRSBIL B4YRSBIL B1YRSSPE B2YRSSPE B4YRSSPE ///
B1YRSPE B2YRSPE B4YRSPE B1YRSART B2YRSART B4YRSART ///
teacher_experience_1 teacher_experience_2 teacher_experience_4 ///
B4KYRSTC B4YRSTC B5YRSTC J61YRSTC J62YRSTC J71YRSTC J72YRSTC ///
B1YRSCH B2YRSCH B4YRSCH B4KYRSCH B5YRSCH ///
D2SCHLYR D4SCHLYR D5SCHLYR D6SCHLYR D7SCHLYR ///
D5YRSTCH D6YRSTCH D7YRSTCH ///
S2LOSLRY S4LOSLRY S2HISLRY S4HISLRY S7STRSAL ///
YKBASSAL YKMERPAY YKEMPBEN ///
B1HGHSTD B2HGHSTD B4HGHSTD B5HGHSTD ///
D2HGHSTD D4HGHSTD D5HGHSTD D6HGHSTD D7HGHSTD ///
A2ABSEN A4ABSEN A5ABSEN G6ABSEN M6ABSEN N6ABSEN GMN6ABSEN G7ABSENT M7ABSENT  N7ABSENT ///
A1BEHVR A2BEHVR A4BEHVR A5BEHVR /// 
G6BEHVR G7BEHVR M6BEHVR M7BEHVR N6BEHVR N7BEHVR GMN6BEHVR GMN7BEHVR ///
C7LOCUS C7CONCPT ///
repeat4 T4GLVL repeat5 T5GLVL repeat6 T6GLVL repeat7 T7GLVL repeat_ver_one repeat_ver_two ///
C5THIRD C6FIFTH U2REPEAT E4GRADE E5GRADE E6ENRGR E7ENROL ///
RACE WKRACETH W1RACETH W3RACETH W5RACETH W8RACETH ///
GENDER ///
P1WEIGHP P2WEIGHP P3WEIGHP P4WEIGHP P1WEIGHO P2WEIGHO P3WEIGHO P4WEIGHO ///
P1HMAGE P2HMAGE P4HMAGE P5HMAGE P6HMAGE P7HMAGE P1BMAGE /// 
DOBMM DOBDD DOBYY childage magebirth ///
WKHMOMAR WKBMOMAR W1MOMAR mmarriedbirth pmarriedbirth ///
WKPARED WKMOMED WKDADED W1PARED W3PARED W5PARED W8PARED ///
W1MOMED W3MOMED W5MOMED W8MOMED W1DADED W3DADED W5DADED W8DADED ///
P1HMEMP P4HMEMP P5HMEMP P6HMEMP P7HMEMP ///
P1HDEMP P4HDEMP P5HDEMP P6HDEMP P7HDEMP ///
P4INCCAT P5INCCAT P6INCCAT P7INCCAT W1INCCAT W3INCCAT W5INCCAT W8INCCAT ///
P4HOUSIT P5HOUSIT P7OWNRNT P7OWNRNT_new ///
P2BOTHER P5BOTHER P7BOTHER P2APPETI P5APPETI P7APPETI ///
P2BLUE P5BLUE P7BLUE P2KPMIND P5KPMIND P7KPMIND ///
P2DEPRES P5DEPRES P7DEPRES P2EFFORT P5EFFORT P7EFFORT ///
P2FEARFL P5FEARFL P7FEARFL P2RESTLS P5RESTLS P7RESTLS ///
P2TALKLS P5TALKLS P7TALKLS P2LONELY P5LONELY P7LONELY ///
P2SAD P5SAD P7SAD P2NOTGO P5NOTGO P7NOTGO ///
pmh_scale_ver_one_2 pmh_scale_ver_one_5 pmh_scale_ver_one_7 ///
pmh_scale_ver_two_2 pmh_scale_ver_two_5 pmh_scale_ver_two_7 ///
P1READBO P1TELLST P1SINGSO P1HELPAR P1CHORES P1GAMES ///
P1NATURE P1BUILD P1SPORT P1CHLBOO P1CHLAUD P1CHLPIC P1CHREAD P1CHSESA ///
cogstim_scale cogstim_factor ///
P2NOENGL P2DRAMA P2CRAFTS P2SPORT P2CONCRT P2MUSEUM P2ZOO ///
P2LIBRAR P2DANCE P2ATHLET P2CLUB P2MUSIC P2ARTCRF P2ORGANZ P2PAR14 P2ATTENB ///
P2ATTENP P2PARGRP P2ATTENS P2VOLUNT P2FUNDRS P2PARADV ///
parprac_scale parprac_factor ///
R3CCDLEA R4CCDLEA R3CCDSID R4CCDSID R3SCHPIN R4SCHPIN R3STSID R4STSID ///
R5CCDLEA R5CCDSID R5SCHPIN R5STSID ///
R6CCDLEA R6CCDSID R6SCHPIN R6STSID ///
R7CCDLEA R7CCDSID R7SCHPIN R7STSID ///
A5_T_ID B5_T_ID E5_T_ID D2T_ID D4T_ID D5T_ID D6T_ID D7T_ID D5_T_ID J61T_ID ///
J62T_ID J71T_ID J72T_ID T1_ID T2_ID T4_ID T5_ID T5_T_ID ///
F5CASSOR F6CASSOR P5CHLDID P6CHLDID P7CHLDID ///
F5PIDISP F6PIDISP F7PIDISP P1DADID P2DADID P4DADID P5DADID P6DADID P7DADID ///
P1MOMID P2MOMID P4MOMID P5MOMID P6MOMID P7MOMID P5RESID P6RESID P7RESID ///
K5_S_ID L5_S_ID S5_ST_ID S6_ST_ID S5_S_ID U5_S_ID ///
P3SMREQ ///
P2INCOME P1HTOTAL S4NONWHTPCT RACE_recoded P1HMEMP_recoded P1HDEMP_recoded WKPARED_recoded ///
C1CW0 C2CW0 C3CW0 C4CW0 ///
c1r4rtht_r c1r4mtht_r c2r4rtht_r c2r4mtht_r c3r4rtht_r c3r4mtht_r c4r4rtht_r c4r4mtht_r c5r4rtht_r c5r4mtht_r c6r4rtht_r c6r4mtht_r c7r4rtht_r c7r4mtht_r





save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\3-merged-data-keep.dta", replace
