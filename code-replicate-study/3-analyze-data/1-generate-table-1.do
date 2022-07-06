log using "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\logs-replicate-study\3-analyze-data\0-table-1.log", replace

/*** TABLE 1 ***/

use "C:\Users\wodtke\Desktop\projects\nhood_mediation_schl_qual\replication\data-replicate-study\data-replicate-study\Merge\analytic-sample-post-mi-R.dta", clear

keep if _mi_m != 0

// Math Test Scores
sum c1r4mtht_r
gen mean1 = -1.174417
gen std1 = .4859363

gen c1r4mtht_r_std = (c1r4mtht_r - mean1)/std1
gen c2r4mtht_r_std = (c2r4mtht_r - mean1)/std1
gen c3r4mtht_r_std = (c3r4mtht_r - mean1)/std1
gen c4r4mtht_r_std = (c4r4mtht_r - mean1)/std1
gen c5r4mtht_r_std = (c5r4mtht_r - mean1)/std1
gen c6r4mtht_r_std = (c6r4mtht_r - mean1)/std1
gen c7r4mtht_r_std = (c7r4mtht_r - mean1)/std1

sum c1r4mtht_r_std c2r4mtht_r_std c3r4mtht_r_std c4r4mtht_r_std c5r4mtht_r_std c6r4mtht_r_std c7r4mtht_r_std

drop mean1 std1

// Reading Test Scores
sum c1r4rtht_r
gen mean1 = -1.313206
gen std1 = .5239012

gen c1r4rtht_r_std = (c1r4rtht_r - mean1)/std1
gen c2r4rtht_r_std = (c2r4rtht_r - mean1)/std1
gen c3r4rtht_r_std = (c3r4rtht_r - mean1)/std1
gen c4r4rtht_r_std = (c4r4rtht_r - mean1)/std1
gen c5r4rtht_r_std = (c5r4rtht_r - mean1)/std1
gen c6r4rtht_r_std = (c6r4rtht_r - mean1)/std1
gen c7r4rtht_r_std = (c7r4rtht_r - mean1)/std1

sum c1r4rtht_r_std c2r4rtht_r_std c3r4rtht_r_std c4r4rtht_r_std c5r4rtht_r_std c6r4rtht_r_std c7r4rtht_r_std

log close
