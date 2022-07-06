/**************************************************************************************
READING ACHIEVEMENT VIA ASSESSMENT BATTERIES/PSYCHOMETRIC TESTS AND TEACHER ASSESSMENTS 
AT LEAST ONCE PER YEAR (TWICE PER YEAR IN KINDERGARTEN AND 1ST GRADE)
********************************************************************/

/*
C1-2-3-4-5-6-7R4RSCL
C1-2-3-4-5-6-7R4RTSC
*/

forval i=1/7 {
	replace C`i'R4RSCL = . if C`i'R4RSCL < 0
	replace C`i'R4RTSC = . if C`i'R4RTSC < 0
}
