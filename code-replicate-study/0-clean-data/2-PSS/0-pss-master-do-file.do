/*****************
PSS MASTER DO FILE
*****************/

// Read and merge datasets
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\2-PSS\1-pss-merge-datasets-to-eclsk.do" nostop

// Generate variables
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\2-PSS\2-pss-generate-variables-after-merging-with-eclsk-ccd.do" nostop
