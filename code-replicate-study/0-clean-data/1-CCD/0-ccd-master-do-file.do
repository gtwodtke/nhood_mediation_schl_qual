/*****************
CCD MASTER DO FILE
*****************/

// Read and merge datasets
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\1-CCD\1-ccd-merge-datasets-to-eclsk.do" nostop

// Generate variables
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\1-CCD\2-ccd-generate-variables-after-merging-with-eclsk.do" nostop
