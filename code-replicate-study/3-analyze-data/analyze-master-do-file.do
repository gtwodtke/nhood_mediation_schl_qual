/************************
ANALYZE MASTER DO FILE
************************/

// 0-prepare-stata-dataset-for-r
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\3-analyze-data\0-prepare-stata-dataset-for-r.do" nostop

// 1-generate-table-1
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\3-analyze-data\1-generate-table-1.do" nostop

// 2-generate-table-2
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\3-analyze-data\2-generate-table-2.do" nostop

// 3-generate-table-3
clear all
do "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\3-analyze-data\3-generate-table-3.do" nostop

// 4-generate-figure-3
global anlpath "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\3-analyze-data\"

shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}4-generate-figure-3.R"
shell DEL "${anlpath}4-generate-figure-3.Rout"

// 5-generate-tables-4-5-6-7-8-b-d-e-f-2020-10-28
shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}5-generate-tables-4-5-6-7-8-b-d-e.R"
shell DEL "${anlpath}5-generate-tables-4-5-6-7-8-b-d-e.Rout"

// 6-generate-appendix-g-2020-10-28
shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}6-generate-appendix-g.R"
shell DEL "${anlpath}6-generate-appendix-g.Rout"

// 7-generate-mid-2020-10-28
shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}7-generate-mid.R"
shell DEL "${anlpath}7-generate-mid.Rout"

// 8-robustness-check-control-for-all-mediators
shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}8-robustness-check-control-for-all-mediators.R"
shell DEL "${anlpath}8-robustness-check-control-for-all-mediators.Rout"

// 9-generate-figure-densPlot
shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}9-generate-figure-densPlot.R"
shell DEL "${anlpath}9-generate-figure-densPlot.Rout"

// 10-generate-alt-schl-effectiveness-est
shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}10-generate-alt-schl-effectiveness-est.R"
shell DEL "${anlpath}10-generate-alt-schl-effectiveness-est.Rout"
