/********************
ECLS-K MASTER DO FILE 
********************/

// Read public data
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\1-eclsk-read-public-data.do" nostop

// Generate datasets with extracted variables
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\2-eclsk-generate-datasets-with-extracted-variables.do" nostop

// Keep only necessary variables in extracts
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\3-eclsk-keep-only-necessary-variables-in-extracts.do" nostop

// Merge public and restricted datasets
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\4-eclsk-merge-public-and-restricted-datasets.do" nostop

// Generate variables
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\5-eclsk-generate-variables.do" nostop

// Keep only necessary variables in merged data
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\6-eclsk-keep-only-necessary-variables-in-merged-data.do" nostop

// Read .dat geocode files
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\0-ECLS-K\7-read-dot-dat-geocode-files.do" nostop
