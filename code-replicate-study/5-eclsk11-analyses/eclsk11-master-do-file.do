/************************
ANALYZE MASTER DO FILE
************************/
clear all

global anlpath "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\5-eclsk11-analyses\"

do "${anlpath}1-create-eclsk11v1.do" nostop

do "${anlpath}2-create-eclsk11v2.do" nostop

do "${anlpath}3-create-eclsk11v3.do" nostop

do "${anlpath}4-create-eclsk11v4.do" nostop

do "${anlpath}5-create-eclsk11v5.do" nostop

do "${anlpath}6-multiple-impute-eclsk11mi.do" nostop

shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}7-generate-eclsk11-schl-effectiveness-est.R"
shell DEL "${anlpath}7-generate-eclsk11-schl-effectiveness-est.Rout"
