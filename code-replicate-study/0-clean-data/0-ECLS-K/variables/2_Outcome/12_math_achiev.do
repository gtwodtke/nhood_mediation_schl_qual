/***********************************************************************************
MATH ACHIEVEMENT VIA ASSESSMENT BATTERIES/PSYCHOMETRIC TESTS AND TEACHER ASSESSMENTS 
AT LEAST ONCE PER YEAR (TWICE PER YEAR IN KINDERGARTEN AND 1ST GRADE)
********************************************************************/

/*
C1-2-3-4-5-6-7R4MSCL
C1-2-3-4-5-6-7R4MTSC
*/

forval i=1/7 {
	replace C`i'R4MSCL = . if C`i'R4MSCL < 0
	replace C`i'R4MTSC = . if C`i'R4MTSC < 0
}
