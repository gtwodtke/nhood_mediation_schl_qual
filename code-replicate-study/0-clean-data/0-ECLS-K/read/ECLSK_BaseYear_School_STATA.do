* This is a do-file for STATA programming. In order to use it correctly,
* You should type 'do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\read\ECLSK_BaseYear_School_STATA.do" nostop' in command line
* after you launch the STATA application.
infile using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\dct\ECLSK_BaseYear_School_STATA.dct"
#delimit ;
keep if  (S2KPUPRI == 1 | 
       S2KPUPRI == 2 | 
       S2KPUPRI == -9);
   label define PUBLICS
      1  "YES"  
      2  "NO"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define CAFEOKS
      1  "DO NOT HAVE"  
      2  "NEVER ADEQUATE"  
      3  "OFTEN NOT ADEQUATE"  
      4  "SOMETIMES NOT ADEQUATE"  
      5  "ALWAYS ADEQUATE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define COMUNIS
      1  "RURAL, FARMING COMMUNITY OR INDIAN RESERVATION"  
      2  "A SMALL CITY OR TOWN OF FEWER THAN 50000"  
      3  "A MEDIUM-SIZED CITY (50,000 TO 100,000)"  
      4  "A SUBURB OF A MEDIUM-SIZED CITY"  
      5  "A LARGE CITY (100,001 TO 500,000 PEOPLE)"  
      6  "A SUBURB OF A LARGE CITY"  
      7  "A VERY LARGE CITY (OVER 500,000 PEOPLE)"  
      8  "A SUBURB OF A VERY LARGE CITY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TENSIOS
      1  "BIG PROBLEM"  
      2  "SOMEWHAT OF A PROBLEM"  
      3  "NO PROBLEM"  
      4  "DON'T KNOW"  
      -7  "REFUSED"  
      -9  "NOT ASCERTAINED"  
;
   label define ANYGRAS
      1  "TRUE"  
      2  "FALSE"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define PTAMEES
      1  "NEVER"  
      2  "ONCE A YEAR"  
      3  "2 TO 3 TIMES A YEAR"  
      4  "4 TO 6 TIMES A YEAR"  
      5  "7 OR MORE TIMES A YEAR"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define REGHELS
      1  "NONE"  
      2  "1-25%"  
      3  "26-50%"  
      4  "51-75%"  
      5  "75% OR MORE"  
      6  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TYPSERS
      1  "CHILDREN WITH DISABILITIES NOT SERVED"  
      2  "CHILDREN WITH DISABILITIES IN SEPARATE CLASS"  
      3  "CHILDREN WITH DISABILITIES IN REGULAR CLASS"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define ONEXPOS
      1  "NONE"  
      2  "25% OR LESS"  
      3  "26% TO 50%"  
      4  "51% TO 75%"  
      5  "76% OR MORE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define LOSALAR
      1  "LESS THAN $15,000"  
      2  "$15,000 TO $20,000"  
      3  "$20,001 TO $25,000"  
      4  "$25,001 TO $30,000"  
      5  "MORE THAN $30,000"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define ACTIVES
      1  "STRONGLY DISAGREE"  
      2  "DISAGREE"  
      3  "NEITHER AGREE NOR DISAGREE"  
      4  "AGREE"  
      5  "STRONGLY AGREE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define GOALAS
      1  "NO OR MINOR EMPHASIS"  
      2  "MODERATE EMPHASIS"  
      3  "MAJOR EMPHASIS"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define SUCCAS
      1  "NOT VERY SUCCESSFUL"  
      2  "SOMEWHAT SUCCESSFUL"  
      3  "VERY SUCCESSFUL"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q67A1BS
      0  "DECISION MAKER HAS NO INFLUENCE"  
      1  "DECISION MAKER HAS SOME INFLUENCE"  
      2  "DECISION MAKER HAS MAJOR INFLUENCE"  
      3  "DECISION NOT APPLICABLE TO THIS SCHOOL"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define SCORESS
      1  "NO INFLUENCE"  
      2  "SOME INFLUENCE"  
      3  "A GREAT DEAL OF INFLUENCE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define GNDERS
      1  "MALE"  
      2  "FEMALE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define EDLVLS
      1  "HIGH SCHOOL/ASSOCIATE'S DEGREE/BACHELOR'S DEGREE"  
      2  "AT LEAST ONE YEAR BEYOND BACHELOR'S"  
      3  "MASTER'S DEGREE"  
      4  "EDUCATION SPECIALIST/PROFESSIONAL DIPLOMA"  
      5  "DOCTORATE"  
      6  "OTHER (PLEASE SPECIFY)"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define KNOWNS
      1  "NEARLY EVERY CHILD"  
      2  "76% OR MORE"  
      3  "51% TO 75%"  
      4  "26% TO 50%"  
      5  "25% OR LESS"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define INSACS
      1  "TRUE"  
      0  "FALSE"  
;
   label define SCTYPES
      1  "CATHOLIC"  
      2  "OTHER RELIGIOUS"  
      3  "OTHER PRIVATE"  
      4  "PUBLIC/DOD/BIA"  
      -9  "NOT ASCERTAINED"  
;
   label define ENRLSS
      1  "0-149 STUDENTS"  
      2  "150-299 STUDENTS"  
      3  "300-499 STUDENTS"  
      4  "500-749 STUDENTS"  
      5  "750 AND ABOVE"  
      -9  "NOT ASCERTAINED"  
;
   label define REGIONS
      1  "NORTHEAST"  
      2  "MIDWEST"  
      3  "SOUTH"  
      4  "WEST"  
      -9  "NOT ASCERTAINED"  
;
   label define SCLVLS
      1  "LESS THAN 1ST GRADE"  
      2  "PRIMARY SCHOOL"  
      3  "ELEMENTARY SCHOOL"  
      4  "COMBINED SCHOOL"  
      -9  "NOT ASCERTAINED"  
;
   label define URBANS
      1  "CENTRAL CITY"  
      2  "URBAN FRINGE AND LARGE TOWN"  
      3  "SMALL TOWN AND RURAL"  
      -9  "NOT ASCERTAINED"  
;
   label define K2IN
      1  "TRUE"  
      0  "FALSE"  
;
   label define K2Q1AA
      1  "SATISFACTORY"  
      2  "UNSATISFACTORY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2Q1AB
      1  "SATISFACTORY"  
      2  "UNSATISFACTORY"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2Q1AC
      1  "YES"  
      2  "NO"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2Q1BA
      1  "YES"  
      2  "NO"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2QB
      1  "YES"  
      2  "NO"  
      3  "YES, BUT NOT ENFORCED"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2QC
      1  "VERY SAFE"  
      2  "SAFE"  
      3  "UNSAFE"  
      4  "VERY UNSAFE"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2Q3AA
      0  "NONE"  
      1  "A LITTLE"  
      2  "SOME"  
      3  "A LOT"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2Q5_OBS
      1 - 700  "1 - 700"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2Q5AA
      1  "NONE"  
      2  "A FEW (2-4 CHILDREN)"  
      3  "MANY (5-10 CHILDREN)"  
      4  "MOST (MORE THAN 10)"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define K2QF
      1  "STRONGLY AGREE"  
      2  "SOMEWHAT AGREE"  
      3  "SOMEWHAT DISAGREE"  
      4  "STRONGLY DISAGREE"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define SAQW0S
      6 - 485  "6 - 485"  
;
   label define SAQW1S
      0 - 547  "0 - 547"  
;
   label define SAQW2S
      0 - 536  "0 - 536"  
;
   label define SAQW3S
      0 - 494  "0 - 494"  
;
   label define SAQW4S
      0 - 485  "0 - 485"  
;
   label define SAQW5S
      0 - 489  "0 - 489"  
;
   label define SAQW6S
      0 - 485  "0 - 485"  
;
   label define SAQW7S
      0 - 476  "0 - 476"  
;
   label define SAQW8S
      0 - 481  "0 - 481"  
;
   label define SAQW9S
      0 - 481  "0 - 481"  
;
   label define SAQW10S
      0 - 483  "0 - 483"  
;
   label define SAQW11S
      0 - 493  "0 - 493"  
;
   label define SAQW12S
      0 - 489  "0 - 489"  
;
   label define SAQW13S
      0 - 487  "0 - 487"  
;
   label define SAQW14S
      0 - 489  "0 - 489"  
;
   label define SAQW15S
      0 - 485  "0 - 485"  
;
   label define SAQW16S
      0 - 485  "0 - 485"  
;
   label define SAQW17S
      0 - 678  "0 - 678"  
;
   label define SAQW18S
      0 - 502  "0 - 502"  
;
   label define SAQW19S
      0 - 486  "0 - 486"  
;
   label define SAQW20S
      0 - 477  "0 - 477"  
;
   label define SAQW21S
      0 - 482  "0 - 482"  
;
   label define SAQW22S
      0 - 485  "0 - 485"  
;
   label define SAQW23S
      0 - 488  "0 - 488"  
;
   label define SAQW24S
      0 - 489  "0 - 489"  
;
   label define SAQW25S
      0 - 485  "0 - 485"  
;
   label define SAQW26S
      0 - 485  "0 - 485"  
;
   label define SAQW27S
      0 - 485  "0 - 485"  
;
   label define SAQW28S
      0 - 480  "0 - 480"  
;
   label define SAQW29S
      0 - 485  "0 - 485"  
;
   label define SAQW30S
      0 - 483  "0 - 483"  
;
   label define SAQW31S
      0 - 490  "0 - 490"  
;
   label define SAQW32S
      0 - 485  "0 - 485"  
;
   label define SAQW33S
      0 - 485  "0 - 485"  
;
   label define SAQW34S
      0 - 487  "0 - 487"  
;
   label define SAQW35S
      0 - 483  "0 - 483"  
;
   label define SAQW36S
      0 - 481  "0 - 481"  
;
   label define SAQW37S
      0 - 485  "0 - 485"  
;
   label define SAQW38S
      0 - 485  "0 - 485"  
;
   label define SAQW39S
      0 - 485  "0 - 485"  
;
   label define SAQW40S
      0 - 487  "0 - 487"  
;
   label define SAQW41S
      0 - 486  "0 - 486"  
;
   label define SAQW42S
      0 - 483  "0 - 483"  
;
   label define SAQW43S
      0 - 484  "0 - 484"  
;
   label define SAQW44S
      0 - 482  "0 - 482"  
;
   label define SAQW45S
      0 - 486  "0 - 486"  
;
   label define SAQW46S
      0 - 486  "0 - 486"  
;
   label define SAQW47S
      0 - 483  "0 - 483"  
;
   label define SAQW48S
      0 - 485  "0 - 485"  
;
   label define SAQW49S
      0 - 485  "0 - 485"  
;
   label define SAQW50S
      0 - 486  "0 - 486"  
;
   label define SAQW51S
      0 - 489  "0 - 489"  
;
   label define SAQW52S
      0 - 488  "0 - 488"  
;
   label define SAQW53S
      0 - 485  "0 - 485"  
;
   label define SAQW54S
      0 - 481  "0 - 481"  
;
   label define SAQW55S
      0 - 481  "0 - 481"  
;
   label define SAQW56S
      0 - 477  "0 - 477"  
;
   label define SAQW57S
      0 - 483  "0 - 483"  
;
   label define SAQW58S
      0 - 487  "0 - 487"  
;
   label define SAQW59S
      0 - 490  "0 - 490"  
;
   label define SAQW60S
      0 - 560  "0 - 560"  
;
   label define SAQW61S
      0 - 485  "0 - 485"  
;
   label define SAQW62S
      0 - 485  "0 - 485"  
;
   label define SAQW63S
      0 - 485  "0 - 485"  
;
   label define SAQW64S
      0 - 482  "0 - 482"  
;
   label define SAQW65S
      0 - 490  "0 - 490"  
;
   label define SAQW66S
      0 - 481  "0 - 481"  
;
   label define SAQW67S
      0 - 495  "0 - 495"  
;
   label define SAQW68S
      0 - 482  "0 - 482"  
;
   label define SAQW69S
      0 - 485  "0 - 485"  
;
   label define SAQW70S
      0 - 482  "0 - 482"  
;
   label define SAQW71S
      0 - 491  "0 - 491"  
;
   label define SAQW72S
      0 - 483  "0 - 483"  
;
   label define SAQW73S
      0 - 493  "0 - 493"  
;
   label define SAQW74S
      0 - 477  "0 - 477"  
;
   label define SAQW75S
      0 - 389  "0 - 389"  
;
   label define SAQW76S
      0 - 480  "0 - 480"  
;
   label define SAQW77S
      0 - 482  "0 - 482"  
;
   label define SAQW78S
      0 - 631  "0 - 631"  
;
   label define SAQW79S
      0 - 483  "0 - 483"  
;
   label define SAQW80S
      0 - 489  "0 - 489"  
;
   label define SAQW81S
      0 - 481  "0 - 481"  
;
   label define SAQW82S
      0 - 487  "0 - 487"  
;
   label define SAQW83S
      0 - 485  "0 - 485"  
;
   label define SAQW84S
      0 - 486  "0 - 486"  
;
   label define SAQW85S
      0 - 493  "0 - 493"  
;
   label define SAQW86S
      0 - 492  "0 - 492"  
;
   label define SAQW87S
      0 - 475  "0 - 475"  
;
   label define SAQW88S
      0 - 490  "0 - 490"  
;
   label define SAQW89S
      0 - 482  "0 - 482"  
;
   label define SAQW90S
      0 - 484  "0 - 484"  
;
   label define SAQSTRS
      1 - 88  "1 - 88"  
;
   label define SAQPSUS
      1 - 69  "1 - 69"  
;
   label define ADAS
      89 - 100  "89 - 100"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define ADMINSS
      0 - 100  "0 - 100"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define AIDSPES
      0 - 9  "0 - 9"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define ANUMKDS
      59 - 900  "59 - 900"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define ARMSINS
      0 - 60  "0 - 60"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define BLCKNMS
      1  "0"  
      2  "MORE THAN 0 AND LESS THAN 5"  
      3  "5 TO LESS THAN 10"  
      4  "10 TO LESS THAN 25"  
      5  "25 OR MORE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define BNUMKDS
      1  "0 - 10"  
      2  "11 - 40"  
      3  "41 OR MORE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define BRMSINS
      0 - 65  "0 - 65"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define BRTHYRS
      1923 - 1972  "1923 - 1972"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define BUSSEDS
      0 - 100  "0 - 100"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define CHLDNMS
      0 - 850  "0 - 850"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define CK3AKDS
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define CK3DHRS
      0 - 33  "0 - 33"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define CMPFTES
      0 - 4  "0 - 4"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define CNUMKDS
      1  "0 - 10"  
      2  "11 - 40"  
      3  "41 OR MORE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define COMPNMS
      0 - 160  "0 - 160"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define CRMSINS
      0 - 60  "0 - 60"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define DAFIVES
      1 - 31  "1 - 31"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define DDCOMPS
      1 - 31  "1 - 31"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define DISCATS
      0 - 30  "0 - 30"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define ESLAIDS
      0 - 3  "0 - 3"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define ESLTCHS
      0 - 4  "0 - 4"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define ETHNICS
      0 - 33  "0 - 33"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FD2AKDS
      0 - 140  "0 - 140"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FD2BCLS
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FD2DHRS
      0 - 39  "0 - 39"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTECOMS
      0 - 2  "0 - 2"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTECRDS
      0 - 1  "0 - 1"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTEFLS
      0 - 1  "0 - 1"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTEHDSS
      0 - 3  "0 - 3"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTEMDAS
      0 - 1  "0 - 1"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTENRSS
      0 - 1  "0 - 1"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTENWKS
      0 - 18  "0 - 18"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTEPRNS
      0 - 1  "0 - 1"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTEPSCS
      0 - 2  "0 - 2"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTESCMS
      0 - 1  "0 - 1"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTESPES
      0 - 7  "0 - 7"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTETAIS
      0 - 16  "0 - 16"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTETHRS
      0 - 2  "0 - 2"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define FTETOTS
      5 - 100  "5 - 100"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define GYMFTES
      0 - 5  "0 - 5"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define HD1AKDS
      0 - 120  "0 - 120"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define HD1BCLS
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define HD1DHRS
      0 - 38  "0 - 38"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define HWLONGS
      1 - 39  "1 - 39"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define INRMGTS
      0 - 50  "0 - 50"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define INSTPUS
      0 - 130  "0 - 130"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define INSTRUS
      0 - 40  "0 - 40"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define KDSRVDS
      1  "0 - 40"  
      2  "41 - 150"  
      3  "151 OR MORE"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define LEPKNDS
      0 - 95  "0 - 95"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define LEPSKLS
      0 - 99  "0 - 99"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define MMCOMPS
      1  "JANUARY"  
      2  "FEBRUARY"  
      3  "MARCH"  
      4  "APRIL"  
      5  "MAY"  
      6  "JUNE"  
      7  "JULY"  
      8  "AUGUST"  
      9  "SEPTEMBER"  
      10  "OCTOBER"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define MOFIVES
      1  "JANUARY"  
      2  "FEBRUARY"  
      3  "MARCH"  
      4  "APRIL"  
      5  "MAY"  
      6  "JUNE"  
      7  "JULY"  
      8  "AUGUST"  
      9  "SEPTEMBER"  
      10  "OCTOBER"  
      11  "NOVEMBER"  
      12  "DECEMBER"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define MONITRS
      0 - 35  "0 - 35"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NGHBORS
      0 - 100  "0 - 100"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NMADMNS
      1 - 3  "1 - 3"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NMBKPTS
      0 - 6  "0 - 6"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NMDSTRS
      1 - 1  "1 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NMOMDDS
      1 - 8  "1 - 8"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NMREPSS
      1 - 3  "1 - 3"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NMTECHS
      1 - 10  "1 - 10"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NONTENS
      0 - 5  "0 - 5"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NUMBRDS
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NUMDAYS
      170 - 183  "170 - 183"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NUMHSPS
      1  "0"  
      2  "MORE THAN 0 AND LESS THAN 5"  
      3  "5 TO LESS THAN 10"  
      4  "10 TO LESS THAN 25"  
      5  "25 OR MORE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define NUMOTHS
      1 - 2  "1 - 2"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define OUTSIDS
      0 - 100  "0 - 100"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define PPRWRKS
      0 - 80  "0 - 80"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define PREPRIS
      0 - 25  "0 - 25"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define PRINHRS
      0 - 20  "0 - 20"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q62ASNS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q62BLKS
      0 - 35  "0 - 35"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q62INDS
      0 - 1  "0 - 1"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q62WHTS
      0 - 100  "0 - 100"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75AS
      0 - 50  "0 - 50"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75BS
      0 - 25  "0 - 25"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75CS
      0 - 24  "0 - 24"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75DS
      0 - 43  "0 - 43"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75ES
      0 - 50  "0 - 50"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75FS
      0 - 13  "0 - 13"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75GS
      0 - 20  "0 - 20"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75HS
      0 - 50  "0 - 50"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75IS
      0 - 30  "0 - 30"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q75JS
      0 - 28  "0 - 28"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76AS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76BS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76CS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76DS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76ES
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76FS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76GS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76HS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define Q76IS
      0 - 6  "0 - 6"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define REGFTES
      0 - 40  "0 - 40"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define RMNUMS
      0 - 50  "0 - 50"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define SRVBTHS
      0 - 5  "0 - 5"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define STAFADS
      0 - 3  "0 - 3"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define STUDNTS
      0 - 40  "0 - 40"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TALKMTS
      0 - 40  "0 - 40"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TEEECHS
      0 - 50  "0 - 50"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TENURES
      0 - 5  "0 - 5"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TF5AKDS
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TF5DHRS
      0 - 35  "0 - 35"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TK4AKDS
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TK4DHRS
      0 - 33  "0 - 33"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define TOTPRIS
      0 - 25  "0 - 25"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define YRFIVES
      1990 - 1999  "1990 - 1999"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define YRSBILS
      0 - 4  "0 - 4"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define YRSESLS
      0 - 6  "0 - 6"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define YYCOMPS
      1999 - 1999  "1999 - 1999"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define KENRLKS
      5 - 170  "5 - 170"  
      -9  "NOT ASCERTAINED"  
;
   label define KFLNCHS
      0 - 93  "0 - 93"  
      -9  "NOT ASCERTAINED"  
;
   label define KGFTEDS
      0 - 24  "0 - 24"  
      -9  "NOT ASCERTAINED"  
;
   label define KLNGTHS
      170 - 183  "170 - 183"  
      -9  "NOT ASCERTAINED"  
;
   label define KMINORS
      1  "LESS THAN 10"  
      2  "10 TO LESS THAN 25"  
      3  "25 TO LESS THAN 50"  
      4  "50 TO LESS THAN 75"  
      5  "75 OR MORE"  
      -9  "NOT ASCERTAINED"  
;
   label define KRLNCHS
      0 - 23  "0 - 23"  
      -9  "NOT ASCERTAINED"  
;
   label define SKILRDS
      0 - 100  "0 - 100"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define SKLMTHS
      0 - 100  "0 - 100"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define S2PUBPRI
      1  "PUBLIC"  
      2  "PRIVATE"  
      -9  "NOT ASCERTAINED"  
;
   label define S2KSCTYP
      1  "CATHOLIC"  
      2  "OTHER RELIGIOUS"  
      3  "OTHER PRIVATE"  
      4  "PUBLIC"  
      -9  "NOT ASCERTAINED"  
;
   label define S2302F
      1  "YES"  
      2  "NO"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define S2308F
      1  "TRUE"  
      2  "FALSE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define HISALAR
      1  "LESS THAN $25,000"  
      2  "$25,000 TO $35,000"  
      3  "$35,001 TO $45,000"  
      4  "$45,001 TO $60,000"  
      5  "MORE THAN $60,000"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define S2281F
      1  "WHITE, NON-HISPANIC"  
      2  "BLACK OR AFRICAN AMERICAN, NON-HISPANIC"  
      3  "OTHER RACE"  
      -9  "NOT ASCERTAINED"  
;
   label define SUPPRESS
      -2  "DATA SUPPRESSED"  
;
   label values S2ABSENT ACTIVES;
   label values S2ACTSTF ACTIVES;
   label values S2ADEQTE ACTIVES;
   label values S2CHLDOU ACTIVES;
   label values S2CNSNSS ACTIVES;
   label values S2INCENT ACTIVES;
   label values S2INVOLV ACTIVES;
   label values S2ORDR ACTIVES;
   label values S2OVRCRD ACTIVES;
   label values S2PRODEV ACTIVES;
   label values S2REQSTS ACTIVES;
   label values S2RSSIGN ACTIVES;
   label values S2SBMGD ACTIVES;
   label values S2SPPRT ACTIVES;
   label values S2TOGTHR ACTIVES;
   label values S2TRNOVR ACTIVES;
   label values S2WLCOME ACTIVES;
   label values S2ADA ADAS;
   label values S2ADMNCM ADMINSS;
   label values S2SPAFTE AIDSPES;
   label values S2ANUMCH ANUMKDS;
   label values S2ACADEM ANYGRAS;
   label values S2DSBLED ANYGRAS;
   label values S2EACHGR ANYGRAS;
   label values S2ELMENT ANYGRAS;
   label values S2IMMATU ANYGRAS;
   label values S2KNDRGT ANYGRAS;
   label values S2NOPERM ANYGRAS;
   label values S2POLICY ANYGRAS;
   label values S2PRNTS ANYGRAS;
   label values S2LANRMS ARMSINS;
   label values S2BLKPCT BLCKNMS;
   label values S2BNUMCH BNUMKDS;
   label values S2CDRRMS BRMSINS;
   label values S2BRTHYR BRTHYRS;
   label values S2BUSSED BUSSEDS;
   label values S2ARTOK CAFEOKS;
   label values S2AUDTOK CAFEOKS;
   label values S2CAFEOK CAFEOKS;
   label values S2CLSSOK CAFEOKS;
   label values S2COMPOK CAFEOKS;
   label values S2GYMOK CAFEOKS;
   label values S2LBRYOK CAFEOKS;
   label values S2MULTOK CAFEOKS;
   label values S2MUSCOK CAFEOKS;
   label values S2PLAYOK CAFEOKS;
   label values S2CHLDNM CHLDNMS;
   label values S2KCCHDN CK3AKDS;
   label values S2KCHRS CK3DHRS;
   label values S2TT1FTE CMPFTES;
   label values S2CNUMCH CNUMKDS;
   label values S2TOTCM COMPNMS;
   label values S2CMNITY COMUNIS;
   label values S2NETRMS CRMSINS;
   label values S2DDFIVE DAFIVES;
   label values S2DDCOMP DDCOMPS;
   label values S2DISCAT DISCATS;
   label values S2EDLVL EDLVLS;
   label values S2KENRLS ENRLSS;
   label values S2ESAFTE ESLAIDS;
   label values S2ESLFTE ESLTCHS;
   label values S2ETHNIC ETHNICS;
   label values S2FDCHDN FD2AKDS;
   label values S2FDCLS FD2BCLS;
   label values S2FDHRS FD2DHRS;
   label values S2CMPFTE FTECOMS;
   label values S2CRDFTE FTECRDS;
   label values S2FRLFTE FTEFLS;
   label values S2HDSFTE FTEHDSS;
   label values S2LIBFTE FTEMDAS;
   label values S2NRSFTE FTENRSS;
   label values S2NONFTE FTENWKS;
   label values S2LIAFTE FTEPRNS;
   label values S2COUFTE FTEPSCS;
   label values S2MSCFTE FTESCMS;
   label values S2SPEFTE FTESPES;
   label values S2AIDFTE FTETAIS;
   label values S2THRFTE FTETHRS;
   label values S2FTETOT FTETOTS;
   label values S2GNDER GNDERS;
   label values S2GOAL1 GOALAS;
   label values S2GOAL10 GOALAS;
   label values S2GOAL11 GOALAS;
   label values S2GOAL2 GOALAS;
   label values S2GOAL3 GOALAS;
   label values S2GOAL4 GOALAS;
   label values S2GOAL5 GOALAS;
   label values S2GOAL6 GOALAS;
   label values S2GOAL7 GOALAS;
   label values S2GOAL8 GOALAS;
   label values S2GOAL9 GOALAS;
   label values S2GYMFTE GYMFTES;
   label values S2HDCHDN HD1AKDS;
   label values S2HDCLS HD1BCLS;
   label values S2HDHRS HD1DHRS;
   label values S2HISLRY HISALAR;
   label values S2HWLONG HWLONGS;
   label values S2INRMGT INRMGTS;
   label values S2INSAQ INSACS;
   label values S2INSTCM INSTPUS;
   label values S2INSTRU INSTRUS;
   label values K2INFAC K2IN;
   label values K2Q1A_C K2Q1AA;
   label values K2Q1A_D K2Q1AA;
   label values K2Q1A_E K2Q1AA;
   label values K2Q1A_F K2Q1AA;
   label values K2Q1A_G K2Q1AA;
   label values K2Q1A_H K2Q1AA;
   label values K2Q1B_C K2Q1AB;
   label values K2Q1B_D K2Q1AB;
   label values K2Q1B_E K2Q1AB;
   label values K2Q1B_F K2Q1AB;
   label values K2Q1B_G K2Q1AB;
   label values K2Q1B_H K2Q1AB;
   label values K2Q1C_C K2Q1AB;
   label values K2Q1C_D K2Q1AB;
   label values K2Q1C_E K2Q1AB;
   label values K2Q1C_F K2Q1AB;
   label values K2Q1C_G K2Q1AB;
   label values K2Q1C_H K2Q1AB;
   label values K2Q1D_C K2Q1AB;
   label values K2Q1D_D K2Q1AB;
   label values K2Q1D_E K2Q1AB;
   label values K2Q1D_F K2Q1AB;
   label values K2Q1D_G K2Q1AB;
   label values K2Q1D_H K2Q1AB;
   label values K2Q1E_C K2Q1AB;
   label values K2Q1E_D K2Q1AB;
   label values K2Q1E_E K2Q1AB;
   label values K2Q1E_F K2Q1AB;
   label values K2Q1E_G K2Q1AB;
   label values K2Q1E_H K2Q1AB;
   label values K2Q1F_C K2Q1AB;
   label values K2Q1F_D K2Q1AB;
   label values K2Q1F_E K2Q1AB;
   label values K2Q1F_F K2Q1AB;
   label values K2Q1F_G K2Q1AB;
   label values K2Q1F_H K2Q1AB;
   label values K2Q1G_C K2Q1AB;
   label values K2Q1G_D K2Q1AB;
   label values K2Q1G_E K2Q1AB;
   label values K2Q1G_F K2Q1AB;
   label values K2Q1G_G K2Q1AB;
   label values K2Q1G_H K2Q1AB;
   label values K2Q1H_C K2Q1AB;
   label values K2Q1H_D K2Q1AB;
   label values K2Q1H_E K2Q1AB;
   label values K2Q1H_F K2Q1AB;
   label values K2Q1H_G K2Q1AB;
   label values K2Q1H_H K2Q1AB;
   label values K2Q1I_C K2Q1AB;
   label values K2Q1I_D K2Q1AB;
   label values K2Q1I_E K2Q1AB;
   label values K2Q1I_F K2Q1AB;
   label values K2Q1I_G K2Q1AB;
   label values K2Q1I_H K2Q1AB;
   label values K2Q1J_C K2Q1AB;
   label values K2Q1J_D K2Q1AB;
   label values K2Q1J_E K2Q1AB;
   label values K2Q1J_F K2Q1AB;
   label values K2Q1J_G K2Q1AB;
   label values K2Q1J_H K2Q1AB;
   label values K2Q1K_C K2Q1AB;
   label values K2Q1K_F K2Q1AB;
   label values K2Q1L_C K2Q1AB;
   label values K2Q1L_D K2Q1AB;
   label values K2Q1L_E K2Q1AB;
   label values K2Q1L_F K2Q1AB;
   label values K2Q1L_G K2Q1AB;
   label values K2Q1L_H K2Q1AB;
   label values K2Q1A_I K2Q1AC;
   label values K2Q1B_A K2Q1AC;
   label values K2Q1C_A K2Q1AC;
   label values K2Q1D_A K2Q1AC;
   label values K2Q1E_A K2Q1AC;
   label values K2Q1F_A K2Q1AC;
   label values K2Q1G_A K2Q1AC;
   label values K2Q1H_A K2Q1AC;
   label values K2Q1I_A K2Q1AC;
   label values K2Q1J_A K2Q1AC;
   label values K2Q1K_A K2Q1AC;
   label values K2Q1L_B K2Q1AC;
   label values K2Q1B_B K2Q1BA;
   label values K2Q1B_I K2Q1BA;
   label values K2Q1C_B K2Q1BA;
   label values K2Q1C_I K2Q1BA;
   label values K2Q1D_B K2Q1BA;
   label values K2Q1D_I K2Q1BA;
   label values K2Q1E_B K2Q1BA;
   label values K2Q1E_I K2Q1BA;
   label values K2Q1F_B K2Q1BA;
   label values K2Q1F_I K2Q1BA;
   label values K2Q1G_B K2Q1BA;
   label values K2Q1G_I K2Q1BA;
   label values K2Q1H_B K2Q1BA;
   label values K2Q1H_I K2Q1BA;
   label values K2Q1I_B K2Q1BA;
   label values K2Q1I_I K2Q1BA;
   label values K2Q1J_B K2Q1BA;
   label values K2Q1J_I K2Q1BA;
   label values K2Q1K_B K2Q1BA;
   label values K2Q1K_I K2Q1BA;
   label values K2Q1L_I K2Q1BA;
   label values K2Q4 K2Q1BA;
   label values K2Q3A_A K2Q3AA;
   label values K2Q3B_B K2Q3AA;
   label values K2Q3C_C K2Q3AA;
   label values K2Q3D_D K2Q3AA;
   label values K2Q5_OBS K2Q5_OBS;
   label values K2Q5_A K2Q5AA;
   label values K2Q5_B K2Q5AA;
   label values K2Q5_C K2Q5AA;
   label values K2Q5_D K2Q5AA;
   label values K2Q2_A K2QB;
   label values K2Q2_B K2QB;
   label values K2Q2_C K2QB;
   label values K2Q2_D K2QB;
   label values K2Q2_E K2QB;
   label values K2Q2_F K2QB;
   label values K2Q2_G K2QB;
   label values K2Q2_H K2QB;
   label values K2Q2_I K2QB;
   label values K2Q2_J K2QB;
   label values K2Q2_K K2QB;
   label values K2Q2_L K2QB;
   label values K2Q3 K2QC;
   label values K2Q6_A K2QF;
   label values K2Q6_B K2QF;
   label values K2Q6_C K2QF;
   label values K2Q6_D K2QF;
   label values K2Q6_E K2QF;
   label values K2Q6_F K2QF;
   label values S2CHSRVD KDSRVDS;
   label values S2KENRLK KENRLKS;
   label values S2KFLNCH KFLNCHS;
   label values S2KGFTED KGFTEDS;
   label values S2KLNGTH KLNGTHS;
   label values S2KMINOR KMINORS;
   label values S2KNWNME KNOWNS;
   label values S2KRLNCH KRLNCHS;
   label values S2LEPKND LEPKNDS;
   label values S2LEPSCH LEPSKLS;
   label values S2LOSLRY LOSALAR;
   label values S2MMCOMP MMCOMPS;
   label values S2MMFIVE MOFIVES;
   label values S2MONITR MONITRS;
   label values S2NGHBOR NGHBORS;
   label values S2NMADMN NMADMNS;
   label values S2NMBKPT NMBKPTS;
   label values S2NMDSTR NMDSTRS;
   label values S2NMOMDD NMOMDDS;
   label values S2NMREPS NMREPSS;
   label values S2NMTECH NMTECHS;
   label values S2OBSVNT NONTENS;
   label values S2NUMBRD NUMBRDS;
   label values S2NUMDAY NUMDAYS;
   label values S2PCTHSP NUMHSPS;
   label values S2NUMOTH NUMOTHS;
   label values S2EVLIEP ONEXPOS;
   label values S2REGCUR ONEXPOS;
   label values S2REGMLA ONEXPOS;
   label values S2TSTIEP ONEXPOS;
   label values S2OUTSID OUTSIDS;
   label values S2PPRWRK PPRWRKS;
   label values S2YSTCH PREPRIS;
   label values S2PRINHR PRINHRS;
   label values S2ACTOTH PTAMEES;
   label values S2CLASPR PTAMEES;
   label values S2FUNDRS PTAMEES;
   label values S2HVISIT PTAMEES;
   label values S2INVITE PTAMEES;
   label values S2NWSHME PTAMEES;
   label values S2PTAMT PTAMEES;
   label values S2PTCONF PTAMEES;
   label values S2RPRTCD PTAMEES;
   label values S2WRKSHP PTAMEES;
   label values S211TH PUBLICS;
   label values S212TH PUBLICS;
   label values S27TH PUBLICS;
   label values S28TH PUBLICS;
   label values S2ACADRC PUBLICS;
   label values S2ADDTST PUBLICS;
   label values S2ADMISS PUBLICS;
   label values S2ADMN PUBLICS;
   label values S2APTIT PUBLICS;
   label values S2ASSESO PUBLICS;
   label values S2BRDMEM PUBLICS;
   label values S2CATHOL PUBLICS;
   label values S2CDRSTU PUBLICS;
   label values S2CHCESK PUBLICS;
   label values S2CUTOFF PUBLICS;
   label values S2DELAY PUBLICS;
   label values S2DIOCES PUBLICS;
   label values S2DSTROF PUBLICS;
   label values S2EARLCH PUBLICS;
   label values S2FIFTH PUBLICS;
   label values S2FOCUS PUBLICS;
   label values S2FOURTH PUBLICS;
   label values S2GRADE1 PUBLICS;
   label values S2HOMVST PUBLICS;
   label values S2INDVDL PUBLICS;
   label values S2KINDER PUBLICS;
   label values S2LANSTU PUBLICS;
   label values S2LOTTER PUBLICS;
   label values S2MAGSKL PUBLICS;
   label values S2MEETSP PUBLICS;
   label values S2MMSDDS PUBLICS;
   label values S2NEEDS PUBLICS;
   label values S2NETSTU PUBLICS;
   label values S2NINTH PUBLICS;
   label values S2OTHGRP PUBLICS;
   label values S2OTHPRI PUBLICS;
   label values S2OTHREL PUBLICS;
   label values S2OTHTRA PUBLICS;
   label values S2OUTRCH PUBLICS;
   label values S2PARISH PUBLICS;
   label values S2PERINT PUBLICS;
   label values S2PLACE PUBLICS;
   label values S2PRE1 PUBLICS;
   label values S2PRKNDR PUBLICS;
   label values S2PVTEAR PUBLICS;
   label values S2RECOME PUBLICS;
   label values S2REGSKL PUBLICS;
   label values S2RELIG PUBLICS;
   label values S2RPCOMM PUBLICS;
   label values S2SECOND PUBLICS;
   label values S2SIXTH PUBLICS;
   label values S2SPLNDS PUBLICS;
   label values S2STNDTE PUBLICS;
   label values S2TCHERS PUBLICS;
   label values S2TENTH PUBLICS;
   label values S2THIRD PUBLICS;
   label values S2TRANS PUBLICS;
   label values S2TRANSL PUBLICS;
   label values S2TRNWRT PUBLICS;
   label values S2TT1ED PUBLICS;
   label values S2TT1EXT PUBLICS;
   label values S2TT1FLS PUBLICS;
   label values S2TT1INC PUBLICS;
   label values S2TT1OTH PUBLICS;
   label values S2TT1PD PUBLICS;
   label values S2TT1PO PUBLICS;
   label values S2TT1SW PUBLICS;
   label values S2UNGRAD PUBLICS;
   label values S2Q62ASN Q62ASNS;
   label values S2Q62BLK Q62BLKS;
   label values S2Q62IND Q62INDS;
   label values S2Q62WHT Q62WHTS;
   label values S267A1B1 Q67A1BS;
   label values S267A1B2 Q67A1BS;
   label values S267A1B3 Q67A1BS;
   label values S267A1B4 Q67A1BS;
   label values S267A1B5 Q67A1BS;
   label values S267A1B6 Q67A1BS;
   label values S267A2B1 Q67A1BS;
   label values S267A2B2 Q67A1BS;
   label values S267A2B3 Q67A1BS;
   label values S267A2B4 Q67A1BS;
   label values S267A2B5 Q67A1BS;
   label values S267A2B6 Q67A1BS;
   label values S267A3B1 Q67A1BS;
   label values S267A3B2 Q67A1BS;
   label values S267A3B3 Q67A1BS;
   label values S267A3B4 Q67A1BS;
   label values S267A3B5 Q67A1BS;
   label values S267A3B6 Q67A1BS;
   label values S267A4B1 Q67A1BS;
   label values S267A4B2 Q67A1BS;
   label values S267A4B3 Q67A1BS;
   label values S267A4B4 Q67A1BS;
   label values S267A4B5 Q67A1BS;
   label values S267A4B6 Q67A1BS;
   label values S267A5B1 Q67A1BS;
   label values S267A5B2 Q67A1BS;
   label values S267A5B3 Q67A1BS;
   label values S267A5B4 Q67A1BS;
   label values S267A5B5 Q67A1BS;
   label values S267A5B6 Q67A1BS;
   label values S267A6B1 Q67A1BS;
   label values S267A6B2 Q67A1BS;
   label values S267A6B3 Q67A1BS;
   label values S267A6B4 Q67A1BS;
   label values S267A6B5 Q67A1BS;
   label values S267A6B6 Q67A1BS;
   label values S2YRPREK Q75AS;
   label values S2YRK Q75BS;
   label values S2YR1ST Q75CS;
   label values S2YR2TO5 Q75DS;
   label values S2YR6 Q75ES;
   label values S2YRESL Q75FS;
   label values S2YRBILG Q75GS;
   label values S2YRSPED Q75HS;
   label values S2YRPHED Q75IS;
   label values S2YRART Q75JS;
   label values S2CRSECE Q76AS;
   label values S2CRSELE Q76BS;
   label values S2CRSSPE Q76CS;
   label values S2CRSESL Q76DS;
   label values S2CRSCDV Q76ES;
   label values S2CRSMTR Q76FS;
   label values S2CRSMTM Q76GS;
   label values S2CRSSCI Q76HS;
   label values S2CRSADM Q76IS;
   label values S2TCHFTE REGFTES;
   label values S2ARTMSC REGHELS;
   label values S2GOPCNF REGHELS;
   label values S2GOPTA REGHELS;
   label values S2OPENHS REGHELS;
   label values S2PLYFAI REGHELS;
   label values S2RGHELP REGHELS;
   label values S2RSFUND REGHELS;
   label values CREGION REGIONS;
   label values S2RMNUM RMNUMS;
   label values S2PRACE S2281F;
   label values S2ADLTLT S2302F;
   label values S2AFTSCH S2302F;
   label values S2AFUND S2302F;
   label values S2ATTACK S2302F;
   label values S2B4SCH S2302F;
   label values S2BFUND S2302F;
   label values S2CDRSCH S2302F;
   label values S2CFUND S2302F;
   label values S2CHCARE S2302F;
   label values S2CHGOTH S2302F;
   label values S2CHKLST S2302F;
   label values S2DETECT S2302F;
   label values S2DFUND S2302F;
   label values S2EFUND S2302F;
   label values S2FFUND S2302F;
   label values S2FMILIT S2302F;
   label values S2FOLIO S2302F;
   label values S2FORCE S2302F;
   label values S2FUNDLV S2302F;
   label values S2GFT1ST S2302F;
   label values S2GFT2ND S2302F;
   label values S2GFT3RD S2302F;
   label values S2GFT4TH S2302F;
   label values S2GFT5TH S2302F;
   label values S2GFTK S2302F;
   label values S2GFTP S2302F;
   label values S2GFTR S2302F;
   label values S2GFUND S2302F;
   label values S2HDSTRT S2302F;
   label values S2HFUND S2302F;
   label values S2HLFDAY S2302F;
   label values S2HLLPSS S2302F;
   label values S2HLLWAY S2302F;
   label values S2HRVIS S2302F;
   label values S2IEP504 S2302F;
   label values S2IFUND S2302F;
   label values S2INCROL S2302F;
   label values S2INFANT S2302F;
   label values S2JFUND S2302F;
   label values S2KFUND S2302F;
   label values S2LANSCH S2302F;
   label values S2LIMENG S2302F;
   label values S2LOCKDR S2302F;
   label values S2LSSINC S2302F;
   label values S2MGTCMM S2302F;
   label values S2MIGRSM S2302F;
   label values S2MIGRSY S2302F;
   label values S2MOBILE S2302F;
   label values S2NETSCH S2302F;
   label values S2NOGFT S2302F;
   label values S2NOTEST S2302F;
   label values S2ON504 S2302F;
   label values S2ONIEP S2302F;
   label values S2ORIENT S2302F;
   label values S2ORIGIN S2302F;
   label values S2PREKIN S2302F;
   label values S2PRGRPT S2302F;
   label values S2PRNTNG S2302F;
   label values S2PUBLIC S2302F;
   label values S2RDITST S2302F;
   label values S2RESTRM S2302F;
   label values S2SCISRV S2302F;
   label values S2SECURT S2302F;
   label values S2SIGNIN S2302F;
   label values S2SRPCRD S2302F;
   label values S2SRVOTH S2302F;
   label values S2STDSCO S2302F;
   label values S2SUMMER S2302F;
   label values S2TEST1 S2302F;
   label values S2TEST10 S2302F;
   label values S2TEST11 S2302F;
   label values S2TEST12 S2302F;
   label values S2TEST2 S2302F;
   label values S2TEST3 S2302F;
   label values S2TEST4 S2302F;
   label values S2TEST5 S2302F;
   label values S2TEST6 S2302F;
   label values S2TEST7 S2302F;
   label values S2TEST8 S2302F;
   label values S2TEST9 S2302F;
   label values S2TESTK S2302F;
   label values S2TESTP1 S2302F;
   label values S2TESTPK S2302F;
   label values S2TESTR S2302F;
   label values S2TSHORT S2302F;
   label values S2TT1 S2302F;
   label values S2TTEAM S2302F;
   label values S2UNIFRM S2302F;
   label values S2WEAPON S2302F;
   label values S2ANYGRD S2308F;
   label values S2KSCTYP S2KSCTYP;
   label values S2KPUPRI S2PUBPRI;
   label values S2SAQPSU SAQPSUS;
   label values S2SAQSTR SAQSTRS;
   label values S2SAQW0 SAQW0S;
   label values S2SAQW10 SAQW10S;
   label values S2SAQW11 SAQW11S;
   label values S2SAQW12 SAQW12S;
   label values S2SAQW13 SAQW13S;
   label values S2SAQW14 SAQW14S;
   label values S2SAQW15 SAQW15S;
   label values S2SAQW16 SAQW16S;
   label values S2SAQW17 SAQW17S;
   label values S2SAQW18 SAQW18S;
   label values S2SAQW19 SAQW19S;
   label values S2SAQW1 SAQW1S;
   label values S2SAQW20 SAQW20S;
   label values S2SAQW21 SAQW21S;
   label values S2SAQW22 SAQW22S;
   label values S2SAQW23 SAQW23S;
   label values S2SAQW24 SAQW24S;
   label values S2SAQW25 SAQW25S;
   label values S2SAQW26 SAQW26S;
   label values S2SAQW27 SAQW27S;
   label values S2SAQW28 SAQW28S;
   label values S2SAQW29 SAQW29S;
   label values S2SAQW2 SAQW2S;
   label values S2SAQW30 SAQW30S;
   label values S2SAQW31 SAQW31S;
   label values S2SAQW32 SAQW32S;
   label values S2SAQW33 SAQW33S;
   label values S2SAQW34 SAQW34S;
   label values S2SAQW35 SAQW35S;
   label values S2SAQW36 SAQW36S;
   label values S2SAQW37 SAQW37S;
   label values S2SAQW38 SAQW38S;
   label values S2SAQW39 SAQW39S;
   label values S2SAQW3 SAQW3S;
   label values S2SAQW40 SAQW40S;
   label values S2SAQW41 SAQW41S;
   label values S2SAQW42 SAQW42S;
   label values S2SAQW43 SAQW43S;
   label values S2SAQW44 SAQW44S;
   label values S2SAQW45 SAQW45S;
   label values S2SAQW46 SAQW46S;
   label values S2SAQW47 SAQW47S;
   label values S2SAQW48 SAQW48S;
   label values S2SAQW49 SAQW49S;
   label values S2SAQW4 SAQW4S;
   label values S2SAQW50 SAQW50S;
   label values S2SAQW51 SAQW51S;
   label values S2SAQW52 SAQW52S;
   label values S2SAQW53 SAQW53S;
   label values S2SAQW54 SAQW54S;
   label values S2SAQW55 SAQW55S;
   label values S2SAQW56 SAQW56S;
   label values S2SAQW57 SAQW57S;
   label values S2SAQW58 SAQW58S;
   label values S2SAQW59 SAQW59S;
   label values S2SAQW5 SAQW5S;
   label values S2SAQW60 SAQW60S;
   label values S2SAQW61 SAQW61S;
   label values S2SAQW62 SAQW62S;
   label values S2SAQW63 SAQW63S;
   label values S2SAQW64 SAQW64S;
   label values S2SAQW65 SAQW65S;
   label values S2SAQW66 SAQW66S;
   label values S2SAQW67 SAQW67S;
   label values S2SAQW68 SAQW68S;
   label values S2SAQW69 SAQW69S;
   label values S2SAQW6 SAQW6S;
   label values S2SAQW70 SAQW70S;
   label values S2SAQW71 SAQW71S;
   label values S2SAQW72 SAQW72S;
   label values S2SAQW73 SAQW73S;
   label values S2SAQW74 SAQW74S;
   label values S2SAQW75 SAQW75S;
   label values S2SAQW76 SAQW76S;
   label values S2SAQW77 SAQW77S;
   label values S2SAQW78 SAQW78S;
   label values S2SAQW79 SAQW79S;
   label values S2SAQW7 SAQW7S;
   label values S2SAQW80 SAQW80S;
   label values S2SAQW81 SAQW81S;
   label values S2SAQW82 SAQW82S;
   label values S2SAQW83 SAQW83S;
   label values S2SAQW84 SAQW84S;
   label values S2SAQW85 SAQW85S;
   label values S2SAQW86 SAQW86S;
   label values S2SAQW87 SAQW87S;
   label values S2SAQW88 SAQW88S;
   label values S2SAQW89 SAQW89S;
   label values S2SAQW8 SAQW8S;
   label values S2SAQW90 SAQW90S;
   label values S2SAQW9 SAQW9S;
   label values S2KSCLVL SCLVLS;
   label values S2ATENDN SCORESS;
   label values S2DVELOP SCORESS;
   label values S2INVLME SCORESS;
   label values S2OTHINF SCORESS;
   label values S2PRFLVL SCORESS;
   label values S2SAFETY SCORESS;
   label values S2SCORES SCORESS;
   label values S2STFSPP SCORESS;
   label values S2SUPORT SCORESS;
   label values CS_TYPE2 SCTYPES;
   label values S2PCTRD SKILRDS;
   label values S2PCTMTH SKLMTHS;
   label values S2SRVBTH SRVBTHS;
   label values S2ADMFTE STAFADS;
   label values S2STUDNT STUDNTS;
   label values S2SUCC1 SUCCAS;
   label values S2SUCC10 SUCCAS;
   label values S2SUCC11 SUCCAS;
   label values S2SUCC2 SUCCAS;
   label values S2SUCC3 SUCCAS;
   label values S2SUCC4 SUCCAS;
   label values S2SUCC5 SUCCAS;
   label values S2SUCC6 SUCCAS;
   label values S2SUCC7 SUCCAS;
   label values S2SUCC8 SUCCAS;
   label values S2SUCC9 SUCCAS;
   label values S2ASNPCT SUPPRESS;
   label values S2ATE8TH SUPPRESS;
   label values S2BIASKL SUPPRESS;
   label values S2BILING SUPPRESS;
   label values S2ELEV11 SUPPRESS;
   label values S2ELIBRK SUPPRESS;
   label values S2ELILNC SUPPRESS;
   label values S2ELIRED SUPPRESS;
   label values S2EMPHAS SUPPRESS;
   label values S2ESLBIL SUPPRESS;
   label values S2ESLONL SUPPRESS;
   label values S2FDDAYS SUPPRESS;
   label values S2FIF5TH SUPPRESS;
   label values S2FIR1ST SUPPRESS;
   label values S2FOR4TH SUPPRESS;
   label values S2GFTNBR SUPPRESS;
   label values S2HDDAYS SUPPRESS;
   label values S2INDPCT SUPPRESS;
   label values S2KCCLS SUPPRESS;
   label values S2KCDAYS SUPPRESS;
   label values S2KINGAR SUPPRESS;
   label values S2NAISKL SUPPRESS;
   label values S2NIN9TH SUPPRESS;
   label values S2NOCUTO SUPPRESS;
   label values S2OTHFTE SUPPRESS;
   label values S2PARBRK SUPPRESS;
   label values S2PARLNC SUPPRESS;
   label values S2PARRED SUPPRESS;
   label values S2PCFPCT SUPPRESS;
   label values S2PRE1ST SUPPRESS;
   label values S2PREK SUPPRESS;
   label values S2PRIVRD SUPPRESS;
   label values S2PVTSPD SUPPRESS;
   label values S2Q62HAW SUPPRESS;
   label values S2RACE1 SUPPRESS;
   label values S2RACE2 SUPPRESS;
   label values S2RACE3 SUPPRESS;
   label values S2RACE4 SUPPRESS;
   label values S2RACE5 SUPPRESS;
   label values S2REAFTE SUPPRESS;
   label values S2REDDYN SUPPRESS;
   label values S2SEC2ND SUPPRESS;
   label values S2SEV7TH SUPPRESS;
   label values S2SIX6TH SUPPRESS;
   label values S2SPEDSK SUPPRESS;
   label values S2SPENR SUPPRESS;
   label values S2T1CLS SUPPRESS;
   label values S2T1DAYS SUPPRESS;
   label values S2TEN10 SUPPRESS;
   label values S2THI3RD SUPPRESS;
   label values S2TKCLS SUPPRESS;
   label values S2TKDAYS SUPPRESS;
   label values S2TWEL12 SUPPRESS;
   label values S2WHTPCT SUPPRESS;
   label values S2TALKPT TALKMTS;
   label values S2TEEECH TEEECHS;
   label values S2CRIME TENSIOS;
   label values S2DRUGS TENSIOS;
   label values S2GANGS TENSIOS;
   label values S2LITTER TENSIOS;
   label values S2TNSION TENSIOS;
   label values S2TRFFIC TENSIOS;
   label values S2VCANCY TENSIOS;
   label values S2VLENCE TENSIOS;
   label values S2OBSVTT TENURES;
   label values S2T1CHDN TF5AKDS;
   label values S2T1HRS TF5DHRS;
   label values S2TKCHDN TK4AKDS;
   label values S2TKHRS TK4DHRS;
   label values S2TOTPRI TOTPRIS;
   label values S2DISSRV TYPSERS;
   label values KURBAN_R URBANS;
   label values S2YYFIVE YRFIVES;
   label values S2YRSBIL YRSBILS;
   label values S2YRSESL YRSESLS;
   label values S2YYCOMP YYCOMPS;
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\dta\ECLSK_BaseYear_School_STATA.dta", replace;
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\dta\ECLSK_BaseYear_School_STATA.dta";
tabulate CREGION;
tabulate CS_TYPE2;
tabulate KURBAN_R;
tabulate S2INSAQ;
tabulate K2INFAC;
tabulate S2KSCTYP;
tabulate S2KENRLS;
tabulate S2KMINOR;
tabulate S2KSCLVL;
tabulate S2KPUPRI;
tabulate S2BNUMCH;
tabulate S2CNUMCH;
tabulate S2UNGRAD;
tabulate S2SPLNDS;
tabulate S2PRKNDR;
tabulate S2TRANS;
tabulate S2KINDER;
tabulate S2PRE1;
tabulate S2GRADE1;
tabulate S2SECOND;
tabulate S2THIRD;
tabulate S2FOURTH;
tabulate S2FIFTH;
tabulate S2SIXTH;
tabulate S27TH;
tabulate S28TH;
tabulate S2NINTH;
tabulate S2TENTH;
tabulate S211TH;
tabulate S212TH;
tabulate S2PUBLIC;
tabulate S2REGSKL;
tabulate S2MAGSKL;
tabulate S2CHCESK;
tabulate S2BIASKL;
tabulate S2SPEDSK;
tabulate S2EARLCH;
tabulate S2CATHOL;
tabulate S2DIOCES;
tabulate S2PARISH;
tabulate S2PRIVRD;
tabulate S2OTHREL;
tabulate S2NAISKL;
tabulate S2OTHPRI;
tabulate S2PVTSPD;
tabulate S2PVTEAR;
tabulate S2FOCUS;
tabulate S2EMPHAS;
tabulate S2PREK;
tabulate S2REDDYN;
tabulate S2KINGAR;
tabulate S2PRE1ST;
tabulate S2FIR1ST;
tabulate S2SEC2ND;
tabulate S2THI3RD;
tabulate S2FOR4TH;
tabulate S2FIF5TH;
tabulate S2SIX6TH;
tabulate S2SEV7TH;
tabulate S2ATE8TH;
tabulate S2NIN9TH;
tabulate S2TEN10;
tabulate S2ELEV11;
tabulate S2TWEL12;
tabulate S2SPENR;
tabulate S2ADMISS;
tabulate S2STNDTE;
tabulate S2NEEDS;
tabulate S2APTIT;
tabulate S2PERINT;
tabulate S2RECOME;
tabulate S2ACADRC;
tabulate S2RELIG;
tabulate S2LOTTER;
tabulate S2TTEAM;
tabulate S2FUNDLV;
tabulate S2INCROL;
tabulate S2LSSINC;
tabulate S2MOBILE;
tabulate S2TSHORT;
tabulate S2CHGOTH;
tabulate S2PCTHSP;
tabulate S2INDPCT;
tabulate S2ASNPCT;
tabulate S2BLKPCT;
tabulate S2PCFPCT;
tabulate S2WHTPCT;
tabulate S2ELIBRK;
tabulate S2PARBRK;
tabulate S2ELILNC;
tabulate S2PARLNC;
tabulate S2ELIRED;
tabulate S2PARRED;
tabulate S2TT1;
tabulate S2TT1SW;
tabulate S2TT1PO;
tabulate S2TT1INC;
tabulate S2TT1EXT;
tabulate S2TT1ED;
tabulate S2TT1PD;
tabulate S2TT1FLS;
tabulate S2TT1OTH;
tabulate S2CHSRVD;
tabulate S2HDDAYS;
tabulate S2FDDAYS;
tabulate S2KCCLS;
tabulate S2KCDAYS;
tabulate S2TKCLS;
tabulate S2TKDAYS;
tabulate S2T1CLS;
tabulate S2T1DAYS;
tabulate S2MMFIVE;
tabulate S2NOCUTO;
tabulate S2AFUND;
tabulate S2BFUND;
tabulate S2CFUND;
tabulate S2DFUND;
tabulate S2EFUND;
tabulate S2FFUND;
tabulate S2GFUND;
tabulate S2HFUND;
tabulate S2IFUND;
tabulate S2JFUND;
tabulate S2KFUND;
tabulate S2CAFEOK;
tabulate S2COMPOK;
tabulate S2LBRYOK;
tabulate S2ARTOK;
tabulate S2GYMOK;
tabulate S2MUSCOK;
tabulate S2PLAYOK;
tabulate S2CLSSOK;
tabulate S2AUDTOK;
tabulate S2MULTOK;
tabulate S2LANSCH;
tabulate S2LANSTU;
tabulate S2CDRSCH;
tabulate S2CDRSTU;
tabulate S2NETSCH;
tabulate S2NETSTU;
tabulate S2CMNITY;
tabulate S2TNSION;
tabulate S2LITTER;
tabulate S2DRUGS;
tabulate S2GANGS;
tabulate S2TRFFIC;
tabulate S2VLENCE;
tabulate S2VCANCY;
tabulate S2CRIME;
tabulate S2WEAPON;
tabulate S2FORCE;
tabulate S2ATTACK;
tabulate S2SECURT;
tabulate S2DETECT;
tabulate S2LOCKDR;
tabulate S2SIGNIN;
tabulate S2RESTRM;
tabulate S2HLLWAY;
tabulate S2HLLPSS;
tabulate S2UNIFRM;
tabulate S2RDITST;
tabulate S2CUTOFF;
tabulate S2PLACE;
tabulate S2ADDTST;
tabulate S2INDVDL;
tabulate S2DELAY;
tabulate S2ASSESO;
tabulate S2NOTEST;
tabulate S2TESTPK;
tabulate S2TESTR;
tabulate S2TESTK;
tabulate S2TESTP1;
tabulate S2TEST1;
tabulate S2TEST2;
tabulate S2TEST3;
tabulate S2TEST4;
tabulate S2TEST5;
tabulate S2TEST6;
tabulate S2TEST7;
tabulate S2TEST8;
tabulate S2TEST9;
tabulate S2TEST10;
tabulate S2TEST11;
tabulate S2TEST12;
tabulate S2ANYGRD;
tabulate S2IMMATU;
tabulate S2PRNTS;
tabulate S2ACADEM;
tabulate S2KNDRGT;
tabulate S2EACHGR;
tabulate S2ELMENT;
tabulate S2NOPERM;
tabulate S2DSBLED;
tabulate S2POLICY;
tabulate S2B4SCH;
tabulate S2HLFDAY;
tabulate S2AFTSCH;
tabulate S2INFANT;
tabulate S2HDSTRT;
tabulate S2PREKIN;
tabulate S2SUMMER;
tabulate S2MIGRSY;
tabulate S2MIGRSM;
tabulate S2HRVIS;
tabulate S2CHCARE;
tabulate S2PRNTNG;
tabulate S2ADLTLT;
tabulate S2FMILIT;
tabulate S2SCISRV;
tabulate S2ORIENT;
tabulate S2SRVOTH;
tabulate S2PTAMT;
tabulate S2NWSHME;
tabulate S2RPRTCD;
tabulate S2PTCONF;
tabulate S2HVISIT;
tabulate S2INVITE;
tabulate S2CLASPR;
tabulate S2FUNDRS;
tabulate S2WRKSHP;
tabulate S2ACTOTH;
tabulate S2SRPCRD;
tabulate S2PRGRPT;
tabulate S2CHKLST;
tabulate S2FOLIO;
tabulate S2STDSCO;
tabulate S2RGHELP;
tabulate S2GOPCNF;
tabulate S2OPENHS;
tabulate S2ARTMSC;
tabulate S2GOPTA;
tabulate S2RSFUND;
tabulate S2PLYFAI;
tabulate S2MGTCMM;
tabulate S2ADMN;
tabulate S2TCHERS;
tabulate S2DSTROF;
tabulate S2BRDMEM;
tabulate S2MMSDDS;
tabulate S2RPCOMM;
tabulate S2OTHGRP;
tabulate S2LIMENG;
tabulate S2BILING;
tabulate S2ESLONL;
tabulate S2ESLBIL;
tabulate S2TRANSL;
tabulate S2TRNWRT;
tabulate S2HOMVST;
tabulate S2OUTRCH;
tabulate S2MEETSP;
tabulate S2OTHTRA;
tabulate S2ONIEP;
tabulate S2ON504;
tabulate S2IEP504;
tabulate S2DISSRV;
tabulate S2REGCUR;
tabulate S2REGMLA;
tabulate S2EVLIEP;
tabulate S2TSTIEP;
tabulate S2NOGFT;
tabulate S2GFTR;
tabulate S2GFTK;
tabulate S2GFTP;
tabulate S2GFT1ST;
tabulate S2GFT2ND;
tabulate S2GFT3RD;
tabulate S2GFT4TH;
tabulate S2GFT5TH;
tabulate S2GFTNBR;
tabulate S2REAFTE;
tabulate S2OTHFTE;
tabulate S2LOSLRY;
tabulate S2HISLRY;
tabulate S2Q62HAW;
tabulate S2PRODEV;
tabulate S2ACTSTF;
tabulate S2ADEQTE;
tabulate S2INCENT;
tabulate S2GOAL1;
tabulate S2GOAL2;
tabulate S2GOAL3;
tabulate S2GOAL4;
tabulate S2GOAL5;
tabulate S2GOAL6;
tabulate S2GOAL7;
tabulate S2GOAL8;
tabulate S2GOAL9;
tabulate S2GOAL10;
tabulate S2GOAL11;
tabulate S2SUCC1;
tabulate S2SUCC2;
tabulate S2SUCC3;
tabulate S2SUCC4;
tabulate S2SUCC5;
tabulate S2SUCC6;
tabulate S2SUCC7;
tabulate S2SUCC8;
tabulate S2SUCC9;
tabulate S2SUCC10;
tabulate S2SUCC11;
tabulate S267A1B1;
tabulate S267A1B2;
tabulate S267A1B3;
tabulate S267A1B4;
tabulate S267A1B5;
tabulate S267A1B6;
tabulate S267A2B1;
tabulate S267A2B2;
tabulate S267A2B3;
tabulate S267A2B4;
tabulate S267A2B5;
tabulate S267A2B6;
tabulate S267A3B1;
tabulate S267A3B2;
tabulate S267A3B3;
tabulate S267A3B4;
tabulate S267A3B5;
tabulate S267A3B6;
tabulate S267A4B1;
tabulate S267A4B2;
tabulate S267A4B3;
tabulate S267A4B4;
tabulate S267A4B5;
tabulate S267A4B6;
tabulate S267A5B1;
tabulate S267A5B2;
tabulate S267A5B3;
tabulate S267A5B4;
tabulate S267A5B5;
tabulate S267A5B6;
tabulate S267A6B1;
tabulate S267A6B2;
tabulate S267A6B3;
tabulate S267A6B4;
tabulate S267A6B5;
tabulate S267A6B6;
tabulate S2SBMGD;
tabulate S2TOGTHR;
tabulate S2INVOLV;
tabulate S2ABSENT;
tabulate S2TRNOVR;
tabulate S2CHLDOU;
tabulate S2SPPRT;
tabulate S2CNSNSS;
tabulate S2ORDR;
tabulate S2OVRCRD;
tabulate S2WLCOME;
tabulate S2RSSIGN;
tabulate S2REQSTS;
tabulate S2SCORES;
tabulate S2PRFLVL;
tabulate S2ATENDN;
tabulate S2SAFETY;
tabulate S2SUPORT;
tabulate S2INVLME;
tabulate S2STFSPP;
tabulate S2DVELOP;
tabulate S2OTHINF;
tabulate S2GNDER;
tabulate S2ORIGIN;
tabulate S2RACE1;
tabulate S2RACE2;
tabulate S2RACE3;
tabulate S2RACE4;
tabulate S2RACE5;
tabulate S2EDLVL;
tabulate S2KNWNME;
tabulate S2MMCOMP;
tabulate K2Q1A_C;
tabulate K2Q1A_D;
tabulate K2Q1A_E;
tabulate K2Q1A_F;
tabulate K2Q1A_G;
tabulate K2Q1A_H;
tabulate K2Q1A_I;
tabulate K2Q1B_A;
tabulate K2Q1B_B;
tabulate K2Q1B_C;
tabulate K2Q1B_D;
tabulate K2Q1B_E;
tabulate K2Q1B_F;
tabulate K2Q1B_G;
tabulate K2Q1B_H;
tabulate K2Q1B_I;
tabulate K2Q1C_A;
tabulate K2Q1C_B;
tabulate K2Q1C_C;
tabulate K2Q1C_D;
tabulate K2Q1C_E;
tabulate K2Q1C_F;
tabulate K2Q1C_G;
tabulate K2Q1C_H;
tabulate K2Q1C_I;
tabulate K2Q1D_A;
tabulate K2Q1D_B;
tabulate K2Q1D_C;
tabulate K2Q1D_D;
tabulate K2Q1D_E;
tabulate K2Q1D_F;
tabulate K2Q1D_G;
tabulate K2Q1D_H;
tabulate K2Q1D_I;
tabulate K2Q1E_A;
tabulate K2Q1E_B;
tabulate K2Q1E_C;
tabulate K2Q1E_D;
tabulate K2Q1E_E;
tabulate K2Q1E_F;
tabulate K2Q1E_G;
tabulate K2Q1E_H;
tabulate K2Q1E_I;
tabulate K2Q1F_A;
tabulate K2Q1F_B;
tabulate K2Q1F_C;
tabulate K2Q1F_D;
tabulate K2Q1F_E;
tabulate K2Q1F_F;
tabulate K2Q1F_G;
tabulate K2Q1F_H;
tabulate K2Q1F_I;
tabulate K2Q1G_A;
tabulate K2Q1G_B;
tabulate K2Q1G_C;
tabulate K2Q1G_D;
tabulate K2Q1G_E;
tabulate K2Q1G_F;
tabulate K2Q1G_G;
tabulate K2Q1G_H;
tabulate K2Q1G_I;
tabulate K2Q1H_A;
tabulate K2Q1H_B;
tabulate K2Q1H_C;
tabulate K2Q1H_D;
tabulate K2Q1H_E;
tabulate K2Q1H_F;
tabulate K2Q1H_G;
tabulate K2Q1H_H;
tabulate K2Q1H_I;
tabulate K2Q1I_A;
tabulate K2Q1I_B;
tabulate K2Q1I_C;
tabulate K2Q1I_D;
tabulate K2Q1I_E;
tabulate K2Q1I_F;
tabulate K2Q1I_G;
tabulate K2Q1I_H;
tabulate K2Q1I_I;
tabulate K2Q1J_A;
tabulate K2Q1J_B;
tabulate K2Q1J_C;
tabulate K2Q1J_D;
tabulate K2Q1J_E;
tabulate K2Q1J_F;
tabulate K2Q1J_G;
tabulate K2Q1J_H;
tabulate K2Q1J_I;
tabulate K2Q1K_A;
tabulate K2Q1K_B;
tabulate K2Q1K_C;
tabulate K2Q1K_F;
tabulate K2Q1K_I;
tabulate K2Q1L_B;
tabulate K2Q1L_C;
tabulate K2Q1L_D;
tabulate K2Q1L_E;
tabulate K2Q1L_F;
tabulate K2Q1L_G;
tabulate K2Q1L_H;
tabulate K2Q1L_I;
tabulate K2Q2_A;
tabulate K2Q2_B;
tabulate K2Q2_C;
tabulate K2Q2_D;
tabulate K2Q2_E;
tabulate K2Q2_F;
tabulate K2Q2_G;
tabulate K2Q2_H;
tabulate K2Q2_I;
tabulate K2Q2_J;
tabulate K2Q2_K;
tabulate K2Q2_L;
tabulate K2Q3;
tabulate K2Q3A_A;
tabulate K2Q3B_B;
tabulate K2Q3C_C;
tabulate K2Q3D_D;
tabulate K2Q4;
tabulate K2Q5_A;
tabulate K2Q5_B;
tabulate K2Q5_C;
tabulate K2Q5_D;
tabulate K2Q6_A;
tabulate K2Q6_B;
tabulate K2Q6_C;
tabulate K2Q6_D;
tabulate K2Q6_E;
tabulate K2Q6_F;
tabulate S2PRACE;
summarize S2SAQW0 S2KENRLK S2KFLNCH S2KRLNCH S2KLNGTH S2KGFTED S2NUMDAY S2ADA S2ANUMCH S2HDCHDN S2HDCLS S2HDHRS S2FDCHDN S2FDCLS S2FDHRS S2KCCHDN S2KCHRS S2TKCHDN S2TKHRS S2T1CHDN S2T1HRS S2DDFIVE S2YYFIVE S2CHLDNM S2RMNUM S2INSTCM S2ADMNCM S2TOTCM S2LANRMS S2CDRRMS S2NETRMS S2NGHBOR S2BUSSED S2OUTSID S2PCTRD S2PCTMTH S2NMBKPT S2NMADMN S2NMTECH S2NMDSTR S2NUMBRD S2NMOMDD S2NMREPS S2NUMOTH S2LEPSCH S2LEPKND S2YRSESL S2YRSBIL S2SRVBTH S2ADMFTE S2TCHFTE S2GYMFTE S2CMPFTE S2HDSFTE S2CRDFTE S2TT1FTE S2AIDFTE S2SPEFTE S2SPAFTE S2ESLFTE S2ESAFTE S2LIAFTE S2COUFTE S2LIBFTE S2THRFTE S2NRSFTE S2NONFTE S2MSCFTE S2FRLFTE S2FTETOT S2ETHNIC S2Q62IND S2Q62ASN S2Q62BLK S2Q62WHT S2HWLONG S2OBSVNT S2OBSVTT S2BRTHYR S2YSTCH S2TOTPRI S2PRINHR S2YRPREK S2YRK S2YR1ST S2YR2TO5 S2YR6 S2YRESL S2YRBILG S2YRSPED S2YRPHED S2YRART S2CRSECE S2CRSELE S2CRSSPE S2CRSESL S2CRSCDV S2CRSMTR S2CRSMTM S2CRSSCI S2CRSADM S2INSTRU S2INRMGT S2DISCAT S2MONITR S2TEEECH S2TALKPT S2STUDNT S2PPRWRK S2DDCOMP S2YYCOMP K2Q5_OBS S2SAQSTR S2SAQPSU S2SAQW1 S2SAQW2 S2SAQW3 S2SAQW4 S2SAQW5 S2SAQW6 S2SAQW7 S2SAQW8 S2SAQW9 S2SAQW10 S2SAQW11 S2SAQW12 S2SAQW13 S2SAQW14 S2SAQW15 S2SAQW16 S2SAQW17 S2SAQW18 S2SAQW19 S2SAQW20 S2SAQW21 S2SAQW22 S2SAQW23 S2SAQW24 S2SAQW25 S2SAQW26 S2SAQW27 S2SAQW28 S2SAQW29 S2SAQW30 S2SAQW31 S2SAQW32 S2SAQW33 S2SAQW34 S2SAQW35 S2SAQW36 S2SAQW37 S2SAQW38 S2SAQW39 S2SAQW40 S2SAQW41 S2SAQW42 S2SAQW43 S2SAQW44 S2SAQW45 S2SAQW46 S2SAQW47 S2SAQW48 S2SAQW49 S2SAQW50 S2SAQW51 S2SAQW52 S2SAQW53 S2SAQW54 S2SAQW55 S2SAQW56 S2SAQW57 S2SAQW58 S2SAQW59 S2SAQW60 S2SAQW61 S2SAQW62 S2SAQW63 S2SAQW64 S2SAQW65 S2SAQW66 S2SAQW67 S2SAQW68 S2SAQW69 S2SAQW70 S2SAQW71 S2SAQW72 S2SAQW73 S2SAQW74 S2SAQW75 S2SAQW76 S2SAQW77 S2SAQW78 S2SAQW79 S2SAQW80 S2SAQW81 S2SAQW82 S2SAQW83 S2SAQW84 S2SAQW85 S2SAQW86 S2SAQW87 S2SAQW88 S2SAQW89 S2SAQW90;
