#delimit ;
capture log close ;
capture clear all ;
set more off ;

global dct_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\eclsk11\dataextract\" ;
global data_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\eclsk11\" ;
global log_directory "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\5-eclsk11-analyses\" ;

log using "${log_directory}1-create-eclsk11v1.log", replace ;


/******************************************************************
PROGRAM NAME: 1-create-eclsk11v.do
AUTHOR: KW
PURPOSE: Read in raw data from ecls-k 2011 extraction tool to stata
NOTES: GW revised on 11/19/2021
*******************************************************************/

/********************************
READ IN RAW DATA USING DICTIONARY
*********************************/
infile using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\eclsk11\dataextract\eclsk11_extract9.29.21.dct" ;
keep if  (X1PUBPRI == 1 | 
       X1PUBPRI == 2 | 
       X1PUBPRI == -1 | 
       X1PUBPRI == -9 | 
       X1PUBPRI == .); 
   keep if (X2PUBPRI == 1 | 
       X2PUBPRI == 2 | 
       X2PUBPRI == -1 | 
       X2PUBPRI == -9); 
   keep if (X3PUBPRI == 1 | 
       X3PUBPRI == 2 | 
       X3PUBPRI == -1 | 
       X3PUBPRI == -9 | 
       X3PUBPRI == .); 
   keep if (X4PUBPRI == 1 | 
       X4PUBPRI == 2 | 
       X4PUBPRI == -1 | 
       X4PUBPRI == -9 | 
       X4PUBPRI == .); 
   keep if (X5PUBPRI == 1 | 
       X5PUBPRI == 2 | 
       X5PUBPRI == -1 | 
       X5PUBPRI == -9 | 
       X5PUBPRI == .); 
   keep if (X6PUBPRI == 1 | 
       X6PUBPRI == 2 | 
       X6PUBPRI == -1 | 
       X6PUBPRI == -9 | 
       X6PUBPRI == .); 
   keep if (X7PUBPRI == 1 | 
       X7PUBPRI == 2 | 
       X7PUBPRI == -1 | 
       X7PUBPRI == -9 | 
       X7PUBPRI == .); 
   keep if (X8PUBPRI == 1 | 
       X8PUBPRI == 2 | 
       X8PUBPRI == -1 | 
       X8PUBPRI == -9 | 
       X8PUBPRI == .); 
   keep if (X9PUBPRI == 1 | 
       X9PUBPRI == 2 | 
       X9PUBPRI == -1 | 
       X9PUBPRI == -9 | 
       X9PUBPRI == .); 
   keep if (X1KSCTYP == 1 | 
       X1KSCTYP == 2 | 
       X1KSCTYP == 3 | 
       X1KSCTYP == 4 | 
       X1KSCTYP == -1 | 
       X1KSCTYP == -9 | 
       X1KSCTYP == .); 
   keep if (X2KSCTYP == 1 | 
       X2KSCTYP == 2 | 
       X2KSCTYP == 3 | 
       X2KSCTYP == 4 | 
       X2KSCTYP == -1 | 
       X2KSCTYP == -9); 
   keep if (X4SCTYP == 1 | 
       X4SCTYP == 2 | 
       X4SCTYP == 3 | 
       X4SCTYP == 4 | 
       X4SCTYP == -1 | 
       X4SCTYP == -9 | 
       X4SCTYP == .); 
   keep if (X6SCTYP == 1 | 
       X6SCTYP == 2 | 
       X6SCTYP == 3 | 
       X6SCTYP == 4 | 
       X6SCTYP == -1 | 
       X6SCTYP == -9 | 
       X6SCTYP == .); 
   keep if (X7SCTYP == 1 | 
       X7SCTYP == 2 | 
       X7SCTYP == 3 | 
       X7SCTYP == 4 | 
       X7SCTYP == -1 | 
       X7SCTYP == -9 | 
       X7SCTYP == .); 
   keep if (X8SCTYP == 1 | 
       X8SCTYP == 2 | 
       X8SCTYP == 3 | 
       X8SCTYP == 4 | 
       X8SCTYP == -1 | 
       X8SCTYP == -9 | 
       X8SCTYP == .); 
   keep if (X9SCTYP == 1 | 
       X9SCTYP == 2 | 
       X9SCTYP == 3 | 
       X9SCTYP == 4 | 
       X9SCTYP == -1 | 
       X9SCTYP == -9 | 
       X9SCTYP == .);
   label define FRMEALFLG
      0  "0: NO APPARENT ANOMALY IN REPORTED FIGURE"  
      1  "1: NUMBER OF STUDENTS, NOT PERCENT, LIKELY REPORTED"  
;
   label define IFP71F
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM SECOND GRADE"  
      2  "2: IMPUTED USING VALUE FROM EARLIER ROUND"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define _7COMPYY
      2014  "2014"  
;
   label define A1DBEHVR
      1  "1: GROUP MISBEHAVES VERY FREQUENTLY"  
      2  "2: GROUP MISBEHAVES FREQUENTLY"  
      3  "3: GROUP MISBEHAVES OCCASIONALLY"  
      4  "4: GROUP BEHAVES WELL"  
      5  "5: GROUP BEHAVES EXCEPTIONALLY WELL"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1ENJOY
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1HGHSTD
      1  "1: DID NOT COMPLETE HIGH SCHOOL"  
      2  "2: HIGH SCHOOL DIPLOMA OR EQUIVALENT/GED"  
      3  "3: SOME COLLEGE OR TECHNICAL OR VOCATIONAL SCHOOL"  
      4  "4: ASSOCIATE'S DEGREE"  
      5  "5: BACHELOR'S DEGREE"  
      6  "6: MASTER'S DEGREE"  
      7  "7: AN ADVANCED PROFESSIONAL DEGREE BEYOND A MASTER'S DEGREE"  
      8  "8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1HMWRK
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1MKDIFF
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1NATEXM
      1  "1: NOT TAKEN"  
      2  "2: TAKEN AND PASSED"  
      3  "3: TAKEN AND HAVE NOT YET PASSED"  
      4  "4: TAKEN AND AWAITING TEST RESULTS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1SMLGRP
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1STATCT
      1  "1: REGULAR OR STANDARD STATE CERTIFICATE OR ADVANCED PROF CERT"  
      2  "2: CERTIFICATE WITHOUT COMPLETION OF PROBATIONARY PERIOD"  
      3  "3: CERTIFICATE REQUIRING ADDITIONAL WORK TEACHING OR EXAM"  
      4  "4: CERTIFICATE ISSUED TO PERSONS NEEDING CERTIFICATION PROGRAM"  
      5  "5: I DO NOT HOLD ANY OF THE ABOVE CERTIFICATIONS IN THIS STATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1TEACH
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1TGEND
      1  "1: MALE"  
      2  "2: FEMALE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A1TIMDIS
      1  "1: LESS THAN 1/2 HOUR A DAY"  
      2  "2: 1/2 HOUR TO LESS THAN 1 HOUR A DAY"  
      3  "3: 1 TO LESS THAN 1 1/2 HOURS A DAY"  
      4  "4: 1 1/2 TO LESS THAN 2 HOURS A DAY"  
      5  "5: 2 TO LESS THAN 2 1/2 HOURS A DAY"  
      6  "6: 2 1/2 TO LESS THAN 3 HOURS A DAY"  
      7  "7: 3 HOURS OR MORE A DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2ACCPTD
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2ATTND
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2AUDIOV
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2BLNDWD
      1  "1: TAUGHT AT A HIGHER GRADE LEVEL"  
      2  "2: CHILDREN SHOULD ALREADY KNOW"  
      3  "3: ONCE A MONTH OR LESS"  
      4  "4: TWO OR THREE TIMES A MONTH"  
      5  "5: ONCE OR TWICE A WEEK"  
      6  "6: THREE OR FOUR TIMES A WEEK"  
      7  "7: DAILY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2CLASPA
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2CLSSPC
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2CNTNLR
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2COMPEQ
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2COPIER
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2COPRTV
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2COPSTF
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2DBEHVR
      1  "1: GROUP MISBEHAVES VERY FREQUENTLY"  
      2  "2: GROUP MISBEHAVES FREQUENTLY"  
      3  "3: GROUP MISBEHAVES OCCASIONALLY"  
      4  "4: GROUP BEHAVES WELL"  
      5  "5: GROUP BEHAVES EXCEPTIONALLY WELL"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2DIVMTH
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2DIVRD
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2EFFO
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2ENCOUR
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2ENJOY
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2FLLWDR
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2IGRPRJ
      1  "1: NEVER"  
      2  "2: ONE OR TWO TIMES A YEAR"  
      3  "3: ONE OR TWO TIMES A MONTH"  
      4  "4: ONE OR TWO TIMES A WEEK"  
      5  "5: THREE OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2IMPRVM
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2INDVDL
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2MANIPU
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2MISSIO
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2MKDIFF
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTART
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTDAN
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTHTR
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTMTH
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTMUS
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTPE
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTRDL
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTSCI
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2OFTSOC
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2PAPER
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2PAPRWR
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2PSUPP
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2RECJOB
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2SETPRI
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2SMLGRP
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2SOFTWA
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2STNDLO
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2STNDRD
      1  "1: NEVER"  
      2  "2: ONE OR TWO TIMES A YEAR"  
      3  "3: ONE OR TWO TIMES A MONTH"  
      4  "4: ONE OR TWO TIMES A WEEK"  
      5  "5: THREE OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TCHRMD
      1  "1: NEVER"  
      2  "2: ONE OR TWO TIMES A YEAR"  
      3  "3: ONE OR TWO TIMES A MONTH"  
      4  "4: ONE OR TWO TIMES A WEEK"  
      5  "5: THREE OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TEACH
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TOCLAS
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TOSTND
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXART
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXDAN
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXFOR
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXMTH
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXMUS
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXPE
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXRDLA
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXSCI
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXSOC
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXTBK
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2TXTHTR
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2USECMP
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2USEKIT
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2USEOTH
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2USETRD
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2VIDEO
      1  "1: I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2WRKSHT
      1  "1: NEVER"  
      2  "2: ONE OR TWO TIMES A YEAR"  
      3  "3: ONE OR TWO TIMES A MONTH"  
      4  "4: ONE OR TWO TIMES A WEEK"  
      5  "5: THREE OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A2WRKSMP
      1  "1: NEVER"  
      2  "2: ONE OR TWO TIMES A YEAR"  
      3  "3: ONE OR TWO TIMES A MONTH"  
      4  "4: ONE OR TWO TIMES A WEEK"  
      5  "5: THREE OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4ADDTO100F
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4ANCLS
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4ANSGRPH
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4ARR3OBJ
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4ATTRSHP
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4BEHVR
      1  "1: GROUP MISBEHAVES VERY FREQUENTLY"  
      2  "2: GROUP MISBEHAVES FREQUENTLY"  
      3  "3: GROUP MISBEHAVES OCCASIONALLY"  
      4  "4: GROUP BEHAVES WELL"  
      5  "5: GROUP BEHAVES EXCEPTIONALLY WELL"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4BSCPLT
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CHARPLOT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CLSBHV
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CLSPAR
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CLSPROP
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-5 DAYS"  
      3  "3: ON 6-10 DAYS"  
      4  "4: ON 11-15 DAYS"  
      5  "5: ON 16-20 DAYS"  
      6  "6: ON MORE THAN 20 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CMPXINF
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CMPXPRO
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CNSNSS
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CNT120F
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CNT20QTY
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4COMMSCI
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-5 DAYS"  
      3  "3: ON 6-10 DAYS"  
      4  "4: ON 11-15 DAYS"  
      5  "5: ON 16-20 DAYS"  
      6  "6: ON MORE THAN 20 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4COOPRT
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CREVNT
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CTADSUB
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4CULTRS
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4DESCHAR
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4DIMCOMP
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4DINFOS
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4DPWHMWK
      0  "0: 0 DAYS"  
      1  "1: 1 DAY"  
      2  "2: 2 DAYS"  
      3  "3: 3 DAYS"  
      4  "4: 4 DAYS"  
      5  "5: 5 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4DRWGRPH
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4EFFRT
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4EQLSIGN
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4ESTLNG
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4FICNONF
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4FIND10F
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4FLLDIR
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4GENCSP
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4GRPCHRT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-5 DAYS"  
      3  "3: ON 6-10 DAYS"  
      4  "4: ON 11-15 DAYS"  
      5  "5: ON 16-20 DAYS"  
      6  "6: ON MORE THAN 20 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4HGHSTD
      1  "1: DID NOT COMPLETE HIGH SCHOOL"  
      2  "2: HIGH SCHOOL DIPLOMA OR EQUIVALENT/GED"  
      3  "3: SOME COLLEGE OR TECHNICAL OR VOCATIONAL SCHOOL"  
      4  "4: ASSOCIATE'S DEGREE"  
      5  "5: BACHELOR'S DEGREE"  
      6  "6: MASTER'S DEGREE"  
      7  "7: AN ADVANCED PROFESSIONAL DEGREE BEYOND A MASTER'S DEGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4HISTORY
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4IMPPRG
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4INFPIEC
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4IRREGWD
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KCLSBHV
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KCLSPAR
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KCNSNSS
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KCOOPRT
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KDBEHVR
      1  "1: GROUP MISBEHAVES VERY FREQUENTLY"  
      2  "2: GROUP MISBEHAVES FREQUENTLY"  
      3  "3: GROUP MISBEHAVES OCCASIONALLY"  
      4  "4: GROUP BEHAVES WELL"  
      5  "5: GROUP BEHAVES EXCEPTIONALLY WELL"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KDPWHMWK
      0  "0: 0 DAYS"  
      1  "1: 1 DAY"  
      2  "2: 2 DAYS"  
      3  "3: 3 DAYS"  
      4  "4: 4 DAYS"  
      5  "5: 5 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KEFFRT
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KFLLDIR
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KHGHSTD
      1  "1: DID NOT COMPLETE HIGH SCHOOL"  
      2  "2: HIGH SCHOOL DIPLOMA OR EQUIVALENT/GED"  
      3  "3: SOME COLLEGE OR TECHNICAL OR VOCATIONAL SCHOOL"  
      4  "4: ASSOCIATE'S DEGREE"  
      5  "5: BACHELOR'S DEGREE"  
      6  "6: MASTER'S DEGREE"  
      7  "7: AN ADVANCED PROFESSIONAL DEGREE BEYOND A MASTER'S DEGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KIMPPRG
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KOFTFLN
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KPROJCT
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KSTNTST
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KTOCLSS
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KTOSTDR
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KTSTQZ
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KTXFLN
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KWKINDP
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KWKINDV
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KWKLGRP
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KWKPEER
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KWKSGRP
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KWRKSAM
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4KWRKSTS
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4LAWGVT
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4LNG2BY3F
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4LNGMULT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4MAINID
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4MAINTEXT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4MANPHO
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4MAPSKL
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4MEATOOL
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4NARRTV
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4NATRSC
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4NMRL120F
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4NUMQTY
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4NUTHLTH
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4OFTFLN
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4OPINION
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4PACEINT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4PARTEQL
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4PORTION
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4PREDCT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-5 DAYS"  
      3  "3: ON 6-10 DAYS"  
      4  "4: ON 11-15 DAYS"  
      5  "5: ON 16-20 DAYS"  
      6  "6: ON MORE THAN 20 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4PREDICT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4PROJCT
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4RDACCR
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4REASSUP
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4RELQTY
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4RELSYM
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4RETELL
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SEGWORD
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SENCTXT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SENSES
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SENSOBS
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-5 DAYS"  
      3  "3: ON 6-10 DAYS"  
      4  "4: ON 11-15 DAYS"  
      5  "5: ON 16-20 DAYS"  
      6  "6: ON MORE THAN 20 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SHDLGT
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SIDEQUA
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SIMDIFF
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SKIPCNT
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SLVADD3F
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SLVADSB
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SLVCOIN
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SLVUKNM
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SNDWRD
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4SOLSPC
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4STNTST
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4STTMTR
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4TELLTIME
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4TENONES
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4TOCLSS
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4TOSTDR
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4TRIQUAD
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4TSTQZ
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4TXFLN
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USEANTH
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USEAUBK
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USEBGBK
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USEBSL
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USEDECB
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USEGLOS
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USELEV
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USEMAN
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4USENEW
      1  "1: NEVER OR HARDLY EVER"  
      2  "2: ONCE OR TWICE A MONTH"  
      3  "3: ONCE OR TWICE A WEEK"  
      4  "4: ALMOST EVERY DAY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WETHER
      1  "1: TAUGHT IN MY CLASS OR CLASSES"  
      2  "2: NOT TAUGHT IN MY CLASS OR CLASSES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WHOTELL
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WKINDP
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WKINDV
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WKLGRP
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WKPEER
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WKSGRP
      1  "1: NO TIME"  
      2  "2: HALF HOUR OR LESS"  
      3  "3: ABOUT ONE HOUR"  
      4  "4: ABOUT TWO HOURS"  
      5  "5: ABOUT THREE HOURS"  
      6  "6: FOUR HOURS OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WRKSAM
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WRKSTS
      1  "1: NEVER"  
      2  "2: 1 OR 2 TIMES A YEAR"  
      3  "3: 3 TO 8 TIMES A YEAR"  
      4  "4: 1 OR 2 TIMES A MONTH"  
      5  "5: 1 OR 2 TIMES A WEEK"  
      6  "6: 3 OR MORE TIMES A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WRTTIME
      1  "1: NOT TAUGHT"  
      2  "2: ON 1-10 DAYS"  
      3  "3: ON 11-20 DAYS"  
      4  "4: ON 21-40 DAYS"  
      5  "5: ON 41-80 DAYS"  
      6  "6: ON MORE THAN 80 DAYS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A4WTBUSE
      1  "1: NOT AVAILABLE"  
      2  "2: NEVER"  
      3  "3: RARELY"  
      4  "4: SOMETIMES"  
      5  "5: OFTEN"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A6DIVRD
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define B2NATEXM
      1  "1: NOT TAKEN"  
      2  "2: TAKEN AND PASSED"  
      3  "3: TAKEN AND HAVE NOT YET PASSED"  
      4  "4: TAKEN AND AWAITING TEST RESULTS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define B2STATCT
      1  "1: REGULAR OR STANDARD STATE CERTIFICATE OR ADVANCED PROF CERT"  
      2  "2: CERTIFICATE WITHOUT COMPLETION OF PROBATIONARY PERIOD"  
      3  "3: CERTIFICATE REQUIRING ADDITIONAL WORK TEACHING OR EXAM"  
      4  "4: CERTIFICATE ISSUED TO PERSONS NEEDING CERTIFICATION PROGRAM"  
      5  "5: I DO NOT HOLD ANY OF THE ABOVE CERTIFICATIONS IN THIS STATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define B2TGEND
      1  "1: MALE"  
      2  "2: FEMALE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C1ATTLVL
      1  "1: UNABLE TO ATTEND"  
      2  "2: DIFFICULTY ATTENDING"  
      3  "3: ATTENTIVE"  
      4  "4: VERY ATTENTIVE"  
      5  "5: COMPLETE AND FULL ATTENTION"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C1COOPER
      1  "1: VERY UNCOOPERATIVE"  
      2  "2: UNCOOPERATIVE"  
      3  "3: MATTER OF FACT"  
      4  "4: COOPERATIVE"  
      5  "5: VERY COOPERATIVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C1MOTIVA
      1  "1: VERY LOW"  
      2  "2: LOW"  
      3  "3: AVERAGE"  
      4  "4: HIGH"  
      5  "5: VERY HIGH"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C2ATTLVL
      1  "1: UNABLE TO ATTEND"  
      2  "2: DIFFICULTY ATTENDING"  
      3  "3: ATTENTIVE"  
      4  "4: VERY ATTENTIVE"  
      5  "5: COMPLETE AND FULL ATTENTION"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C2COOPER
      1  "1: VERY UNCOOPERATIVE"  
      2  "2: UNCOOPERATIVE"  
      3  "3: MATTER OF FACT"  
      4  "4: COOPERATIVE"  
      5  "5: VERY COOPERATIVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C2MOTIVA
      1  "1: VERY LOW"  
      2  "2: LOW"  
      3  "3: AVERAGE"  
      4  "4: HIGH"  
      5  "5: VERY HIGH"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C3ATTLVL
      1  "1: UNABLE TO ATTEND"  
      2  "2: DIFFICULTY ATTENDING"  
      3  "3: ATTENTIVE"  
      4  "4: VERY ATTENTIVE"  
      5  "5: COMPLETE AND FULL ATTENTION"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C3COOPER
      1  "1: VERY UNCOOPERATIVE"  
      2  "2: UNCOOPERATIVE"  
      3  "3: MATTER OF FACT"  
      4  "4: COOPERATIVE"  
      5  "5: VERY COOPERATIVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C3MOTIVA
      1  "1: VERY LOW"  
      2  "2: LOW"  
      3  "3: AVERAGE"  
      4  "4: HIGH"  
      5  "5: VERY HIGH"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C4ATTLVL
      1  "1: UNABLE TO ATTEND"  
      2  "2: DIFFICULTY ATTENDING"  
      3  "3: ATTENTIVE"  
      4  "4: VERY ATTENTIVE"  
      5  "5: COMPLETE AND FULL ATTENTION"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C4COOPER
      1  "1: VERY UNCOOPERATIVE"  
      2  "2: UNCOOPERATIVE"  
      3  "3: MATTER OF FACT"  
      4  "4: COOPERATIVE"  
      5  "5: VERY COOPERATIVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define C4MOTIVA
      1  "1: VERY LOW"  
      2  "2: LOW"  
      3  "3: AVERAGE"  
      4  "4: HIGH"  
      5  "5: VERY HIGH"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define D2TEACH
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define F1ASMTMM
      1  "1: JANUARY"  
      2  "2: FEBRUARY"  
      3  "3: MARCH"  
      4  "4: APRIL"  
      5  "5: MAY"  
      6  "6: JUNE"  
      7  "7: JULY"  
      8  "8: AUGUST"  
      9  "9: SEPTEMBER"  
      10  "10: OCTOBER"  
      11  "11: NOVEMBER"  
      12  "12: DECEMBER"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define F1ASMTYY
      2010  "2010"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define F2ASMTMM
      1  "1: JANUARY"  
      2  "2: FEBRUARY"  
      3  "3: MARCH"  
      4  "4: APRIL"  
      5  "5: MAY"  
      6  "6: JUNE"  
      7  "7: JULY"  
      8  "8: AUGUST"  
      9  "9: SEPTEMBER"  
      10  "10: OCTOBER"  
      11  "11: NOVEMBER"  
      12  "12: DECEMBER"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define F2ASMTYY
      2011  "2011"  
      2012  "2012"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define F3ASMTYY
      2011  "2011"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define IFP4TINCTH
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM BASE YEAR (KG)"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define IFS6PCTFLN
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM PREVIOUS ROUND"  
      2  "2: IMPUTED USING VALUE FROM SCHOOL FRAME"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define IFX4FMEAL
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM BASE YEAR (KG)"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define IFX4PAR1OCC
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM BASE YEAR (KG)"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define IFX4PAR1SCR
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM BASE YEAR (KG)"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define IFX4PAR2OCC
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM BASE YEAR (KG)"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define IFX4PAR2SCR
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM BASE YEAR (KG)"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define IFX4RMEAL
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM BASE YEAR (KG)"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define IMPUTE
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED"  
;
   label define P1CURMAR
      1  "1: MARRIED"  
      2  "2: SEPARATED"  
      3  "3: DIVORCED"  
      4  "4: WIDOWED"  
      5  "5: NEVER MARRIED"  
      6  "6: CIVIL UNIONS/DOMESTIC PARTNERSHIP"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1DAD1F
      1  "1: BIRTH FATHER"  
      2  "2: ADOPTIVE FATHER"  
      3  "3: STEP FATHER"  
      4  "4: FOSTER FATHER/MALE GUARDIAN"  
      5  "5: OTHER MALE PARENT OR GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
;
   label define P1DAD2F
      1  "1: BIRTH FATHER"  
      2  "2: ADOPTIVE FATHER"  
      3  "3: STEP FATHER"  
      4  "4: FOSTER FATHER/MALE GUARDIAN"  
      5  "5: OTHER MALE PARENT OR GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
;
   label define P1EXPECT
      1  "1: TO RECEIVE LESS THAN HIGH SCHOOL DIPLOMA"  
      2  "2: TO GRADUATE FROM HIGH SCHOOL"  
      3  "3: TO ATTEND A VOCATIONAL OR TECHNICAL SCHOOL AFTER HIGH SCHOOL"  
      4  "4: TO ATTEND TWO OR MORE YEARS OF COLLEGE"  
      5  "5: TO FINISH A FOUR-OR FIVE-YEAR COLLEGE DEGREE"  
      6  "6: TO EARN A MASTER'S DEGREE OR EQUIVALENT"  
      7  "7: TO FINISH A PH.D., MD, OR OTHER ADVANCED DEGREE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1GAMES
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1HSCALE
      1  "1: EXCELLENT"  
      2  "2: VERY GOOD"  
      3  "3: GOOD"  
      4  "4: FAIR"  
      5  "5: POOR"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1MOM1F
      1  "1: BIRTH MOTHER"  
      2  "2: ADOPTIVE MOTHER"  
      3  "3: STEP MOTHER"  
      4  "4: FOSTER MOTHER OR FEMALE GUARDIAN"  
      5  "5: OTHER FEMALE PARENT OR GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
;
   label define P1MOM2F
      1  "1: BIRTH MOTHER"  
      2  "2: ADOPTIVE MOTHER"  
      3  "3: STEP MOTHER"  
      4  "4: FOSTER MOTHER OR FEMALE GUARDIAN"  
      5  "5: OTHER FEMALE PARENT OR GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
;
   label define P1NUMBRS
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1PRMLNG
      0  "0: ENGLISH"  
      1  "1: ARABIC"  
      2  "2: CHINESE LANGUAGE/DIALECT"  
      3  "3: FILIPINO LANGUAGE"  
      4  "4: FRENCH"  
      5  "5: GERMAN"  
      6  "6: GREEK"  
      7  "7: ITALIAN"  
      8  "8: JAPANESE"  
      9  "9: KOREAN"  
      10  "10: POLISH"  
      11  "11: PORTUGUESE"  
      12  "12: SPANISH"  
      13  "13: VIETNAMESE"  
      14  "14: FARSI"  
      15  "15: HMONG"  
      16  "16: RESPONDENT CANNOT CHOOSE A PRIMARY LANGUAGE"  
      17  "17: TWO LANGUAGES USED EQUALLY"  
      18  "18: OTHER LANGUAGES"  
      19  "19: AFRICAN LANGUAGES"  
      20  "20: EASTERN EUROPEAN LANGUAGES"  
      21  "21: NATIVE AMERICAN LANGUAGES"  
      22  "22: SIGN LANGUAGE"  
      23  "23: MIDDLE EASTERN LANGUAGES"  
      24  "24: WESTERN EUROPEAN LANGUAGES"  
      25  "25: INDIAN SUBCONTINENTAL LANGUAGES"  
      26  "26: SOUTH EAST ASIAN LANGUAGES"  
      27  "27: PACIFIC ISLANDER LANGUAGES"  
      91  "91: OTHER"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1READBK
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3-6 TIMES A WEEK"  
      4  "4: EVERY DAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1SEX1F
      1  "1: MALE"  
      2  "2: FEMALE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1SEX2F
      1  "1: MALE"  
      2  "2: FEMALE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
;
   label define P2CURMAR
      1  "1: MARRIED"  
      2  "2: SEPARATED"  
      3  "3: DIVORCED"  
      4  "4: WIDOWED"  
      5  "5: NEVER MARRIED"  
      6  "6: CIVIL UNIONS/DOMESTIC PARTNERSHIP"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2DAD1F
      1  "1: BIRTH FATHER"  
      2  "2: ADOPTIVE FATHER"  
      3  "3: STEP FATHER"  
      4  "4: FOSTER FATHER/MALE GUARDIAN"  
      5  "5: OTHER MALE PARENT OR GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2DAD2F
      1  "1: BIRTH FATHER"  
      2  "2: ADOPTIVE FATHER"  
      3  "3: STEP FATHER"  
      4  "4: FOSTER FATHER/MALE GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2HSCALE
      1  "1: EXCELLENT"  
      2  "2: VERY GOOD"  
      3  "3: GOOD"  
      4  "4: FAIR"  
      5  "5: POOR"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2MOM1F
      1  "1: BIRTH MOTHER"  
      2  "2: ADOPTIVE MOTHER"  
      3  "3: STEP MOTHER"  
      4  "4: FOSTER MOTHER OR FEMALE GUARDIAN"  
      5  "5: OTHER FEMALE PARENT OR GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2MOM2F
      1  "1: BIRTH MOTHER"  
      2  "2: ADOPTIVE MOTHER"  
      3  "3: STEP MOTHER"  
      4  "4: FOSTER MOTHER OR FEMALE GUARDIAN"  
      5  "5: OTHER FEMALE PARENT OR GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2SEX1F
      1  "1: MALE"  
      2  "2: FEMALE"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2SEX2F
      1  "1: MALE"  
      2  "2: FEMALE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P3RDBKTC
      1  "1: NEVER"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3-6 TIMES A WEEK"  
      4  "4: EVERY DAY"  
      5  "5: CHILD AWAY WHOLE SUMMER"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P4PRMLNG
      0  "0: ENGLISH"  
      1  "1: ARABIC"  
      2  "2: CHINESE LANGUAGE/DIALECT"  
      3  "3: FILIPINO LANGUAGE"  
      4  "4: FRENCH"  
      5  "5: GERMAN"  
      6  "6: GREEK"  
      7  "7: ITALIAN"  
      8  "8: JAPANESE"  
      9  "9: KOREAN"  
      10  "10: POLISH"  
      11  "11: PORTUGUESE"  
      12  "12: SPANISH"  
      13  "13: VIETNAMESE"  
      14  "14: FARSI"  
      15  "15: HMONG"  
      16  "16: RESPONDENT CANNOT CHOOSE A PRIMARY LANGUAGE"  
      19  "19: AFRICAN LANGUAGES"  
      20  "20: EASTERN EUROPEAN LANGUAGES"  
      21  "21: NATIVE AMERICAN LANGUAGES"  
      22  "22: SIGN LANGUAGE"  
      23  "23: MIDDLE EASTERN LANGUAGES"  
      24  "24: WESTERN EUROPEAN LANGUAGES"  
      25  "25: INDIAN SUBCONTINENTAL LANGUAGES"  
      26  "26: SOUTH EAST ASIAN LANGUAGES"  
      27  "27: PACIFIC ISLANDER LANGUAGES"  
      28  "28: CREOLE"  
      91  "91: OTHER"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P6IMPFLG1F
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM FIRST GRADE"  
      2  "2: IMPUTED USING VALUE FROM BASE YEAR (KG)"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define P6PRMLNG
      0  "0: ENGLISH"  
      1  "1: ARABIC"  
      2  "2: CHINESE LANGUAGE/DIALECT"  
      3  "3: FILIPINO LANGUAGE"  
      4  "4: FRENCH"  
      5  "5: GERMAN"  
      6  "6: GREEK"  
      7  "7: ITALIAN"  
      8  "8: JAPANESE"  
      9  "9: KOREAN"  
      10  "10: POLISH"  
      11  "11: PORTUGUESE"  
      12  "12: SPANISH"  
      13  "13: VIETNAMESE"  
      14  "14: FARSI"  
      15  "15: HMONG"  
      16  "16: SIGN LANGUAGE"  
      17  "17: TWO LANGUAGES ARE USED EQUALLY"  
      19  "19: AFRICAN LANGUAGES"  
      20  "20: EASTERN EUROPEAN LANGUAGES"  
      21  "21: NATIVE AMERICAN LANGUAGES"  
      22  "22: SIGN LANGUAGE"  
      23  "23: MIDDLE EASTERN LANGUAGES"  
      24  "24: WESTERN EUROPEAN LANGUAGES"  
      25  "25: INDIAN SUBCONTINENTAL LANGUAGES"  
      26  "26: SOUTH EAST ASIAN LANGUAGES"  
      27  "27: PACIFIC ISLANDER LANGUAGES"  
      28  "28: CREOLE"  
      91  "91: OTHER"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2ABSENT
      1  "1: SERIOUS PROBLEM"  
      2  "2: MODERATE PROBLEM"  
      3  "3: MINOR PROBLEM"  
      4  "4: NOT A PROBLEM"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2ALCOHL
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2ARTOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2AUDTOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2BULLY
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2CAFEOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2CLSSOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2CNSNSS
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2COMPOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2CONFLC
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2DISORD
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2DRGFRQ
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2EDLVL
      1  "1: HIGH SCHOOL DIPLOMA OR EQUIVALENT/GED"  
      2  "2: ASSOCIATE'S DEGREE"  
      3  "3: BACHELOR'S DEGREE"  
      4  "4: AT LEAST 1 YR COURSEWORK BEYOND BACHELOR'S BUT NO DEGREE"  
      5  "5: MASTER'S DEGREE"  
      6  "6: EDUCATION SPECIALIST OR PROFESSIONAL DIPLOMA"  
      7  "7: DOCTORATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2GENDER
      1  "1: MALE"  
      2  "2: FEMALE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2GYMOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2LBRYOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2MULTOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2MUSCOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2PLAYOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2PTCONF
      1  "1: NEVER"  
      2  "2: ONCE A YEAR"  
      3  "3: 2 TO 3 TIMES A YEAR"  
      4  "4: 4 TO 6 TIMES A YEAR"  
      5  "5: 7 OR MORE TIMES A YEAR"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2RPRTCD
      1  "1: NEVER"  
      2  "2: ONCE A YEAR"  
      3  "3: 2 TO 3 TIMES A YEAR"  
      4  "4: 4 TO 6 TIMES A YEAR"  
      5  "5: 7 OR MORE TIMES A YEAR"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2SPPRT
      1  "1: STRONGLY DISAGREE"  
      2  "2: DISAGREE"  
      3  "3: NEITHER AGREE NOR DISAGREE"  
      4  "4: AGREE"  
      5  "5: STRONGLY AGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2STTEST
      1  "1: NEVER"  
      2  "2: ONCE A YEAR"  
      3  "3: 2 TO 3 TIMES A YEAR"  
      4  "4: 4 TO 6 TIMES A YEAR"  
      5  "5: 7 OR MORE TIMES A YEAR"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2THEFT
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S2VANDAL
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S4CSALDE
      1  "1: NOT AT ALL"  
      2  "2: SMALL EXTENT"  
      3  "3: MODERATE EXTENT"  
      4  "4: LARGE EXTENT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S4CSALIN
      1  "1: NOT AT ALL"  
      2  "2: SMALL EXTENT"  
      3  "3: MODERATE EXTENT"  
      4  "4: LARGE EXTENT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S4FACSOK
      1  "1: DO NOT HAVE"  
      2  "2: NEVER ADEQUATE"  
      3  "3: OFTEN NOT ADEQUATE"  
      4  "4: SOMETIMES NOT ADEQUATE"  
      5  "5: ALWAYS ADEQUATE"  
      -5  "-5: ABBREVIATED SURVEY (ITEM NOT FIELDED)"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S4FUNDDC
      1  "1: NOT AT ALL"  
      2  "2: SMALL EXTENT"  
      3  "3: MODERATE EXTENT"  
      4  "4: LARGE EXTENT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S4RPTCRD
      1  "1: NEVER"  
      2  "2: ONCE A YEAR"  
      3  "3: 2 TO 3 TIMES A YEAR"  
      4  "4: 4 TO 6 TIMES A YEAR"  
      5  "5: 7 OR MORE TIMES A YEAR"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T1CMPSEN
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T1READS
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T1SHOWS
      1  "1: NEVER"  
      2  "2: SOMETIMES"  
      3  "3: OFTEN"  
      4  "4: VERY OFTEN"  
      5  "5: NO OPPORTUNITY TO OBSERVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T1SOLVE
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T1STRAT
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T1WORKS
      1  "1: NEVER"  
      2  "2: SOMETIMES"  
      3  "3: OFTEN"  
      4  "4: VERY OFTEN"  
      5  "5: NO OPPORTUNITY TO OBSERVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T1WRITE
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T2CMPSEN
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T2GRADE
      1  "1: KINDERGARTEN (FULL-DAY PROGRAM)"  
      2  "2: KINDERGARTEN (PART-DAY PROGRAM)"  
      3  "3: FIRST GRADE"  
      4  "4: THIS IS AN UNGRADED CLASSROOM"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T2READS
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T2SHOWS
      1  "1: NEVER"  
      2  "2: SOMETIMES"  
      3  "3: OFTEN"  
      4  "4: VERY OFTEN"  
      5  "5: NO OPPORTUNITY TO OBSERVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T2SOLVE
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T2STRAT
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T2WORKS
      1  "1: NEVER"  
      2  "2: SOMETIMES"  
      3  "3: OFTEN"  
      4  "4: VERY OFTEN"  
      5  "5: NO OPPORTUNITY TO OBSERVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T2WRITE
      1  "1: NOT YET"  
      2  "2: BEGINNING"  
      3  "3: IN PROGRESS"  
      4  "4: INTERMEDIATE"  
      5  "5: PROFICIENT"  
      6  "6: NOT APPLICABLE OR SKILL NOT YET TAUGHT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define T3GRADE
      1  "1: KINDERGARTEN (FULL-DAY PROGRAM)"  
      2  "2: KINDERGARTEN (PART-DAY PROGRAM)"  
      3  "3: FIRST GRADE"  
      4  "4: SECOND GRADE"  
      5  "5: THIS IS AN UNGRADED CLASSROOM"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X12LNGST
      1  "1: NON-ENGLISH LANGUAGE"  
      2  "2: ENGLISH LANGUAGE"  
      3  "3: CAN'T CHOOSE PRIMARY OR 2 LANG EQUALLY"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X12PR1EI
      0  "0: NONE"  
      1  "1: 8TH GRADE OR BELOW"  
      2  "2: 9TH - 12TH GRADE"  
      3  "3: HIGH SCHOOL DIPLOMA/EQUIVALENT"  
      4  "4: VOC/TECH PROGRAM"  
      5  "5: SOME COLLEGE"  
      6  "6: BACHELOR'S DEGREE"  
      7  "7: GRADUATE/PROFESSIONAL SCHOOL-NO DEGREE"  
      8  "8: MASTER'S DEGREE (MA, MS)"  
      9  "9: DOCTORATE OR PROFESSIONAL DEGREE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X12PR2EI
      0  "0: NONE"  
      1  "1: 8TH GRADE OR BELOW"  
      2  "2: 9TH - 12TH GRADE"  
      3  "3: HIGH SCHOOL DIPLOMA/EQUIVALENT"  
      4  "4: VOC/TECH PROGRAM"  
      5  "5: SOME COLLEGE"  
      6  "6: BACHELOR'S DEGREE"  
      7  "7: GRADUATE/PROFESSIONAL SCHOOL-NO DEGREE"  
      8  "8: MASTER'S DEGREE (MA, MS)"  
      9  "9: DOCTORATE OR PROFESSIONAL DEGREE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X12RACTH
      1  "1: WHITE, NON-HISPANIC"  
      2  "2: BLACK/AFRICAN AMERICAN, NON-HISPANIC"  
      3  "3: HISPANIC, RACE SPECIFIED"  
      4  "4: HISPANIC, NO RACE SPECIFIED"  
      5  "5: ASIAN, NON-HISPANIC"  
      6  "6: NATIVE HAWAIIAN/PACIFIC ISLANDER, NON-HISPANIC"  
      7  "7: AMERICAN INDIAN/ALASKA NATIVE, NON-HISPANIC"  
      8  "8: TWO OR MORE RACES, NON-HISPANIC"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X12RACTP
      1  "1: WHITE, NON-HISPANIC"  
      2  "2: BLACK/AFRICAN AMERICAN, NON-HISPANIC"  
      3  "3: HISPANIC, RACE SPECIFIED"  
      4  "4: HISPANIC, NO RACE SPECIFIED"  
      5  "5: ASIAN, NON-HISPANIC"  
      6  "6: NATIVE HAWAIIAN/PACIFIC ISLANDER, NON-HISPANIC"  
      7  "7: AMERICAN INDIAN/ALASKA NATIVE, NON-HISPANIC"  
      8  "8: TWO OR MORE RACES, NON-HISPANIC"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1ASMTDD
      1  "1: DAY OF MONTH 1-7"  
      2  "2: DAY OF MONTH 8-15"  
      3  "3: DAY OF MONTH 16-22"  
      4  "4: DAY OF MONTH 23-31"  
;
   label define X1HPARNT
      1  "1: TWO BIOLOGICAL/ADOPTIVE PARENTS"  
      2  "2: ONE BIOLOGICAL/ADOPTIVE PARENT AND ONE OTHER PARENT/PARTNER"  
      3  "3: ONE BIOLOGICAL/ADOPTIVE PARENT ONLY"  
      4  "4: OTHER GUARDIANS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1KSCTYP
      1  "1: CATHOLIC"  
      2  "2: OTHER RELIGIOUS"  
      3  "3: OTHER PRIVATE"  
      4  "4: PUBLIC"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1LOCALE
      11  "11: CITY, LARGE"  
      12  "12: CITY, MIDSIZE"  
      13  "13: CITY, SMALL"  
      21  "21: SUBURB, LARGE"  
      22  "22: SUBURB, MIDSIZE"  
      23  "23: SUBURB, SMALL"  
      31  "31: TOWN, FRINGE"  
      32  "32: TOWN, DISTANT"  
      33  "33: TOWN, REMOTE"  
      41  "41: RURAL, FRINGE"  
      42  "42: RURAL, DISTANT"  
      43  "43: RURAL, REMOTE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1PR1EMP
      1  "1: 35 OR MORE HOURS PER WEEK"  
      2  "2: LESS THAN 35 HOURS PER WEEK"  
      3  "3: LOOKING FOR WORK"  
      4  "4: NOT IN THE LABOR FORCE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1PR1OCC
      1  "1: EXECUTIVE, ADMIN, MANAGERIAL OCCUPATION"  
      2  "2: ENGINEERS, SURVEYORS, & ARCHITECTS"  
      3  "3: NATURAL SCIENTISTS & MATHEMATICIANS"  
      4  "4: SOCIAL SCIENTIST/WORKERS, LAWYERS"  
      5  "5: UNIVERSITY TEACHERS, POSTSECONDARY COUNSELORS, LIBRARIANS"  
      6  "6: TEACHER, EXCEPT POSTSECONDARY"  
      7  "7: PHYSICIANS, DENTISTS, VETERINARIANS"  
      8  "8: REGISTERED NURSES, PHARMACISTS"  
      9  "9: WRITERS, ARTISTS, ENTERTAINERS, ATHLETES"  
      10  "10: HEALTH TECHNOLOGISTS & TECHNICIANS"  
      11  "11: TECHNOLOGISTS, EXCEPT HEALTH"  
      12  "12: MARKETING & SALES OCCUPATION"  
      13  "13: ADMINISTRATIVE SUPPORT, INCLUDING CLERK"  
      14  "14: SERVICE OCCUPATIONS"  
      15  "15: AGRICULTURE, FORESTRY, FISHING OCCUPATIONS"  
      16  "16: MECHANICS & REPAIRERS"  
      17  "17: CONSTRUCTION & EXTRACTIVE OCCUPATIONS"  
      18  "18: PRECISION PRODUCTION OCCUPATION"  
      19  "19: PRODUCTION WORKING OCCUPATION"  
      20  "20: TRANSPORTATION, MATERIAL MOVING"  
      21  "21: HANDLER, EQUIP, CLEANER, HELPERS, LABOR"  
      22  "22: UNEMPLOYED/RETIRED/DISABLED/UNCLASSIFIED"  
      -1  "-1: NO OCCUPATION"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1PR1RAC
      1  "1: WHITE, NON-HISPANIC"  
      2  "2: BLACK OR AFRICAN AMERICAN, NON-HISPANIC"  
      3  "3: HISPANIC, RACE SPECIFIED"  
      4  "4: HISPANIC, NO RACE SPECIFIED"  
      5  "5: ASIAN, NON-HISPANIC"  
      6  "6: NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER, NON-HISPANIC"  
      7  "7: AMERICAN INDIAN OR ALASKA NATIVE, NON-HISPANIC"  
      8  "8: MORE THAN 1 RACE, NON-HISPANIC"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1PR2EMP
      1  "1: 35 OR MORE HOURS PER WEEK"  
      2  "2: LESS THAN 35 HOURS PER WEEK"  
      3  "3: LOOKING FOR WORK"  
      4  "4: NOT IN THE LABOR FORCE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1PR2OCC
      1  "1: EXECUTIVE, ADMIN, MANAGERIAL OCCUPATION"  
      2  "2: ENGINEERS, SURVEYORS, & ARCHITECTS"  
      3  "3: NATURAL SCIENTISTS & MATHEMATICIANS"  
      4  "4: SOCIAL SCIENTIST/WORKERS, LAWYERS"  
      5  "5: UNIVERSITY TEACHERS, POSTSECONDARY COUNSELORS, LIBRARIANS"  
      6  "6: TEACHER, EXCEPT POSTSECONDARY"  
      7  "7: PHYSICIANS, DENTISTS, VETERINARIANS"  
      8  "8: REGISTERED NURSES, PHARMACISTS"  
      9  "9: WRITERS, ARTISTS, ENTERTAINERS, ATHLETES"  
      10  "10: HEALTH TECHNOLOGISTS & TECHNICIANS"  
      11  "11: TECHNOLOGISTS, EXCEPT HEALTH"  
      12  "12: MARKETING & SALES OCCUPATION"  
      13  "13: ADMINISTRATIVE SUPPORT, INCLUDING CLERK"  
      14  "14: SERVICE OCCUPATIONS"  
      15  "15: AGRICULTURE, FORESTRY, FISHING OCCUPATIONS"  
      16  "16: MECHANICS & REPAIRERS"  
      17  "17: CONSTRUCTION & EXTRACTIVE OCCUPATIONS"  
      18  "18: PRECISION PRODUCTION OCCUPATION"  
      19  "19: PRODUCTION WORKING OCCUPATION"  
      20  "20: TRANSPORTATION, MATERIAL MOVING"  
      21  "21: HANDLER, EQUIP, CLEANER, HELPERS, LABOR"  
      22  "22: UNEMPLOYED/RETIRED/DISABLED/UNCLASSIFIED"  
      -1  "-1: NO OCCUPATION OR NO PARENT 2"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1PR2RAC
      1  "1: WHITE, NON-HISPANIC"  
      2  "2: BLACK OR AFRICAN AMERICAN, NON-HISPANIC"  
      3  "3: HISPANIC, RACE SPECIFIED"  
      4  "4: HISPANIC, NO RACE SPECIFIED"  
      5  "5: ASIAN, NON-HISPANIC"  
      6  "6: NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER, NON-HISPANIC"  
      7  "7: AMERICAN INDIAN OR ALASKA NATIVE, NON-HISPANIC"  
      8  "8: MORE THAN 1 RACE, NON-HISPANIC"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1PUBPRI
      1  "1: PUBLIC"  
      2  "2: PRIVATE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1REGION
      1  "1: NORTHEAST"  
      2  "2: MIDWEST"  
      3  "3: SOUTH"  
      4  "4: WEST"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2HIGGRD
      1  "1: PRE-KINDERGARTEN"  
      2  "2: KINDERGARTEN"  
      3  "3: FIRST GRADE"  
      4  "4: SECOND GRADE"  
      5  "5: THIRD GRADE"  
      6  "6: FOURTH GRADE"  
      7  "7: FIFTH GRADE"  
      8  "8: SIXTH GRADE"  
      9  "9: SEVENTH GRADE"  
      10  "10: EIGHTH GRADE"  
      11  "11: NINTH GRADE"  
      12  "12: TENTH GRADE"  
      13  "13: ELEVENTH GRADE"  
      14  "14: TWELFTH GRADE"  
      15  "15: UNGRADED"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2HPARNT
      1  "1: TWO BIOLOGICAL/ADOPTIVE PARENTS"  
      2  "2: ONE BIOLOGICAL/ADOPTIVE PARENT AND ONE OTHER PARENT/PARTNER"  
      3  "3: ONE BIOLOGICAL/ADOPTIVE PARENT ONLY"  
      4  "4: OTHER GUARDIAN(S)"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2INCATI
      1  "1: $5,000 OR LESS"  
      2  "2: $5,001 TO $10,000"  
      3  "3: $10,001 TO $15,000"  
      4  "4: $15,001 TO $20,000"  
      5  "5: $20,001 TO $25,000"  
      6  "6: $25,001 TO $30,000"  
      7  "7: $30,001 TO $35,000"  
      8  "8: $35,001 TO $40,000"  
      9  "9: $40,001 TO $45,000"  
      10  "10: $45,001 TO $50,000"  
      11  "11: $50,001 TO $55,000"  
      12  "12: $55,001 TO $60,000"  
      13  "13: $60,001 TO $65,000"  
      14  "14: $65,001 TO $70,000"  
      15  "15: $70,001 TO $75,000"  
      16  "16: $75,001 TO $100,000"  
      17  "17: $100,001 TO $200,000"  
      18  "18: $200,001 OR MORE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2KENRLS
      1  "1: 0-149 STUDENTS"  
      2  "2: 150-299 STUDENTS"  
      3  "3: 300-499 STUDENTS"  
      4  "4: 500-749 STUDENTS"  
      5  "5: 750 AND ABOVE STUDENTS"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2KSCTYP
      1  "1: CATHOLIC"  
      2  "2: OTHER RELIGIOUS"  
      3  "3: OTHER PRIVATE"  
      4  "4: PUBLIC"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2LOCALE
      11  "11: CITY, LARGE"  
      12  "12: CITY, MIDSIZE"  
      13  "13: CITY, SMALL"  
      21  "21: SUBURB, LARGE"  
      22  "22: SUBURB, MIDSIZE"  
      23  "23: SUBURB, SMALL"  
      31  "31: TOWN, FRINGE"  
      32  "32: TOWN, DISTANT"  
      33  "33: TOWN, REMOTE"  
      41  "41: RURAL, FRINGE"  
      42  "42: RURAL, DISTANT"  
      43  "43: RURAL, REMOTE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2LOWGRD
      1  "1: PRE-KINDERGARTEN"  
      2  "2: KINDERGARTEN"  
      3  "3: FIRST GRADE"  
      4  "4: SECOND GRADE"  
      5  "5: THIRD GRADE"  
      6  "6: FOURTH GRADE"  
      7  "7: FIFTH GRADE"  
      8  "8: SIXTH GRADE"  
      9  "9: SEVENTH GRADE"  
      10  "10: EIGHTH GRADE"  
      11  "11: NINTH GRADE"  
      12  "12: TENTH GRADE"  
      13  "13: ELEVENTH GRADE"  
      14  "14: TWELFTH GRADE"  
      15  "15: UNGRADED"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2PR1RAC
      1  "1: WHITE, NON-HISPANIC"  
      2  "2: BLACK OR AFRICAN AMERICAN, NON-HISPANIC"  
      3  "3: HISPANIC, RACE SPECIFIED"  
      4  "4: HISPANIC, NO RACE SPECIFIED"  
      5  "5: ASIAN, NON-HISPANIC"  
      6  "6: NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER, NON-HISPANIC"  
      7  "7: AMERICAN INDIAN OR ALASKA NATIVE, NON-HISPANIC"  
      8  "8: MORE THAN 1 RACE, NON-HISPANIC"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2PR2RAC
      1  "1: WHITE, NON-HISPANIC"  
      2  "2: BLACK OR AFRICAN AMERICAN, NON-HISPANIC"  
      3  "3: HISPANIC, RACE SPECIFIED"  
      4  "4: HISPANIC, NO RACE SPECIFIED"  
      5  "5: ASIAN, NON-HISPANIC"  
      6  "6: NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER, NON-HISPANIC"  
      7  "7: AMERICAN INDIAN OR ALASKA NATIVE, NON-HISPANIC"  
      8  "8: MORE THAN 1 RACE, NON-HISPANIC"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2PUBPRI
      1  "1: PUBLIC"  
      2  "2: PRIVATE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2REGION
      1  "1: NORTHEAST"  
      2  "2: MIDWEST"  
      3  "3: SOUTH"  
      4  "4: WEST"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2SCHBMM
      1  "1: JANUARY"  
      2  "2: FEBRUARY"  
      3  "3: MARCH"  
      4  "4: APRIL"  
      5  "5: MAY"  
      6  "6: JUNE"  
      7  "7: JULY"  
      8  "8: AUGUST"  
      9  "9: SEPTEMBER"  
      10  "10: OCTOBER"  
      11  "11: NOVEMBER"  
      12  "12: DECEMBER"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2SCHBYY
      2010  "2010"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2SCHEMM
      1  "1: JANUARY"  
      2  "2: FEBRUARY"  
      3  "3: MARCH"  
      4  "4: APRIL"  
      5  "5: MAY"  
      6  "6: JUNE"  
      7  "7: JULY"  
      8  "8: AUGUST"  
      9  "9: SEPTEMBER"  
      10  "10: OCTOBER"  
      11  "11: NOVEMBER"  
      12  "12: DECEMBER"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2SCHEYY
      2011  "2011"  
      2012  "2012"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X3FALLSMP
      1  "1: IN FALL SUBSAMPLE, PARTICIPATED"  
      2  "2: IN FALL SUBSAMPLE, DID NOT PARTICIPATE"  
      3  "3: NOT IN FALL SUBSAMPLE"  
;
   label define X3GRDLVL
      1  "1: KINDERGARTEN"  
      2  "2: FIRST GRADE"  
      3  "3: SECOND GRADE"  
      4  "4: UNGRADED"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X4GRDLVL
      1  "1: KINDERGARTEN"  
      2  "2: FIRST GRADE"  
      3  "3: SECOND GRADE"  
      4  "4: THIRD GRADE"  
      5  "5: UNGRADED"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X4PUBPRI
      1  "1: PUBLIC"  
      2  "2: PRIVATE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X4REGION
      1  "1: NORTHEAST"  
      2  "2: MIDWEST"  
      3  "3: SOUTH"  
      4  "4: WEST"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X4SCHBMM
      1  "1: JANUARY"  
      2  "2: FEBRUARY"  
      3  "3: MARCH"  
      4  "4: APRIL"  
      5  "5: MAY"  
      6  "6: JUNE"  
      7  "7: JULY"  
      8  "8: AUGUST"  
      9  "9: SEPTEMBER"  
      10  "10: OCTOBER"  
      11  "11: NOVEMBER"  
      12  "12: DECEMBER"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X4SCHBYY
      2011  "2011"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X5ASMTYY
      2012  "2012"  
;
   label define X5GRDLVL
      1  "1: KINDERGARTEN"  
      2  "2: FIRST GRADE"  
      3  "3: SECOND GRADE"  
      4  "4: THIRD GRADE OR HIGHER"  
      5  "5: UNGRADED"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X6SCHBYY
      2012  "2012"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X6SCHEYY
      2013  "2013"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define XF2YRRND
      0  "0: NOT YEAR ROUND SCHOOL"  
      1  "1: YEAR ROUND SCHOOL"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X_CHSEX
      1  "1: MALE"  
      2  "2: FEMALE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X_DOBMM
      1  "1: JANUARY"  
      2  "2: FEBRUARY"  
      3  "3: MARCH"  
      4  "4: APRIL"  
      5  "5: MAY"  
      6  "6: JUNE"  
      7  "7: JULY"  
      8  "8: AUGUST"  
      9  "9: SEPTEMBER"  
      10  "10: OCTOBER"  
      11  "11: NOVEMBER"  
      12  "12: DECEMBER"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define YN159F
      1  "1: YES"  
      2  "2: NO"  
      -1  "-1: NOT APPLICABLE"  
      -5  "-5: ABBREVIATED SURVEY (ITEM NOT FIELDED)"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define YN19F
      1  "1: YES"  
      2  "2: NO"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define YN1RDK9F
      1  "1: YES"  
      2  "2: NO"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define YN9F
      1  "1: YES"  
      2  "2: NO"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define YNRDK9F
      1  "1: YES"  
      2  "2: NO"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define _1789F
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define _19F
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define _59F
      -5  "-5: ABBREVIATED SURVEY (ITEM NOT FIELDED)"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define _6COMPYY
      2013  "2013"  
;
   label define _789F
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define _9F
      -9  "-9: NOT ASCERTAINED"  
;
   label define S7THEFT
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -5  "-5: ABBREVIATED SURVEY (ITEM NOT FIELDED)"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X7GRDLVL
      1  "1: FIRST GRADE"  
      2  "2: SECOND GRADE"  
      3  "3: THIRD GRADE"  
      4  "4: FOURTH GRADE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X7SCHEYY
      2014  "2014"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X7SCHBYY
      2013  "2013"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A8OFTPROJ
      1  "1: NEVER"  
      2  "2: LESS THAN ONCE A WEEK"  
      3  "3: 1 DAY A WEEK"  
      4  "4: 2 DAYS A WEEK"  
      5  "5: 3 DAYS A WEEK"  
      6  "6: 4 DAYS A WEEK"  
      7  "7: 5 DAYS A WEEK"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A8RPTPARENT
      1  "1: NOT IMPORTANT"  
      2  "2: SOMEWHAT IMPORTANT"  
      3  "3: VERY IMPORTANT"  
      4  "4: EXTREMELY IMPORTANT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define A8TIMEPROJ
      1  "1: NOT APPLICABLE/NEVER"  
      2  "2: LESS THAN 1/2 HOUR A DAY"  
      3  "3: 1/2 HOUR TO LESS THAN 1 HOUR"  
      4  "4: 1 TO LESS THAN 1 1/2 HOURS"  
      5  "5: 1 1/2 TO LESS THAN 2 HOURS"  
      6  "6: 2 TO LESS THAN 2 1/2 HOURS"  
      7  "7: 2 1/2 TO LESS THAN 3 HOURS"  
      8  "8: 3 OR MORE HOURS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define G8OFTBEHV
      1  "1: NEVER"  
      2  "2: SOMETIMES"  
      3  "3: OFTEN"  
      4  "4: VERY OFTEN"  
      5  "5: NO OPPORTUNITY TO OBSERVE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define G8TIMEACTV
      1  "1: NO TIME"  
      2  "2: 1-15 MINUTES"  
      3  "3: 16-30 MINUTES"  
      4  "4: 31-45 MINUTES"  
      5  "5: LONGER THAN 45 MINUTES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define GENDERNA
      1  "1: MALE"  
      2  "2: FEMALE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define IFP81F
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM THIRD GRADE"  
      2  "2: IMPUTED USING VALUE FROM EARLIER ROUND"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define M8TIMEACTV
      1  "1: NO TIME"  
      2  "2: 1-15 MINUTES"  
      3  "3: 16-30 MINUTES"  
      4  "4: 31-45 MINUTES"  
      5  "5: LONGER THAN 45 MINUTES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define N8TIMEACTV
      1  "1: NO TIME"  
      2  "2: 1-15 MINUTES"  
      3  "3: 16-30 MINUTES"  
      4  "4: 31-45 MINUTES"  
      5  "5: LONGER THAN 45 MINUTES"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P8DAD2F
      1  "1: BIRTH FATHER"  
      2  "2: ADOPTIVE FATHER"  
      3  "3: STEP FATHER"  
      4  "4: FOSTER FATHER/MALE GUARDIAN"  
      5  "5: OTHER MALE PARENT OR GUARDIAN"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S8FREQACTIV
      1  "1: NEVER"  
      2  "2: ONCE A YEAR"  
      3  "3: 2 TO 3 TIMES A YEAR"  
      4  "4: 4 TO 6 TIMES A YEAR"  
      5  "5: 7 OR MORE TIMES A YEAR"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S8NBGHRPROB
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S8SCHLCHNGS
      1  "1: NOT AT ALL"  
      2  "2: SMALL EXTENT"  
      3  "3: MODERATE EXTENT"  
      4  "4: LARGE EXTENT"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define S8SCHPROB
      1  "1: SERIOUS PROBLEM"  
      2  "2: MODERATE PROBLEM"  
      3  "3: MINOR PROBLEM"  
      4  "4: NOT A PROBLEM"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X8GRDLVL
      2  "2: SECOND GRADE"  
      3  "3: THIRD GRADE"  
      4  "4: FOURTH GRADE"  
      5  "5: FIFTH GRADE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X8SCHBYY
      2014  "2014"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X8SCHEYY
      2015  "2015"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define _8COMPYY
      2015  "2015"  
;
   label define S8NBGHRPRBB
      1  "1: HAPPENS DAILY"  
      2  "2: HAPPENS AT LEAST ONCE A WEEK"  
      3  "3: HAPPENS AT LEAST ONCE A MONTH"  
      4  "4: HAPPENS ON OCCASION"  
      5  "5: NEVER HAPPENS"  
      -5  "-5: ABBREVIATED SURVEY (ITEM NOT FIELDED)"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define _9COMPYY
      2016  "2016"  
;
   label define IFP92F
      0  "0: NOT IMPUTED"  
      1  "1: IMPUTED USING VALUE FROM FOURTH GRADE"  
      2  "2: IMPUTED USING VALUE FROM EARLIER ROUND"  
      3  "3: IMPUTED USING HOT-DECK METHOD"  
;
   label define X9GRDLVL
      1  "1: FIRST GRADE"  
      2  "2: SECOND GRADE"  
      3  "3: THIRD GRADE"  
      4  "4: FOURTH GRADE"  
      5  "5: FIFTH GRADE"  
      6  "6: SIXTH GRADE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X9SCHBYY
      2015  "2015"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X9SCHEYY
      2016  "2016"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define G9CHILDBEHV
      1  "1: DOESN'T APPLY (SELDOM DISPLAYS THIS BEHAVIOR)"  
      2  "2: SOMETIMES APPLIES (OCCASIONALLY DISPLAYS THIS BEHAVIOR)"  
      3  "3: CERTAINLY APPLIES (OFTEN DISPLAYS THIS BEHAVIOR)"  
      -9  "-9: NOT ASCERTAINED"  
;
   label values P1OLDMOM _1789F;
   label values P1WEIGHO _1789F;
   label values P2TINCTH _1789F;
   label values P4TINCTH_I _1789F;
   label values P6TINCTH_I _1789F;
   label values P7TINCTH_I _1789F;
   label values P8TINCTH_I _1789F;
   label values P9TINCTH_I _1789F;
   label values S2RYYEMP _19F;
   label values S2TOTELL _19F;
   label values S4TOTELL _19F;
   label values S6TOTELL _19F;
   label values S7TOTELL _19F;
   label values S8RYYEMP _19F;
   label values S8TOTELL _19F;
   label values S9RYYEMP _19F;
   label values S9TOTELL _19F;
   label values X1ATTNFS _19F;
   label values X1PAR1SCR_I _19F;
   label values X1PAR2AGE _19F;
   label values X1PAR2SCR_I _19F;
   label values X1PLART _19F;
   label values X1PLSS _19F;
   label values X1TCHEXT _19F;
   label values X1TCHINT _19F;
   label values X2ATTNFS _19F;
   label values X2FLCH2_I _19F;
   label values X2PLART _19F;
   label values X2PLSS _19F;
   label values X2RLCH2_I _19F;
   label values X2SCHBDD _19F;
   label values X2SCHEDD _19F;
   label values X2TCHEXT _19F;
   label values X2TCHINT _19F;
   label values X3PLART _19F;
   label values X3PLSS _19F;
   label values X3TCHEXT _19F;
   label values X3TCHINT _19F;
   label values X4ATTNFS _19F;
   label values X4FMEAL_I _19F;
   label values X4KATTNFS _19F;
   label values X4KTCHEXT _19F;
   label values X4KTCHINT _19F;
   label values X4PAR1SCR_I _19F;
   label values X4PAR2SCR_I _19F;
   label values X4PLART _19F;
   label values X4PLSS _19F;
   label values X4RMEAL_I _19F;
   label values X4SCHBDD _19F;
   label values X4SCHEDD _19F;
   label values X4TCHEXT _19F;
   label values X4TCHINT _19F;
   label values X6FRMEAL_I _19F;
   label values X6PAR1SCR_I _19F;
   label values X6PAR2SCR_I _19F;
   label values X6SCHBDD _19F;
   label values X6SCHEDD _19F;
   label values X7FRMEAL_I _19F;
   label values X7SCHBDD _19F;
   label values X7SCHEDD _19F;
   label values X8FRMEAL_I _19F;
   label values X8SCHBDD _19F;
   label values X8SCHEDD _19F;
   label values X9FRMEAL_I _19F;
   label values X9PAR1SCR_I _19F;
   label values X9PAR2SCR_I _19F;
   label values X9SCHBDD _19F;
   label values X9SCHEDD _19F;
   label values S7BLACPT _59F;
   label values S7HISPPT _59F;
   label values S7WHITPT _59F;
   label values S8BLACPT _59F;
   label values S8HISPPT _59F;
   label values S8WHITPT _59F;
   label values X6ASMTYY _6COMPYY;
   label values P1NUMPLA _789F;
   label values P4NUMPLA _789F;
   label values X7ASMTYY _7COMPYY;
   label values X8ASMTYY _8COMPYY;
   label values X9ASMTYY _9COMPYY;
   label values A1YRSCH _9F;
   label values A1YRSTCH _9F;
   label values A4KYRSCH _9F;
   label values A4KYRSTCH _9F;
   label values A4YRSCH _9F;
   label values A4YRSTCH _9F;
   label values A6YRSCH _9F;
   label values A6YRSTCH _9F;
   label values A7YRSTCH _9F;
   label values A8YRSTCH _9F;
   label values A8YRSTCHZ _9F;
   label values A9YRSTCH _9F;
   label values A9YRSTCHZ _9F;
   label values S2BLACPT _9F;
   label values S2BUSSED _9F;
   label values S2ESLFL _9F;
   label values S2GIFPCT _9F;
   label values S2GIFTFL _9F;
   label values S2HISPPT _9F;
   label values S2INSTCM _9F;
   label values S2INSTRU _9F;
   label values S2LIBRFL _9F;
   label values S2MSARFL _9F;
   label values S2NUMTOT _9F;
   label values S2NURSFL _9F;
   label values S2PARAFL _9F;
   label values S2PSYCFL _9F;
   label values S2PSYCPT _9F;
   label values S2READFL _9F;
   label values S2RTCHFL _9F;
   label values S2SPDPCT _9F;
   label values S2SPEDFL _9F;
   label values S2TALKPT _9F;
   label values S2TEBEGN _9F;
   label values S2TELEFT _9F;
   label values S2TOTPRI _9F;
   label values S2WHITPT _9F;
   label values S2YSTCH _9F;
   label values S4ADA _9F;
   label values S4ARTSTF _9F;
   label values S4BLACPT _9F;
   label values S4CTECHF _9F;
   label values S4ESLF _9F;
   label values S4GIFPCT _9F;
   label values S4GIFTF _9F;
   label values S4GYMTF _9F;
   label values S4HISPPT _9F;
   label values S4INSTRU _9F;
   label values S4LIBRF _9F;
   label values S4NUMTOT _9F;
   label values S4NURSF _9F;
   label values S4PARAF _9F;
   label values S4PSYCF _9F;
   label values S4PSYCP _9F;
   label values S4RGTCHF _9F;
   label values S4RYYEMP _9F;
   label values S4SPDPCT _9F;
   label values S4SPEDF _9F;
   label values S4TALKPT _9F;
   label values S4TEBEGN _9F;
   label values S4TELEFT _9F;
   label values S4TOTPRI _9F;
   label values S4WHITPT _9F;
   label values S4YSTCH _9F;
   label values S6ARTSTF _9F;
   label values S6BLACPT _9F;
   label values S6CTECHF _9F;
   label values S6ESLF _9F;
   label values S6GIFPCT _9F;
   label values S6GIFTF _9F;
   label values S6GYMTF _9F;
   label values S6HISPPT _9F;
   label values S6INSTRU _9F;
   label values S6LIBRF _9F;
   label values S6NUMTOT _9F;
   label values S6NURSF _9F;
   label values S6PARAF _9F;
   label values S6PSYCF _9F;
   label values S6PSYCP _9F;
   label values S6RGTCHF _9F;
   label values S6RYYEMP _9F;
   label values S6SPDPCT _9F;
   label values S6SPEDF _9F;
   label values S6TALKPT _9F;
   label values S6TEBEGN _9F;
   label values S6TELEFT _9F;
   label values S6TOTPRI _9F;
   label values S6WHITPT _9F;
   label values S6YSTCH _9F;
   label values S7ARTSTF _9F;
   label values S7ESLF _9F;
   label values S7GIFPCT _9F;
   label values S7GYMTF _9F;
   label values S7PARAF _9F;
   label values S7RGTCHF _9F;
   label values S7RYYEMP _9F;
   label values S7SPDPCT _9F;
   label values S7SPEDF _9F;
   label values S7TEBEGN _9F;
   label values S7TELEFT _9F;
   label values S7TOTPRI _9F;
   label values S7YSTCH _9F;
   label values S8ARTSTF _9F;
   label values S8ESLF _9F;
   label values S8GIFPCT _9F;
   label values S8GYMTF _9F;
   label values S8PARAF _9F;
   label values S8RGTCHF _9F;
   label values S8SPDPCT _9F;
   label values S8SPEDF _9F;
   label values S8TEBEGN _9F;
   label values S8TELEFT _9F;
   label values S8TOTPRI _9F;
   label values S8YSTCH _9F;
   label values S9ARTSTF _9F;
   label values S9BLACPT _9F;
   label values S9ESLF _9F;
   label values S9GIFPCT _9F;
   label values S9GYMTF _9F;
   label values S9HISPPT _9F;
   label values S9NUMTOT _9F;
   label values S9PARAF _9F;
   label values S9RGTCHF _9F;
   label values S9SPDPCT _9F;
   label values S9SPEDF _9F;
   label values S9TEBEGN _9F;
   label values S9TELEFT _9F;
   label values S9TOTPRI _9F;
   label values S9WHITPT _9F;
   label values S9YSTCH _9F;
   label values X_DOBYY_R _9F;
   label values X1HTOTAL _9F;
   label values X1KAGE_R _9F;
   label values X1LESS18 _9F;
   label values X1MTHETK5 _9F;
   label values X1NUMSIB _9F;
   label values X1PAR1AGE _9F;
   label values X1RTHETK5 _9F;
   label values X2HTOTAL _9F;
   label values X2KAGE_R _9F;
   label values X2LESS18 _9F;
   label values X2MTHETK5 _9F;
   label values X2NUMSIB _9F;
   label values X2RTHETK5 _9F;
   label values X2STHETK5 _9F;
   label values X3AGE _9F;
   label values X3MTHETK5 _9F;
   label values X3RTHETK5 _9F;
   label values X3STHETK5 _9F;
   label values X4AGE _9F;
   label values X4HTOTAL _9F;
   label values X4LESS18_R _9F;
   label values X4MTHETK5 _9F;
   label values X4NUMSIB _9F;
   label values X4RTHETK5 _9F;
   label values X4STHETK5 _9F;
   label values X5AGE _9F;
   label values X5MTHETK5 _9F;
   label values X5RTHETK5 _9F;
   label values X5STHETK5 _9F;
   label values X5TCHEXT _9F;
   label values X5TCHINT _9F;
   label values X6AGE _9F;
   label values X6HTOTAL _9F;
   label values X6LESS18 _9F;
   label values X6MTHETK5 _9F;
   label values X6NUMSIB _9F;
   label values X6RTHETK5 _9F;
   label values X6STHETK5 _9F;
   label values X6TCHEXT _9F;
   label values X6TCHINT _9F;
   label values X7AGE _9F;
   label values X7HTOTAL _9F;
   label values X7LESS18 _9F;
   label values X7MTHETK5 _9F;
   label values X7NUMSIB _9F;
   label values X7RTHETK5 _9F;
   label values X7STHETK5 _9F;
   label values X7TCHEXT _9F;
   label values X7TCHINT _9F;
   label values X8AGE _9F;
   label values X8HTOTAL _9F;
   label values X8LESS18 _9F;
   label values X8MTHETK5 _9F;
   label values X8NUMSIB _9F;
   label values X8RTHETK5 _9F;
   label values X8STHETK5 _9F;
   label values X8TCHEXT _9F;
   label values X8TCHINT _9F;
   label values X9AGE _9F;
   label values X9HTOTAL _9F;
   label values X9LESS18 _9F;
   label values X9MTHETK5 _9F;
   label values X9NUMSIB _9F;
   label values X9RTHETK5 _9F;
   label values X9STHETK5 _9F;
   label values X9TCHEXT _9F;
   label values X9TCHINT _9F;
   label values A1DBEHVR A1DBEHVR;
   label values A1ENJOY A1ENJOY;
   label values A1HGHSTD A1HGHSTD;
   label values A1HMWRK A1HMWRK;
   label values A1MKDIFF A1MKDIFF;
   label values A1NATEXM A1NATEXM;
   label values A1SMLGRP A1SMLGRP;
   label values A1STATCT A1STATCT;
   label values A1TEACH A1TEACH;
   label values A1TGEND A1TGEND;
   label values A1TIMDIS A1TIMDIS;
   label values A2ACCPTD A2ACCPTD;
   label values A4ACCPTD A2ACCPTD;
   label values A4KACCPTD A2ACCPTD;
   label values A6ACCPTD A2ACCPTD;
   label values A2ATTND A2ATTND;
   label values A2AUDIOV A2AUDIOV;
   label values A2BLNDWD A2BLNDWD;
   label values A2CLASPA A2CLASPA;
   label values A2CLSSPC A2CLSSPC;
   label values A2CNTNLR A2CNTNLR;
   label values A4CNTNLR A2CNTNLR;
   label values A4KCNTNLR A2CNTNLR;
   label values A6CNTNLR A2CNTNLR;
   label values A2COMPEQ A2COMPEQ;
   label values A2COPIER A2COPIER;
   label values A2COPRTV A2COPRTV;
   label values A2COPSTF A2COPSTF;
   label values A4COPSTF A2COPSTF;
   label values A4KCOPSTF A2COPSTF;
   label values A6COPSTF A2COPSTF;
   label values A7COPSTF A2COPSTF;
   label values A2DBEHVR A2DBEHVR;
   label values A2DIVMTH A2DIVMTH;
   label values A4DIVMTH A2DIVMTH;
   label values A4KDIVMTH A2DIVMTH;
   label values A2DIVRD A2DIVRD;
   label values A4DIVRD A2DIVRD;
   label values A4KDIVRD A2DIVRD;
   label values A2EFFO A2EFFO;
   label values A2ENCOUR A2ENCOUR;
   label values A4ENCOUR A2ENCOUR;
   label values A4KENCOUR A2ENCOUR;
   label values A6ENCOUR A2ENCOUR;
   label values A7ENCOUR A2ENCOUR;
   label values A2ENJOY A2ENJOY;
   label values A4ENJOY A2ENJOY;
   label values A4KENJOY A2ENJOY;
   label values A6ENJOY A2ENJOY;
   label values A7ENJOY A2ENJOY;
   label values A2FLLWDR A2FLLWDR;
   label values A2IGRPRJ A2IGRPRJ;
   label values A2IMPRVM A2IMPRVM;
   label values A2INDVDL A2INDVDL;
   label values A2MANIPU A2MANIPU;
   label values A2MISSIO A2MISSIO;
   label values A4KMISSIO A2MISSIO;
   label values A4MISSIO A2MISSIO;
   label values A6MISSIO A2MISSIO;
   label values A2MKDIFF A2MKDIFF;
   label values A4KMKDIFF A2MKDIFF;
   label values A4MKDIFF A2MKDIFF;
   label values A6MKDIFF A2MKDIFF;
   label values A2OFTART A2OFTART;
   label values A4KOFTART A2OFTART;
   label values A4OFTART A2OFTART;
   label values A6OFTART A2OFTART;
   label values A7OFTART A2OFTART;
   label values A2OFTDAN A2OFTDAN;
   label values A4KOFTDAN A2OFTDAN;
   label values A4OFTDAN A2OFTDAN;
   label values A6OFTDAN A2OFTDAN;
   label values A7OFTDAN A2OFTDAN;
   label values A2OFTHTR A2OFTHTR;
   label values A4KOFTHTR A2OFTHTR;
   label values A4OFTHTR A2OFTHTR;
   label values A6OFTHTR A2OFTHTR;
   label values A7OFTHTR A2OFTHTR;
   label values A2OFTMTH A2OFTMTH;
   label values A4KOFTMTH A2OFTMTH;
   label values A4OFTMTH A2OFTMTH;
   label values A6OFTMTH A2OFTMTH;
   label values A7OFTMTH A2OFTMTH;
   label values A2OFTMUS A2OFTMUS;
   label values A4KOFTMUS A2OFTMUS;
   label values A4OFTMUS A2OFTMUS;
   label values A6OFTMUS A2OFTMUS;
   label values A7OFTMUS A2OFTMUS;
   label values A2OFTPE A2OFTPE;
   label values A4KOFTPE A2OFTPE;
   label values A4OFTPE A2OFTPE;
   label values A6OFTPE A2OFTPE;
   label values A7OFTPE A2OFTPE;
   label values A2OFTRDL A2OFTRDL;
   label values A4KOFTRDL A2OFTRDL;
   label values A4OFTRDL A2OFTRDL;
   label values A6OFTRDL A2OFTRDL;
   label values A7OFTRDL A2OFTRDL;
   label values A2OFTSCI A2OFTSCI;
   label values A4KOFTSCI A2OFTSCI;
   label values A4OFTSCI A2OFTSCI;
   label values A6OFTSCI A2OFTSCI;
   label values A7OFTSCI A2OFTSCI;
   label values A4OFTSOC A2OFTSOC;
   label values A2PAPER A2PAPER;
   label values A2PAPRWR A2PAPRWR;
   label values A4KPAPRWR A2PAPRWR;
   label values A4PAPRWR A2PAPRWR;
   label values A6PAPRWR A2PAPRWR;
   label values A2PSUPP A2PSUPP;
   label values A4KPSUPP A2PSUPP;
   label values A4PSUPP A2PSUPP;
   label values A6PSUPP A2PSUPP;
   label values A7PSUPP A2PSUPP;
   label values A2RECJOB A2RECJOB;
   label values A4KRECJOB A2RECJOB;
   label values A4RECJOB A2RECJOB;
   label values A6RECJOB A2RECJOB;
   label values A2SETPRI A2SETPRI;
   label values A4KSETPRI A2SETPRI;
   label values A4SETPRI A2SETPRI;
   label values A6SETPRI A2SETPRI;
   label values A7SETPRI A2SETPRI;
   label values A2SMLGRP A2SMLGRP;
   label values A2SOFTWA A2SOFTWA;
   label values A2STNDLO A2STNDLO;
   label values A4KSTNDLO A2STNDLO;
   label values A4STNDLO A2STNDLO;
   label values A6STNDLO A2STNDLO;
   label values A7STNDLO A2STNDLO;
   label values A2STNDRD A2STNDRD;
   label values A2TCHRMD A2TCHRMD;
   label values A2TEACH A2TEACH;
   label values A4TEACH A2TEACH;
   label values A6TEACH A2TEACH;
   label values A7TEACH A2TEACH;
   label values A2TOCLAS A2TOCLAS;
   label values A2TOSTND A2TOSTND;
   label values A2TXART A2TXART;
   label values A4KTXART A2TXART;
   label values A4TXART A2TXART;
   label values A6TXART A2TXART;
   label values A7TXART A2TXART;
   label values A2TXDAN A2TXDAN;
   label values A4KTXDAN A2TXDAN;
   label values A4TXDAN A2TXDAN;
   label values A6TXDAN A2TXDAN;
   label values A7TXDAN A2TXDAN;
   label values A2TXFOR A2TXFOR;
   label values A2TXMTH A2TXMTH;
   label values A4KTXMTH A2TXMTH;
   label values A4TXMTH A2TXMTH;
   label values A6TXMTH A2TXMTH;
   label values A7TXMTH A2TXMTH;
   label values A2TXMUS A2TXMUS;
   label values A4KTXMUS A2TXMUS;
   label values A4TXMUS A2TXMUS;
   label values A6TXMUS A2TXMUS;
   label values A7TXMUS A2TXMUS;
   label values A2TXPE A2TXPE;
   label values A4KTXPE A2TXPE;
   label values A4TXPE A2TXPE;
   label values A6TXPE A2TXPE;
   label values A7TXPE A2TXPE;
   label values A2TXRDLA A2TXRDLA;
   label values A4KTXRDLA A2TXRDLA;
   label values A4TXRDLA A2TXRDLA;
   label values A6TXRDLA A2TXRDLA;
   label values A7TXRDLA A2TXRDLA;
   label values A2TXSCI A2TXSCI;
   label values A4KTXSCI A2TXSCI;
   label values A4TXSCI A2TXSCI;
   label values A6TXSCI A2TXSCI;
   label values A7TXSCI A2TXSCI;
   label values A2TXSOC A2TXSOC;
   label values A4KTXSOC A2TXSOC;
   label values A4TXSOC A2TXSOC;
   label values A6TXSOC A2TXSOC;
   label values A7TXSOC A2TXSOC;
   label values A2TXTBK A2TXTBK;
   label values A2TXTHTR A2TXTHTR;
   label values A4KTXTHTR A2TXTHTR;
   label values A4TXTHTR A2TXTHTR;
   label values A6TXTHTR A2TXTHTR;
   label values A7TXTHTR A2TXTHTR;
   label values A4USECMP A2USECMP;
   label values A4USEKIT A2USEKIT;
   label values A4USEOTH A2USEOTH;
   label values A4USETRD A2USETRD;
   label values A2VIDEO A2VIDEO;
   label values A2WRKSHT A2WRKSHT;
   label values A2WRKSMP A2WRKSMP;
   label values A4ADDTO100 A4ADDTO100F;
   label values A4ANCLS A4ANCLS;
   label values A4ANSGRPH A4ANSGRPH;
   label values A4ARR3OBJ A4ARR3OBJ;
   label values A4ATTRSHP A4ATTRSHP;
   label values A4BEHVR A4BEHVR;
   label values A6BEHVR A4BEHVR;
   label values A7BEHVR A4BEHVR;
   label values G8BEHVR A4BEHVR;
   label values G9BEHVR A4BEHVR;
   label values M8BEHVR A4BEHVR;
   label values M9BEHVR A4BEHVR;
   label values N8BEHVR A4BEHVR;
   label values N9BEHVR A4BEHVR;
   label values A4BSCPLT A4BSCPLT;
   label values A4CHARPLOT A4CHARPLOT;
   label values A4CLSBHV A4CLSBHV;
   label values A6CLSBHV A4CLSBHV;
   label values A7CLSBHV A4CLSBHV;
   label values A4CLSPAR A4CLSPAR;
   label values A6CLSPAR A4CLSPAR;
   label values A7CLSPAR A4CLSPAR;
   label values A4CLSPROP A4CLSPROP;
   label values A4CMPXINF A4CMPXINF;
   label values A4CMPXPRO A4CMPXPRO;
   label values A4CNSNSS A4CNSNSS;
   label values A6CNSNSS A4CNSNSS;
   label values A7CNSNSS A4CNSNSS;
   label values A4CNT120 A4CNT120F;
   label values A4CNT20QTY A4CNT20QTY;
   label values A4COMMSCI A4COMMSCI;
   label values A4COOPRT A4COOPRT;
   label values A6COOPRT A4COOPRT;
   label values A7COOPRT A4COOPRT;
   label values A4CREVNT A4CREVNT;
   label values A4CTADSUB A4CTADSUB;
   label values A4CULTRS A4CULTRS;
   label values A4DESCHAR A4DESCHAR;
   label values A4DIMCOMP A4DIMCOMP;
   label values A4DINFOS A4DINFOS;
   label values A4DPWHMWK A4DPWHMWK;
   label values A6DPWHMWK A4DPWHMWK;
   label values A7DPWHMWK A4DPWHMWK;
   label values G8DPWHMWK A4DPWHMWK;
   label values G9DPWHMWK A4DPWHMWK;
   label values M8DPWHMWK A4DPWHMWK;
   label values M9DPWHMWK A4DPWHMWK;
   label values N8DPWHMWK A4DPWHMWK;
   label values N9DPWHMWK A4DPWHMWK;
   label values A4DRWGRPH A4DRWGRPH;
   label values A4EFFRT A4EFFRT;
   label values A6EFFRT A4EFFRT;
   label values A7EFFRT A4EFFRT;
   label values A4EQLSIGN A4EQLSIGN;
   label values A4ESTLNG A4ESTLNG;
   label values A4FICNONF A4FICNONF;
   label values A4FIND10 A4FIND10F;
   label values A4FLLDIR A4FLLDIR;
   label values A6FLLDIR A4FLLDIR;
   label values A7FLLDIR A4FLLDIR;
   label values A4GENCSP A4GENCSP;
   label values A4GRPCHRT A4GRPCHRT;
   label values A4HGHSTD A4HGHSTD;
   label values A6HGHSTD A4HGHSTD;
   label values A7HGHSTD A4HGHSTD;
   label values A8HGHSTD A4HGHSTD;
   label values A8HGHSTDZ A4HGHSTD;
   label values A9HGHSTD A4HGHSTD;
   label values A9HGHSTDZ A4HGHSTD;
   label values A4HISTORY A4HISTORY;
   label values A4IMPPRG A4IMPPRG;
   label values A6IMPPRG A4IMPPRG;
   label values A7IMPPRG A4IMPPRG;
   label values A4INFPIEC A4INFPIEC;
   label values A4IRREGWD A4IRREGWD;
   label values A4KCLSBHV A4KCLSBHV;
   label values A4KCLSPAR A4KCLSPAR;
   label values A4KCNSNSS A4KCNSNSS;
   label values A4KCOOPRT A4KCOOPRT;
   label values A4KDBEHVR A4KDBEHVR;
   label values A4KDPWHMWK A4KDPWHMWK;
   label values A4KEFFRT A4KEFFRT;
   label values A4KFLLDIR A4KFLLDIR;
   label values A4KHGHSTD A4KHGHSTD;
   label values A4KIMPPRG A4KIMPPRG;
   label values A4KOFTFLN A4KOFTFLN;
   label values A4KPROJCT A4KPROJCT;
   label values A4KSTNTST A4KSTNTST;
   label values A4KTOCLSS A4KTOCLSS;
   label values A4KTOSTDR A4KTOSTDR;
   label values A4KTSTQZ A4KTSTQZ;
   label values A4KTXFLN A4KTXFLN;
   label values A4KWKINDP A4KWKINDP;
   label values A4KWKINDV A4KWKINDV;
   label values A4KWKLGRP A4KWKLGRP;
   label values A4KWKPEER A4KWKPEER;
   label values A4KWKSGRP A4KWKSGRP;
   label values A4KWRKSAM A4KWRKSAM;
   label values A4KWRKSTS A4KWRKSTS;
   label values A4LAWGVT A4LAWGVT;
   label values A4LNG2BY3 A4LNG2BY3F;
   label values A4LNGMULT A4LNGMULT;
   label values A4MAINID A4MAINID;
   label values A4MAINTEXT A4MAINTEXT;
   label values A4MANPHO A4MANPHO;
   label values A4MAPSKL A4MAPSKL;
   label values A4MEATOOL A4MEATOOL;
   label values A4NARRTV A4NARRTV;
   label values A4NATRSC A4NATRSC;
   label values A4NMRL120 A4NMRL120F;
   label values A4NUMQTY A4NUMQTY;
   label values A4NUTHLTH A4NUTHLTH;
   label values A4OFTFLN A4OFTFLN;
   label values A6OFTFLN A4OFTFLN;
   label values A7OFTFLN A4OFTFLN;
   label values A4OPINION A4OPINION;
   label values A4PACEINT A4PACEINT;
   label values A4PARTEQL A4PARTEQL;
   label values A4PORTION A4PORTION;
   label values A4PREDCT A4PREDCT;
   label values A4PREDICT A4PREDICT;
   label values A4PROJCT A4PROJCT;
   label values A6PROJCT A4PROJCT;
   label values A4RDACCR A4RDACCR;
   label values A4REASSUP A4REASSUP;
   label values A4RELQTY A4RELQTY;
   label values A4RELSYM A4RELSYM;
   label values A4RETELL A4RETELL;
   label values A4SEGWORD A4SEGWORD;
   label values A4SENCTXT A4SENCTXT;
   label values A4SENSES A4SENSES;
   label values A4SENSOBS A4SENSOBS;
   label values A4SHDLGT A4SHDLGT;
   label values A4SIDEQUA A4SIDEQUA;
   label values A4SIMDIFF A4SIMDIFF;
   label values A4SKIPCNT A4SKIPCNT;
   label values A4SLVADD3 A4SLVADD3F;
   label values A4SLVADSB A4SLVADSB;
   label values A4SLVCOIN A4SLVCOIN;
   label values A4SLVUKNM A4SLVUKNM;
   label values A4SNDWRD A4SNDWRD;
   label values A4SOLSPC A4SOLSPC;
   label values A4STNTST A4STNTST;
   label values A6STNTST A4STNTST;
   label values A4STTMTR A4STTMTR;
   label values A4TELLTIME A4TELLTIME;
   label values A4TENONES A4TENONES;
   label values A4TOCLSS A4TOCLSS;
   label values A6TOCLSS A4TOCLSS;
   label values A7TOCLSS A4TOCLSS;
   label values A4TOSTDR A4TOSTDR;
   label values A6TOSTDR A4TOSTDR;
   label values A7TOSTDR A4TOSTDR;
   label values A4TRIQUAD A4TRIQUAD;
   label values A4TSTQZ A4TSTQZ;
   label values A6TSTQZ A4TSTQZ;
   label values A4TXFLN A4TXFLN;
   label values A6TXFLN A4TXFLN;
   label values A7TXFLN A4TXFLN;
   label values A4USEANTH A4USEANTH;
   label values A4USEAUBK A4USEAUBK;
   label values A4USEBGBK A4USEBGBK;
   label values A4USEBSL A4USEBSL;
   label values A4USEDECB A4USEDECB;
   label values A4USEGLOS A4USEGLOS;
   label values A4USELEV A4USELEV;
   label values A4USEMAN A4USEMAN;
   label values A4USENEW A4USENEW;
   label values A4WETHER A4WETHER;
   label values A4WHOTELL A4WHOTELL;
   label values A4WKINDP A4WKINDP;
   label values A6WKINDP A4WKINDP;
   label values A4WKINDV A4WKINDV;
   label values A6WKINDV A4WKINDV;
   label values A4WKLGRP A4WKLGRP;
   label values A6WKLGRP A4WKLGRP;
   label values A4WKPEER A4WKPEER;
   label values A6WKPEER A4WKPEER;
   label values A4WKSGRP A4WKSGRP;
   label values A6WKSGRP A4WKSGRP;
   label values A4WRKSAM A4WRKSAM;
   label values A6WRKSAM A4WRKSAM;
   label values A4WRKSTS A4WRKSTS;
   label values A6WRKSTS A4WRKSTS;
   label values A4WRTTIME A4WRTTIME;
   label values A7WTBUSE A4WTBUSE;
   label values A6DIVMTH A6DIVRD;
   label values A6DIVRD A6DIVRD;
   label values A8OFTART A8OFTPROJ;
   label values A8OFTARTZ A8OFTPROJ;
   label values A8OFTDAN A8OFTPROJ;
   label values A8OFTDANZ A8OFTPROJ;
   label values A8OFTFLN A8OFTPROJ;
   label values A8OFTFLNZ A8OFTPROJ;
   label values A8OFTHTR A8OFTPROJ;
   label values A8OFTHTRZ A8OFTPROJ;
   label values A8OFTMTH A8OFTPROJ;
   label values A8OFTMTHZ A8OFTPROJ;
   label values A8OFTMUS A8OFTPROJ;
   label values A8OFTMUSZ A8OFTPROJ;
   label values A8OFTPE A8OFTPROJ;
   label values A8OFTPEZ A8OFTPROJ;
   label values A8OFTRDL A8OFTPROJ;
   label values A8OFTRDLZ A8OFTPROJ;
   label values A8OFTSCI A8OFTPROJ;
   label values A8OFTSCIZ A8OFTPROJ;
   label values A9OFTART A8OFTPROJ;
   label values A9OFTARTZ A8OFTPROJ;
   label values A9OFTDAN A8OFTPROJ;
   label values A9OFTDANZ A8OFTPROJ;
   label values A9OFTFLN A8OFTPROJ;
   label values A9OFTFLNZ A8OFTPROJ;
   label values A9OFTHTR A8OFTPROJ;
   label values A9OFTHTRZ A8OFTPROJ;
   label values A9OFTMTH A8OFTPROJ;
   label values A9OFTMTHZ A8OFTPROJ;
   label values A9OFTMUS A8OFTPROJ;
   label values A9OFTMUSZ A8OFTPROJ;
   label values A9OFTPE A8OFTPROJ;
   label values A9OFTPEZ A8OFTPROJ;
   label values A9OFTRDL A8OFTPROJ;
   label values A9OFTRDLZ A8OFTPROJ;
   label values A9OFTSCI A8OFTPROJ;
   label values A9OFTSCIZ A8OFTPROJ;
   label values A8CLSBHV A8RPTPARENT;
   label values A8CLSBHVZ A8RPTPARENT;
   label values A8CLSPAR A8RPTPARENT;
   label values A8CLSPARZ A8RPTPARENT;
   label values A8COOPRT A8RPTPARENT;
   label values A8COOPRTZ A8RPTPARENT;
   label values A8EFFRT A8RPTPARENT;
   label values A8EFFRTZ A8RPTPARENT;
   label values A8FLLDIR A8RPTPARENT;
   label values A8FLLDIRZ A8RPTPARENT;
   label values A8IMPPRG A8RPTPARENT;
   label values A8IMPPRGZ A8RPTPARENT;
   label values A8TOCLSS A8RPTPARENT;
   label values A8TOCLSSZ A8RPTPARENT;
   label values A8TOSTDR A8RPTPARENT;
   label values A8TOSTDRZ A8RPTPARENT;
   label values A9CLSBHV A8RPTPARENT;
   label values A9CLSBHVZ A8RPTPARENT;
   label values A9CLSPAR A8RPTPARENT;
   label values A9CLSPARZ A8RPTPARENT;
   label values A9COOPRT A8RPTPARENT;
   label values A9COOPRTZ A8RPTPARENT;
   label values A9EFFRT A8RPTPARENT;
   label values A9EFFRTZ A8RPTPARENT;
   label values A9FLLDIR A8RPTPARENT;
   label values A9FLLDIRZ A8RPTPARENT;
   label values A9IMPPRG A8RPTPARENT;
   label values A9IMPPRGZ A8RPTPARENT;
   label values A9TOCLSS A8RPTPARENT;
   label values A9TOCLSSZ A8RPTPARENT;
   label values A9TOSTDR A8RPTPARENT;
   label values A9TOSTDRZ A8RPTPARENT;
   label values A8TXART A8TIMEPROJ;
   label values A8TXARTZ A8TIMEPROJ;
   label values A8TXDAN A8TIMEPROJ;
   label values A8TXDANZ A8TIMEPROJ;
   label values A8TXFLN A8TIMEPROJ;
   label values A8TXFLNZ A8TIMEPROJ;
   label values A8TXMTH A8TIMEPROJ;
   label values A8TXMTHZ A8TIMEPROJ;
   label values A8TXMUS A8TIMEPROJ;
   label values A8TXMUSZ A8TIMEPROJ;
   label values A8TXPE A8TIMEPROJ;
   label values A8TXPEZ A8TIMEPROJ;
   label values A8TXRDLA A8TIMEPROJ;
   label values A8TXRDLAZ A8TIMEPROJ;
   label values A8TXSCI A8TIMEPROJ;
   label values A8TXSCIZ A8TIMEPROJ;
   label values A8TXSOC A8TIMEPROJ;
   label values A8TXSOCZ A8TIMEPROJ;
   label values A8TXTHTR A8TIMEPROJ;
   label values A8TXTHTRZ A8TIMEPROJ;
   label values A9TXART A8TIMEPROJ;
   label values A9TXARTZ A8TIMEPROJ;
   label values A9TXDAN A8TIMEPROJ;
   label values A9TXDANZ A8TIMEPROJ;
   label values A9TXFLN A8TIMEPROJ;
   label values A9TXFLNZ A8TIMEPROJ;
   label values A9TXMTH A8TIMEPROJ;
   label values A9TXMTHZ A8TIMEPROJ;
   label values A9TXMUS A8TIMEPROJ;
   label values A9TXMUSZ A8TIMEPROJ;
   label values A9TXPE A8TIMEPROJ;
   label values A9TXPEZ A8TIMEPROJ;
   label values A9TXRDLA A8TIMEPROJ;
   label values A9TXRDLAZ A8TIMEPROJ;
   label values A9TXSCI A8TIMEPROJ;
   label values A9TXSCIZ A8TIMEPROJ;
   label values A9TXSOC A8TIMEPROJ;
   label values A9TXSOCZ A8TIMEPROJ;
   label values A9TXTHTR A8TIMEPROJ;
   label values A9TXTHTRZ A8TIMEPROJ;
   label values A4KNATEXM B2NATEXM;
   label values A4NATEXM B2NATEXM;
   label values A6NATEXM B2NATEXM;
   label values A4KSTATCT B2STATCT;
   label values A4STATCT B2STATCT;
   label values A6STATCT B2STATCT;
   label values A7STATCT B2STATCT;
   label values A8STATCT B2STATCT;
   label values A9STATCT B2STATCT;
   label values A4KTGEND B2TGEND;
   label values A4TGEND B2TGEND;
   label values A6TGEND B2TGEND;
   label values A7TGEND B2TGEND;
   label values C1ATTLVL C1ATTLVL;
   label values C1COOPER C1COOPER;
   label values C1MOTIVA C1MOTIVA;
   label values C2ATTLVL C2ATTLVL;
   label values C2COOPER C2COOPER;
   label values C2MOTIVA C2MOTIVA;
   label values C3ATTLVL C3ATTLVL;
   label values C5ATTLVL C3ATTLVL;
   label values C3COOPER C3COOPER;
   label values C5COOPER C3COOPER;
   label values C3MOTIVA C3MOTIVA;
   label values C5MOTIVA C3MOTIVA;
   label values C4ATTLVL C4ATTLVL;
   label values C6ATTLVL C4ATTLVL;
   label values C7ATTLVL C4ATTLVL;
   label values C8ATTLVL C4ATTLVL;
   label values C9ATTLVL C4ATTLVL;
   label values C4COOPER C4COOPER;
   label values C6COOPER C4COOPER;
   label values C7COOPER C4COOPER;
   label values C8COOPER C4COOPER;
   label values C9COOPER C4COOPER;
   label values C4MOTIVA C4MOTIVA;
   label values C6MOTIVA C4MOTIVA;
   label values C7MOTIVA C4MOTIVA;
   label values C8MOTIVA C4MOTIVA;
   label values C9MOTIVA C4MOTIVA;
   label values A8CNSNSS D2TEACH;
   label values A8CNSNSSZ D2TEACH;
   label values A8COPSTF D2TEACH;
   label values A8COPSTFZ D2TEACH;
   label values A8ENCOUR D2TEACH;
   label values A8ENCOURZ D2TEACH;
   label values A8ENJOY D2TEACH;
   label values A8ENJOYZ D2TEACH;
   label values A8PSUPP D2TEACH;
   label values A8PSUPPZ D2TEACH;
   label values A8SETPRI D2TEACH;
   label values A8SETPRIZ D2TEACH;
   label values A8STNDLO D2TEACH;
   label values A8STNDLOZ D2TEACH;
   label values A8TEACH D2TEACH;
   label values A8TEACHZ D2TEACH;
   label values A9CNSNSS D2TEACH;
   label values A9CNSNSSZ D2TEACH;
   label values A9COPSTF D2TEACH;
   label values A9COPSTFZ D2TEACH;
   label values A9ENCOUR D2TEACH;
   label values A9ENCOURZ D2TEACH;
   label values A9ENJOY D2TEACH;
   label values A9ENJOYZ D2TEACH;
   label values A9PSUPP D2TEACH;
   label values A9PSUPPZ D2TEACH;
   label values A9SETPRI D2TEACH;
   label values A9SETPRIZ D2TEACH;
   label values A9STNDLO D2TEACH;
   label values A9STNDLOZ D2TEACH;
   label values A9TEACH D2TEACH;
   label values A9TEACHZ D2TEACH;
   label values X1ASMTMM F1ASMTMM;
   label values X3ASMTMM F1ASMTMM;
   label values X4ASMTMM F1ASMTMM;
   label values X5ASMTMM F1ASMTMM;
   label values X1ASMTYY F1ASMTYY;
   label values X2ASMTMM F2ASMTMM;
   label values X6ASMTMM F2ASMTMM;
   label values X7ASMTMM F2ASMTMM;
   label values X8ASMTMM F2ASMTMM;
   label values X9ASMTMM F2ASMTMM;
   label values X2ASMTYY F2ASMTYY;
   label values X4ASMTYY F2ASMTYY;
   label values X3ASMTYY F3ASMTYY;
   label values X7FRMEALFLG FRMEALFLG;
   label values X8FRMEALFLG FRMEALFLG;
   label values X9FRMEALFLG FRMEALFLG;
   label values G8SHOWS G8OFTBEHV;
   label values G8WORKS G8OFTBEHV;
   label values G9SHOWS G8OFTBEHV;
   label values G9WORKS G8OFTBEHV;
   label values G8WKINDP G8TIMEACTV;
   label values G8WKINDV G8TIMEACTV;
   label values G8WKLGRP G8TIMEACTV;
   label values G8WKPEER G8TIMEACTV;
   label values G8WKSGRP G8TIMEACTV;
   label values G9WKINDP G8TIMEACTV;
   label values G9WKINDV G8TIMEACTV;
   label values G9WKLGRP G8TIMEACTV;
   label values G9WKPEER G8TIMEACTV;
   label values G9WKSGRP G8TIMEACTV;
   label values G8ENJACT G9CHILDBEHV;
   label values G9ENJACT G9CHILDBEHV;
   label values A8TGEND GENDERNA;
   label values A8TGENDZ GENDERNA;
   label values A9TGEND GENDERNA;
   label values A9TGENDZ GENDERNA;
   label values S8GENDER GENDERNA;
   label values S9GENDER GENDERNA;
   label values IFP4TINCTH IFP4TINCTH;
   label values IFP7TINCTH IFP71F;
   label values IFP8TINCTH IFP81F;
   label values IFP9TINCTH IFP92F;
   label values IFX9PAR1OCC IFP92F;
   label values IFX9PAR1SCR IFP92F;
   label values IFX9PAR2OCC IFP92F;
   label values IFX9PAR2SCR IFP92F;
   label values IFX6FRMEAL IFS6PCTFLN;
   label values IFX7FRMEAL IFS6PCTFLN;
   label values IFX8FRMEAL IFS6PCTFLN;
   label values IFX9FRMEAL IFS6PCTFLN;
   label values IFX4FMEAL IFX4FMEAL;
   label values IFX4PAR1OCC IFX4PAR1OCC;
   label values IFX4PAR1SCR IFX4PAR1SCR;
   label values IFX4PAR2OCC IFX4PAR2OCC;
   label values IFX4PAR2SCR IFX4PAR2SCR;
   label values IFX4RMEAL IFX4RMEAL;
   label values IFX12PAR1ED IMPUTE;
   label values IFX12PAR2ED IMPUTE;
   label values IFX1PAR1SCR IMPUTE;
   label values IFX1PAR2SCR IMPUTE;
   label values IFX2FLCH2 IMPUTE;
   label values IFX2INCCAT IMPUTE;
   label values IFX2RLCH2 IMPUTE;
   label values M8WKINDP M8TIMEACTV;
   label values M8WKINDV M8TIMEACTV;
   label values M8WKLGRP M8TIMEACTV;
   label values M8WKPEER M8TIMEACTV;
   label values M8WKSGRP M8TIMEACTV;
   label values M9WKINDP M8TIMEACTV;
   label values M9WKINDV M8TIMEACTV;
   label values M9WKLGRP M8TIMEACTV;
   label values M9WKPEER M8TIMEACTV;
   label values M9WKSGRP M8TIMEACTV;
   label values N8WKINDP N8TIMEACTV;
   label values N8WKINDV N8TIMEACTV;
   label values N8WKLGRP N8TIMEACTV;
   label values N8WKPEER N8TIMEACTV;
   label values N8WKSGRP N8TIMEACTV;
   label values N9WKINDP N8TIMEACTV;
   label values N9WKINDV N8TIMEACTV;
   label values N9WKLGRP N8TIMEACTV;
   label values N9WKPEER N8TIMEACTV;
   label values N9WKSGRP N8TIMEACTV;
   label values P1CURMAR P1CURMAR;
   label values P1DAD_1 P1DAD1F;
   label values P1DAD_2 P1DAD2F;
   label values P1EXPECT P1EXPECT;
   label values P7EXPECT P1EXPECT;
   label values P9EXPECT P1EXPECT;
   label values P6PRACTC P1GAMES;
   label values P8PRACTC P1GAMES;
   label values P9PRACTC P1GAMES;
   label values P1HSCALE P1HSCALE;
   label values P1MOM_1 P1MOM1F;
   label values P1MOM_2 P1MOM2F;
   label values P1NUMBRS P1NUMBRS;
   label values P1PRMLNG P1PRMLNG;
   label values P1READBK P1READBK;
   label values P4READBK P1READBK;
   label values P6READBK P1READBK;
   label values P1SEX_1 P1SEX1F;
   label values P1SEX_2 P1SEX2F;
   label values P2CURMAR P2CURMAR;
   label values P4CURMAR P2CURMAR;
   label values P6CURMAR P2CURMAR;
   label values P7CURMAR P2CURMAR;
   label values P8CURMAR P2CURMAR;
   label values P9CURMAR P2CURMAR;
   label values P2DAD_1 P2DAD1F;
   label values P4DAD_1 P2DAD1F;
   label values P6DAD_1 P2DAD1F;
   label values P7DAD_1 P2DAD1F;
   label values P8DAD_1 P2DAD1F;
   label values P9DAD_1 P2DAD1F;
   label values P2DAD_2 P2DAD2F;
   label values P4DAD_2 P2DAD2F;
   label values P6DAD_2 P2DAD2F;
   label values P7DAD_2 P2DAD2F;
   label values P2HSCALE P2HSCALE;
   label values P4HSCALE P2HSCALE;
   label values P6HSCALE P2HSCALE;
   label values P7HSCALE P2HSCALE;
   label values P8HSCALE P2HSCALE;
   label values P9HSCALE P2HSCALE;
   label values P2MOM_1 P2MOM1F;
   label values P4MOM_1 P2MOM1F;
   label values P6MOM_1 P2MOM1F;
   label values P7MOM_1 P2MOM1F;
   label values P8MOM_1 P2MOM1F;
   label values P9MOM_1 P2MOM1F;
   label values P2MOM_2 P2MOM2F;
   label values P4MOM_2 P2MOM2F;
   label values P6MOM_2 P2MOM2F;
   label values P7MOM_2 P2MOM2F;
   label values P8MOM_2 P2MOM2F;
   label values P9MOM_2 P2MOM2F;
   label values P2SEX_1 P2SEX1F;
   label values P4SEX_1 P2SEX1F;
   label values P6SEX_1 P2SEX1F;
   label values P7SEX_1 P2SEX1F;
   label values P8SEX_1 P2SEX1F;
   label values P9SEX_1 P2SEX1F;
   label values P2SEX_2 P2SEX2F;
   label values P4SEX_2 P2SEX2F;
   label values P6SEX_2 P2SEX2F;
   label values P7SEX_2 P2SEX2F;
   label values P8SEX_2 P2SEX2F;
   label values P9SEX_2 P2SEX2F;
   label values P3RDBKTC P3RDBKTC;
   label values P5RDBKTC P3RDBKTC;
   label values P4PRMLNG P4PRMLNG;
   label values IFP6TINCTH P6IMPFLG1F;
   label values IFX6PAR1OCC P6IMPFLG1F;
   label values IFX6PAR1SCR P6IMPFLG1F;
   label values IFX6PAR2OCC P6IMPFLG1F;
   label values IFX6PAR2SCR P6IMPFLG1F;
   label values P6PRMLNG P6PRMLNG;
   label values P9PRMLNG P6PRMLNG;
   label values P8DAD_2 P8DAD2F;
   label values P9DAD_2 P8DAD2F;
   label values S2ABSENT S2ABSENT;
   label values S4ABSENT S2ABSENT;
   label values S6ABSENT S2ABSENT;
   label values S7ABSENT S2ABSENT;
   label values S2ALCOHL S2ALCOHL;
   label values S4ALCOHL S2ALCOHL;
   label values S6ALCOHL S2ALCOHL;
   label values S2ARTOK S2ARTOK;
   label values S2AUDTOK S2AUDTOK;
   label values S2BULLY S2BULLY;
   label values S4BULLY S2BULLY;
   label values S6BULLY S2BULLY;
   label values S7BULLY S2BULLY;
   label values S2CAFEOK S2CAFEOK;
   label values S2CLSSOK S2CLSSOK;
   label values S2CNSNSS S2CNSNSS;
   label values S4CNSNSS S2CNSNSS;
   label values S6CNSNSS S2CNSNSS;
   label values S2COMPOK S2COMPOK;
   label values S2CONFLC S2CONFLC;
   label values S4CONFLC S2CONFLC;
   label values S6CONFLC S2CONFLC;
   label values S7CONFLC S2CONFLC;
   label values S2DISORD S2DISORD;
   label values S4DISORD S2DISORD;
   label values S6DISORD S2DISORD;
   label values S7DISORD S2DISORD;
   label values S2DRGFRQ S2DRGFRQ;
   label values S4DRGFRQ S2DRGFRQ;
   label values S6DRGFRQ S2DRGFRQ;
   label values S2EDLVL S2EDLVL;
   label values S4EDLVL S2EDLVL;
   label values S6EDLVL S2EDLVL;
   label values S7EDLVL S2EDLVL;
   label values S8EDLVL S2EDLVL;
   label values S9EDLVL S2EDLVL;
   label values S2GENDER S2GENDER;
   label values S4GENDER S2GENDER;
   label values S6GENDER S2GENDER;
   label values S7GENDER S2GENDER;
   label values S2GYMOK S2GYMOK;
   label values S2LBRYOK S2LBRYOK;
   label values S2MULTOK S2MULTOK;
   label values S2MUSCOK S2MUSCOK;
   label values S2PLAYOK S2PLAYOK;
   label values S2PTCONF S2PTCONF;
   label values S4PTCONF S2PTCONF;
   label values S6PTCONF S2PTCONF;
   label values S7PTCONF S2PTCONF;
   label values S2RPRTCD S2RPRTCD;
   label values S2SPPRT S2SPPRT;
   label values S4SPPRT S2SPPRT;
   label values S6SPPRT S2SPPRT;
   label values S7SPPRT S2SPPRT;
   label values S2STTEST S2STTEST;
   label values S4STTEST S2STTEST;
   label values S6STTEST S2STTEST;
   label values S7STTEST S2STTEST;
   label values S2THEFT S2THEFT;
   label values S4THEFT S2THEFT;
   label values S6THEFT S2THEFT;
   label values S2VANDAL S2VANDAL;
   label values S4VANDAL S2VANDAL;
   label values S6VANDAL S2VANDAL;
   label values S4CSALDE S4CSALDE;
   label values S6CSALDE S4CSALDE;
   label values S7CSALDE S4CSALDE;
   label values S4CSALIN S4CSALIN;
   label values S6CSALIN S4CSALIN;
   label values S7CSALIN S4CSALIN;
   label values S4ARTOK S4FACSOK;
   label values S4AUDTOK S4FACSOK;
   label values S4CAFEOK S4FACSOK;
   label values S4CLSSOK S4FACSOK;
   label values S4COMPOK S4FACSOK;
   label values S4GYMOK S4FACSOK;
   label values S4LBRYOK S4FACSOK;
   label values S4MULTOK S4FACSOK;
   label values S4MUSCOK S4FACSOK;
   label values S4PLAYOK S4FACSOK;
   label values S6ARTOK S4FACSOK;
   label values S6AUDTOK S4FACSOK;
   label values S6CAFEOK S4FACSOK;
   label values S6CLSSOK S4FACSOK;
   label values S6COMPOK S4FACSOK;
   label values S6GYMOK S4FACSOK;
   label values S6LBRYOK S4FACSOK;
   label values S6MULTOK S4FACSOK;
   label values S6MUSCOK S4FACSOK;
   label values S6PLAYOK S4FACSOK;
   label values S7CLSSOK S4FACSOK;
   label values S7COMPOK S4FACSOK;
   label values S7GYMOK S4FACSOK;
   label values S7LBRYOK S4FACSOK;
   label values S7PLAYOK S4FACSOK;
   label values S4FUNDDC S4FUNDDC;
   label values S6FUNDDC S4FUNDDC;
   label values S7FUNDDC S4FUNDDC;
   label values S4RPTCRD S4RPTCRD;
   label values S6RPTCRD S4RPTCRD;
   label values S7RPTCRD S4RPTCRD;
   label values S7ALCOHL S7THEFT;
   label values S7DRGFRQ S7THEFT;
   label values S7THEFT S7THEFT;
   label values S7VANDAL S7THEFT;
   label values S8PTCONF S8FREQACTIV;
   label values S8RPTCRD S8FREQACTIV;
   label values S8STTEST S8FREQACTIV;
   label values S9PTCONF S8FREQACTIV;
   label values S9RPTCRD S8FREQACTIV;
   label values S9STTEST S8FREQACTIV;
   label values S8ALCOHL S8NBGHRPRBB;
   label values S8DRGFRQ S8NBGHRPRBB;
   label values S8THEFT S8NBGHRPRBB;
   label values S8VANDAL S8NBGHRPRBB;
   label values S8BULLY S8NBGHRPROB;
   label values S8CONFLC S8NBGHRPROB;
   label values S8DISORD S8NBGHRPROB;
   label values S9ALCOHL S8NBGHRPROB;
   label values S9BULLY S8NBGHRPROB;
   label values S9CONFLC S8NBGHRPROB;
   label values S9DISORD S8NBGHRPROB;
   label values S9DRGFRQ S8NBGHRPROB;
   label values S9THEFT S8NBGHRPROB;
   label values S9VANDAL S8NBGHRPROB;
   label values S8CSALDE S8SCHLCHNGS;
   label values S8CSALIN S8SCHLCHNGS;
   label values S8FUNDDC S8SCHLCHNGS;
   label values S9CSALDE S8SCHLCHNGS;
   label values S9CSALIN S8SCHLCHNGS;
   label values S9FUNDDC S8SCHLCHNGS;
   label values S8ABSENT S8SCHPROB;
   label values S9ABSENT S8SCHPROB;
   label values T1CMPSEN T1CMPSEN;
   label values T1READS T1READS;
   label values T1SHOWS T1SHOWS;
   label values T1SOLVE T1SOLVE;
   label values T1STRAT T1STRAT;
   label values T1WORKS T1WORKS;
   label values T1WRITE T1WRITE;
   label values T2CMPSEN T2CMPSEN;
   label values T4KCMPSEN T2CMPSEN;
   label values T2GRADE T2GRADE;
   label values T2READS T2READS;
   label values T4KREADS T2READS;
   label values T2SHOWS T2SHOWS;
   label values T3SHOWS T2SHOWS;
   label values T4KSHOWS T2SHOWS;
   label values T4SHOWS T2SHOWS;
   label values T5SHOWS T2SHOWS;
   label values T6SHOWS T2SHOWS;
   label values T7SHOWS T2SHOWS;
   label values T2SOLVE T2SOLVE;
   label values T4KSOLVE T2SOLVE;
   label values T2STRAT T2STRAT;
   label values T4KSTRAT T2STRAT;
   label values T2WORKS T2WORKS;
   label values T3WORKS T2WORKS;
   label values T4KWORKS T2WORKS;
   label values T4WORKS T2WORKS;
   label values T5WORKS T2WORKS;
   label values T6WORKS T2WORKS;
   label values T7WORKS T2WORKS;
   label values T2WRITE T2WRITE;
   label values T4KWRITE T2WRITE;
   label values T3GRADE T3GRADE;
   label values X_CHSEX_R X_CHSEX;
   label values X_DOBMM_R X_DOBMM;
   label values X12LANGST X12LNGST;
   label values X4LANGST X12LNGST;
   label values X6LANGST X12LNGST;
   label values X9LANGST X12LNGST;
   label values X12PAR1ED_I X12PR1EI;
   label values X4PAR1ED_I X12PR1EI;
   label values X7PAR1ED_I X12PR1EI;
   label values X8PAR1ED_I X12PR1EI;
   label values X9PAR1ED_I X12PR1EI;
   label values X12PAR2ED_I X12PR2EI;
   label values X4PAR2ED_I X12PR2EI;
   label values X7PAR2ED_I X12PR2EI;
   label values X8PAR2ED_I X12PR2EI;
   label values X9PAR2ED_I X12PR2EI;
   label values X_RACETH_R X12RACTH;
   label values X_RACETHP_R X12RACTP;
   label values X1ASMTDD X1ASMTDD;
   label values X2ASMTDD X1ASMTDD;
   label values X3ASMTDD X1ASMTDD;
   label values X4ASMTDD X1ASMTDD;
   label values X5ASMTDD X1ASMTDD;
   label values X6ASMTDD X1ASMTDD;
   label values X7ASMTDD X1ASMTDD;
   label values X8ASMTDD X1ASMTDD;
   label values X9ASMTDD X1ASMTDD;
   label values X1HPARNT X1HPARNT;
   label values X1KSCTYP X1KSCTYP;
   label values X4SCTYP X1KSCTYP;
   label values X6SCTYP X1KSCTYP;
   label values X7SCTYP X1KSCTYP;
   label values X8SCTYP X1KSCTYP;
   label values X9SCTYP X1KSCTYP;
   label values X1LOCALE X1LOCALE;
   label values X4LOCALE X1LOCALE;
   label values X6LOCALE X1LOCALE;
   label values X7LOCALE X1LOCALE;
   label values X8LOCALE X1LOCALE;
   label values X9LOCALE X1LOCALE;
   label values X1PAR1EMP X1PR1EMP;
   label values X4PAR1EMP_I X1PR1EMP;
   label values X6PAR1EMP_I X1PR1EMP;
   label values X9PAR1EMP_I X1PR1EMP;
   label values X1PAR1OCC_I X1PR1OCC;
   label values X4PAR1OCC_I X1PR1OCC;
   label values X6PAR1OCC_I X1PR1OCC;
   label values X9PAR1OCC_I X1PR1OCC;
   label values X1PAR1RAC X1PR1RAC;
   label values X4PAR1RAC X1PR1RAC;
   label values X6PAR1RAC X1PR1RAC;
   label values X7PAR1RAC X1PR1RAC;
   label values X8PAR1RAC X1PR1RAC;
   label values X9PAR1RAC X1PR1RAC;
   label values X1PAR2EMP X1PR2EMP;
   label values X4PAR2EMP_I X1PR2EMP;
   label values X6PAR2EMP_I X1PR2EMP;
   label values X9PAR2EMP_I X1PR2EMP;
   label values X1PAR2OCC_I X1PR2OCC;
   label values X4PAR2OCC_I X1PR2OCC;
   label values X6PAR2OCC_I X1PR2OCC;
   label values X9PAR2OCC_I X1PR2OCC;
   label values X1PAR2RAC X1PR2RAC;
   label values X4PAR2RAC X1PR2RAC;
   label values X6PAR2RAC X1PR2RAC;
   label values X7PAR2RAC X1PR2RAC;
   label values X8PAR2RAC X1PR2RAC;
   label values X9PAR2RAC X1PR2RAC;
   label values X1PUBPRI X1PUBPRI;
   label values X1REGION X1REGION;
   label values X2HIGGRD X2HIGGRD;
   label values X4HIGGRD X2HIGGRD;
   label values X6HIGGRD X2HIGGRD;
   label values X7HIGGRD X2HIGGRD;
   label values X8HIGGRD X2HIGGRD;
   label values X9HIGGRD X2HIGGRD;
   label values X2HPARNT X2HPARNT;
   label values X4HPARNT X2HPARNT;
   label values X6HPARNT X2HPARNT;
   label values X7HPARNT X2HPARNT;
   label values X8HPARNT X2HPARNT;
   label values X9HPARNT X2HPARNT;
   label values X2INCCAT_I X2INCATI;
   label values X4INCCAT_I X2INCATI;
   label values X6INCCAT_I X2INCATI;
   label values X7INCCAT_I X2INCATI;
   label values X8INCCAT_I X2INCATI;
   label values X9INCCAT_I X2INCATI;
   label values X2KENRLS X2KENRLS;
   label values X4ENRLS X2KENRLS;
   label values X6ENRLS X2KENRLS;
   label values X7ENRLS_R X2KENRLS;
   label values X8ENRLS X2KENRLS;
   label values X9ENRLS X2KENRLS;
   label values X2KSCTYP X2KSCTYP;
   label values X2LOCALE X2LOCALE;
   label values X3LOCALE X2LOCALE;
   label values X5LOCALE X2LOCALE;
   label values X2LOWGRD X2LOWGRD;
   label values X4LOWGRD X2LOWGRD;
   label values X6LOWGRD X2LOWGRD;
   label values X7LOWGRD X2LOWGRD;
   label values X8LOWGRD X2LOWGRD;
   label values X9LOWGRD X2LOWGRD;
   label values X2PAR1RAC X2PR1RAC;
   label values X2PAR2RAC X2PR2RAC;
   label values X2PUBPRI X2PUBPRI;
   label values X3PUBPRI X2PUBPRI;
   label values X5PUBPRI X2PUBPRI;
   label values X2REGION X2REGION;
   label values X3REGION X2REGION;
   label values X5REGION X2REGION;
   label values X2SCHBMM X2SCHBMM;
   label values X2SCHBYY X2SCHBYY;
   label values X2SCHEMM X2SCHEMM;
   label values X4SCHEMM X2SCHEMM;
   label values X6SCHEMM X2SCHEMM;
   label values X7SCHEMM X2SCHEMM;
   label values X8SCHEMM X2SCHEMM;
   label values X9SCHEMM X2SCHEMM;
   label values X2SCHEYY X2SCHEYY;
   label values X4SCHEYY X2SCHEYY;
   label values X3FALLSMP X3FALLSMP;
   label values X3GRDLVL X3GRDLVL;
   label values X4GRDLVL X4GRDLVL;
   label values X6GRDLVL X4GRDLVL;
   label values X4PUBPRI X4PUBPRI;
   label values X6PUBPRI X4PUBPRI;
   label values X7PUBPRI X4PUBPRI;
   label values X8PUBPRI X4PUBPRI;
   label values X9PUBPRI X4PUBPRI;
   label values X4REGION X4REGION;
   label values X6REGION X4REGION;
   label values X7REGION X4REGION;
   label values X8REGION X4REGION;
   label values X9REGION X4REGION;
   label values X4SCHBMM X4SCHBMM;
   label values X6SCHBMM X4SCHBMM;
   label values X7SCHBMM X4SCHBMM;
   label values X8SCHBMM X4SCHBMM;
   label values X9SCHBMM X4SCHBMM;
   label values X4SCHBYY X4SCHBYY;
   label values X5ASMTYY X5ASMTYY;
   label values X5GRDLVL X5GRDLVL;
   label values X6SCHBYY X6SCHBYY;
   label values X6SCHEYY X6SCHEYY;
   label values X7GRDLVL X7GRDLVL;
   label values X7SCHBYY X7SCHBYY;
   label values X7SCHEYY X7SCHEYY;
   label values X8GRDLVL X8GRDLVL;
   label values X8SCHBYY X8SCHBYY;
   label values X8SCHEYY X8SCHEYY;
   label values X9GRDLVL X9GRDLVL;
   label values X9SCHBYY X9SCHBYY;
   label values X9SCHEYY X9SCHEYY;
   label values X12YRRND XF2YRRND;
   label values X4YRRND XF2YRRND;
   label values X6YRRND XF2YRRND;
   label values X7YRRND XF2YRRND;
   label values X8YRRND XF2YRRND;
   label values X9YRRND XF2YRRND;
   label values S4TRANSL YN159F;
   label values S6TRANSL YN159F;
   label values S7T3PRDV YN159F;
   label values S7TRANSL YN159F;
   label values S7TT1 YN159F;
   label values S8TRANSL YN159F;
   label values S2T3PRDV YN19F;
   label values S2TRANSL YN19F;
   label values S2TT1 YN19F;
   label values S4T3PRDV YN19F;
   label values S4TT1 YN19F;
   label values S6T3PRDV YN19F;
   label values S6TT1 YN19F;
   label values S8TT1 YN19F;
   label values S9TRANSL YN19F;
   label values S9TT1 YN19F;
   label values P2WICCHD YN1RDK9F;
   label values P2WICMOM YN1RDK9F;
   label values P4ATTENB YN1RDK9F;
   label values P4ATTENP YN1RDK9F;
   label values P4ATTENS YN1RDK9F;
   label values P4PTCONF YN1RDK9F;
   label values P4VOLSCH YN1RDK9F;
   label values P6ATTENB YN1RDK9F;
   label values P6ATTENP YN1RDK9F;
   label values P6ATTENS YN1RDK9F;
   label values P6PTCONF YN1RDK9F;
   label values P6VOLSCH YN1RDK9F;
   label values P7ATTENB YN1RDK9F;
   label values P7ATTENP YN1RDK9F;
   label values P7ATTENS YN1RDK9F;
   label values P7PTCONF YN1RDK9F;
   label values P7VOLSCH YN1RDK9F;
   label values P8ATTENB YN1RDK9F;
   label values P8ATTENP YN1RDK9F;
   label values P8ATTENS YN1RDK9F;
   label values P8PTCONF YN1RDK9F;
   label values P8VOLSCH YN1RDK9F;
   label values P9ATTENB YN1RDK9F;
   label values P9ATTENP YN1RDK9F;
   label values P9ATTENS YN1RDK9F;
   label values P9PTCONF YN1RDK9F;
   label values P9VOLSCH YN1RDK9F;
   label values A1AMINAN YN9F;
   label values A1ARTARE YN9F;
   label values A1ASIAN YN9F;
   label values A1BLACK YN9F;
   label values A1COMPAR YN9F;
   label values A1DRAMAR YN9F;
   label values A1HAWPI YN9F;
   label values A1HISP YN9F;
   label values A1LISTNC YN9F;
   label values A1MATHAR YN9F;
   label values A1PLAYAR YN9F;
   label values A1READAR YN9F;
   label values A1SCIAR YN9F;
   label values A1WATRSA YN9F;
   label values A1WHITE YN9F;
   label values A1WRTCNT YN9F;
   label values A4AMINAN YN9F;
   label values A4ASIAN YN9F;
   label values A4BLACK YN9F;
   label values A4HAWPI YN9F;
   label values A4HISP YN9F;
   label values A4KAMINAN YN9F;
   label values A4KARTARE YN9F;
   label values A4KASIAN YN9F;
   label values A4KBLACK YN9F;
   label values A4KCOMPAR YN9F;
   label values A4KDRAMAR YN9F;
   label values A4KHAWPI YN9F;
   label values A4KHISP YN9F;
   label values A4KLISTNC YN9F;
   label values A4KMATHAR YN9F;
   label values A4KPUZBLK YN9F;
   label values A4KREADAR YN9F;
   label values A4KSCIAR YN9F;
   label values A4KWHITE YN9F;
   label values A4KWRTCNT YN9F;
   label values A4KWTRSAND YN9F;
   label values A4WHITE YN9F;
   label values A6AMINAN YN9F;
   label values A6ASIAN YN9F;
   label values A6BLACK YN9F;
   label values A6HAWPI YN9F;
   label values A6HISP YN9F;
   label values A6WHITE YN9F;
   label values A7AMINAN YN9F;
   label values A7ASIAN YN9F;
   label values A7BLACK YN9F;
   label values A7HAWPI YN9F;
   label values A7HISP YN9F;
   label values A7WHITE YN9F;
   label values A8AMINAN YN9F;
   label values A8AMINANZ YN9F;
   label values A8ASIAN YN9F;
   label values A8ASIANZ YN9F;
   label values A8BLACK YN9F;
   label values A8BLACKZ YN9F;
   label values A8HAWPI YN9F;
   label values A8HAWPIZ YN9F;
   label values A8HISP YN9F;
   label values A8HISPZ YN9F;
   label values A8WHITE YN9F;
   label values A8WHITEZ YN9F;
   label values A9AMINAN YN9F;
   label values A9AMINANZ YN9F;
   label values A9ASIAN YN9F;
   label values A9ASIANZ YN9F;
   label values A9BLACK YN9F;
   label values A9BLACKZ YN9F;
   label values A9HAWPI YN9F;
   label values A9HAWPIZ YN9F;
   label values A9HISP YN9F;
   label values A9HISPZ YN9F;
   label values A9WHITE YN9F;
   label values A9WHITEZ YN9F;
   label values S2AMINAN YN9F;
   label values S2ASIAN YN9F;
   label values S2BLACK YN9F;
   label values S2FUNDLV YN9F;
   label values S2HAWPI YN9F;
   label values S2HISP YN9F;
   label values S2WHITE YN9F;
   label values S4AMINAN YN9F;
   label values S4ASIAN YN9F;
   label values S4BLACK YN9F;
   label values S4CSLYFZ YN9F;
   label values S4HAWPI YN9F;
   label values S4HISP YN9F;
   label values S4WHITE YN9F;
   label values S6AMINAN YN9F;
   label values S6ASIAN YN9F;
   label values S6BLACK YN9F;
   label values S6CSLYFZ YN9F;
   label values S6HAWPI YN9F;
   label values S6HISP YN9F;
   label values S6WHITE YN9F;
   label values S7AMINAN YN9F;
   label values S7ASIAN YN9F;
   label values S7BLACK YN9F;
   label values S7CSLYFZ YN9F;
   label values S7CTECYN YN9F;
   label values S7GIFTYN YN9F;
   label values S7HAWPI YN9F;
   label values S7HISP YN9F;
   label values S7LIBRYN YN9F;
   label values S7MATHYN YN9F;
   label values S7NURSYN YN9F;
   label values S7PSYCYN YN9F;
   label values S7RDTCYN YN9F;
   label values S7WHITE YN9F;
   label values S8AMINAN YN9F;
   label values S8ASIAN YN9F;
   label values S8BLACK YN9F;
   label values S8CSLYFZ YN9F;
   label values S8CTECYN YN9F;
   label values S8GIFTYN YN9F;
   label values S8HAWPI YN9F;
   label values S8HISP YN9F;
   label values S8LIBRYN YN9F;
   label values S8MATHYN YN9F;
   label values S8NURSYN YN9F;
   label values S8PSYCYN YN9F;
   label values S8RDTCYN YN9F;
   label values S8WHITE YN9F;
   label values S9AMINAN YN9F;
   label values S9ASIAN YN9F;
   label values S9BLACK YN9F;
   label values S9CSLYFZ YN9F;
   label values S9CTECYN YN9F;
   label values S9GIFTYN YN9F;
   label values S9HAWPI YN9F;
   label values S9HISP YN9F;
   label values S9LIBRYN YN9F;
   label values S9MATHYN YN9F;
   label values S9NURSYN YN9F;
   label values S9PSYCYN YN9F;
   label values S9RDTCYN YN9F;
   label values S9WHITE YN9F;
   label values X_AMINAN_R YN9F;
   label values X_ASIAN_R YN9F;
   label values X_BLACK_R YN9F;
   label values X_HAWPI_R YN9F;
   label values X_HISP_R YN9F;
   label values X_MULTR_R YN9F;
   label values X_WHITE_R YN9F;
   label values X12MOMAR YN9F;
   label values X1FIRKDG YN9F;
   label values P1FSTAMP YNRDK9F;
   label values P1TANF YNRDK9F;
   label values P1WICCHD YNRDK9F;
   label values P1WICMOM YNRDK9F;
   label values P2ATTENB YNRDK9F;
   label values P2ATTENP YNRDK9F;
   label values P2ATTENS YNRDK9F;
   label values P2FSTAMP YNRDK9F;
   label values P2PTCONF YNRDK9F;
   label values P2TANF YNRDK9F;
   label values P2VOLSCH YNRDK9F;
   label values P3SUMSCH YNRDK9F;
   label values P4ASTHMA YNRDK9F;
   label values P4FSTAMP YNRDK9F;
   label values P4TANF YNRDK9F;
   label values P6ASTHMA YNRDK9F;
   label values P6FSTAMP YNRDK9F;
   label values P6TANF YNRDK9F;
   label values P7ASTHMA YNRDK9F;
   label values P8ASTHMA YNRDK9F;
   label values P8FSTAMP YNRDK9F;
   label values P8TANF YNRDK9F;
   label values P9ASTHMA YNRDK9F;
   label values P9FSTAMP YNRDK9F;
   label values P9TANF YNRDK9F;
   
/************************
SAVE DATA IN STATA FORMAT
*************************/  
save "${data_directory}eclsk11v1.dta", replace ;
clear ;

infile using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\eclsk11\eclsk11\dataextract\eclsk11_extract11.30.21.dct" ;

keep if  (X1PUBPRI == 1 | 
       X1PUBPRI == 2 | 
       X1PUBPRI == -1 | 
       X1PUBPRI == -9 | 
       X1PUBPRI == .); 
   keep if (X2PUBPRI == 1 | 
       X2PUBPRI == 2 | 
       X2PUBPRI == -1 | 
       X2PUBPRI == -9); 
   keep if (X3PUBPRI == 1 | 
       X3PUBPRI == 2 | 
       X3PUBPRI == -1 | 
       X3PUBPRI == -9 | 
       X3PUBPRI == .); 
   keep if (X4PUBPRI == 1 | 
       X4PUBPRI == 2 | 
       X4PUBPRI == -1 | 
       X4PUBPRI == -9 | 
       X4PUBPRI == .); 
   keep if (X5PUBPRI == 1 | 
       X5PUBPRI == 2 | 
       X5PUBPRI == -1 | 
       X5PUBPRI == -9 | 
       X5PUBPRI == .); 
   keep if (X6PUBPRI == 1 | 
       X6PUBPRI == 2 | 
       X6PUBPRI == -1 | 
       X6PUBPRI == -9 | 
       X6PUBPRI == .); 
   keep if (X7PUBPRI == 1 | 
       X7PUBPRI == 2 | 
       X7PUBPRI == -1 | 
       X7PUBPRI == -9 | 
       X7PUBPRI == .); 
   keep if (X8PUBPRI == 1 | 
       X8PUBPRI == 2 | 
       X8PUBPRI == -1 | 
       X8PUBPRI == -9 | 
       X8PUBPRI == .); 
   keep if (X9PUBPRI == 1 | 
       X9PUBPRI == 2 | 
       X9PUBPRI == -1 | 
       X9PUBPRI == -9 | 
       X9PUBPRI == .); 
   keep if (X1KSCTYP == 1 | 
       X1KSCTYP == 2 | 
       X1KSCTYP == 3 | 
       X1KSCTYP == 4 | 
       X1KSCTYP == -1 | 
       X1KSCTYP == -9 | 
       X1KSCTYP == .); 
   keep if (X2KSCTYP == 1 | 
       X2KSCTYP == 2 | 
       X2KSCTYP == 3 | 
       X2KSCTYP == 4 | 
       X2KSCTYP == -1 | 
       X2KSCTYP == -9); 
   keep if (X4SCTYP == 1 | 
       X4SCTYP == 2 | 
       X4SCTYP == 3 | 
       X4SCTYP == 4 | 
       X4SCTYP == -1 | 
       X4SCTYP == -9 | 
       X4SCTYP == .); 
   keep if (X6SCTYP == 1 | 
       X6SCTYP == 2 | 
       X6SCTYP == 3 | 
       X6SCTYP == 4 | 
       X6SCTYP == -1 | 
       X6SCTYP == -9 | 
       X6SCTYP == .); 
   keep if (X7SCTYP == 1 | 
       X7SCTYP == 2 | 
       X7SCTYP == 3 | 
       X7SCTYP == 4 | 
       X7SCTYP == -1 | 
       X7SCTYP == -9 | 
       X7SCTYP == .); 
   keep if (X8SCTYP == 1 | 
       X8SCTYP == 2 | 
       X8SCTYP == 3 | 
       X8SCTYP == 4 | 
       X8SCTYP == -1 | 
       X8SCTYP == -9 | 
       X8SCTYP == .); 
   keep if (X9SCTYP == 1 | 
       X9SCTYP == 2 | 
       X9SCTYP == 3 | 
       X9SCTYP == 4 | 
       X9SCTYP == -1 | 
       X9SCTYP == -9 | 
       X9SCTYP == .);
   label define P1BUILD
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1CHORES
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1CHREAD
      1  "1: NEVER"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1GAMES
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1NATURE
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1NUMBRS
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1READBK
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3-6 TIMES A WEEK"  
      4  "4: EVERY DAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1SINGSO
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1SPORT
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P1TELLST
      1  "1: NOT AT ALL"  
      2  "2: ONCE OR TWICE A WEEK"  
      3  "3: 3 TO 6 TIMES A WEEK"  
      4  "4: EVERYDAY"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2APPETI
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2BLUE
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2BOTHER
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2DEPRES
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2EFFORT
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2FEARFL
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2KPMIND
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2LONELY
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2NOTGO
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2RESTLS
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2SAD
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P2TALKLS
      1  "1: NEVER"  
      2  "2: SOME OF THE TIME"  
      3  "3: A MODERATE AMOUNT OF THE TIME"  
      4  "4: MOST OF THE TIME"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define P4HOUSIT
      1  "1: OWN HOUSE OR CONDOMINIUM"  
      2  "2: RENT HOUSE OR APARTMENT"  
      3  "3: EXCHANGE SERVICES FOR HOUSING"  
      4  "4: NOT PAYING FOR HOUSING"  
      5  "5: LIVES IN TEMPORARY HOUSING OR SHELTER"  
      6  "6: LIVES WITH RELATIVE OR IN DWELLING OWNED BY RELATIVE"  
      91  "91: HAVE ANOTHER TYPE OF HOUSING ARRANGEMENT"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X12RACTH
      1  "1: WHITE, NON-HISPANIC"  
      2  "2: BLACK/AFRICAN AMERICAN, NON-HISPANIC"  
      3  "3: HISPANIC, RACE SPECIFIED"  
      4  "4: HISPANIC, NO RACE SPECIFIED"  
      5  "5: ASIAN, NON-HISPANIC"  
      6  "6: NATIVE HAWAIIAN/PACIFIC ISLANDER, NON-HISPANIC"  
      7  "7: AMERICAN INDIAN/ALASKA NATIVE, NON-HISPANIC"  
      8  "8: TWO OR MORE RACES, NON-HISPANIC"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1KSCTYP
      1  "1: CATHOLIC"  
      2  "2: OTHER RELIGIOUS"  
      3  "3: OTHER PRIVATE"  
      4  "4: PUBLIC"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1LOCALE
      11  "11: CITY, LARGE"  
      12  "12: CITY, MIDSIZE"  
      13  "13: CITY, SMALL"  
      21  "21: SUBURB, LARGE"  
      22  "22: SUBURB, MIDSIZE"  
      23  "23: SUBURB, SMALL"  
      31  "31: TOWN, FRINGE"  
      32  "32: TOWN, DISTANT"  
      33  "33: TOWN, REMOTE"  
      41  "41: RURAL, FRINGE"  
      42  "42: RURAL, DISTANT"  
      43  "43: RURAL, REMOTE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1PUBPRI
      1  "1: PUBLIC"  
      2  "2: PRIVATE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X1REGION
      1  "1: NORTHEAST"  
      2  "2: MIDWEST"  
      3  "3: SOUTH"  
      4  "4: WEST"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2KSCTYP
      1  "1: CATHOLIC"  
      2  "2: OTHER RELIGIOUS"  
      3  "3: OTHER PRIVATE"  
      4  "4: PUBLIC"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2LOCALE
      11  "11: CITY, LARGE"  
      12  "12: CITY, MIDSIZE"  
      13  "13: CITY, SMALL"  
      21  "21: SUBURB, LARGE"  
      22  "22: SUBURB, MIDSIZE"  
      23  "23: SUBURB, SMALL"  
      31  "31: TOWN, FRINGE"  
      32  "32: TOWN, DISTANT"  
      33  "33: TOWN, REMOTE"  
      41  "41: RURAL, FRINGE"  
      42  "42: RURAL, DISTANT"  
      43  "43: RURAL, REMOTE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2PUBPRI
      1  "1: PUBLIC"  
      2  "2: PRIVATE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X2REGION
      1  "1: NORTHEAST"  
      2  "2: MIDWEST"  
      3  "3: SOUTH"  
      4  "4: WEST"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X4PUBPRI
      1  "1: PUBLIC"  
      2  "2: PRIVATE"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X4REGION
      1  "1: NORTHEAST"  
      2  "2: MIDWEST"  
      3  "3: SOUTH"  
      4  "4: WEST"  
      -1  "-1: NOT APPLICABLE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X_CHSEX
      1  "1: MALE"  
      2  "2: FEMALE"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define X_DOBMM
      1  "1: JANUARY"  
      2  "2: FEBRUARY"  
      3  "3: MARCH"  
      4  "4: APRIL"  
      5  "5: MAY"  
      6  "6: JUNE"  
      7  "7: JULY"  
      8  "8: AUGUST"  
      9  "9: SEPTEMBER"  
      10  "10: OCTOBER"  
      11  "11: NOVEMBER"  
      12  "12: DECEMBER"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define YN1RDK9F
      1  "1: YES"  
      2  "2: NO"  
      -1  "-1: NOT APPLICABLE"  
      -7  "-7: REFUSED"  
      -8  "-8: DON'T KNOW"  
      -9  "-9: NOT ASCERTAINED"  
;
   label define _9F
      -9  "-9: NOT ASCERTAINED"  
;
   label values X_DOBYY_R _9F;
   label values P1BUILD P1BUILD;
   label values P1CHORES P1CHORES;
   label values P1CHREAD P1CHREAD;
   label values P1GAMES P1GAMES;
   label values P1NATURE P1NATURE;
   label values P1NUMBRS P1NUMBRS;
   label values P1READBK P1READBK;
   label values P1SINGSO P1SINGSO;
   label values P1SPORT P1SPORT;
   label values P1TELLST P1TELLST;
   label values P2APPETI P2APPETI;
   label values P2BLUE P2BLUE;
   label values P2BOTHER P2BOTHER;
   label values P2DEPRES P2DEPRES;
   label values P2EFFORT P2EFFORT;
   label values P2FEARFL P2FEARFL;
   label values P2KPMIND P2KPMIND;
   label values P2LONELY P2LONELY;
   label values P2NOTGO P2NOTGO;
   label values P2RESTLS P2RESTLS;
   label values P2SAD P2SAD;
   label values P2TALKLS P2TALKLS;
   label values P4HOUSIT P4HOUSIT;
   label values X_CHSEX_R X_CHSEX;
   label values X_DOBMM_R X_DOBMM;
   label values X_RACETH_R X12RACTH;
   label values X1KSCTYP X1KSCTYP;
   label values X4SCTYP X1KSCTYP;
   label values X6SCTYP X1KSCTYP;
   label values X7SCTYP X1KSCTYP;
   label values X8SCTYP X1KSCTYP;
   label values X9SCTYP X1KSCTYP;
   label values X1LOCALE X1LOCALE;
   label values X4LOCALE X1LOCALE;
   label values X6LOCALE X1LOCALE;
   label values X7LOCALE X1LOCALE;
   label values X8LOCALE X1LOCALE;
   label values X9LOCALE X1LOCALE;
   label values X1PUBPRI X1PUBPRI;
   label values X1REGION X1REGION;
   label values X2KSCTYP X2KSCTYP;
   label values X2LOCALE X2LOCALE;
   label values X3LOCALE X2LOCALE;
   label values X5LOCALE X2LOCALE;
   label values X2PUBPRI X2PUBPRI;
   label values X3PUBPRI X2PUBPRI;
   label values X5PUBPRI X2PUBPRI;
   label values X2REGION X2REGION;
   label values X3REGION X2REGION;
   label values X5REGION X2REGION;
   label values X4PUBPRI X4PUBPRI;
   label values X6PUBPRI X4PUBPRI;
   label values X7PUBPRI X4PUBPRI;
   label values X8PUBPRI X4PUBPRI;
   label values X9PUBPRI X4PUBPRI;
   label values X4REGION X4REGION;
   label values X6REGION X4REGION;
   label values X7REGION X4REGION;
   label values X8REGION X4REGION;
   label values X9REGION X4REGION;
   label values P2DEPRESS YN1RDK9F;
   
keep
	CHILDID
	P1BUILD
	P1CHORES
	P1CHREAD
	P1GAMES
	P1NATURE
	P1NUMBRS
	P1READBK
	P1SINGSO
	P1SPORT
	P1TELLST
	P2APPETI
	P2BLUE
	P2BOTHER
	P2DEPRES
	P2EFFORT
	P2FEARFL
	P2KPMIND
	P2LONELY
	P2NOTGO
	P2RESTLS
	P2SAD
	P2TALKLS
	P4HOUSIT ;

save "${data_directory}temp.dta", replace ;

use "${data_directory}eclsk11v1.dta", replace ;

merge 1:1 CHILDID using "${data_directory}temp.dta" ;
tab _merge ;
drop _merge ;

save "${data_directory}eclsk11v1.dta", replace ;

erase "${data_directory}temp.dta" ;
 	
clear all ; 
log close ; 
   
   
   
   
   
   
   
   
   
   
   
   
   
   
