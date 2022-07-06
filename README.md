# nhood_mediation_schl_qual

The code is organized in 6 parts, which are run in the following order:



0-clean-data

1-generate-impact-measures.do

2-multiple-impute.do

3-analyze-data

4-ancillary-analyses

5-eclsk11-analyses



~~~~~~~~~~~~~~~~~~

~~~ CLEAN DATA ~~~

~~~~~~~~~~~~~~~~~~



The first of these parts (0-clean-data) includes a clean-data-master-do-file, which runs the code in the following subfolders:



0-ECLS-K

1-CCD

2-PSS

3-GeoLytics



Data cleaning starts with ECLS-K, which involves merging public and restricted datasets, generating variables needed for analysis, and adding geocode information. 



To be able to use the public data, the corresponding child, school, and teacher .dat, .dct, and .dat files for ECLS-K Kindergarten-Eighth Grade Public-use File need to be downloaded from the NCES website from the link: https://nces.ed.gov/ecls/dataproducts.asp#K-8 In addition, the .dta errata file for theta scores needs to be downloaded as well from the same link.



To be able to use the restricted data, the user needs access to the ECLS-K Kindergarten-Eighth Grade Restricted-use File. This file can be acquired in the form of a set of CDs after making a formal request to the NCES. This CD provides a set of programs that can be used to generate .do and .dct files needed to turn the restricted .dat file into Stata format. 



The scripts that generate new variables based on the ECLS-K dataset are organized under three subfolders for mediator, outcome, and covariates.



Next, the CCD and PSS scripts are run, which merge these datasets to the ECLS-K dataset and generate more variables. 



To be able to use the CCD dataset, the user needs access to the relevant public CCD files. These files can be downloaded for SAS/SPSS format from the NCES website from the link: https://nces.ed.gov/ccd/ccddata.asp Once read into SPSS, the user can subsequently output the data in Stata format from there. 



Similarly, to be able to use the PSS dataset, the user needs access to the relevant public PSS files. These files can be downloaded for SAS/SPSS format from the NCES website from the link: https://nces.ed.gov/surveys/pss/pssdata.asp Once read into SPSS, the user can subsequently output the data in Stata format from there. 



Finally, the GeoLytics scripts are run, which generate the necessary treatment variable and merges the resulting dataset to the earlier datasets generated. 



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~ GENERATE IMPACT MEASURES ~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



After data cleaning is complete, the next step is to run the script that generates the impact measures. This script first calculates the exposure estimates needed for analysis and then uses the HLM software to fit a three-level hierarchical linear model to the data to generate the impact measures. 



~~~~~~~~~~~~~~~~~~~~~~~

~~~ MULTIPLE IMPUTE ~~~

~~~~~~~~~~~~~~~~~~~~~~~



The final step before analyzing the data is to use multiple imputation to deal with missing data. This script uses chained equations to generate 50 imputed datasets. 



~~~~~~~~~~~~~~~~~~~~

~~~ ANALYZE DATA ~~~

~~~~~~~~~~~~~~~~~~~~



Once the initial preprocessing discussed above is complete, the final set of scripts that analyze the data are run. These scripts prepare the dataset for analysis in R and subsequently run the analyses that generate Tables 1-8, Figure 3, as well as the tables and figures in various online appendices.
