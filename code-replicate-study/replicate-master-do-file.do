/************************
REPLICATE MASTER DO FILE
************************/

// Clean Data
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\0-clean-data\clean-data-master-do-file.do" nostop

// Generate Impact Measures
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\1-generate-impact-measures.do" nostop

// Multiple Impute
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\2-multiple-impute.do" nostop

// Analyze Data
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\3-analyze-data\analyze-master-do-file.do" nostop

// Ancillary analyses
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\4-ancillary-analyses\ancillary-master-do-file.do" nostop

// ECLS-K 2011 replication
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\5-eclsk11-analyses\eclsk11-master-do-file.do" nostop
