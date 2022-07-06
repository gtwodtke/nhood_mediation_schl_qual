* This is a do-file for STATA programming. In order to use it correctly,
* You should type 'do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\read\ECLSK_BaseYear_Teacher_STATA.do" nostop' in command line
* after you launch the STATA application.
infile using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\dct\ECLSK_BaseYear_Teacher_STATA.dct"
#delimit ;
keep if  (S2KPUPRI == 1 | 
       S2KPUPRI == 2 | 
       S2KPUPRI == -9); 
   keep if (KGCLASS == 1 | 
       KGCLASS == 2 | 
       KGCLASS == 3 | 
       KGCLASS == 4 | 
       KGCLASS == 5 | 
       KGCLASS == 6 | 
       KGCLASS == 7 | 
       KGCLASS == -9);
   label define LOCALE
      1  "CENTRAL CITY"  
      2  "URBAN FRINGE AND LARGE TOWN"  
      3  "SMALL TOWN AND RURAL"  
;
   label define REGIONS
      1  "NORTHEAST"  
      2  "MIDWEST"  
      3  "SOUTH"  
      4  "WEST"  
      -9  "NOT ASCERTAINED"  
;
   label define SCTYPES
      1  "CATHOLIC"  
      2  "OTHER RELIGIOUS"  
      3  "OTHER PRIVATE"  
      4  "PUBLIC/DOD/BIA"  
      -9  "NOT ASCERTAINED"  
;
   label define S2PUBPRI
      1  "PUBLIC"  
      2  "PRIVATE"  
      -9  "NOT ASCERTAINED"  
;
   label define S2SCTYPE
      1  "CATHOLIC"  
      2  "OTHER RELIGIOUS"  
      3  "OTHER PRIVATE"  
      4  "PUBLIC"  
      -9  "NOT ASCERTAINED"  
;
   label define S2ENRLS
      1  "0-149 STUDENTS"  
      2  "150-299 STUDENTS"  
      3  "300-499 STUDENTS"  
      4  "500-749 STUDENTS"  
      5  "750 AND ABOVE"  
      -9  "NOT ASCERTAINED"  
;
   label define S2SCLVL
      1  "LESS THAN 1ST GRADE"  
      2  "PRIMARY SCHOOL"  
      3  "ELEMENTARY SCHOOL"  
      4  "COMBINED SCHOOL"  
      -9  "NOT ASCERTAINED"  
;
   label define A2CLASS
      1  "AM ONLY"  
      2  "PM ONLY"  
      3  "AM AND PM"  
      4  "ALL DAY ONLY"  
      5  "AM AND ALL DAY"  
      6  "PM AND ALL DAY"  
      7  "AM, PM, AND ALL DAY"  
      -9  "NOT ASCERTAINED"  
;
   label define A2NEW
      0 - 7  "0 - 7"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2BEHVR
      1  "GROUP MISBEHAVES VERY FREQUENTLY"  
      2  "GROUP MISBEHAVES FREQUENTLY"  
      3  "GROUP MISBEHAVES OCCASIONALLY"  
      4  "GROUP BEHAVES WELL"  
      5  "GROUP BEHAVES EXCEPTIONALLY WELL"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2WHOLE
      1  "NO TIME"  
      2  "HALF HOUR OR LESS"  
      3  "ABOUT ONE HOUR"  
      4  "ABOUT TWO HOURS"  
      5  "THREE HOURS OR MORE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2YN
      1  "YES"  
      2  "NO"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2YNN
      1  "YES"  
      2  "NO"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2OFTRD
      1  "NEVER"  
      2  "LESS THAN ONCE A WEEK"  
      3  "1-2 TIMES A WEEK"  
      4  "3-4 TIMES A WEEK"  
      5  "DAILY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2TXRD
      1  "1-30 MINUTES A DAY"  
      2  "31-60 MINUTES A DAY"  
      3  "61-90 MINUTES A DAY"  
      4  "MORE THAN 90 MINUTES A DAY"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2TXSPEN
      1  "DO NOT PARTICIPATE IN PHYSICAL EDUCATION"  
      2  "1-15 MINUTES PER DAY"  
      3  "16-30 MINUTES PER DAY"  
      4  "31-60 MINUTES PER DAY"  
      5  "MORE THAN 60 MINUTES PER DAY"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DYREC
      0 - 5  "0 - 5"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2TXREC
      1  "ONCE"  
      2  "TWICE"  
      3  "THREE OR MORE TIMES"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2LUNCH
      1  "1-15 MINUTES"  
      2  "16-30 MINUTES"  
      3  "31-45 MINUTES"  
      4  "LONGER THAN 45 MINUTES"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DIVREA
      1  "NEVER"  
      2  "LESS THAN ONCE A WEEK"  
      3  "ONCE OR TWICE A WEEK"  
      4  "THREE OR FOUR TIMES A WEEK"  
      5  "DAILY"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DIV
      1  "NEVER"  
      2  "LESS THAN ONCE A WEEK"  
      3  "ONCE OR TWICE A WEEK"  
      4  "THREE OR FOUR TIMES A WEEK"  
      5  "DAILY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2MINREA
      1  "1-15 MINUTES/DAY"  
      2  "16-30 MINUTES/DAY"  
      3  "31-60 MINUTES/DAY"  
      4  "LONGER THAN 60 MINUTES/DAY"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2EXASIS
      1  "NEVER"  
      2  "LESS THAN ONCE A WEEK"  
      3  "ONCE OR TWICE A WEEK"  
      4  "THREE OR FOUR TIMES A WEEK"  
      5  "DAILY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2GOTO
      0  "NO LIBRARY OR MEDIA CENTER IN THIS SCHOOL"  
      1  "ONCE A MONTH OR LESS"  
      2  "TWO OR THREE TIMES A MONTH"  
      3  "ONCE OR TWICE A WEEK"  
      4  "THREE OR FOUR TIMES A WEEK"  
      5  "DAILY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2REGWRK
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2SPEA
      1  "NOT AT ALL WELL"  
      2  "NOT WELL"  
      3  "WELL"  
      4  "VERY WELL"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2LVLEF
      1  "HIGH SCHOOL DIPLOMA OR GED"  
      2  "AA IN EARLY CHILDHOOD EDUCATION"  
      3  "BA OR BS IN ELEMENTARY EDUCATION"  
      4  "WORKING ON A BACHELORS DEGREE"  
      5  "DONT KNOW"  
      6  "OTHER (SPECIFY)"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2CERTF
      1  "ELEMENTARY EDUCATION"  
      2  "EARLY CHILDHOOD EDUCATION"  
      3  "CURRENTLY WORKING ON A TEACHING CREDENT"  
      4  "DON'T KNOW"  
      5  "OTHER (SPECIFY)"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -9  "NOT ASCERTAINED"  
;
   label define A2TXTBK
      1  "I DO NOT USE THESE AT THIS GRADE LEVEL"  
      2  "NEVER ADEQUATE"  
      3  "OFTEN NOT ADEQUATE"  
      4  "SOMETIMES NOT ADEQUATE"  
      5  "ALWAYS ADEQUATE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ARTMAT
      0  "NOT AVAILABLE"  
      1  "NEVER"  
      2  "ONCE A MONTH OR LESS"  
      3  "TWO OR THREE TIMES A MONTH"  
      4  "ONCE OR TWICE A WEEK"  
      5  "THREE OR FOUR TIMES A WEEK"  
      6  "DAILY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2LERN
      1  "NEVER"  
      2  "ONCE A MONTH OR LESS"  
      3  "TWO OR THREE TIMES A MONTH"  
      4  "ONCE OR TWICE A WEEK"  
      5  "THREE OR FOUR TIMES A WEEK"  
      6  "DAILY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2CONVEN
      1  "TAUGHT AT A HIGHER GRADE LEVEL"  
      2  "CHILDREN SHOULD ALREADY KNOW"  
      3  "ONE A MONTH OR LESS"  
      4  "2-3 TIMES A MONTH"  
      5  "1-2 TIMES A WEEK"  
      6  "3-4 TIMES A WEEK"  
      7  "DAILY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2INVSP
      1  "STRONGLY DISAGREE"  
      2  "DISAGREE"  
      3  "NEITHER AGREE NOR DISAGREE"  
      4  "AGREE"  
      5  "STRONGLY AGREE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2LRNREA
      1  "NEVER"  
      2  "ONCE A MONTH OR LESS"  
      3  "TWO OR THREE TIMES A MONTH"  
      4  "ONCE OR TWICE A WEEK"  
      5  "THREE OR FOUR TIMES A WEEK"  
      6  "DAILY"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2NUMCON
      1  "NO CONFERENCES"  
      2  "ONE CONFERENCE"  
      3  "TWO CONFERENCES"  
      4  "THREE OR MORE CONFERENCES"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2TPCONF
      1  "NONE"  
      2  "1-25 PERCENT"  
      3  "26-50 PERCENT"  
      4  "51-75 PERCENT"  
      5  "76 PERCENT OR MORE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2SENTHO
      1  "NEVER"  
      2  "ONE TO TWO TIMES"  
      3  "THREE OR FIVE TIMES"  
      4  "SIX TO TEN TIMES"  
      5  "10-14 TIMES"  
      6  "15 OR MORE TIMES"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2MMCOMP
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
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DDCOMP
      1 - 31  "1 - 31"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2YYCOMP
      1999  "1999"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2YNCOMP
      1  "TRUE"  
      0  "FALSE"  
;
   label define B1001F
      0 - 15  "0 - 15"  
      -9  "NOT ASCERTAINED"  
;
   label define B1002F
      0 - 30  "0 - 30"  
      -9  "NOT ASCERTAINED"  
;
   label define B1003F
      0 - 15  "0 - 15"  
      -9  "NOT ASCERTAINED"  
;
   label define B1004F
      0 - 15  "0 - 15"  
      -9  "NOT ASCERTAINED"  
;
   label define B1005F
      0 - 10  "0 - 10"  
      -9  "NOT ASCERTAINED"  
;
   label define B1006F
      0 - 10  "0 - 10"  
      -9  "NOT ASCERTAINED"  
;
   label define B1007F
      0 - 10  "0 - 10"  
      -9  "NOT ASCERTAINED"  
;
   label define B1008F
      0 - 10  "0 - 10"  
      -9  "NOT ASCERTAINED"  
;
   label define B1009F
      0 - 5  "0 - 5"  
      -9  "NOT ASCERTAINED"  
;
   label define B1010F
      0 - 5  "0 - 5"  
      -9  "NOT ASCERTAINED"  
;
   label define B1011F
      0 - 30  "0 - 30"  
      -9  "NOT ASCERTAINED"  
;
   label define B1012F
      24 - 58  "24 - 58"  
      -9  "NOT ASCERTAINED"  
;
   label define A1048F
      1  "YES"  
      2  "NO"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1049F
      1  "NONE"  
      2  "1 - 25%"  
      3  "26 - 50%"  
      4  "51 - 75%"  
      5  "76% OR MORE"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1050F
      1  "GROUP MISBEHAVES VERY FREQUENTLY"  
      2  "GROUP MISBEHAVES FREQUENTLY"  
      3  "GROUP MISBEHAVES OCCASIONALLY"  
      4  "GROUP BEHAVES WELL"  
      5  "GROUP BEHAVES EXCEPTIONALLY WELL"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1051F
      1  "YES"  
      2  "NO"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1068F
      1  "1 - 15 MINUTES PER DAY"  
      2  "16 - 30 MINUTES PER DAY"  
      3  "31 - 60 MINUTES PER DAY"  
      4  "MORE THAN 60 MINUTES PER DAY"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1069F
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
      -9  "NOT ASCERTAINED"  
;
   label define A1070F
      1 - 31  "1 - 31"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1071F
      1998  "1998"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1072F
      1  "ARABIC"  
      2  "FRENCH"  
      3  "GERMAN"  
      4  "GREEK"  
      5  "ITALIAN"  
      6  "POLISH"  
      7  "PORTUGUESE"  
      8  "AFRICAN LANGUAGE"  
      9  "EAST EUROPEAN LANGUAGE"  
      10  "NATIVE AMERICAN LANGUAGE"  
      11  "SIGN LANGUAGE"  
      12  "MIDDLE EASTERN LANGUAGE"  
      13  "WEST EUROPEAN LANGUAGE"  
      14  "INDIAN SUBCONTINENT - LANGUAGE"  
      15  "SOUTHEASTERN ASIAN LANGUAGE"  
      16  "PACIFIC ISLANDS LANGUAGE"  
      17  "OTHER LANGUAGE"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1073F
      1  "ARABIC"  
      2  "FRENCH"  
      3  "GERMAN"  
      4  "GREEK"  
      5  "ITALIAN"  
      6  "POLISH"  
      7  "PORTUGUESE"  
      8  "AFRICAN LANGUAGE"  
      9  "EAST EUROPEAN LANGUAGE"  
      10  "NATIVE AMERICAN LANGUAGE"  
      11  "SIGN LANGUAGE"  
      12  "MIDDLE EASTERN LANGUAGE"  
      13  "WEST EUROPEAN LANGUAGE"  
      14  "INDIAN SUBCONTINENT - LANGUAGE"  
      15  "SOUTHEASTERN ASIAN LANGUAGE"  
      16  "PACIFIC ISLANDS LANGUAGE"  
      17  "OTHER LANGUAGE"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define B1013F
      1  "NO TIME"  
      2  "HALF HOUR OR LESS"  
      3  "ABOUT ONE HOUR"  
      4  "ABOUT TWO HOURS"  
      5  "THREE HOURS OR MORE"  
      -9  "NOT ASCERTAINED"  
;
   label define B1014F
      1  "YES"  
      2  "NO"  
      -9  "NOT ASCERTAINED"  
;
   label define B1015F
      1  "NOT IMPORTANT"  
      2  "SOMEWHAT IMPORTANT"  
      3  "VERY IMPORTANT"  
      4  "EXTREMELY IMPORTANT"  
      5  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define B1016F
      1  "SAME STANDARDS, EXCEPTIONS FOR NEEDS"  
      2  "DIFFERENT STANDARDS BASED ON TALENTS"  
      3  "EXACTLY THE SAME STANDARDS"  
      -9  "NOT ASCERTAINED"  
;
   label define B1017F
      1  "2 HOURS OR LESS PER WEEK"  
      2  "MORE THAN 2 HOURS BUT LESS THAN 5 A WEEK"  
      3  "5 TO 9 HOURS PER WEEK"  
      4  "10 TO 14 HOURS PER WEEK"  
      5  "15 OR MORE HOURS PER WEEK"  
      -9  "NOT ASCERTAINED"  
;
   label define B1018F
      1  "NOT IMPORTANT"  
      2  "NOT VERY IMPORTANT"  
      3  "SOMEWHAT IMPORTANT"  
      4  "VERY IMPORTANT"  
      5  "ESSENTIAL"  
      -9  "NOT ASCERTAINED"  
;
   label define B1019F
      1  "STRONGLY DISAGREE"  
      2  "DISAGREE"  
      3  "NEITHER AGREE NOR DISAGREE"  
      4  "AGREE"  
      5  "STRONGLY AGREE"  
      -9  "NOT ASCERTAINED"  
;
   label define B1020F
      1  "NO INFLUENCE"  
      2  "SLIGHT INFLUENCE"  
      3  "SOME INFLUENCE"  
      4  "MODERATE INFLUENCE"  
      5  "A GREAT DEAL OF INFLUENCE"  
      -9  "NOT ASCERTAINED"  
;
   label define B1021F
      1  "NO CONTROL"  
      2  "SLIGHT CONTROL"  
      3  "SOME CONTROL"  
      4  "MODERATE CONTROL"  
      5  "A GREAT DEAL OF CONTROL"  
      -9  "NOT ASCERTAINED"  
;
   label define B1022F
      1  "MALE"  
      2  "FEMALE"  
      -9  "NOT ASCERTAINED"  
;
   label define B1023F
      1940 - 1974  "1940 - 1974"  
      -9  "NOT ASCERTAINED"  
;
   label define B1024F
      1  "YES"  
      2  "NO"  
      -9  "NOT ASCERTAINED"  
;
   label define B1025F
      1  "HIGH SCHOOL/ASSOCIATE'S DEGREE/BACHELOR'S DEGREE"  
      2  "AT LEAST ONE YEAR BEYOND BACHELOR'S"  
      3  "MASTER'S DEGREE"  
      4  "EDUCATION SPECIALIST/PROFESSIONAL DIPLOMA"  
      5  "DOCTORATE"  
      -9  "NOT ASCERTAINED"  
;
   label define B1026F
      0  "0"  
      1  "1"  
      2  "2"  
      3  "3"  
      4  "4"  
      5  "5"  
      6  "6+"  
      -9  "NOT ASCERTAINED"  
;
   label define B1027F
      1  "NONE"  
      2  "TEMPORARY/PROBATIONAL CERTIFICATION"  
      3  "ALTERNATIVE PROGRAM CERTIFICATION"  
      4  "REGULAR CERTIFICATION, LESS THAN HIGHEST"  
      5  "HIGHEST CERTIFICATION AVAILABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define B1028F
      1  "YES"  
      2  "NO"  
      -9  "NOT ASCERTAINED"  
;
   label define B1029F
      1998  "1998"  
      1999  "1999"  
      -9  "NOT ASCERTAINED"  
;
   label define B1030F
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
      -9  "NOT ASCERTAINED"  
;
   label define B1031F
      1 - 31  "1 - 31"  
      -9  "NOT ASCERTAINED"  
;
   label define B1TTWSTR
      1 - 89  "1 - 89"  
;
   label define B1TTWPSU
      1 - 80  "1 - 80"  
;
   label define B1TW0F
      0 - 504  "0 - 504"  
;
   label define B1TW1F
      0 - 585  "0 - 585"  
;
   label define B1TW2F
      0 - 589  "0 - 589"  
;
   label define B1TW3F
      0 - 500  "0 - 500"  
;
   label define B1TW4F
      0 - 504  "0 - 504"  
;
   label define B1TW5F
      0 - 508  "0 - 508"  
;
   label define B1TW6F
      0 - 504  "0 - 504"  
;
   label define B1TW7F
      0 - 503  "0 - 503"  
;
   label define B1TW8F
      0 - 500  "0 - 500"  
;
   label define B1TW9F
      0 - 500  "0 - 500"  
;
   label define B1TW10F
      0 - 501  "0 - 501"  
;
   label define B1TW11F
      0 - 512  "0 - 512"  
;
   label define B1TW12F
      0 - 508  "0 - 508"  
;
   label define B1TW13F
      0 - 506  "0 - 506"  
;
   label define B1TW14F
      0 - 508  "0 - 508"  
;
   label define B1TW15F
      0 - 510  "0 - 510"  
;
   label define B1TW16F
      0 - 503  "0 - 503"  
;
   label define B1TW17F
      0 - 778  "0 - 778"  
;
   label define B1TW18F
      0 - 508  "0 - 508"  
;
   label define B1TW19F
      0 - 504  "0 - 504"  
;
   label define B1TW20F
      0 - 496  "0 - 496"  
;
   label define B1TW21F
      0 - 500  "0 - 500"  
;
   label define B1TW22F
      0 - 504  "0 - 504"  
;
   label define B1TW23F
      0 - 508  "0 - 508"  
;
   label define B1TW24F
      0 - 508  "0 - 508"  
;
   label define B1TW25F
      0 - 504  "0 - 504"  
;
   label define B1TW26F
      0 - 504  "0 - 504"  
;
   label define B1TW27F
      0 - 504  "0 - 504"  
;
   label define B1TW28F
      0 - 505  "0 - 505"  
;
   label define B1TW29F
      0 - 504  "0 - 504"  
;
   label define B1TW30F
      0 - 500  "0 - 500"  
;
   label define B1TW31F
      0 - 512  "0 - 512"  
;
   label define B1TW32F
      0 - 504  "0 - 504"  
;
   label define B1TW33F
      0 - 504  "0 - 504"  
;
   label define B1TW34F
      0 - 508  "0 - 508"  
;
   label define B1TW35F
      0 - 500  "0 - 500"  
;
   label define B1TW36F
      0 - 504  "0 - 504"  
;
   label define B1TW37F
      0 - 504  "0 - 504"  
;
   label define B1TW38F
      0 - 504  "0 - 504"  
;
   label define B1TW39F
      0 - 504  "0 - 504"  
;
   label define B1TW40F
      0 - 508  "0 - 508"  
;
   label define B1TW41F
      0 - 502  "0 - 502"  
;
   label define B1TW42F
      0 - 501  "0 - 501"  
;
   label define B1TW43F
      0 - 500  "0 - 500"  
;
   label define B1TW44F
      0 - 496  "0 - 496"  
;
   label define B1TW45F
      0 - 502  "0 - 502"  
;
   label define B1TW46F
      0 - 508  "0 - 508"  
;
   label define B1TW47F
      0 - 498  "0 - 498"  
;
   label define B1TW48F
      0 - 508  "0 - 508"  
;
   label define B1TW49F
      0 - 504  "0 - 504"  
;
   label define B1TW50F
      0 - 500  "0 - 500"  
;
   label define B1TW51F
      0 - 509  "0 - 509"  
;
   label define B1TW52F
      0 - 507  "0 - 507"  
;
   label define B1TW53F
      0 - 504  "0 - 504"  
;
   label define B1TW54F
      0 - 503  "0 - 503"  
;
   label define B1TW55F
      0 - 503  "0 - 503"  
;
   label define B1TW56F
      0 - 505  "0 - 505"  
;
   label define B1TW57F
      0 - 500  "0 - 500"  
;
   label define B1TW58F
      0 - 501  "0 - 501"  
;
   label define B1TW59F
      0 - 505  "0 - 505"  
;
   label define B1TW60F
      0 - 606  "0 - 606"  
;
   label define B1TW61F
      0 - 504  "0 - 504"  
;
   label define B1TW62F
      0 - 504  "0 - 504"  
;
   label define B1TW63F
      0 - 504  "0 - 504"  
;
   label define B1TW64F
      0 - 499  "0 - 499"  
;
   label define B1TW65F
      0 - 502  "0 - 502"  
;
   label define B1TW66F
      0 - 503  "0 - 503"  
;
   label define B1TW67F
      0 - 508  "0 - 508"  
;
   label define B1TW68F
      0 - 503  "0 - 503"  
;
   label define B1TW69F
      0 - 500  "0 - 500"  
;
   label define B1TW70F
      0 - 495  "0 - 495"  
;
   label define B1TW71F
      0 - 512  "0 - 512"  
;
   label define B1TW72F
      0 - 504  "0 - 504"  
;
   label define B1TW73F
      0 - 518  "0 - 518"  
;
   label define B1TW74F
      0 - 491  "0 - 491"  
;
   label define B1TW75F
      0 - 405  "0 - 405"  
;
   label define B1TW76F
      0 - 504  "0 - 504"  
;
   label define B1TW77F
      0 - 501  "0 - 501"  
;
   label define B1TW78F
      0 - 665  "0 - 665"  
;
   label define B1TW79F
      0 - 500  "0 - 500"  
;
   label define B1TW80F
      0 - 507  "0 - 507"  
;
   label define B1TW81F
      0 - 499  "0 - 499"  
;
   label define B1TW82F
      0 - 503  "0 - 503"  
;
   label define B1TW83F
      0 - 504  "0 - 504"  
;
   label define B1TW84F
      0 - 513  "0 - 513"  
;
   label define B1TW85F
      0 - 508  "0 - 508"  
;
   label define B1TW86F
      0 - 511  "0 - 511"  
;
   label define B1TW87F
      0 - 548  "0 - 548"  
;
   label define B1TW88F
      0 - 506  "0 - 506"  
;
   label define B1TW89F
      0 - 501  "0 - 501"  
;
   label define B1TW90F
      0 - 511  "0 - 511"  
;
   label define B2TTWSTR
      1 - 90  "1 - 90"  
;
   label define B2TTWPSU
      1 - 84  "1 - 84"  
;
   label define B2TW0F
      0 - 454  "0 - 454"  
;
   label define B2TW1F
      0 - 523  "0 - 523"  
;
   label define B2TW2F
      0 - 522  "0 - 522"  
;
   label define B2TW3F
      0 - 459  "0 - 459"  
;
   label define B2TW4F
      0 - 454  "0 - 454"  
;
   label define B2TW5F
      0 - 458  "0 - 458"  
;
   label define B2TW6F
      0 - 454  "0 - 454"  
;
   label define B2TW7F
      0 - 447  "0 - 447"  
;
   label define B2TW8F
      0 - 450  "0 - 450"  
;
   label define B2TW9F
      0 - 450  "0 - 450"  
;
   label define B2TW10F
      0 - 452  "0 - 452"  
;
   label define B2TW11F
      0 - 461  "0 - 461"  
;
   label define B2TW12F
      0 - 457  "0 - 457"  
;
   label define B2TW13F
      0 - 456  "0 - 456"  
;
   label define B2TW14F
      0 - 458  "0 - 458"  
;
   label define B2TW15F
      0 - 456  "0 - 456"  
;
   label define B2TW16F
      0 - 453  "0 - 453"  
;
   label define B2TW17F
      0 - 673  "0 - 673"  
;
   label define B2TW18F
      0 - 464  "0 - 464"  
;
   label define B2TW19F
      0 - 455  "0 - 455"  
;
   label define B2TW20F
      0 - 447  "0 - 447"  
;
   label define B2TW21F
      0 - 451  "0 - 451"  
;
   label define B2TW22F
      0 - 454  "0 - 454"  
;
   label define B2TW23F
      0 - 457  "0 - 457"  
;
   label define B2TW24F
      0 - 458  "0 - 458"  
;
   label define B2TW25F
      0 - 454  "0 - 454"  
;
   label define B2TW26F
      0 - 454  "0 - 454"  
;
   label define B2TW27F
      0 - 454  "0 - 454"  
;
   label define B2TW28F
      0 - 451  "0 - 451"  
;
   label define B2TW29F
      0 - 454  "0 - 454"  
;
   label define B2TW30F
      0 - 451  "0 - 451"  
;
   label define B2TW31F
      0 - 460  "0 - 460"  
;
   label define B2TW32F
      0 - 454  "0 - 454"  
;
   label define B2TW33F
      0 - 454  "0 - 454"  
;
   label define B2TW34F
      0 - 456  "0 - 456"  
;
   label define B2TW35F
      0 - 451  "0 - 451"  
;
   label define B2TW36F
      0 - 454  "0 - 454"  
;
   label define B2TW37F
      0 - 454  "0 - 454"  
;
   label define B2TW38F
      0 - 454  "0 - 454"  
;
   label define B2TW39F
      0 - 454  "0 - 454"  
;
   label define B2TW40F
      0 - 452  "0 - 452"  
;
   label define B2TW41F
      0 - 454  "0 - 454"  
;
   label define B2TW42F
      0 - 452  "0 - 452"  
;
   label define B2TW43F
      0 - 451  "0 - 451"  
;
   label define B2TW44F
      0 - 453  "0 - 453"  
;
   label define B2TW45F
      0 - 454  "0 - 454"  
;
   label define B2TW46F
      0 - 456  "0 - 456"  
;
   label define B2TW47F
      0 - 451  "0 - 451"  
;
   label define B2TW48F
      0 - 458  "0 - 458"  
;
   label define B2TW49F
      0 - 454  "0 - 454"  
;
   label define B2TW50F
      0 - 453  "0 - 453"  
;
   label define B2TW51F
      0 - 459  "0 - 459"  
;
   label define B2TW52F
      0 - 457  "0 - 457"  
;
   label define B2TW53F
      0 - 454  "0 - 454"  
;
   label define B2TW54F
      0 - 453  "0 - 453"  
;
   label define B2TW55F
      0 - 452  "0 - 452"  
;
   label define B2TW56F
      0 - 455  "0 - 455"  
;
   label define B2TW57F
      0 - 452  "0 - 452"  
;
   label define B2TW58F
      0 - 454  "0 - 454"  
;
   label define B2TW59F
      0 - 456  "0 - 456"  
;
   label define B2TW60F
      0 - 537  "0 - 537"  
;
   label define B2TW61F
      0 - 454  "0 - 454"  
;
   label define B2TW62F
      0 - 454  "0 - 454"  
;
   label define B2TW63F
      0 - 454  "0 - 454"  
;
   label define B2TW64F
      0 - 451  "0 - 451"  
;
   label define B2TW65F
      0 - 454  "0 - 454"  
;
   label define B2TW66F
      0 - 451  "0 - 451"  
;
   label define B2TW67F
      0 - 457  "0 - 457"  
;
   label define B2TW68F
      0 - 452  "0 - 452"  
;
   label define B2TW69F
      0 - 452  "0 - 452"  
;
   label define B2TW70F
      0 - 449  "0 - 449"  
;
   label define B2TW71F
      0 - 460  "0 - 460"  
;
   label define B2TW72F
      0 - 453  "0 - 453"  
;
   label define B2TW73F
      0 - 464  "0 - 464"  
;
   label define B2TW74F
      0 - 444  "0 - 444"  
;
   label define B2TW75F
      0 - 347  "0 - 347"  
;
   label define B2TW76F
      0 - 448  "0 - 448"  
;
   label define B2TW77F
      0 - 451  "0 - 451"  
;
   label define B2TW78F
      0 - 594  "0 - 594"  
;
   label define B2TW79F
      0 - 452  "0 - 452"  
;
   label define B2TW80F
      0 - 457  "0 - 457"  
;
   label define B2TW81F
      0 - 447  "0 - 447"  
;
   label define B2TW82F
      0 - 451  "0 - 451"  
;
   label define B2TW83F
      0 - 454  "0 - 454"  
;
   label define B2TW84F
      0 - 455  "0 - 455"  
;
   label define B2TW85F
      0 - 458  "0 - 458"  
;
   label define B2TW86F
      0 - 461  "0 - 461"  
;
   label define B2TW87F
      0 - 474  "0 - 474"  
;
   label define B2TW88F
      0 - 457  "0 - 457"  
;
   label define B2TW89F
      0 - 452  "0 - 452"  
;
   label define B2TW90F
      0 - 460  "0 - 460"  
;
   label define S2COMP
      1  "LESS THAN 10"  
      2  "10 TO LESS THAN 25"  
      3  "25 TO LESS THAN 50"  
      4  "50 TO LESS THAN 75"  
      5  "75 OR MORE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1004P
      2 - 7  "2 - 7"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1004D
      2 - 8  "2 - 8"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1004A
      2 - 7  "2 - 7"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1005P
      2 - 5  "2 - 5"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1005D
      2 - 6  "2 - 6"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1005A
      1 - 6  "1 - 6"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1006D
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1006A
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1006P
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1007D
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1007P
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1007A
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1008P
      0 - 25  "0 - 25"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1008A
      0 - 25  "0 - 25"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1008D
      0 - 30  "0 - 30"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1009A
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1009P
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1009D
      0 - 15  "0 - 15"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1010P
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1010D
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1010A
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1011D
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1011P
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1011A
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1012P
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1012D
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1012A
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1013D
      10 - 30  "10 - 30"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1013P
      10 - 30  "10 - 30"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1013A
      10 - 30  "10 - 30"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1014A
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1014P
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1014D
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1015P
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1015D
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1015A
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1016P
      0 - 15  "0 - 15"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1016D
      0 - 25  "0 - 25"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1016A
      0 - 15  "0 - 15"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1017P
      0 - 25  "0 - 25"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1017D
      0 - 25  "0 - 25"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1017A
      0 - 25  "0 - 25"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1018A
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1018D
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1018P
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1019D
      0 - 5  "0 - 5"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1019P
      0 - 3  "0 - 3"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1019A
      0 - 3  "0 - 3"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1020D
      9 - 30  "9 - 30"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1020P
      9 - 30  "9 - 30"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1020A
      9 - 30  "9 - 30"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1021A
      0 - 33  "0 - 33"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1021P
      1 - 23  "1 - 23"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1021D
      0 - 29  "0 - 29"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1022D
      0 - 31  "0 - 31"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1022P
      0 - 24  "0 - 24"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1022A
      0 - 24  "0 - 24"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1023A
      0 - 18  "0 - 18"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1023D
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1023P
      0 - 13  "0 - 13"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1024A
      0 - 38  "0 - 38"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1024P
      0 - 30  "0 - 30"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1024D
      0 - 47  "0 - 47"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1025D
      0 - 27  "0 - 27"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1025P
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1025A
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1026D
      0 - 27  "0 - 27"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1026A
      0 - 41  "0 - 41"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1026P
      0 - 18  "0 - 18"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1027P
      0 - 32  "0 - 32"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1027D
      0 - 31  "0 - 31"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1027A
      0 - 32  "0 - 32"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1028D
      0 - 31  "0 - 31"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1028P
      0 - 28  "0 - 28"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1028A
      0 - 29  "0 - 29"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1029P
      0 - 32  "0 - 32"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1029A
      0 - 33  "0 - 33"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1029D
      0 - 31  "0 - 31"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1030P
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1030D
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1030A
      0 - 19  "0 - 19"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1031D
      0 - 95  "0 - 95"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1031A
      0 - 95  "0 - 95"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1031P
      0 - 95  "0 - 95"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1032P
      0 - 100  "0 - 100"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1032D
      0 - 100  "0 - 100"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1032A
      0 - 100  "0 - 100"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1033D
      0 - 100  "0 - 100"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1033P
      0 - 100  "0 - 100"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A1033A
      0 - 100  "0 - 100"  
      -1  "NOT APPLICABLE"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AOTDIS
      0 - 6  "0 - 6"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ASPCIA
      0 - 12  "0 - 12"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AIEP
      0 - 12  "0 - 12"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AS504F
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AMORE
      0 - 29  "0 - 29"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PLEFT
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2APRTGF
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PNEW
      0 - 39  "0 - 39"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PORTHO
      0 - 2  "0 - 2"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PPRTGF
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2MN18C
      0 - 60  "0 - 60"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PIMPAI
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ARDBLO
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DRDBLO
      0 - 26  "0 - 26"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DPRTGF
      0 - 3  "0 - 3"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DIMPAI
      0 - 22  "0 - 22"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DGIFT
      0 - 4  "0 - 4"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PRDBLO
      0 - 25  "0 - 25"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PGIFT
      0 - 2  "0 - 2"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ALEFT
      0 - 26  "0 - 26"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ANEW
      0 - 39  "0 - 39"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DDISAB
      0 - 9  "0 - 9"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DABSEN
      0 - 18  "0 - 18"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PMORE
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DTARDY
      0 - 22  "0 - 22"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DMTHBL
      0 - 23  "0 - 23"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2MN18E
      3 - 90  "3 - 90"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PMTHBL
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AGIFT
      0 - 2  "0 - 2"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PHEAR
      0 - 2  "0 - 2"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PVIS
      0 - 3  "0 - 3"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PDELAY
      0 - 20  "0 - 20"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PDSTRU
      0 - 2  "0 - 2"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PLRNDI
      0 - 30  "0 - 30"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PABSEN
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DNEW
      0 - 44  "0 - 44"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AIMPAI
      0 - 12  "0 - 12"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AORTHO
      0 - 3  "0 - 3"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PTRAUM
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DOTHER
      0 - 5  "0 - 5"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DORTHO
      0 - 4  "0 - 4"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DHEAR
      0 - 8  "0 - 8"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DVIS
      0 - 13  "0 - 13"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DDELAY
      0 - 23  "0 - 23"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DRETAR
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DIEP
      0 - 17  "0 - 17"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DTRAUM
      0 - 2  "0 - 2"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AOTHER
      0 - 12  "0 - 12"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PTARDY
      0 - 12  "0 - 12"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AHEAR
      0 - 3  "0 - 3"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AVIS
      0 - 5  "0 - 5"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ADELAY
      0 - 14  "0 - 14"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ADSTRU
      0 - 4  "0 - 4"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ALRNDI
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PDISAB
      0 - 8  "0 - 8"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ADISAB
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ATRAUM
      0 - 1  "0 - 1"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2ATARDY
      0 - 15  "0 - 15"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AABSEN
      0 - 8  "0 - 8"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AMHRS
      0 - 40  "0 - 40"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PS504F
      0 - 8  "0 - 8"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PIEP
      0 - 30  "0 - 30"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PSPCIA
      0 - 30  "0 - 30"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2POTDIS
      0 - 2  "0 - 2"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DLRNDI
      0 - 15  "0 - 15"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DLEFT
      0 - 30  "0 - 30"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2POTHER
      0 - 3  "0 - 3"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2PMHRS
      0 - 40  "0 - 40"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2AMTHBL
      0 - 15  "0 - 15"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2MN18D
      1 - 95  "1 - 95"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2MN18B
      2 - 90  "2 - 90"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2MN18A
      0 - 90  "0 - 90"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2NOMATH
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2NUMRD
      0 - 34  "0 - 34"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DMORE
      0 - 23  "0 - 23"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DS504F
      0 - 10  "0 - 10"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DSPCIA
      0 - 22  "0 - 22"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DDSTRU
      0 - 12  "0 - 12"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2DOTDIS
      0 - 9  "0 - 9"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2FDHRS
      0 - 45  "0 - 45"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2RECESS
      1  "1-15 MINUTES"  
      2  "16-30 MINUTES"  
      3  "31-45 MINUTES"  
      4  "LONGER THAN 45 MINUTES"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2REGWRA
      0 - 8  "0 - 8"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2REGWRB
      0 - 8  "0 - 8"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2REGWRC
      0 - 6  "0 - 6"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2REGWRD
      0 - 7  "0 - 7"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define A2REGWRE
      0 - 9  "0 - 9"  
      -1  "NOT APPLICABLE"  
      -7  "REFUSED"  
      -8  "DON'T KNOW"  
      -9  "NOT ASCERTAINED"  
;
   label define SUPPRESS
      -2  "DATA SUPPRESSED"  
;
   label values A1AHRSDA A1004A;
   label values A1DHRSDA A1004D;
   label values A1PHRSDA A1004P;
   label values A1ADYSWK A1005A;
   label values A1DDYSWK A1005D;
   label values A1PDYSWK A1005P;
   label values A1A3YROL A1006A;
   label values A1D3YROL A1006D;
   label values A1P3YROL A1006P;
   label values A1A4YROL A1007A;
   label values A1D4YROL A1007D;
   label values A1P4YROL A1007P;
   label values A1A5YROL A1008A;
   label values A1D5YROL A1008D;
   label values A1P5YROL A1008P;
   label values A1A6YROL A1009A;
   label values A1D6YROL A1009D;
   label values A1P6YROL A1009P;
   label values A1A7YROL A1010A;
   label values A1D7YROL A1010D;
   label values A1P7YROL A1010P;
   label values A1A8YROL A1011A;
   label values A1D8YROL A1011D;
   label values A1P8YROL A1011P;
   label values A1A9YROL A1012A;
   label values A1D9YROL A1012D;
   label values A1P9YROL A1012P;
   label values A1ATOTAG A1013A;
   label values A1DTOTAG A1013D;
   label values A1PTOTAG A1013P;
   label values A1AASIAN A1014A;
   label values A1DASIAN A1014D;
   label values A1PASIAN A1014P;
   label values A1AHISP A1015A;
   label values A1DHISP A1015D;
   label values A1PHISP A1015P;
   label values A1ABLACK A1016A;
   label values A1DBLACK A1016D;
   label values A1PBLACK A1016P;
   label values A1AWHITE A1017A;
   label values A1DWHITE A1017D;
   label values A1PWHITE A1017P;
   label values A1AAMRIN A1018A;
   label values A1DAMRIN A1018D;
   label values A1PAMRIN A1018P;
   label values A1ARACEO A1019A;
   label values A1DRACEO A1019D;
   label values A1PRACEO A1019P;
   label values A1ATOTRA A1020A;
   label values A1DTOTRA A1020D;
   label values A1PTOTRA A1020P;
   label values A1ABOYS A1021A;
   label values A1DBOYS A1021D;
   label values A1PBOYS A1021P;
   label values A1AGIRLS A1022A;
   label values A1DGIRLS A1022D;
   label values A1PGIRLS A1022P;
   label values A1AREPK A1023A;
   label values A1DREPK A1023D;
   label values A1PREPK A1023P;
   label values A1ALETT A1024A;
   label values A1DLETT A1024D;
   label values A1PLETT A1024P;
   label values A1AWORD A1025A;
   label values A1DWORD A1025D;
   label values A1PWORD A1025P;
   label values A1ASNTNC A1026A;
   label values A1DSNTNC A1026D;
   label values A1PSNTNC A1026P;
   label values A1ANUMLE A1027A;
   label values A1DNUMLE A1027D;
   label values A1PNUMLE A1027P;
   label values A1ANOESL A1028A;
   label values A1DNOESL A1028D;
   label values A1PNOESL A1028P;
   label values A1AESLRE A1029A;
   label values A1DESLRE A1029D;
   label values A1PESLRE A1029P;
   label values A1AESLOU A1030A;
   label values A1DESLOU A1030D;
   label values A1PESLOU A1030P;
   label values A1APBLK A1031A;
   label values A1DPBLK A1031D;
   label values A1PPBLK A1031P;
   label values A1APHIS A1032A;
   label values A1DPHIS A1032D;
   label values A1PPHIS A1032P;
   label values A1APMIN A1033A;
   label values A1DPMIN A1033D;
   label values A1PPMIN A1033P;
   label values A1ALEP A1048F;
   label values A1AOTLAN A1048F;
   label values A1APRESC A1048F;
   label values A1DLEP A1048F;
   label values A1DOTLAN A1048F;
   label values A1DPRESC A1048F;
   label values A1PLEP A1048F;
   label values A1POTLAN A1048F;
   label values A1PPRESC A1048F;
   label values A1APCPRE A1049F;
   label values A1DPCPRE A1049F;
   label values A1PPCPRE A1049F;
   label values A1ABEHVR A1050F;
   label values A1DBEHVR A1050F;
   label values A1PBEHVR A1050F;
   label values A1ACCHNS A1051F;
   label values A1ACFLPN A1051F;
   label values A1ACJPNS A1051F;
   label values A1ACKRN A1051F;
   label values A1ACSPNH A1051F;
   label values A1ACVTNM A1051F;
   label values A1AOTASN A1051F;
   label values A1AOTLNG A1051F;
   label values A1ATNOOT A1051F;
   label values A1ATSPNH A1051F;
   label values A1DCCHNS A1051F;
   label values A1DCFLPN A1051F;
   label values A1DCJPNS A1051F;
   label values A1DCKRN A1051F;
   label values A1DCSPNH A1051F;
   label values A1DCVTNM A1051F;
   label values A1DOTASN A1051F;
   label values A1DOTLNG A1051F;
   label values A1DTNOOT A1051F;
   label values A1DTSPNH A1051F;
   label values A1PCCHNS A1051F;
   label values A1PCFLPN A1051F;
   label values A1PCJPNS A1051F;
   label values A1PCKRN A1051F;
   label values A1PCSPNH A1051F;
   label values A1PCVTNM A1051F;
   label values A1POTASN A1051F;
   label values A1POTLNG A1051F;
   label values A1PTNOOT A1051F;
   label values A1PTSPNH A1051F;
   label values A1ANONEN A1068F;
   label values A1DNONEN A1068F;
   label values A1PNONEN A1068F;
   label values A1COMPMM A1069F;
   label values A1COMPDD A1070F;
   label values A1COMPYY A1071F;
   label values A1ALANOS A1072F;
   label values A1DLANOS A1072F;
   label values A1PLANOS A1072F;
   label values A1ALEPOS A1073F;
   label values A1DLEPOS A1073F;
   label values A1PLEPOS A1073F;
   label values A2AABSEN A2AABSEN;
   label values A2ADELAY A2ADELAY;
   label values A2ADISAB A2ADISAB;
   label values A2AEMPRB A2ADSTRU;
   label values A2AGIFT A2AGIFT;
   label values A2AHEAR A2AHEAR;
   label values A2AIEP A2AIEP;
   label values A2AIMPAI A2AIMPAI;
   label values A2ALEFT A2ALEFT;
   label values A2ALRNDI A2ALRNDI;
   label values A2AVHRS A2AMHRS;
   label values A2AMORE A2AMORE;
   label values A2AMTHBL A2AMTHBL;
   label values A2ANEW A2ANEW;
   label values A2AORTHO A2AORTHO;
   label values A2AOTDIS A2AOTDIS;
   label values A2AOTHER A2AOTHER;
   label values A2APRTGF A2APRTGF;
   label values A2ARDBLO A2ARDBLO;
   label values A2ARTMAT A2ARTMAT;
   label values A2BOOKS A2ARTMAT;
   label values A2COOK A2ARTMAT;
   label values A2COSTUM A2ARTMAT;
   label values A2EQUIPM A2ARTMAT;
   label values A2MUSIC A2ARTMAT;
   label values A2PLAYER A2ARTMAT;
   label values A2TVWTCH A2ARTMAT;
   label values A2VCR A2ARTMAT;
   label values A2ASC504 A2AS504F;
   label values A2ASPCIA A2ASPCIA;
   label values A2ATARDY A2ATARDY;
   label values A2ATRAUM A2ATRAUM;
   label values A2AVIS A2AVIS;
   label values A2ABEHVR A2BEHVR;
   label values A2DBEHVR A2BEHVR;
   label values A2PBEHVR A2BEHVR;
   label values A2ACERTF A2CERTF;
   label values A2DCERTF A2CERTF;
   label values A2PCERTF A2CERTF;
   label values KGCLASS A2CLASS;
   label values A21TO10 A2CONVEN;
   label values A22S5S10 A2CONVEN;
   label values A23DGT A2CONVEN;
   label values A2ACCURA A2CONVEN;
   label values A2ADD2DG A2CONVEN;
   label values A2ALPBTZ A2CONVEN;
   label values A2BODY A2CONVEN;
   label values A2BYD100 A2CONVEN;
   label values A2CARRY A2CONVEN;
   label values A2CMNITY A2CONVEN;
   label values A2COMPSE A2CONVEN;
   label values A2CONVNT A2CONVEN;
   label values A2CULTUR A2CONVEN;
   label values A2DATACO A2CONVEN;
   label values A2DINOSR A2CONVEN;
   label values A2DRCTNS A2CONVEN;
   label values A2ECOLOG A2CONVEN;
   label values A2EQTN A2CONVEN;
   label values A2ESTQNT A2CONVEN;
   label values A2FRCTNS A2CONVEN;
   label values A2GEORPH A2CONVEN;
   label values A2GRAPHS A2CONVEN;
   label values A2HISTOR A2CONVEN;
   label values A2HYGIEN A2CONVEN;
   label values A2IDQNTY A2CONVEN;
   label values A2LAWS A2CONVEN;
   label values A2LIGHT A2CONVEN;
   label values A2MAGNET A2CONVEN;
   label values A2MAINID A2CONVEN;
   label values A2MAPRD A2CONVEN;
   label values A2MATCH A2CONVEN;
   label values A2MIXOP A2CONVEN;
   label values A2MOTORS A2CONVEN;
   label values A2ORALID A2CONVEN;
   label values A2ORDINL A2CONVEN;
   label values A2PLACE A2CONVEN;
   label values A2PLANT A2CONVEN;
   label values A2PNCTUA A2CONVEN;
   label values A2PRBBTY A2CONVEN;
   label values A2PREDIC A2CONVEN;
   label values A2PREPOS A2CONVEN;
   label values A2PTTRNS A2CONVEN;
   label values A2QUANTI A2CONVEN;
   label values A2RCGNZE A2CONVEN;
   label values A2RDFLNT A2CONVEN;
   label values A2REGZCN A2CONVEN;
   label values A2RHYMNG A2CONVEN;
   label values A2SCMTHD A2CONVEN;
   label values A2SHAPES A2CONVEN;
   label values A2SNGDGT A2CONVEN;
   label values A2SOCPRO A2CONVEN;
   label values A2SOLAR A2CONVEN;
   label values A2SOUND A2CONVEN;
   label values A2SPELL A2CONVEN;
   label values A2SUB2DG A2CONVEN;
   label values A2SUBGRP A2CONVEN;
   label values A2SUBSDG A2CONVEN;
   label values A2SYLLAB A2CONVEN;
   label values A2SZORDR A2CONVEN;
   label values A2TELLTI A2CONVEN;
   label values A2TEMP A2CONVEN;
   label values A2TEXTCU A2CONVEN;
   label values A2TOOLS A2CONVEN;
   label values A2TWODGT A2CONVEN;
   label values A2VOCAB A2CONVEN;
   label values A2W12100 A2CONVEN;
   label values A2WATER A2CONVEN;
   label values A2WRTNME A2CONVEN;
   label values A2WRTSTO A2CONVEN;
   label values A2WTHER A2CONVEN;
   label values A2DABSEN A2DABSEN;
   label values A2DDCOMP A2DDCOMP;
   label values A2DDELAY A2DDELAY;
   label values A2DDISAB A2DDISAB;
   label values A2DEMPRB A2DDSTRU;
   label values A2DGIFT A2DGIFT;
   label values A2DHEAR A2DHEAR;
   label values A2DIEP A2DIEP;
   label values A2DIMPAI A2DIMPAI;
   label values A2DIVMTH A2DIV;
   label values A2DIVRD A2DIV;
   label values A2OTASSI A2DIVREA;
   label values A2DLEFT A2DLEFT;
   label values A2DLRNDI A2DLRNDI;
   label values A2DMORE A2DMORE;
   label values A2DMTHBL A2DMTHBL;
   label values A2DNEW A2DNEW;
   label values A2DORTHO A2DORTHO;
   label values A2DOTDIS A2DOTDIS;
   label values A2DOTHER A2DOTHER;
   label values A2DPRTGF A2DPRTGF;
   label values A2DRDBLO A2DRDBLO;
   label values A2ARETAR A2DRETAR;
   label values A2DRETAR A2DRETAR;
   label values A2PRETAR A2DRETAR;
   label values A2DSC504 A2DS504F;
   label values A2DSPCIA A2DSPCIA;
   label values A2DTARDY A2DTARDY;
   label values A2DTRAUM A2DTRAUM;
   label values A2DVIS A2DVIS;
   label values A2DYRECS A2DYREC;
   label values A2AIDTUT A2EXASIS;
   label values A2EXASIS A2EXASIS;
   label values A2PULLOU A2EXASIS;
   label values A2SPECTU A2EXASIS;
   label values A2DVHRS A2FDHRS;
   label values A2BORROW A2GOTO;
   label values A2GOTOLI A2GOTO;
   label values A2ADTRND A2INVSP;
   label values A2INCLUS A2INVSP;
   label values A2INVSPE A2INVSP;
   label values A2BASAL A2LERN;
   label values A2CALCUL A2LERN;
   label values A2CALEND A2LERN;
   label values A2CHLKBD A2LERN;
   label values A2CHSBK A2LERN;
   label values A2COMPOS A2LERN;
   label values A2CRTIVE A2LERN;
   label values A2CURRDV A2LERN;
   label values A2DICTAT A2LERN;
   label values A2DISCHD A2LERN;
   label values A2DOPROJ A2LERN;
   label values A2EXPMTH A2LERN;
   label values A2GEOMET A2LERN;
   label values A2INDCHD A2LERN;
   label values A2INVENT A2LERN;
   label values A2JRNL A2LERN;
   label values A2LERNLT A2LERN;
   label values A2LESPLN A2LERN;
   label values A2MANIPS A2LERN;
   label values A2MTHGME A2LERN;
   label values A2MTHSHT A2LERN;
   label values A2MTHTXT A2LERN;
   label values A2MUSMTH A2LERN;
   label values A2MXDGRP A2LERN;
   label values A2MXMATH A2LERN;
   label values A2NEWVOC A2LERN;
   label values A2NOPRNT A2LERN;
   label values A2OUTLOU A2LERN;
   label values A2PEER A2LERN;
   label values A2PHONIC A2LERN;
   label values A2PRACLT A2LERN;
   label values A2PRTNRS A2LERN;
   label values A2PRTUTR A2LERN;
   label values A2PUBLSH A2LERN;
   label values A2READLD A2LERN;
   label values A2REALLI A2LERN;
   label values A2RETELL A2LERN;
   label values A2RULERS A2LERN;
   label values A2SEEPRI A2LERN;
   label values A2SILENT A2LERN;
   label values A2SKITS A2LERN;
   label values A2TELLRS A2LERN;
   label values A2WRKBK A2LERN;
   label values A2WRTWRD A2LERN;
   label values A2LRNART A2LRNREA;
   label values A2LRNGMS A2LRNREA;
   label values A2LRNKEY A2LRNREA;
   label values A2LRNLAN A2LRNREA;
   label values A2LRNMSC A2LRNREA;
   label values A2LRNMTH A2LRNREA;
   label values A2LRNRD A2LRNREA;
   label values A2LRNSCN A2LRNREA;
   label values A2LRNSS A2LRNREA;
   label values A2LUNCH A2LUNCH;
   label values A2ALVLED A2LVLEF;
   label values A2DLVLED A2LVLEF;
   label values A2PLVLED A2LVLEF;
   label values A2MINMTH A2MINREA;
   label values A2MINRD A2MINREA;
   label values A2MMCOMP A2MMCOMP;
   label values A2MNEXTR A2MN18A;
   label values A2MNAIDE A2MN18B;
   label values A2MNSPEC A2MN18C;
   label values A2MNPOIN A2MN18D;
   label values A2MNOSHP A2MN18E;
   label values A2PDAIDE A2NEW;
   label values A2NUMTH A2NOMATH;
   label values A2NUMCNF A2NUMCON;
   label values A2NUMRD A2NUMRD;
   label values A2OFTART A2OFTRD;
   label values A2OFTDAN A2OFTRD;
   label values A2OFTESL A2OFTRD;
   label values A2OFTFOR A2OFTRD;
   label values A2OFTHTR A2OFTRD;
   label values A2OFTMTH A2OFTRD;
   label values A2OFTMUS A2OFTRD;
   label values A2OFTRDL A2OFTRD;
   label values A2OFTSCI A2OFTRD;
   label values A2OFTSOC A2OFTRD;
   label values A2TXPE A2OFTRD;
   label values A2PABSEN A2PABSEN;
   label values A2PDELAY A2PDELAY;
   label values A2PDISAB A2PDISAB;
   label values A2PEMPRB A2PDSTRU;
   label values A2PGIFT A2PGIFT;
   label values A2PHEAR A2PHEAR;
   label values A2PIEP A2PIEP;
   label values A2PIMPAI A2PIMPAI;
   label values A2PLEFT A2PLEFT;
   label values A2PLRNDI A2PLRNDI;
   label values A2PVHRS A2PMHRS;
   label values A2PMORE A2PMORE;
   label values A2PMTHBL A2PMTHBL;
   label values A2PNEW A2PNEW;
   label values A2PORTHO A2PORTHO;
   label values A2POTDIS A2POTDIS;
   label values A2POTHER A2POTHER;
   label values A2PPRTGF A2PPRTGF;
   label values A2PRDBLO A2PRDBLO;
   label values A2PSC504 A2PS504F;
   label values A2PSPCIA A2PSPCIA;
   label values A2PTARDY A2PTARDY;
   label values A2PTRAUM A2PTRAUM;
   label values A2PVIS A2PVIS;
   label values A2RECESS A2RECESS;
   label values A2REGNON A2REGWRA;
   label values A2REGWRK A2REGWRB;
   label values A2SPEDNO A2REGWRC;
   label values A2ESLWRK A2REGWRD;
   label values A2SPEDWK A2REGWRE;
   label values A2ESLNON A2REGWRK;
   label values A2SHARED A2SENTHO;
   label values A2SNTHME A2SENTHO;
   label values A2ASPK A2SPEA;
   label values A2DSPK A2SPEA;
   label values A2PSPK A2SPEA;
   label values A2ATTART A2TPCONF;
   label values A2ATTOPN A2TPCONF;
   label values A2REGHLP A2TPCONF;
   label values A2TPCONF A2TPCONF;
   label values A2TXART A2TXRD;
   label values A2TXDAN A2TXRD;
   label values A2TXESL A2TXRD;
   label values A2TXFOR A2TXRD;
   label values A2TXMTH A2TXRD;
   label values A2TXMUS A2TXRD;
   label values A2TXRDLA A2TXRD;
   label values A2TXSCI A2TXRD;
   label values A2TXSOC A2TXRD;
   label values A2TXTHTR A2TXRD;
   label values A2TXRCE A2TXREC;
   label values A2TXSPEN A2TXSPEN;
   label values A2ART A2TXTBK;
   label values A2AUDIOV A2TXTBK;
   label values A2CLSSPC A2TXTBK;
   label values A2COMPEQ A2TXTBK;
   label values A2DISMAT A2TXTBK;
   label values A2DITTO A2TXTBK;
   label values A2FURNIT A2TXTBK;
   label values A2HEATAC A2TXTBK;
   label values A2INSTRM A2TXTBK;
   label values A2LEPMAT A2TXTBK;
   label values A2MANIPU A2TXTBK;
   label values A2PAPER A2TXTBK;
   label values A2RECRDS A2TXTBK;
   label values A2SOFTWA A2TXTBK;
   label values A2TRADBK A2TXTBK;
   label values A2TXTBK A2TXTBK;
   label values A2VIDEO A2TXTBK;
   label values A2WORKBK A2TXTBK;
   label values A2CHCLDS A2WHOLE;
   label values A2INDVDL A2WHOLE;
   label values A2SMLGRP A2WHOLE;
   label values A2WHLCLS A2WHOLE;
   label values A2ACSPNH A2YN;
   label values A2AENGLS A2YN;
   label values A2ALANG A2YN;
   label values A2DCSPNH A2YN;
   label values A2DENGLS A2YN;
   label values A2DLANG A2YN;
   label values A2PCSPNH A2YN;
   label values A2PENGLS A2YN;
   label values A2PLANG A2YN;
   label values A1ACLASS A2YNCOMP;
   label values A1DCLASS A2YNCOMP;
   label values A1PCLASS A2YNCOMP;
   label values A1TQUEX A2YNCOMP;
   label values A2ACLASS A2YNCOMP;
   label values A2DCLASS A2YNCOMP;
   label values A2PCLASS A2YNCOMP;
   label values A2TQUEX A2YNCOMP;
   label values B1TQUEX A2YNCOMP;
   label values B2TQUEX A2YNCOMP;
   label values A2CNSLT A2YNN;
   label values A2COLLEG A2YNN;
   label values A2COMMTE A2YNN;
   label values A2FDBACK A2YNN;
   label values A2INSRVC A2YNN;
   label values A2OBSERV A2YNN;
   label values A2RELTIM A2YNN;
   label values A2STFFTR A2YNN;
   label values A2SUPPOR A2YNN;
   label values A2TECH A2YNN;
   label values A2WRKSHP A2YNN;
   label values A2YYCOMP A2YYCOMP;
   label values B1YRSPRE B1001F;
   label values B1YRSKIN B1002F;
   label values B1YRSFST B1003F;
   label values B1YRS2T5 B1004F;
   label values B1YRS6PL B1005F;
   label values B1YRSESL B1006F;
   label values B1YRSBIL B1007F;
   label values B1YRSSPE B1008F;
   label values B1YRSPE B1009F;
   label values B1YRSART B1010F;
   label values B1YRSCH B1011F;
   label values B1AGE B1012F;
   label values B1CHCLDS B1013F;
   label values B1INDVDL B1013F;
   label values B1SMLGRP B1013F;
   label values B1WHLCLS B1013F;
   label values B1ARTARE B1014F;
   label values B1COMPAR B1014F;
   label values B1DRAMAR B1014F;
   label values B1HISP B1014F;
   label values B1HMEVST B1014F;
   label values B1INFOHO B1014F;
   label values B1INKNDR B1014F;
   label values B1LISTNC B1014F;
   label values B1MATHAR B1014F;
   label values B1OTTRAN B1014F;
   label values B1PCKTCH B1014F;
   label values B1PLAYAR B1014F;
   label values B1PRNTOR B1014F;
   label values B1READAR B1014F;
   label values B1SCIAR B1014F;
   label values B1SHRTN B1014F;
   label values B1VSTK B1014F;
   label values B1WATRSA B1014F;
   label values B1WRTCNT B1014F;
   label values B1ATTND B1015F;
   label values B1BEHVR B1015F;
   label values B1CLASPA B1015F;
   label values B1COPRTV B1015F;
   label values B1EFFO B1015F;
   label values B1FLLWDR B1015F;
   label values B1IMPRVM B1015F;
   label values B1OTMT B1015F;
   label values B1TOCLAS B1015F;
   label values B1TOSTND B1015F;
   label values B1EVAL B1016F;
   label values B1NOPAYP B1017F;
   label values B1PAIDPR B1017F;
   label values B1ALPHBT B1018F;
   label values B1CNT20 B1018F;
   label values B1COMM B1018F;
   label values B1ENGLAN B1018F;
   label values B1FNSHT B1018F;
   label values B1FOLWDR B1018F;
   label values B1IDCOLO B1018F;
   label values B1NOTDSR B1018F;
   label values B1PENCIL B1018F;
   label values B1PRBLMS B1018F;
   label values B1SENSTI B1018F;
   label values B1SHARE B1018F;
   label values B1SITSTI B1018F;
   label values B1ACCPTD B1019F;
   label values B1ALLKNO B1019F;
   label values B1ALPHBF B1019F;
   label values B1ATNDPR B1019F;
   label values B1CNTNLR B1019F;
   label values B1ENCOUR B1019F;
   label values B1ENJOY B1019F;
   label values B1FRMLIN B1019F;
   label values B1HMWRK B1019F;
   label values B1LRNREA B1019F;
   label values B1MISBHV B1019F;
   label values B1MISSIO B1019F;
   label values B1MKDIFF B1019F;
   label values B1NOTCAP B1019F;
   label values B1PAPRWR B1019F;
   label values B1PRCTWR B1019F;
   label values B1PRESSU B1019F;
   label values B1PRIORI B1019F;
   label values B1PSUPP B1019F;
   label values B1READAT B1019F;
   label values B1SCHSPR B1019F;
   label values B1STNDLO B1019F;
   label values B1TCHPRN B1019F;
   label values B1TEACH B1019F;
   label values B1SCHPLC B1020F;
   label values B1CNTRLC B1021F;
   label values B1TGEND B1022F;
   label values B1YRBORN B1023F;
   label values B1RACE1 B1024F;
   label values B1RACE2 B1024F;
   label values B1RACE3 B1024F;
   label values B1RACE5 B1024F;
   label values B1HGHSTD B1025F;
   label values B1DEVLP B1026F;
   label values B1EARLY B1026F;
   label values B1ELEM B1026F;
   label values B1ESL B1026F;
   label values B1MTHDMA B1026F;
   label values B1MTHDRD B1026F;
   label values B1MTHDSC B1026F;
   label values B1SPECED B1026F;
   label values B1TYPCER B1027F;
   label values B1ELEMCT B1028F;
   label values B1ERLYCT B1028F;
   label values B1OTHCRT B1028F;
   label values B1YYCOMP B1029F;
   label values B1MMCOMP B1030F;
   label values B1DDCOMP B1031F;
   label values B1TTWPSU B1TTWPSU;
   label values B1TTWSTR B1TTWSTR;
   label values B1TW0 B1TW0F;
   label values B1TW10 B1TW10F;
   label values B1TW11 B1TW11F;
   label values B1TW12 B1TW12F;
   label values B1TW13 B1TW13F;
   label values B1TW14 B1TW14F;
   label values B1TW15 B1TW15F;
   label values B1TW16 B1TW16F;
   label values B1TW17 B1TW17F;
   label values B1TW18 B1TW18F;
   label values B1TW19 B1TW19F;
   label values B1TW1 B1TW1F;
   label values B1TW20 B1TW20F;
   label values B1TW21 B1TW21F;
   label values B1TW22 B1TW22F;
   label values B1TW23 B1TW23F;
   label values B1TW24 B1TW24F;
   label values B1TW25 B1TW25F;
   label values B1TW26 B1TW26F;
   label values B1TW27 B1TW27F;
   label values B1TW28 B1TW28F;
   label values B1TW29 B1TW29F;
   label values B1TW2 B1TW2F;
   label values B1TW30 B1TW30F;
   label values B1TW31 B1TW31F;
   label values B1TW32 B1TW32F;
   label values B1TW33 B1TW33F;
   label values B1TW34 B1TW34F;
   label values B1TW35 B1TW35F;
   label values B1TW36 B1TW36F;
   label values B1TW37 B1TW37F;
   label values B1TW38 B1TW38F;
   label values B1TW39 B1TW39F;
   label values B1TW3 B1TW3F;
   label values B1TW40 B1TW40F;
   label values B1TW41 B1TW41F;
   label values B1TW42 B1TW42F;
   label values B1TW43 B1TW43F;
   label values B1TW44 B1TW44F;
   label values B1TW45 B1TW45F;
   label values B1TW46 B1TW46F;
   label values B1TW47 B1TW47F;
   label values B1TW48 B1TW48F;
   label values B1TW49 B1TW49F;
   label values B1TW4 B1TW4F;
   label values B1TW50 B1TW50F;
   label values B1TW51 B1TW51F;
   label values B1TW52 B1TW52F;
   label values B1TW53 B1TW53F;
   label values B1TW54 B1TW54F;
   label values B1TW55 B1TW55F;
   label values B1TW56 B1TW56F;
   label values B1TW57 B1TW57F;
   label values B1TW58 B1TW58F;
   label values B1TW59 B1TW59F;
   label values B1TW5 B1TW5F;
   label values B1TW60 B1TW60F;
   label values B1TW61 B1TW61F;
   label values B1TW62 B1TW62F;
   label values B1TW63 B1TW63F;
   label values B1TW64 B1TW64F;
   label values B1TW65 B1TW65F;
   label values B1TW66 B1TW66F;
   label values B1TW67 B1TW67F;
   label values B1TW68 B1TW68F;
   label values B1TW69 B1TW69F;
   label values B1TW6 B1TW6F;
   label values B1TW70 B1TW70F;
   label values B1TW71 B1TW71F;
   label values B1TW72 B1TW72F;
   label values B1TW73 B1TW73F;
   label values B1TW74 B1TW74F;
   label values B1TW75 B1TW75F;
   label values B1TW76 B1TW76F;
   label values B1TW77 B1TW77F;
   label values B1TW78 B1TW78F;
   label values B1TW79 B1TW79F;
   label values B1TW7 B1TW7F;
   label values B1TW80 B1TW80F;
   label values B1TW81 B1TW81F;
   label values B1TW82 B1TW82F;
   label values B1TW83 B1TW83F;
   label values B1TW84 B1TW84F;
   label values B1TW85 B1TW85F;
   label values B1TW86 B1TW86F;
   label values B1TW87 B1TW87F;
   label values B1TW88 B1TW88F;
   label values B1TW89 B1TW89F;
   label values B1TW8 B1TW8F;
   label values B1TW90 B1TW90F;
   label values B1TW9 B1TW9F;
   label values B2TTWPSU B2TTWPSU;
   label values B2TTWSTR B2TTWSTR;
   label values B2TW0 B2TW0F;
   label values B2TW10 B2TW10F;
   label values B2TW11 B2TW11F;
   label values B2TW12 B2TW12F;
   label values B2TW13 B2TW13F;
   label values B2TW14 B2TW14F;
   label values B2TW15 B2TW15F;
   label values B2TW16 B2TW16F;
   label values B2TW17 B2TW17F;
   label values B2TW18 B2TW18F;
   label values B2TW19 B2TW19F;
   label values B2TW1 B2TW1F;
   label values B2TW20 B2TW20F;
   label values B2TW21 B2TW21F;
   label values B2TW22 B2TW22F;
   label values B2TW23 B2TW23F;
   label values B2TW24 B2TW24F;
   label values B2TW25 B2TW25F;
   label values B2TW26 B2TW26F;
   label values B2TW27 B2TW27F;
   label values B2TW28 B2TW28F;
   label values B2TW29 B2TW29F;
   label values B2TW2 B2TW2F;
   label values B2TW30 B2TW30F;
   label values B2TW31 B2TW31F;
   label values B2TW32 B2TW32F;
   label values B2TW33 B2TW33F;
   label values B2TW34 B2TW34F;
   label values B2TW35 B2TW35F;
   label values B2TW36 B2TW36F;
   label values B2TW37 B2TW37F;
   label values B2TW38 B2TW38F;
   label values B2TW39 B2TW39F;
   label values B2TW3 B2TW3F;
   label values B2TW40 B2TW40F;
   label values B2TW41 B2TW41F;
   label values B2TW42 B2TW42F;
   label values B2TW43 B2TW43F;
   label values B2TW44 B2TW44F;
   label values B2TW45 B2TW45F;
   label values B2TW46 B2TW46F;
   label values B2TW47 B2TW47F;
   label values B2TW48 B2TW48F;
   label values B2TW49 B2TW49F;
   label values B2TW4 B2TW4F;
   label values B2TW50 B2TW50F;
   label values B2TW51 B2TW51F;
   label values B2TW52 B2TW52F;
   label values B2TW53 B2TW53F;
   label values B2TW54 B2TW54F;
   label values B2TW55 B2TW55F;
   label values B2TW56 B2TW56F;
   label values B2TW57 B2TW57F;
   label values B2TW58 B2TW58F;
   label values B2TW59 B2TW59F;
   label values B2TW5 B2TW5F;
   label values B2TW60 B2TW60F;
   label values B2TW61 B2TW61F;
   label values B2TW62 B2TW62F;
   label values B2TW63 B2TW63F;
   label values B2TW64 B2TW64F;
   label values B2TW65 B2TW65F;
   label values B2TW66 B2TW66F;
   label values B2TW67 B2TW67F;
   label values B2TW68 B2TW68F;
   label values B2TW69 B2TW69F;
   label values B2TW6 B2TW6F;
   label values B2TW70 B2TW70F;
   label values B2TW71 B2TW71F;
   label values B2TW72 B2TW72F;
   label values B2TW73 B2TW73F;
   label values B2TW74 B2TW74F;
   label values B2TW75 B2TW75F;
   label values B2TW76 B2TW76F;
   label values B2TW77 B2TW77F;
   label values B2TW78 B2TW78F;
   label values B2TW79 B2TW79F;
   label values B2TW7 B2TW7F;
   label values B2TW80 B2TW80F;
   label values B2TW81 B2TW81F;
   label values B2TW82 B2TW82F;
   label values B2TW83 B2TW83F;
   label values B2TW84 B2TW84F;
   label values B2TW85 B2TW85F;
   label values B2TW86 B2TW86F;
   label values B2TW87 B2TW87F;
   label values B2TW88 B2TW88F;
   label values B2TW89 B2TW89F;
   label values B2TW8 B2TW8F;
   label values B2TW90 B2TW90F;
   label values B2TW9 B2TW9F;
   label values KURBAN LOCALE;
   label values CREGION REGIONS;
   label values S2KMINOR S2COMP;
   label values S2KENRLS S2ENRLS;
   label values S2KPUPRI S2PUBPRI;
   label values S2KSCLVL S2SCLVL;
   label values S2KSCTYP S2SCTYPE;
   label values CS_TYPE2 SCTYPES;
   label values A1A2YRK1 SUPPRESS;
   label values A1A2YRK2 SUPPRESS;
   label values A1AMULGR SUPPRESS;
   label values A1APR1ST SUPPRESS;
   label values A1AREGK SUPPRESS;
   label values A1AT1ST SUPPRESS;
   label values A1AT2ND SUPPRESS;
   label values A1AT3RD SUPPRESS;
   label values A1ATCHNS SUPPRESS;
   label values A1ATFLPN SUPPRESS;
   label values A1ATJPNS SUPPRESS;
   label values A1ATKRN SUPPRESS;
   label values A1ATOTAS SUPPRESS;
   label values A1ATOTLG SUPPRESS;
   label values A1ATPRE1 SUPPRESS;
   label values A1ATPREK SUPPRESS;
   label values A1ATREGK SUPPRESS;
   label values A1ATRNK SUPPRESS;
   label values A1ATTRNK SUPPRESS;
   label values A1ATVTNM SUPPRESS;
   label values A1AUNGR SUPPRESS;
   label values A1D2YRK1 SUPPRESS;
   label values A1D2YRK2 SUPPRESS;
   label values A1DMULGR SUPPRESS;
   label values A1DPR1ST SUPPRESS;
   label values A1DREGK SUPPRESS;
   label values A1DT1ST SUPPRESS;
   label values A1DT2ND SUPPRESS;
   label values A1DT3RD SUPPRESS;
   label values A1DTCHNS SUPPRESS;
   label values A1DTFLPN SUPPRESS;
   label values A1DTJPNS SUPPRESS;
   label values A1DTKRN SUPPRESS;
   label values A1DTOTAS SUPPRESS;
   label values A1DTOTLG SUPPRESS;
   label values A1DTPRE1 SUPPRESS;
   label values A1DTPREK SUPPRESS;
   label values A1DTREGK SUPPRESS;
   label values A1DTRNK SUPPRESS;
   label values A1DTTRNK SUPPRESS;
   label values A1DTVTNM SUPPRESS;
   label values A1DUNGR SUPPRESS;
   label values A1P2YRK1 SUPPRESS;
   label values A1P2YRK2 SUPPRESS;
   label values A1PMULGR SUPPRESS;
   label values A1PPR1ST SUPPRESS;
   label values A1PREGK SUPPRESS;
   label values A1PT1ST SUPPRESS;
   label values A1PT2ND SUPPRESS;
   label values A1PT3RD SUPPRESS;
   label values A1PTCHNS SUPPRESS;
   label values A1PTFLPN SUPPRESS;
   label values A1PTJPNS SUPPRESS;
   label values A1PTKRN SUPPRESS;
   label values A1PTOTAS SUPPRESS;
   label values A1PTOTLG SUPPRESS;
   label values A1PTPRE1 SUPPRESS;
   label values A1PTPREK SUPPRESS;
   label values A1PTREGK SUPPRESS;
   label values A1PTRNK SUPPRESS;
   label values A1PTTRNK SUPPRESS;
   label values A1PTVTNM SUPPRESS;
   label values A1PUNGR SUPPRESS;
   label values A2AAUTSM SUPPRESS;
   label values A2ACCHNS SUPPRESS;
   label values A2ACFLPN SUPPRESS;
   label values A2ACJPNS SUPPRESS;
   label values A2ACKRN SUPPRESS;
   label values A2ACVTNM SUPPRESS;
   label values A2ADEAF SUPPRESS;
   label values A2ALNGOS SUPPRESS;
   label values A2AMULTI SUPPRESS;
   label values A2AOTASN SUPPRESS;
   label values A2AOTLNG SUPPRESS;
   label values A2DAUTSM SUPPRESS;
   label values A2DCCHNS SUPPRESS;
   label values A2DCFLPN SUPPRESS;
   label values A2DCJPNS SUPPRESS;
   label values A2DCKRN SUPPRESS;
   label values A2DCVTNM SUPPRESS;
   label values A2DDEAF SUPPRESS;
   label values A2DLNGOS SUPPRESS;
   label values A2DMULTI SUPPRESS;
   label values A2DOTASN SUPPRESS;
   label values A2DOTLNG SUPPRESS;
   label values A2PAUTSM SUPPRESS;
   label values A2PCCHNS SUPPRESS;
   label values A2PCFLPN SUPPRESS;
   label values A2PCJPNS SUPPRESS;
   label values A2PCKRN SUPPRESS;
   label values A2PCVTNM SUPPRESS;
   label values A2PDEAF SUPPRESS;
   label values A2PLNGOS SUPPRESS;
   label values A2PMULTI SUPPRESS;
   label values A2POTASN SUPPRESS;
   label values A2POTLNG SUPPRESS;
   label values B1RACE4 SUPPRESS;
save "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\dta\ECLSK_BaseYear_Teacher_STATA.dta", replace;
use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Public\ECLS-K\ECLS-K\dta\ECLSK_BaseYear_Teacher_STATA.dta";
tabulate KURBAN;
tabulate CREGION;
tabulate CS_TYPE2;
tabulate A1TQUEX;
tabulate A1ACLASS;
tabulate A1PCLASS;
tabulate A1DCLASS;
tabulate B1TQUEX;
tabulate A2TQUEX;
tabulate A2ACLASS;
tabulate A2PCLASS;
tabulate A2DCLASS;
tabulate B2TQUEX;
tabulate S2KSCTYP;
tabulate S2KPUPRI;
tabulate S2KENRLS;
tabulate S2KSCLVL;
tabulate S2KMINOR;
tabulate KGCLASS;
tabulate A1AREGK;
tabulate A1A2YRK1;
tabulate A1A2YRK2;
tabulate A1ATRNK;
tabulate A1APR1ST;
tabulate A1AUNGR;
tabulate A1AMULGR;
tabulate A1ATPREK;
tabulate A1ATTRNK;
tabulate A1ATREGK;
tabulate A1ATPRE1;
tabulate A1AT1ST;
tabulate A1AT2ND;
tabulate A1AT3RD;
tabulate A1APRESC;
tabulate A1APCPRE;
tabulate A1ABEHVR;
tabulate A1AOTLAN;
tabulate A1ACSPNH;
tabulate A1ACVTNM;
tabulate A1ACCHNS;
tabulate A1ACJPNS;
tabulate A1ACKRN;
tabulate A1ACFLPN;
tabulate A1AOTASN;
tabulate A1AOTLNG;
tabulate A1ALANOS;
tabulate A1ALEP;
tabulate A1ATNOOT;
tabulate A1ATSPNH;
tabulate A1ATVTNM;
tabulate A1ATCHNS;
tabulate A1ATJPNS;
tabulate A1ATKRN;
tabulate A1ATFLPN;
tabulate A1ATOTAS;
tabulate A1ATOTLG;
tabulate A1ALEPOS;
tabulate A1ANONEN;
tabulate A1PREGK;
tabulate A1P2YRK1;
tabulate A1P2YRK2;
tabulate A1PTRNK;
tabulate A1PPR1ST;
tabulate A1PUNGR;
tabulate A1PMULGR;
tabulate A1PTPREK;
tabulate A1PTTRNK;
tabulate A1PTREGK;
tabulate A1PTPRE1;
tabulate A1PT1ST;
tabulate A1PT2ND;
tabulate A1PT3RD;
tabulate A1PPRESC;
tabulate A1PPCPRE;
tabulate A1PBEHVR;
tabulate A1POTLAN;
tabulate A1PCSPNH;
tabulate A1PCVTNM;
tabulate A1PCCHNS;
tabulate A1PCJPNS;
tabulate A1PCKRN;
tabulate A1PCFLPN;
tabulate A1POTASN;
tabulate A1POTLNG;
tabulate A1PLANOS;
tabulate A1PLEP;
tabulate A1PTNOOT;
tabulate A1PTSPNH;
tabulate A1PTVTNM;
tabulate A1PTCHNS;
tabulate A1PTJPNS;
tabulate A1PTKRN;
tabulate A1PTFLPN;
tabulate A1PTOTAS;
tabulate A1PTOTLG;
tabulate A1PLEPOS;
tabulate A1PNONEN;
tabulate A1DREGK;
tabulate A1D2YRK1;
tabulate A1D2YRK2;
tabulate A1DTRNK;
tabulate A1DPR1ST;
tabulate A1DUNGR;
tabulate A1DMULGR;
tabulate A1DTPREK;
tabulate A1DTTRNK;
tabulate A1DTREGK;
tabulate A1DTPRE1;
tabulate A1DT1ST;
tabulate A1DT2ND;
tabulate A1DT3RD;
tabulate A1DPRESC;
tabulate A1DPCPRE;
tabulate A1DBEHVR;
tabulate A1DOTLAN;
tabulate A1DCSPNH;
tabulate A1DCVTNM;
tabulate A1DCCHNS;
tabulate A1DCJPNS;
tabulate A1DCKRN;
tabulate A1DCFLPN;
tabulate A1DOTASN;
tabulate A1DOTLNG;
tabulate A1DLANOS;
tabulate A1DLEP;
tabulate A1DTNOOT;
tabulate A1DTSPNH;
tabulate A1DTVTNM;
tabulate A1DTCHNS;
tabulate A1DTJPNS;
tabulate A1DTKRN;
tabulate A1DTFLPN;
tabulate A1DTOTAS;
tabulate A1DTOTLG;
tabulate A1DLEPOS;
tabulate A1DNONEN;
tabulate A1COMPMM;
tabulate A1COMPYY;
tabulate B1WHLCLS;
tabulate B1SMLGRP;
tabulate B1INDVDL;
tabulate B1CHCLDS;
tabulate B1READAR;
tabulate B1LISTNC;
tabulate B1WRTCNT;
tabulate B1PCKTCH;
tabulate B1MATHAR;
tabulate B1PLAYAR;
tabulate B1WATRSA;
tabulate B1COMPAR;
tabulate B1SCIAR;
tabulate B1DRAMAR;
tabulate B1ARTARE;
tabulate B1TOCLAS;
tabulate B1TOSTND;
tabulate B1IMPRVM;
tabulate B1EFFO;
tabulate B1CLASPA;
tabulate B1ATTND;
tabulate B1BEHVR;
tabulate B1COPRTV;
tabulate B1FLLWDR;
tabulate B1OTMT;
tabulate B1EVAL;
tabulate B1PAIDPR;
tabulate B1NOPAYP;
tabulate B1FNSHT;
tabulate B1CNT20;
tabulate B1SHARE;
tabulate B1PRBLMS;
tabulate B1PENCIL;
tabulate B1NOTDSR;
tabulate B1ENGLAN;
tabulate B1SENSTI;
tabulate B1SITSTI;
tabulate B1ALPHBT;
tabulate B1FOLWDR;
tabulate B1IDCOLO;
tabulate B1COMM;
tabulate B1INFOHO;
tabulate B1INKNDR;
tabulate B1SHRTN;
tabulate B1VSTK;
tabulate B1HMEVST;
tabulate B1PRNTOR;
tabulate B1OTTRAN;
tabulate B1ATNDPR;
tabulate B1FRMLIN;
tabulate B1ALPHBF;
tabulate B1LRNREA;
tabulate B1TCHPRN;
tabulate B1PRCTWR;
tabulate B1HMWRK;
tabulate B1READAT;
tabulate B1SCHSPR;
tabulate B1MISBHV;
tabulate B1NOTCAP;
tabulate B1ACCPTD;
tabulate B1CNTNLR;
tabulate B1PAPRWR;
tabulate B1PSUPP;
tabulate B1SCHPLC;
tabulate B1CNTRLC;
tabulate B1STNDLO;
tabulate B1MISSIO;
tabulate B1ALLKNO;
tabulate B1PRESSU;
tabulate B1PRIORI;
tabulate B1ENCOUR;
tabulate B1ENJOY;
tabulate B1MKDIFF;
tabulate B1TEACH;
tabulate B1TGEND;
tabulate B1HISP;
tabulate B1RACE1;
tabulate B1RACE2;
tabulate B1RACE3;
tabulate B1RACE4;
tabulate B1RACE5;
tabulate B1HGHSTD;
tabulate B1EARLY;
tabulate B1ELEM;
tabulate B1SPECED;
tabulate B1ESL;
tabulate B1DEVLP;
tabulate B1MTHDRD;
tabulate B1MTHDMA;
tabulate B1MTHDSC;
tabulate B1TYPCER;
tabulate B1ELEMCT;
tabulate B1ERLYCT;
tabulate B1OTHCRT;
tabulate B1MMCOMP;
tabulate B1YYCOMP;
tabulate A2ARETAR;
tabulate A2AMULTI;
tabulate A2AAUTSM;
tabulate A2ADEAF;
tabulate A2ABEHVR;
tabulate A2AENGLS;
tabulate A2ACSPNH;
tabulate A2ACVTNM;
tabulate A2ACCHNS;
tabulate A2ACJPNS;
tabulate A2ACKRN;
tabulate A2ACFLPN;
tabulate A2AOTASN;
tabulate A2AOTLNG;
tabulate A2ALNGOS;
tabulate A2PRETAR;
tabulate A2PMULTI;
tabulate A2PAUTSM;
tabulate A2PDEAF;
tabulate A2PBEHVR;
tabulate A2PENGLS;
tabulate A2PCSPNH;
tabulate A2PCVTNM;
tabulate A2PCCHNS;
tabulate A2PCJPNS;
tabulate A2PCKRN;
tabulate A2PCFLPN;
tabulate A2POTASN;
tabulate A2POTLNG;
tabulate A2PLNGOS;
tabulate A2DMULTI;
tabulate A2DAUTSM;
tabulate A2DDEAF;
tabulate A2DBEHVR;
tabulate A2DENGLS;
tabulate A2DCSPNH;
tabulate A2DCVTNM;
tabulate A2DCCHNS;
tabulate A2DCJPNS;
tabulate A2DCKRN;
tabulate A2DCFLPN;
tabulate A2DOTASN;
tabulate A2DOTLNG;
tabulate A2DLNGOS;
tabulate A2WHLCLS;
tabulate A2SMLGRP;
tabulate A2INDVDL;
tabulate A2CHCLDS;
tabulate A2COMMTE;
tabulate A2OFTRDL;
tabulate A2TXRDLA;
tabulate A2OFTMTH;
tabulate A2TXMTH;
tabulate A2OFTSOC;
tabulate A2TXSOC;
tabulate A2OFTSCI;
tabulate A2TXSCI;
tabulate A2OFTMUS;
tabulate A2TXMUS;
tabulate A2OFTART;
tabulate A2TXART;
tabulate A2OFTDAN;
tabulate A2TXDAN;
tabulate A2OFTHTR;
tabulate A2TXTHTR;
tabulate A2OFTFOR;
tabulate A2TXFOR;
tabulate A2OFTESL;
tabulate A2TXESL;
tabulate A2TXPE;
tabulate A2TXSPEN;
tabulate A2TXRCE;
tabulate A2LUNCH;
tabulate A2RECESS;
tabulate A2DIVRD;
tabulate A2DIVMTH;
tabulate A2MINRD;
tabulate A2MINMTH;
tabulate A2EXASIS;
tabulate A2AIDTUT;
tabulate A2SPECTU;
tabulate A2PULLOU;
tabulate A2OTASSI;
tabulate A2GOTOLI;
tabulate A2BORROW;
tabulate A2ALANG;
tabulate A2ASPK;
tabulate A2ALVLED;
tabulate A2ACERTF;
tabulate A2PLANG;
tabulate A2PSPK;
tabulate A2PLVLED;
tabulate A2PCERTF;
tabulate A2DLANG;
tabulate A2DSPK;
tabulate A2DLVLED;
tabulate A2DCERTF;
tabulate A2TXTBK;
tabulate A2TRADBK;
tabulate A2WORKBK;
tabulate A2MANIPU;
tabulate A2AUDIOV;
tabulate A2VIDEO;
tabulate A2COMPEQ;
tabulate A2SOFTWA;
tabulate A2PAPER;
tabulate A2DITTO;
tabulate A2ART;
tabulate A2INSTRM;
tabulate A2RECRDS;
tabulate A2LEPMAT;
tabulate A2DISMAT;
tabulate A2HEATAC;
tabulate A2CLSSPC;
tabulate A2FURNIT;
tabulate A2ARTMAT;
tabulate A2MUSIC;
tabulate A2COSTUM;
tabulate A2COOK;
tabulate A2BOOKS;
tabulate A2VCR;
tabulate A2TVWTCH;
tabulate A2PLAYER;
tabulate A2EQUIPM;
tabulate A2LERNLT;
tabulate A2PRACLT;
tabulate A2NEWVOC;
tabulate A2DICTAT;
tabulate A2PHONIC;
tabulate A2SEEPRI;
tabulate A2NOPRNT;
tabulate A2RETELL;
tabulate A2READLD;
tabulate A2BASAL;
tabulate A2SILENT;
tabulate A2WRKBK;
tabulate A2WRTWRD;
tabulate A2INVENT;
tabulate A2CHSBK;
tabulate A2COMPOS;
tabulate A2DOPROJ;
tabulate A2PUBLSH;
tabulate A2SKITS;
tabulate A2JRNL;
tabulate A2TELLRS;
tabulate A2MXDGRP;
tabulate A2PRTUTR;
tabulate A2CONVNT;
tabulate A2RCGNZE;
tabulate A2MATCH;
tabulate A2WRTNME;
tabulate A2RHYMNG;
tabulate A2SYLLAB;
tabulate A2PREPOS;
tabulate A2MAINID;
tabulate A2PREDIC;
tabulate A2TEXTCU;
tabulate A2ORALID;
tabulate A2DRCTNS;
tabulate A2PNCTUA;
tabulate A2COMPSE;
tabulate A2WRTSTO;
tabulate A2SPELL;
tabulate A2VOCAB;
tabulate A2ALPBTZ;
tabulate A2RDFLNT;
tabulate A2INVSPE;
tabulate A2OUTLOU;
tabulate A2GEOMET;
tabulate A2MANIPS;
tabulate A2MTHGME;
tabulate A2CALCUL;
tabulate A2MUSMTH;
tabulate A2CRTIVE;
tabulate A2RULERS;
tabulate A2EXPMTH;
tabulate A2CALEND;
tabulate A2MTHSHT;
tabulate A2MTHTXT;
tabulate A2CHLKBD;
tabulate A2PRTNRS;
tabulate A2REALLI;
tabulate A2MXMATH;
tabulate A2PEER;
tabulate A2QUANTI;
tabulate A21TO10;
tabulate A22S5S10;
tabulate A2BYD100;
tabulate A2W12100;
tabulate A2SHAPES;
tabulate A2IDQNTY;
tabulate A2SUBGRP;
tabulate A2SZORDR;
tabulate A2PTTRNS;
tabulate A2REGZCN;
tabulate A2SNGDGT;
tabulate A2SUBSDG;
tabulate A2PLACE;
tabulate A2TWODGT;
tabulate A23DGT;
tabulate A2MIXOP;
tabulate A2GRAPHS;
tabulate A2DATACO;
tabulate A2FRCTNS;
tabulate A2ORDINL;
tabulate A2ACCURA;
tabulate A2TELLTI;
tabulate A2ESTQNT;
tabulate A2ADD2DG;
tabulate A2CARRY;
tabulate A2SUB2DG;
tabulate A2PRBBTY;
tabulate A2EQTN;
tabulate A2LRNRD;
tabulate A2LRNMTH;
tabulate A2LRNSS;
tabulate A2LRNSCN;
tabulate A2LRNKEY;
tabulate A2LRNART;
tabulate A2LRNMSC;
tabulate A2LRNGMS;
tabulate A2LRNLAN;
tabulate A2BODY;
tabulate A2PLANT;
tabulate A2DINOSR;
tabulate A2SOLAR;
tabulate A2WTHER;
tabulate A2TEMP;
tabulate A2WATER;
tabulate A2SOUND;
tabulate A2LIGHT;
tabulate A2MAGNET;
tabulate A2MOTORS;
tabulate A2TOOLS;
tabulate A2HYGIEN;
tabulate A2HISTOR;
tabulate A2CMNITY;
tabulate A2MAPRD;
tabulate A2CULTUR;
tabulate A2LAWS;
tabulate A2ECOLOG;
tabulate A2GEORPH;
tabulate A2SCMTHD;
tabulate A2SOCPRO;
tabulate A2NUMCNF;
tabulate A2TPCONF;
tabulate A2REGHLP;
tabulate A2ATTOPN;
tabulate A2ATTART;
tabulate A2SNTHME;
tabulate A2SHARED;
tabulate A2LESPLN;
tabulate A2CURRDV;
tabulate A2INDCHD;
tabulate A2DISCHD;
tabulate A2INSRVC;
tabulate A2WRKSHP;
tabulate A2CNSLT;
tabulate A2FDBACK;
tabulate A2SUPPOR;
tabulate A2OBSERV;
tabulate A2RELTIM;
tabulate A2COLLEG;
tabulate A2TECH;
tabulate A2STFFTR;
tabulate A2ADTRND;
tabulate A2INCLUS;
tabulate A2MMCOMP;
tabulate A2YYCOMP;
tabulate A1AKGTYP;
tabulate A1PKGTYP;
tabulate A1DKGTYP;
summarize B1TW0 B2TW0 A1APBLK A1APHIS A1APMIN A1PPBLK A1PPHIS A1PPMIN A1DPBLK A1DPHIS A1DPMIN B1AGE A1AHRSDA A1ADYSWK A1A3YROL A1A4YROL A1A5YROL A1A6YROL A1A7YROL A1A8YROL A1A9YROL A1ATOTAG A1AASIAN A1AHISP A1ABLACK A1AWHITE A1AAMRIN A1ARACEO A1ATOTRA A1ABOYS A1AGIRLS A1AREPK A1ALETT A1AWORD A1ASNTNC A1ANUMLE A1ANOESL A1AESLRE A1AESLOU A1PHRSDA A1PDYSWK A1P3YROL A1P4YROL A1P5YROL A1P6YROL A1P7YROL A1P8YROL A1P9YROL A1PTOTAG A1PASIAN A1PHISP A1PBLACK A1PWHITE A1PAMRIN A1PRACEO A1PTOTRA A1PBOYS A1PGIRLS A1PREPK A1PLETT A1PWORD A1PSNTNC A1PNUMLE A1PNOESL A1PESLRE A1PESLOU A1DHRSDA A1DDYSWK A1D3YROL A1D4YROL A1D5YROL A1D6YROL A1D7YROL A1D8YROL A1D9YROL A1DTOTAG A1DASIAN A1DHISP A1DBLACK A1DWHITE A1DAMRIN A1DRACEO A1DTOTRA A1DBOYS A1DGIRLS A1DREPK A1DLETT A1DWORD A1DSNTNC A1DNUMLE A1DNOESL A1DESLRE A1DESLOU A1COMPDD B1YRBORN B1YRSPRE B1YRSKIN B1YRSFST B1YRS2T5 B1YRS6PL B1YRSESL B1YRSBIL B1YRSSPE B1YRSPE B1YRSART B1YRSCH B1DDCOMP A2ANEW A2ALEFT A2AGIFT A2APRTGF A2ARDBLO A2AMTHBL A2ATARDY A2AABSEN A2ADISAB A2AIMPAI A2ALRNDI A2AEMPRB A2ADELAY A2AVIS A2AHEAR A2AORTHO A2AOTHER A2ATRAUM A2AOTDIS A2ASPCIA A2AIEP A2ASC504 A2AMORE A2PNEW A2PLEFT A2PGIFT A2PPRTGF A2PRDBLO A2PMTHBL A2PTARDY A2PABSEN A2PDISAB A2PIMPAI A2PLRNDI A2PEMPRB A2PDELAY A2PVIS A2PHEAR A2PORTHO A2POTHER A2PTRAUM A2POTDIS A2PSPCIA A2PIEP A2PSC504 A2PMORE A2DNEW A2DLEFT A2DGIFT A2DPRTGF A2DRDBLO A2DMTHBL A2DTARDY A2DABSEN A2DDISAB A2DIMPAI A2DLRNDI A2DEMPRB A2DRETAR A2DDELAY A2DVIS A2DHEAR A2DORTHO A2DOTHER A2DTRAUM A2DOTDIS A2DSPCIA A2DIEP A2DSC504 A2DMORE A2DYRECS A2NUMRD A2NUMTH A2MNEXTR A2MNAIDE A2MNSPEC A2MNPOIN A2MNOSHP A2PDAIDE A2REGWRK A2SPEDWK A2ESLWRK A2REGNON A2SPEDNO A2ESLNON A2AVHRS A2PVHRS A2DVHRS A2DDCOMP B1TTWSTR B1TTWPSU B1TW1 B1TW2 B1TW3 B1TW4 B1TW5 B1TW6 B1TW7 B1TW8 B1TW9 B1TW10 B1TW11 B1TW12 B1TW13 B1TW14 B1TW15 B1TW16 B1TW17 B1TW18 B1TW19 B1TW20 B1TW21 B1TW22 B1TW23 B1TW24 B1TW25 B1TW26 B1TW27 B1TW28 B1TW29 B1TW30 B1TW31 B1TW32 B1TW33 B1TW34 B1TW35 B1TW36 B1TW37 B1TW38 B1TW39 B1TW40 B1TW41 B1TW42 B1TW43 B1TW44 B1TW45 B1TW46 B1TW47 B1TW48 B1TW49 B1TW50 B1TW51 B1TW52 B1TW53 B1TW54 B1TW55 B1TW56 B1TW57 B1TW58 B1TW59 B1TW60 B1TW61 B1TW62 B1TW63 B1TW64 B1TW65 B1TW66 B1TW67 B1TW68 B1TW69 B1TW70 B1TW71 B1TW72 B1TW73 B1TW74 B1TW75 B1TW76 B1TW77 B1TW78 B1TW79 B1TW80 B1TW81 B1TW82 B1TW83 B1TW84 B1TW85 B1TW86 B1TW87 B1TW88 B1TW89 B1TW90 B2TTWSTR B2TTWPSU B2TW1 B2TW2 B2TW3 B2TW4 B2TW5 B2TW6 B2TW7 B2TW8 B2TW9 B2TW10 B2TW11 B2TW12 B2TW13 B2TW14 B2TW15 B2TW16 B2TW17 B2TW18 B2TW19 B2TW20 B2TW21 B2TW22 B2TW23 B2TW24 B2TW25 B2TW26 B2TW27 B2TW28 B2TW29 B2TW30 B2TW31 B2TW32 B2TW33 B2TW34 B2TW35 B2TW36 B2TW37 B2TW38 B2TW39 B2TW40 B2TW41 B2TW42 B2TW43 B2TW44 B2TW45 B2TW46 B2TW47 B2TW48 B2TW49 B2TW50 B2TW51 B2TW52 B2TW53 B2TW54 B2TW55 B2TW56 B2TW57 B2TW58 B2TW59 B2TW60 B2TW61 B2TW62 B2TW63 B2TW64 B2TW65 B2TW66 B2TW67 B2TW68 B2TW69 B2TW70 B2TW71 B2TW72 B2TW73 B2TW74 B2TW75 B2TW76 B2TW77 B2TW78 B2TW79 B2TW80 B2TW81 B2TW82 B2TW83 B2TW84 B2TW85 B2TW86 B2TW87 B2TW88 B2TW89 B2TW90;
