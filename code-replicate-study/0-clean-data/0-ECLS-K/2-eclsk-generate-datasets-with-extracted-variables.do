/************************************************
ECLS-K GENERATE DATASETS WITH EXTRACTED VARIABLES
************************************************/

/*

This step assumes that the user has access to the ECLS-K Kindergarten-Eighth 
Grade Restricted-use File. This file can be acquired in the form of a set of CDs
after making a formal request to the NCES. This CD provides a set of programs
that can be used to generate .do and .dct files needed to turn the restricted
.dat file into Stata format. 

*/

clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Base Year\base-year-extract" nostop

clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\First Grade\first-grade-extract" nostop

clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Third Grade\third-grade-extract" nostop

clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Fifth Grade\fifth-grade-extract" nostop

clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Eighth Grade\eighth-grade-extract" nostop

clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Student Record Abstract\student-record-abstract-extract" nostop

clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Special Education\special-education-extract" nostop

clear
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Restricted\Variables\Salary and Benefits\salary-and-benefits-extract" nostop
