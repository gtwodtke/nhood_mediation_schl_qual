/************************
ANALYZE MASTER DO FILE
************************/

global anlpath "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\code-replicate-study\4-ancillary-analyses\"

// 1-generate-valueAdd
clear all
do "${anlpath}1-generate-valueAdd.do" nostop

// 2-multiple-impute-valueAdd
clear all
do "${anlpath}2-multiple-impute-valueAdd.do" nostop

// 3-generate-valueAdd-schl-effectiveness-est
clear all

shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}3-generate-valueAdd-schl-effectiveness-est.R"
shell DEL "${anlpath}3-generate-valueAdd-schl-effectiveness-est.Rout"

// 4-generate-rucc-codes
clear all
do "${anlpath}4-generate-rucc-codes.do" nostop

// 5-generate-rucc-effect-mod
clear all

shell "C:\Program Files\R\R-4.0.2\bin\x64\R.exe" CMD BATCH --vanilla --slave --no-restore --no-timing --no-echo "${anlpath}5-generate-rucc-effect-mod.R"
shell DEL "${anlpath}5-generate-rucc-effect-mod.Rout"
