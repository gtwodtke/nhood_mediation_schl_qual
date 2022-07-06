#####################
# TABLES 4-8        #
# APPENDICES B,D,E  #
# ADDITIONAL MODELS #
#####################

rm(list=ls())





#################
### LIBRARIES ###
#################

library(foreign)
library(eivtools)

nmi <- 50
nboot <- 500



################################################################
### INPUT/RECODE DATA (AND DO SOME PRELIMINARY CALCULATIONS) ###
################################################################

### Input data ###
analytic_sample_post_mi <- read.dta("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/data-replicate-study/data-replicate-study/Merge/analytic-sample-post-mi-R.dta")


### Remove original non-imputed dataset ###
vars <- c(
  "c5r4mtht_r", "c5r4rtht_r", "c6r4mtht_r", "c6r4rtht_r", "c7r4mtht_r", "c7r4rtht_r",
  "re_impact_math", "re_impact_math_ver2", "re_impact_math_ver3",
  "re_impact_read", "re_impact_read_ver2", "re_impact_read_ver3",
  "school_resources", "puptchr99", "B4YRSTC_sch", "YKBASSAL_sch", "advdeg_sch", "ndstexp99",
  "school_disorder", "A4ABSEN_r_sch", "A4BEHVR_r_sch",
  "nschlnch99_percent", 
  "S4NONWHTPCT",
  "trct_disadv_index2",
  "c1r4mtht_r", "c1r4rtht_r",
  "c1r4mtht_r_mean", "c1r4rtht_r_mean",
  "male", "female",
  "white_non_hispanic", "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
  "childweightlow",
  "cogstim_scale",
  "magebirth",
  "parprac_scale",
  "pmh_scale_ver_one_2",
  "P2INCOME",
  "P1HTOTAL",
  "less_than_hs_diploma", "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
  "mmarriedbirth",
  "d_thirty_five_hrs_or_more_pw", "d_less_than_thirty_five_hrs_pw", "d_emp_other",
  "m_thirty_five_hrs_or_more_pw", "m_less_than_thirty_five_hrs_pw", "m_emp_other",
  "S3_ID", "_mi_m"
)

analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" != 0), vars]



### Generate "at least some college" variable ###
analytic_sample_post_mi$at_least_some_col <- ifelse(analytic_sample_post_mi$some_college == 1 | analytic_sample_post_mi$bachelor_s_degree == 1 | analytic_sample_post_mi$graduate == 1, 1, 0)



### Standardize variables ###

# Outcome
analytic_sample_post_mi$c5r4mtht_r <- ((analytic_sample_post_mi$c5r4mtht_r - mean(analytic_sample_post_mi$c5r4mtht_r)) / sd(analytic_sample_post_mi$c5r4mtht_r))
analytic_sample_post_mi$c5r4rtht_r <- ((analytic_sample_post_mi$c5r4rtht_r - mean(analytic_sample_post_mi$c5r4rtht_r)) / sd(analytic_sample_post_mi$c5r4rtht_r))
analytic_sample_post_mi$c6r4mtht_r <- ((analytic_sample_post_mi$c6r4mtht_r - mean(analytic_sample_post_mi$c6r4mtht_r)) / sd(analytic_sample_post_mi$c6r4mtht_r))
analytic_sample_post_mi$c6r4rtht_r <- ((analytic_sample_post_mi$c6r4rtht_r - mean(analytic_sample_post_mi$c6r4rtht_r)) / sd(analytic_sample_post_mi$c6r4rtht_r))
analytic_sample_post_mi$c7r4mtht_r <- ((analytic_sample_post_mi$c7r4mtht_r - mean(analytic_sample_post_mi$c7r4mtht_r)) / sd(analytic_sample_post_mi$c7r4mtht_r))
analytic_sample_post_mi$c7r4rtht_r <- ((analytic_sample_post_mi$c7r4rtht_r - mean(analytic_sample_post_mi$c7r4rtht_r)) / sd(analytic_sample_post_mi$c7r4rtht_r))

# Mediator: school effectiveness
analytic_sample_post_mi$re_impact_math      <- ((analytic_sample_post_mi$re_impact_math      - mean(analytic_sample_post_mi$re_impact_math))      / sd(analytic_sample_post_mi$re_impact_math))
analytic_sample_post_mi$re_impact_read      <- ((analytic_sample_post_mi$re_impact_read      - mean(analytic_sample_post_mi$re_impact_read))      / sd(analytic_sample_post_mi$re_impact_read))

# Mediator: school resources
analytic_sample_post_mi$school_resources <- ((analytic_sample_post_mi$school_resources - mean(analytic_sample_post_mi$school_resources)) / sd(analytic_sample_post_mi$school_resources))
analytic_sample_post_mi$puptchr99        <- ((analytic_sample_post_mi$puptchr99        - mean(analytic_sample_post_mi$puptchr99))        / sd(analytic_sample_post_mi$puptchr99))
analytic_sample_post_mi$B4YRSTC_sch      <- ((analytic_sample_post_mi$B4YRSTC_sch      - mean(analytic_sample_post_mi$B4YRSTC_sch))      / sd(analytic_sample_post_mi$B4YRSTC_sch))
analytic_sample_post_mi$YKBASSAL_sch     <- ((analytic_sample_post_mi$YKBASSAL_sch     - mean(analytic_sample_post_mi$YKBASSAL_sch))     / sd(analytic_sample_post_mi$YKBASSAL_sch))
analytic_sample_post_mi$advdeg_sch       <- ((analytic_sample_post_mi$advdeg_sch       - mean(analytic_sample_post_mi$advdeg_sch))       / sd(analytic_sample_post_mi$advdeg_sch))
analytic_sample_post_mi$ndstexp99        <- ((analytic_sample_post_mi$ndstexp99        - mean(analytic_sample_post_mi$ndstexp99))        / sd(analytic_sample_post_mi$ndstexp99))

# Mediator: school disorder
analytic_sample_post_mi$school_disorder <- ((analytic_sample_post_mi$school_disorder - mean(analytic_sample_post_mi$school_disorder)) / sd(analytic_sample_post_mi$school_disorder))
analytic_sample_post_mi$A4ABSEN_r_sch   <- ((analytic_sample_post_mi$A4ABSEN_r_sch   - mean(analytic_sample_post_mi$A4ABSEN_r_sch))   / sd(analytic_sample_post_mi$A4ABSEN_r_sch))
analytic_sample_post_mi$A4BEHVR_r_sch   <- ((analytic_sample_post_mi$A4BEHVR_r_sch   - mean(analytic_sample_post_mi$A4BEHVR_r_sch))   / sd(analytic_sample_post_mi$A4BEHVR_r_sch))

# Post-treatment confounders
#analytic_sample_post_mi$nschlnch99_percent <- ((analytic_sample_post_mi$nschlnch99_percent - mean(analytic_sample_post_mi$nschlnch99_percent)) / sd(analytic_sample_post_mi$nschlnch99_percent))
#analytic_sample_post_mi$S4NONWHTPCT        <- ((analytic_sample_post_mi$S4NONWHTPCT        - mean(analytic_sample_post_mi$S4NONWHTPCT))        / sd(analytic_sample_post_mi$S4NONWHTPCT))

# Treatment
analytic_sample_post_mi$trct_disadv_index2 <- ((analytic_sample_post_mi$trct_disadv_index2 - mean(analytic_sample_post_mi$trct_disadv_index2)) / sd(analytic_sample_post_mi$trct_disadv_index2))

# Pre-treatment confounders
analytic_sample_post_mi$c1r4mtht_r <- ((analytic_sample_post_mi$c1r4mtht_r - mean(analytic_sample_post_mi$c1r4mtht_r)) / sd(analytic_sample_post_mi$c1r4mtht_r))
analytic_sample_post_mi$c1r4rtht_r <- ((analytic_sample_post_mi$c1r4rtht_r - mean(analytic_sample_post_mi$c1r4rtht_r)) / sd(analytic_sample_post_mi$c1r4rtht_r))

analytic_sample_post_mi$c1r4mtht_r_mean <- ((analytic_sample_post_mi$c1r4mtht_r_mean - mean(analytic_sample_post_mi$c1r4mtht_r_mean)) / sd(analytic_sample_post_mi$c1r4mtht_r_mean))
analytic_sample_post_mi$c1r4rtht_r_mean <- ((analytic_sample_post_mi$c1r4rtht_r_mean - mean(analytic_sample_post_mi$c1r4rtht_r_mean)) / sd(analytic_sample_post_mi$c1r4rtht_r_mean))

analytic_sample_post_mi$cogstim_scale       <- ((analytic_sample_post_mi$cogstim_scale       - mean(analytic_sample_post_mi$cogstim_scale))       / sd(analytic_sample_post_mi$cogstim_scale))
analytic_sample_post_mi$magebirth           <- ((analytic_sample_post_mi$magebirth           - mean(analytic_sample_post_mi$magebirth))           / sd(analytic_sample_post_mi$magebirth))
analytic_sample_post_mi$parprac_scale       <- ((analytic_sample_post_mi$parprac_scale       - mean(analytic_sample_post_mi$parprac_scale))       / sd(analytic_sample_post_mi$parprac_scale))
analytic_sample_post_mi$pmh_scale_ver_one_2 <- ((analytic_sample_post_mi$pmh_scale_ver_one_2 - mean(analytic_sample_post_mi$pmh_scale_ver_one_2)) / sd(analytic_sample_post_mi$pmh_scale_ver_one_2))

analytic_sample_post_mi$P2INCOME <- log(analytic_sample_post_mi$P2INCOME + 1) # first take log of income
analytic_sample_post_mi$P2INCOME <- ((analytic_sample_post_mi$P2INCOME - mean(analytic_sample_post_mi$P2INCOME)) / sd(analytic_sample_post_mi$P2INCOME))

analytic_sample_post_mi$P1HTOTAL <- ((analytic_sample_post_mi$P1HTOTAL - mean(analytic_sample_post_mi$P1HTOTAL)) / sd(analytic_sample_post_mi$P1HTOTAL))

analytic_sample_post_mi$mmarriedbirth  <- ((analytic_sample_post_mi$mmarriedbirth  - mean(analytic_sample_post_mi$mmarriedbirth))  / sd(analytic_sample_post_mi$mmarriedbirth))
analytic_sample_post_mi$childweightlow <- ((analytic_sample_post_mi$childweightlow - mean(analytic_sample_post_mi$childweightlow)) / sd(analytic_sample_post_mi$childweightlow))
analytic_sample_post_mi$female         <- ((analytic_sample_post_mi$female         - mean(analytic_sample_post_mi$female))         / sd(analytic_sample_post_mi$female))

analytic_sample_post_mi$black_or_aa_non_hispanic <- ((analytic_sample_post_mi$black_or_aa_non_hispanic - mean(analytic_sample_post_mi$black_or_aa_non_hispanic)) / sd(analytic_sample_post_mi$black_or_aa_non_hispanic))
analytic_sample_post_mi$hispanic                 <- ((analytic_sample_post_mi$hispanic                 - mean(analytic_sample_post_mi$hispanic))                 / sd(analytic_sample_post_mi$hispanic))
analytic_sample_post_mi$asian                    <- ((analytic_sample_post_mi$asian                    - mean(analytic_sample_post_mi$asian))                    / sd(analytic_sample_post_mi$asian))
analytic_sample_post_mi$race_other               <- ((analytic_sample_post_mi$race_other               - mean(analytic_sample_post_mi$race_other))               / sd(analytic_sample_post_mi$race_other))

analytic_sample_post_mi$high_school_diploma_equivalent <- ((analytic_sample_post_mi$high_school_diploma_equivalent - mean(analytic_sample_post_mi$high_school_diploma_equivalent)) / sd(analytic_sample_post_mi$high_school_diploma_equivalent))
analytic_sample_post_mi$voc_tech_program               <- ((analytic_sample_post_mi$voc_tech_program               - mean(analytic_sample_post_mi$voc_tech_program))               / sd(analytic_sample_post_mi$voc_tech_program))
analytic_sample_post_mi$some_college                   <- ((analytic_sample_post_mi$some_college                   - mean(analytic_sample_post_mi$some_college))                   / sd(analytic_sample_post_mi$some_college))
analytic_sample_post_mi$bachelor_s_degree              <- ((analytic_sample_post_mi$bachelor_s_degree              - mean(analytic_sample_post_mi$bachelor_s_degree))              / sd(analytic_sample_post_mi$bachelor_s_degree))
analytic_sample_post_mi$graduate                       <- ((analytic_sample_post_mi$graduate                       - mean(analytic_sample_post_mi$graduate))                       / sd(analytic_sample_post_mi$graduate))

analytic_sample_post_mi$d_less_than_thirty_five_hrs_pw <- ((analytic_sample_post_mi$d_less_than_thirty_five_hrs_pw - mean(analytic_sample_post_mi$d_less_than_thirty_five_hrs_pw)) / sd(analytic_sample_post_mi$d_less_than_thirty_five_hrs_pw))
analytic_sample_post_mi$d_emp_other                    <- ((analytic_sample_post_mi$d_emp_other                    - mean(analytic_sample_post_mi$d_emp_other))                    / sd(analytic_sample_post_mi$d_emp_other))

analytic_sample_post_mi$m_less_than_thirty_five_hrs_pw <- ((analytic_sample_post_mi$m_less_than_thirty_five_hrs_pw - mean(analytic_sample_post_mi$m_less_than_thirty_five_hrs_pw)) / sd(analytic_sample_post_mi$m_less_than_thirty_five_hrs_pw))
analytic_sample_post_mi$m_emp_other                    <- ((analytic_sample_post_mi$m_emp_other                    - mean(analytic_sample_post_mi$m_emp_other))                    / sd(analytic_sample_post_mi$m_emp_other))

# Appendix E variables
analytic_sample_post_mi$black_treat              <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$trct_disadv_index2
analytic_sample_post_mi$black_med_math_eff       <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$re_impact_math
analytic_sample_post_mi$black_treat_med_math_eff <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$re_impact_math
analytic_sample_post_mi$black_med_read_eff       <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$re_impact_read
analytic_sample_post_mi$black_treat_med_read_eff <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$re_impact_read
analytic_sample_post_mi$black_med_schl_res       <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$school_resources
analytic_sample_post_mi$black_treat_med_schl_res <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$school_resources
analytic_sample_post_mi$black_med_schl_dis       <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$school_disorder
analytic_sample_post_mi$black_treat_med_schl_dis <- analytic_sample_post_mi$black_or_aa_non_hispanic * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$school_disorder

analytic_sample_post_mi$female_treat              <- analytic_sample_post_mi$female * analytic_sample_post_mi$trct_disadv_index2
analytic_sample_post_mi$female_med_math_eff       <- analytic_sample_post_mi$female * analytic_sample_post_mi$re_impact_math
analytic_sample_post_mi$female_treat_med_math_eff <- analytic_sample_post_mi$female * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$re_impact_math
analytic_sample_post_mi$female_med_read_eff       <- analytic_sample_post_mi$female * analytic_sample_post_mi$re_impact_read
analytic_sample_post_mi$female_treat_med_read_eff <- analytic_sample_post_mi$female * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$re_impact_read
analytic_sample_post_mi$female_med_schl_res       <- analytic_sample_post_mi$female * analytic_sample_post_mi$school_resources
analytic_sample_post_mi$female_treat_med_schl_res <- analytic_sample_post_mi$female * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$school_resources
analytic_sample_post_mi$female_med_schl_dis       <- analytic_sample_post_mi$female * analytic_sample_post_mi$school_disorder
analytic_sample_post_mi$female_treat_med_schl_dis <- analytic_sample_post_mi$female * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$school_disorder

analytic_sample_post_mi$at_least_some_col                    <- ((analytic_sample_post_mi$at_least_some_col - mean(analytic_sample_post_mi$at_least_some_col)) / sd(analytic_sample_post_mi$at_least_some_col))

analytic_sample_post_mi$at_least_some_col_treat              <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$trct_disadv_index2
analytic_sample_post_mi$at_least_some_col_med_math_eff       <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$re_impact_math
analytic_sample_post_mi$at_least_some_col_treat_med_math_eff <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$re_impact_math
analytic_sample_post_mi$at_least_some_col_med_read_eff       <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$re_impact_read
analytic_sample_post_mi$at_least_some_col_treat_med_read_eff <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$re_impact_read
analytic_sample_post_mi$at_least_some_col_med_schl_res       <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$school_resources
analytic_sample_post_mi$at_least_some_col_treat_med_schl_res <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$school_resources
analytic_sample_post_mi$at_least_some_col_med_schl_dis       <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$school_disorder
analytic_sample_post_mi$at_least_some_col_treat_med_schl_dis <- analytic_sample_post_mi$at_least_some_col * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$school_disorder





####################
### CALCULATIONS ###
####################

### Initialize matrices to store beta/var values ###
  
mibeta_rate <- matrix(data = NA, nrow = nmi, ncol = 22) 
mivar_rate  <- matrix(data = NA, nrow = nmi, ncol = 22)

mibeta_rnde    <- matrix(data = NA, nrow = nmi, ncol = 22)
mivar_rnde     <- matrix(data = NA, nrow = nmi, ncol = 22)
mibeta_cde     <- matrix(data = NA, nrow = nmi, ncol = 22)
mivar_cde      <- matrix(data = NA, nrow = nmi, ncol = 22)
mibeta_rintref <- matrix(data = NA, nrow = nmi, ncol = 22)
mivar_rintref  <- matrix(data = NA, nrow = nmi, ncol = 22)

mibeta_rnie    <- matrix(data = NA, nrow = nmi, ncol = 22)
mivar_rnie     <- matrix(data = NA, nrow = nmi, ncol = 22)
mibeta_rpie    <- matrix(data = NA, nrow = nmi, ncol = 22)
mivar_rpie     <- matrix(data = NA, nrow = nmi, ncol = 22)
mibeta_rintmed <- matrix(data = NA, nrow = nmi, ncol = 22)
mivar_rintmed  <- matrix(data = NA, nrow = nmi, ncol = 22)

mibeta_rnde_dagger <- matrix(data = NA, nrow = nmi, ncol = 22)
mivar_rnde_dagger  <- matrix(data = NA, nrow = nmi, ncol = 22)
mibeta_rnie_dagger <- matrix(data = NA, nrow = nmi, ncol = 22)
mivar_rnie_dagger  <- matrix(data = NA, nrow = nmi, ncol = 22)

mibeta_mediator_on_treatment <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_mediator_on_treatment  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_treatment <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_treatment  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_schl_qual <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_schl_qual  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_schl_qual_x_treatment <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_schl_qual_x_treatment  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_free_lunch <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_free_lunch  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_racial_comp <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_racial_comp  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_rate_het <- matrix(data = NA, nrow = nmi, ncol = 18) 
mivar_rate_het  <- matrix(data = NA, nrow = nmi, ncol = 18)

mibeta_rnde_het    <- matrix(data = NA, nrow = nmi, ncol = 18)
mivar_rnde_het     <- matrix(data = NA, nrow = nmi, ncol = 18)
mibeta_cde_het     <- matrix(data = NA, nrow = nmi, ncol = 18)
mivar_cde_het      <- matrix(data = NA, nrow = nmi, ncol = 18)
mibeta_rintref_het <- matrix(data = NA, nrow = nmi, ncol = 18)
mivar_rintref_het  <- matrix(data = NA, nrow = nmi, ncol = 18)

mibeta_rnie_het    <- matrix(data = NA, nrow = nmi, ncol = 18)
mivar_rnie_het     <- matrix(data = NA, nrow = nmi, ncol = 18)
mibeta_rpie_het    <- matrix(data = NA, nrow = nmi, ncol = 18)
mivar_rpie_het     <- matrix(data = NA, nrow = nmi, ncol = 18)
mibeta_rintmed_het <- matrix(data = NA, nrow = nmi, ncol = 18)
mivar_rintmed_het  <- matrix(data = NA, nrow = nmi, ncol = 18)

mibeta_rnde_dagger_het <- matrix(data = NA, nrow = nmi, ncol = 18)
mivar_rnde_dagger_het  <- matrix(data = NA, nrow = nmi, ncol = 18)
mibeta_rnie_dagger_het <- matrix(data = NA, nrow = nmi, ncol = 18)
mivar_rnie_dagger_het  <- matrix(data = NA, nrow = nmi, ncol = 18)

mibeta_additional <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_additional  <- matrix(data = NA, nrow = nmi, ncol = 6)



### Initialize a set range of reliability values ###
reliabilities <- seq(from = 0.8, to = 0.6, by = -0.1)



### Loop through imputed datasets ###

for (i in 1:nmi) {
  
  # Select imputed dataset
  analytic_sample <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" == i), ]
  
  
  
  # Percentile calculations
  
  # Treatment
  pc_treatment <- quantile(analytic_sample$trct_disadv_index2, probs=c(0.2, 0.8), na.rm=TRUE)
  
  # Math impact score
  pc_schl_eff_math      <- quantile(analytic_sample$re_impact_math,      probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  
  # Reading impact score
  pc_schl_eff_read      <- quantile(analytic_sample$re_impact_read,      probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  
  # School resources
  pc_schl_res <- quantile(analytic_sample$school_resources, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  
  # School disorder
  pc_schl_dis <- quantile(analytic_sample$school_disorder, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  
  m_star_eff_math      <- pc_schl_eff_math[2]
  
  m_star_eff_read      <- pc_schl_eff_read[2]
  
  m_star_res      <- pc_schl_res[2]
  m_star_dis      <- pc_schl_dis[2]
  
  
  
  # Compute impact-by-treatment correlations
  cor_impact_treatment_math_re <- cor(analytic_sample$re_impact_math, analytic_sample$trct_disadv_index2)
  cor_impact_treatment_read_re <- cor(analytic_sample$re_impact_read, analytic_sample$trct_disadv_index2)
  
  # Loop over reliabilities
  idx <- 1
  
  interaction_rel_math_re_vec <- c()
  interaction_rel_read_re_vec <- c()
  
  reliability_vector_math_re_list <- list()
  reliability_vector_read_re_list <- list()
  
  for (r in reliabilities) {
    
    # Compute reliabilities for the impact-by-treatment interaction terms
    interaction_rel_math_re <- (r + cor_impact_treatment_math_re^2) / (1 + cor_impact_treatment_math_re^2)
    interaction_rel_read_re <- (r + cor_impact_treatment_read_re^2) / (1 + cor_impact_treatment_read_re^2)
    
    interaction_rel_math_re_vec <- c(interaction_rel_math_re_vec, interaction_rel_math_re)
    interaction_rel_read_re_vec <- c(interaction_rel_read_re_vec, interaction_rel_read_re)
    
    # Generate reliability vectors
    # Impact
    # Impact x treatment (trct_disadv_index2)
    # trct_disadv_index2
    # nschlnch99_percent_r
    # S4NONWHTPCT_r
    # c1r4mtht_r/c1r4rtht_r
    # cogstim_scale, magebirth, parprac_scale, pmh_scale_ver_one_2, P2INCOME, P1HTOTAL
    # mmarriedbirth, childweightlow, female
    # black_or_aa_non_hispanic, hispanic, asian, race_other
    # high_school_diploma_equivalent, voc_tech_program, some_college, bachelor_s_degree, graduate
    # d_less_than_thirty_five_hrs_pw, d_emp_other
    # m_less_than_thirty_five_hrs_pw, m_emp_other
    # c1r4mtht_r_mean/c1r4rtht_r_mean
    
    reliability_vector_math_re <- c(r, 
                                    interaction_rel_math_re, 
                                    1, 
                                    1, 
                                    1,
                                    1,
                                    1, 1, 1, 1, 1, 1,
                                    1, 1, 1, 
                                    1, 1, 1, 1,
                                    1, 1, 1, 1, 1,
                                    1, 1, 
                                    1, 1,
                                    1)
    
    reliability_vector_read_re <- c(r, 
                                    interaction_rel_read_re,
                                    1, 
                                    1, 
                                    1,
                                    1,
                                    1, 1, 1, 1, 1, 1,
                                    1, 1, 1, 
                                    1, 1, 1, 1,
                                    1, 1, 1, 1, 1,
                                    1, 1, 
                                    1, 1,
                                    1)
    
    names(reliability_vector_math_re) <- 
      c("re_impact_math", 
        "math_impact_x_treatment_re", 
        "trct_disadv_index2", 
        "nschlnch99_percent_r",
        "S4NONWHTPCT_r",
        "c1r4mtht_r",
        "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
        "mmarriedbirth", "childweightlow", "female",
        "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
        "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
        "d_less_than_thirty_five_hrs_pw", "d_emp_other",
        "m_less_than_thirty_five_hrs_pw", "m_emp_other",
        "c1r4mtht_r_mean")
    
    names(reliability_vector_read_re) <- 
      c("re_impact_read", 
        "read_impact_x_treatment_re", 
        "trct_disadv_index2", 
        "nschlnch99_percent_r",
        "S4NONWHTPCT_r",
        "c1r4rtht_r",
        "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
        "mmarriedbirth", "childweightlow", "female",
        "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
        "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
        "d_less_than_thirty_five_hrs_pw", "d_emp_other",
        "m_less_than_thirty_five_hrs_pw", "m_emp_other",
        "c1r4rtht_r_mean")
    
    reliability_vector_math_re_list[[idx]] <- reliability_vector_math_re
    reliability_vector_read_re_list[[idx]] <- reliability_vector_read_re
    
    idx <- idx + 1
    
  }
    
  # Appendix E reliability vectors
  
  interaction_rel_math_re_E <- (0.7 + cor_impact_treatment_math_re^2) / (1 + cor_impact_treatment_math_re^2)
  interaction_rel_read_re_E <- (0.7 + cor_impact_treatment_read_re^2) / (1 + cor_impact_treatment_read_re^2)
  
  # Generate reliability vectors
  # Impact
  # Impact x treatment (trct_disadv_index2)
  # trct_disadv_index2
  # nschlnch99_percent_r
  # S4NONWHTPCT_r
  # c1r4mtht_r/c1r4rtht_r
  # cogstim_scale, magebirth, parprac_scale, pmh_scale_ver_one_2, P2INCOME, P1HTOTAL
  # mmarriedbirth, childweightlow, female
  # black_or_aa_non_hispanic, hispanic, asian, race_other
  # high_school_diploma_equivalent, voc_tech_program, some_college, bachelor_s_degree, graduate
  # d_less_than_thirty_five_hrs_pw, d_emp_other
  # m_less_than_thirty_five_hrs_pw, m_emp_other
  # covariate_treat, covariate_med, covariate_treat_med
  # c1r4mtht_r_mean/c1r4rtht_r_mean
  
  reliability_vector_math_re_black <- c(0.7, 
                                        interaction_rel_math_re_E, 
                                        1, 
                                        1, 
                                        1,
                                        1,
                                        1, 1, 1, 1, 1, 1,
                                        1, 1, 1, 
                                        1, 1, 1, 1,
                                        1, 1, 1, 1, 1,
                                        1, 1, 
                                        1, 1,
                                        1, 1, 1,
                                        1)
  
  reliability_vector_read_re_black <- c(0.7, 
                                        interaction_rel_read_re_E,
                                        1, 
                                        1, 
                                        1,
                                        1,
                                        1, 1, 1, 1, 1, 1,
                                        1, 1, 1, 
                                        1, 1, 1, 1,
                                        1, 1, 1, 1, 1,
                                        1, 1, 
                                        1, 1,
                                        1, 1, 1,
                                        1)
  
  reliability_vector_math_re_female <- c(0.7, 
                                         interaction_rel_math_re_E, 
                                         1, 
                                         1, 
                                         1,
                                         1,
                                         1, 1, 1, 1, 1, 1,
                                         1, 1, 1, 
                                         1, 1, 1, 1,
                                         1, 1, 1, 1, 1,
                                         1, 1, 
                                         1, 1,
                                         1, 1, 1,
                                         1)
  
  reliability_vector_read_re_female <- c(0.7, 
                                         interaction_rel_read_re_E,
                                         1, 
                                         1, 
                                         1,
                                         1,
                                         1, 1, 1, 1, 1, 1,
                                         1, 1, 1, 
                                         1, 1, 1, 1,
                                         1, 1, 1, 1, 1,
                                         1, 1, 
                                         1, 1,
                                         1, 1, 1,
                                         1)
  
  reliability_vector_math_re_some_col <- c(0.7, 
                                           interaction_rel_math_re_E, 
                                           1, 
                                           1, 
                                           1,
                                           1,
                                           1, 1, 1, 1, 1, 1,
                                           1, 1, 1, 
                                           1, 1, 1, 1,
                                           1, 1, 1, 1, 1,
                                           1, 1, 
                                           1, 1,
                                           1, 1, 1,
                                           1)
  
  reliability_vector_read_re_some_col <- c(0.7, 
                                           interaction_rel_read_re_E,
                                           1, 
                                           1, 
                                           1,
                                           1,
                                           1, 1, 1, 1, 1, 1,
                                           1, 1, 1, 
                                           1, 1, 1, 1,
                                           1, 1, 1, 1, 1,
                                           1, 1, 
                                           1, 1,
                                           1, 1, 1,
                                           1)
  
  names(reliability_vector_math_re_black) <- 
    c("re_impact_math", 
      "math_impact_x_treatment_re", 
      "trct_disadv_index2", 
      "nschlnch99_percent_r_black",
      "S4NONWHTPCT_r_black",
      "c1r4mtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "black_treat", "black_med_math_eff", "black_treat_med_math_eff",
      "c1r4mtht_r_mean")
  names(reliability_vector_read_re_black) <- 
    c("re_impact_read", 
      "read_impact_x_treatment_re", 
      "trct_disadv_index2", 
      "nschlnch99_percent_r_black",
      "S4NONWHTPCT_r_black",
      "c1r4rtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "black_treat", "black_med_read_eff", "black_treat_med_read_eff",
      "c1r4rtht_r_mean")
  names(reliability_vector_math_re_female) <- 
    c("re_impact_math", 
      "math_impact_x_treatment_re", 
      "trct_disadv_index2", 
      "nschlnch99_percent_r_female",
      "S4NONWHTPCT_r_female",
      "c1r4mtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "female_treat", "female_med_math_eff", "female_treat_med_math_eff",
      "c1r4mtht_r_mean")
  names(reliability_vector_read_re_female) <- 
    c("re_impact_read", 
      "read_impact_x_treatment_re", 
      "trct_disadv_index2", 
      "nschlnch99_percent_r_female",
      "S4NONWHTPCT_r_female",
      "c1r4rtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "female_treat", "female_med_read_eff", "female_treat_med_read_eff",
      "c1r4rtht_r_mean")
  names(reliability_vector_math_re_some_col) <- 
    c("re_impact_math", 
      "math_impact_x_treatment_re", 
      "trct_disadv_index2", 
      "nschlnch99_percent_r_some_col",
      "S4NONWHTPCT_r_some_col",
      "c1r4mtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "at_least_some_col_treat", "at_least_some_col_med_math_eff", "at_least_some_col_treat_med_math_eff",
      "c1r4mtht_r_mean")
  names(reliability_vector_read_re_some_col) <- 
    c("re_impact_read", 
      "read_impact_x_treatment_re", 
      "trct_disadv_index2", 
      "nschlnch99_percent_r_some_col",
      "S4NONWHTPCT_r_some_col",
      "c1r4rtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "at_least_some_col_treat", "at_least_some_col_med_read_eff", "at_least_some_col_treat_med_read_eff",
      "c1r4rtht_r_mean")
  
  # Additional models
  reliability_vector_math_re_add <- c(0.7, 
                                      1, 
                                      1, 
                                      1,
                                      1,
                                      1, 1, 1, 1, 1, 1,
                                      1, 1, 1, 
                                      1, 1, 1, 1,
                                      1, 1, 1, 1, 1,
                                      1, 1, 
                                      1, 1,
                                      1, 1,
                                      1)
  
  reliability_vector_read_re_add <- c(0.7, 
                                      1, 
                                      1, 
                                      1,
                                      1,
                                      1, 1, 1, 1, 1, 1,
                                      1, 1, 1, 
                                      1, 1, 1, 1,
                                      1, 1, 1, 1, 1,
                                      1, 1, 
                                      1, 1,
                                      1, 1,
                                      1)
  
  names(reliability_vector_math_re_add) <- 
    c("re_impact_math", 
      "trct_disadv_index2", 
      "nschlnch99_percent",
      "S4NONWHTPCT",
      "c1r4mtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "school_resources", "school_disorder",
      "c1r4mtht_r_mean")
  names(reliability_vector_read_re_add) <- 
    c("re_impact_read", 
      "trct_disadv_index2", 
      "nschlnch99_percent",
      "S4NONWHTPCT",
      "c1r4rtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "school_resources", "school_disorder",
      "c1r4rtht_r_mean")
  
  
  
  # Fit Model 1: Mediator on treatment
  schl_eff_math_on_treatment <- lm(re_impact_math ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample)
  
  schl_eff_read_on_treatment <- lm(re_impact_read ~ 
                                     trct_disadv_index2 + 
                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4rtht_r_mean,
                                   data = analytic_sample)
  
  schl_res_on_treatment <- lm(school_resources ~ 
                                trct_disadv_index2 + 
                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                mmarriedbirth + childweightlow + female +
                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                m_less_than_thirty_five_hrs_pw + m_emp_other +
                                c1r4rtht_r_mean,
                              data = analytic_sample)
  
  schl_dis_on_treatment <- lm(school_disorder ~ 
                                trct_disadv_index2 + 
                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                mmarriedbirth + childweightlow + female +
                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                m_less_than_thirty_five_hrs_pw + m_emp_other +
                                c1r4rtht_r_mean,
                              data = analytic_sample)
  
  free_lunch_on_treatment <- lm(nschlnch99_percent ~ 
                                  trct_disadv_index2 + 
                                  c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                  mmarriedbirth + childweightlow + female +
                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                  m_less_than_thirty_five_hrs_pw + m_emp_other +
                                  c1r4rtht_r_mean,
                                data = analytic_sample)
  
  racial_comp_on_treatment <- lm(S4NONWHTPCT ~ 
                                   trct_disadv_index2 + 
                                   c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                   mmarriedbirth + childweightlow + female +
                                   black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                   high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                   d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                   m_less_than_thirty_five_hrs_pw + m_emp_other +
                                   c1r4rtht_r_mean,
                                 data = analytic_sample)
  
  # RWR calculations for percent free lunch eligible
  analytic_sample$nschlnch99_percent_r <- NA
  analytic_sample$nschlnch99_percent_r <- residuals(free_lunch_on_treatment)
  
  # RWR calculations for S4NONWHTPCT
  analytic_sample$S4NONWHTPCT_r <- NA
  analytic_sample$S4NONWHTPCT_r <- residuals(racial_comp_on_treatment)
  
  
  
  # Model 1, Appendix E
  
  # Black
  schl_eff_math_on_treatment_black <- lm(re_impact_math ~ 
                                           trct_disadv_index2 + 
                                           c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other +
                                           black_treat +
                                           c1r4mtht_r_mean,
                                         data = analytic_sample)
  
  schl_eff_read_on_treatment_black <- lm(re_impact_read ~ 
                                           trct_disadv_index2 + 
                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other +
                                           black_treat +
                                           c1r4rtht_r_mean,
                                         data = analytic_sample)
  
  schl_res_on_treatment_black <- lm(school_resources ~ 
                                      trct_disadv_index2 + 
                                      c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                      mmarriedbirth + childweightlow + female +
                                      black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                      high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                      d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                      m_less_than_thirty_five_hrs_pw + m_emp_other +
                                      black_treat +
                                      c1r4rtht_r_mean,
                                    data = analytic_sample)
  
  schl_dis_on_treatment_black <- lm(school_disorder ~ 
                                      trct_disadv_index2 + 
                                      c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                      mmarriedbirth + childweightlow + female +
                                      black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                      high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                      d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                      m_less_than_thirty_five_hrs_pw + m_emp_other +
                                      black_treat +
                                      c1r4rtht_r_mean,
                                    data = analytic_sample)
  
  free_lunch_on_treatment_black <- lm(nschlnch99_percent ~ 
                                        trct_disadv_index2 + 
                                        c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                        mmarriedbirth + childweightlow + female +
                                        black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                        high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                        d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                        m_less_than_thirty_five_hrs_pw + m_emp_other +
                                        black_treat +
                                        c1r4rtht_r_mean,
                                      data = analytic_sample)
  
  racial_comp_on_treatment_black <- lm(S4NONWHTPCT ~ 
                                         trct_disadv_index2 + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other +
                                         black_treat +
                                         c1r4rtht_r_mean,
                                       data = analytic_sample)
  
  # Female
  schl_eff_math_on_treatment_female <- lm(re_impact_math ~ 
                                            trct_disadv_index2 + 
                                            c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                            mmarriedbirth + childweightlow + female +
                                            black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                            d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                            m_less_than_thirty_five_hrs_pw + m_emp_other +
                                            female_treat +
                                            c1r4mtht_r_mean,
                                          data = analytic_sample)
  
  schl_eff_read_on_treatment_female <- lm(re_impact_read ~ 
                                            trct_disadv_index2 + 
                                            c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                            mmarriedbirth + childweightlow + female +
                                            black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                            d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                            m_less_than_thirty_five_hrs_pw + m_emp_other +
                                            female_treat +
                                            c1r4rtht_r_mean,
                                          data = analytic_sample)
  
  schl_res_on_treatment_female <- lm(school_resources ~ 
                                       trct_disadv_index2 + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other +
                                       female_treat +
                                       c1r4rtht_r_mean,
                                     data = analytic_sample)
  
  schl_dis_on_treatment_female <- lm(school_disorder ~ 
                                       trct_disadv_index2 + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other +
                                       female_treat +
                                       c1r4rtht_r_mean,
                                     data = analytic_sample)
  
  free_lunch_on_treatment_female <- lm(nschlnch99_percent ~ 
                                         trct_disadv_index2 + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other +
                                         female_treat +
                                         c1r4rtht_r_mean,
                                       data = analytic_sample)
  
  racial_comp_on_treatment_female <- lm(S4NONWHTPCT ~ 
                                          trct_disadv_index2 + 
                                          c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                          mmarriedbirth + childweightlow + female +
                                          black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                          high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                          d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                          m_less_than_thirty_five_hrs_pw + m_emp_other +
                                          female_treat +
                                          c1r4rtht_r_mean,
                                        data = analytic_sample)
  
  # At least some college
  schl_eff_math_on_treatment_some_col <- lm(re_impact_math ~ 
                                              trct_disadv_index2 + 
                                              c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other +
                                              at_least_some_col_treat +
                                              c1r4mtht_r_mean,
                                            data = analytic_sample)
  
  schl_eff_read_on_treatment_some_col <- lm(re_impact_read ~ 
                                              trct_disadv_index2 + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other +
                                              at_least_some_col_treat +
                                              c1r4rtht_r_mean,
                                            data = analytic_sample)
  
  schl_res_on_treatment_some_col <- lm(school_resources ~ 
                                         trct_disadv_index2 + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other +
                                         at_least_some_col_treat +
                                         c1r4rtht_r_mean,
                                       data = analytic_sample)
  
  schl_dis_on_treatment_some_col <- lm(school_disorder ~ 
                                         trct_disadv_index2 + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other +
                                         at_least_some_col_treat +
                                         c1r4rtht_r_mean,
                                       data = analytic_sample)
  
  free_lunch_on_treatment_some_col <- lm(nschlnch99_percent ~ 
                                           trct_disadv_index2 + 
                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other +
                                           at_least_some_col_treat +
                                           c1r4rtht_r_mean,
                                         data = analytic_sample)
  
  racial_comp_on_treatment_some_col <- lm(S4NONWHTPCT ~ 
                                            trct_disadv_index2 + 
                                            c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                            mmarriedbirth + childweightlow + female +
                                            black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                            d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                            m_less_than_thirty_five_hrs_pw + m_emp_other +
                                            at_least_some_col_treat +
                                            c1r4rtht_r_mean,
                                          data = analytic_sample)
  
  # RWR calculations, Appendix E
  analytic_sample$nschlnch99_percent_r_black    <- NA
  analytic_sample$nschlnch99_percent_r_female   <- NA
  analytic_sample$nschlnch99_percent_r_some_col <- NA
  analytic_sample$nschlnch99_percent_r_black    <- residuals(free_lunch_on_treatment_black)
  analytic_sample$nschlnch99_percent_r_female   <- residuals(free_lunch_on_treatment_female)
  analytic_sample$nschlnch99_percent_r_some_col <- residuals(free_lunch_on_treatment_some_col)
  
  analytic_sample$S4NONWHTPCT_r_black    <- NA
  analytic_sample$S4NONWHTPCT_r_female   <- NA
  analytic_sample$S4NONWHTPCT_r_some_col <- NA
  analytic_sample$S4NONWHTPCT_r_black    <- residuals(racial_comp_on_treatment_black)
  analytic_sample$S4NONWHTPCT_r_female   <- residuals(racial_comp_on_treatment_female)
  analytic_sample$S4NONWHTPCT_r_some_col <- residuals(racial_comp_on_treatment_some_col)
  
  
  
  # Add variables for mediator-by-treatment interaction
  analytic_sample$math_impact_x_treatment_re <- analytic_sample$re_impact_math * analytic_sample$trct_disadv_index2
  analytic_sample$read_impact_x_treatment_re <- analytic_sample$re_impact_read * analytic_sample$trct_disadv_index2
  
  analytic_sample$school_resources_x_treatment <- analytic_sample$school_resources * analytic_sample$trct_disadv_index2
  analytic_sample$school_disorder_x_treatment  <- analytic_sample$school_disorder  * analytic_sample$trct_disadv_index2
  
  
  
  # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
  
  outcome_model_schl_eff_math5 <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math + 
                                           math_impact_x_treatment_re +
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4mtht_r_mean,
                                         data = analytic_sample,
                                         reliability = reliability_vector_math_re_list[[2]])
  
  outcome_model_schl_res_math5 <- lm(c5r4mtht_r ~ 
                                       school_resources + 
                                       school_resources_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4mtht_r_mean,
                                     data = analytic_sample)
  
  outcome_model_schl_dis_math5 <- lm(c5r4mtht_r ~ 
                                       school_disorder + 
                                       school_disorder_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4mtht_r_mean,
                                     data = analytic_sample)
  
  outcome_model_schl_eff_read5 <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read + 
                                           read_impact_x_treatment_re +
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4rtht_r_mean,
                                         data = analytic_sample,
                                         reliability = reliability_vector_read_re_list[[2]])
  
  outcome_model_schl_res_read5 <- lm(c5r4rtht_r ~ 
                                       school_resources + 
                                       school_resources_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4rtht_r_mean,
                                     data = analytic_sample)
  
  outcome_model_schl_dis_read5 <- lm(c5r4rtht_r ~ 
                                       school_disorder + 
                                       school_disorder_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4rtht_r_mean,
                                     data = analytic_sample)
  
  # Appendix B
  outcome_model_schl_eff_math6 <- eivreg(c6r4mtht_r ~ 
                                           re_impact_math + 
                                           math_impact_x_treatment_re +
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4mtht_r_mean,
                                         data = analytic_sample,
                                         reliability = reliability_vector_math_re_list[[2]])
  
  outcome_model_schl_res_math6 <- lm(c6r4mtht_r ~ 
                                       school_resources + 
                                       school_resources_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4mtht_r_mean,
                                     data = analytic_sample)
  
  outcome_model_schl_dis_math6 <- lm(c6r4mtht_r ~ 
                                       school_disorder + 
                                       school_disorder_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4mtht_r_mean,
                                     data = analytic_sample)

  outcome_model_schl_eff_read6 <- eivreg(c6r4rtht_r ~ 
                                           re_impact_read + 
                                           read_impact_x_treatment_re +
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4rtht_r_mean,
                                         data = analytic_sample,
                                         reliability = reliability_vector_read_re_list[[2]])
  
  outcome_model_schl_res_read6 <- lm(c6r4rtht_r ~ 
                                       school_resources + 
                                       school_resources_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4rtht_r_mean,
                                     data = analytic_sample)
  
  outcome_model_schl_dis_read6 <- lm(c6r4rtht_r ~ 
                                       school_disorder + 
                                       school_disorder_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4rtht_r_mean,
                                     data = analytic_sample)
  
  outcome_model_schl_eff_math7 <- eivreg(c7r4mtht_r ~ 
                                           re_impact_math + 
                                           math_impact_x_treatment_re +
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4mtht_r_mean,
                                         data = analytic_sample,
                                         reliability = reliability_vector_math_re_list[[2]])
  
  outcome_model_schl_res_math7 <- lm(c7r4mtht_r ~ 
                                       school_resources + 
                                       school_resources_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4mtht_r_mean,
                                     data = analytic_sample)
  
  outcome_model_schl_dis_math7 <- lm(c7r4mtht_r ~ 
                                       school_disorder + 
                                       school_disorder_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4mtht_r_mean,
                                     data = analytic_sample)

  outcome_model_schl_eff_read7 <- eivreg(c7r4rtht_r ~ 
                                           re_impact_read + 
                                           read_impact_x_treatment_re +
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4rtht_r_mean,
                                         data = analytic_sample,
                                         reliability = reliability_vector_read_re_list[[2]])
  
  outcome_model_schl_res_read7 <- lm(c7r4rtht_r ~ 
                                       school_resources + 
                                       school_resources_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4rtht_r_mean,
                                     data = analytic_sample)
  
  outcome_model_schl_dis_read7 <- lm(c7r4rtht_r ~ 
                                       school_disorder + 
                                       school_disorder_x_treatment +
                                       trct_disadv_index2 + 
                                       nschlnch99_percent_r + 
                                       S4NONWHTPCT_r + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                       c1r4rtht_r_mean,
                                     data = analytic_sample)
  
  # Appendix D
  outcome_model_schl_eff_math5_p8 <- eivreg(c5r4mtht_r ~ 
                                              re_impact_math + 
                                              math_impact_x_treatment_re +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r + 
                                              S4NONWHTPCT_r + 
                                              c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              c1r4mtht_r_mean,
                                            data = analytic_sample,
                                            reliability = reliability_vector_math_re_list[[1]])
  
  outcome_model_schl_eff_read5_p8 <- eivreg(c5r4rtht_r ~ 
                                              re_impact_read + 
                                              read_impact_x_treatment_re +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r + 
                                              S4NONWHTPCT_r + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              c1r4rtht_r_mean,
                                            data = analytic_sample,
                                            reliability = reliability_vector_read_re_list[[1]])
  
  outcome_model_schl_eff_math5_p6 <- eivreg(c5r4mtht_r ~ 
                                              re_impact_math + 
                                              math_impact_x_treatment_re +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r + 
                                              S4NONWHTPCT_r + 
                                              c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              c1r4mtht_r_mean,
                                            data = analytic_sample,
                                            reliability = reliability_vector_math_re_list[[3]])
  
  outcome_model_schl_eff_read5_p6 <- eivreg(c5r4rtht_r ~ 
                                              re_impact_read + 
                                              read_impact_x_treatment_re +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r + 
                                              S4NONWHTPCT_r + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              c1r4rtht_r_mean,
                                            data = analytic_sample,
                                            reliability = reliability_vector_read_re_list[[3]])
  
  # Appendix E

  # Black
  outcome_model_schl_eff_math5_black <- eivreg(c5r4mtht_r ~ 
                                                 re_impact_math + 
                                                 math_impact_x_treatment_re +
                                                 trct_disadv_index2 + 
                                                 nschlnch99_percent_r_black + 
                                                 S4NONWHTPCT_r_black + 
                                                 c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                 mmarriedbirth + childweightlow + female +
                                                 black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                 high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                 d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                 m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                 black_treat + black_med_math_eff + black_treat_med_math_eff +
                                                 c1r4mtht_r_mean,
                                               data = analytic_sample,
                                               reliability = reliability_vector_math_re_black)
  
  outcome_model_schl_res_math5_black <- lm(c5r4mtht_r ~ 
                                             school_resources + 
                                             school_resources_x_treatment +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r_black + 
                                             S4NONWHTPCT_r_black + 
                                             c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             black_treat + black_med_schl_res + black_treat_med_schl_res +
                                             c1r4mtht_r_mean,
                                           data = analytic_sample)
  
  outcome_model_schl_dis_math5_black <- lm(c5r4mtht_r ~ 
                                             school_disorder + 
                                             school_disorder_x_treatment +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r_black + 
                                             S4NONWHTPCT_r_black + 
                                             c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             black_treat + black_med_schl_dis + black_treat_med_schl_dis +
                                             c1r4mtht_r_mean,
                                           data = analytic_sample)
  
  outcome_model_schl_eff_read5_black <- eivreg(c5r4rtht_r ~ 
                                                 re_impact_read + 
                                                 read_impact_x_treatment_re +
                                                 trct_disadv_index2 + 
                                                 nschlnch99_percent_r_black + 
                                                 S4NONWHTPCT_r_black + 
                                                 c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                 mmarriedbirth + childweightlow + female +
                                                 black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                 high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                 d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                 m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                 black_treat + black_med_read_eff + black_treat_med_read_eff +
                                                 c1r4rtht_r_mean,
                                               data = analytic_sample,
                                               reliability = reliability_vector_read_re_black)
  
  outcome_model_schl_res_read5_black <- lm(c5r4rtht_r ~ 
                                             school_resources + 
                                             school_resources_x_treatment +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r_black + 
                                             S4NONWHTPCT_r_black + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             black_treat + black_med_schl_res + black_treat_med_schl_res +
                                             c1r4rtht_r_mean,
                                           data = analytic_sample)
  
  outcome_model_schl_dis_read5_black <- lm(c5r4rtht_r ~ 
                                             school_disorder + 
                                             school_disorder_x_treatment +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r_black + 
                                             S4NONWHTPCT_r_black + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             black_treat + black_med_schl_dis + black_treat_med_schl_dis +
                                             c1r4rtht_r_mean,
                                           data = analytic_sample)
  
  # Female
  outcome_model_schl_eff_math5_female <- eivreg(c5r4mtht_r ~ 
                                                  re_impact_math + 
                                                  math_impact_x_treatment_re +
                                                  trct_disadv_index2 + 
                                                  nschlnch99_percent_r_female + 
                                                  S4NONWHTPCT_r_female + 
                                                  c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                  female_treat + female_med_math_eff + female_treat_med_math_eff +
                                                  c1r4mtht_r_mean,
                                                data = analytic_sample,
                                                reliability = reliability_vector_math_re_female)
  
  outcome_model_schl_res_math5_female <- lm(c5r4mtht_r ~ 
                                              school_resources + 
                                              school_resources_x_treatment +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r_female + 
                                              S4NONWHTPCT_r_female + 
                                              c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              female_treat + female_med_schl_res + female_treat_med_schl_res +
                                              c1r4mtht_r_mean,
                                            data = analytic_sample)
  
  outcome_model_schl_dis_math5_female <- lm(c5r4mtht_r ~ 
                                              school_disorder + 
                                              school_disorder_x_treatment +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r_female + 
                                              S4NONWHTPCT_r_female + 
                                              c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              female_treat + female_med_schl_dis + female_treat_med_schl_dis +
                                              c1r4mtht_r_mean,
                                            data = analytic_sample)
  
  outcome_model_schl_eff_read5_female <- eivreg(c5r4rtht_r ~ 
                                                  re_impact_read + 
                                                  read_impact_x_treatment_re +
                                                  trct_disadv_index2 + 
                                                  nschlnch99_percent_r_female + 
                                                  S4NONWHTPCT_r_female + 
                                                  c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                  female_treat + female_med_read_eff + female_treat_med_read_eff +
                                                  c1r4rtht_r_mean,
                                                data = analytic_sample,
                                                reliability = reliability_vector_read_re_female)
  
  outcome_model_schl_res_read5_female <- lm(c5r4rtht_r ~ 
                                              school_resources + 
                                              school_resources_x_treatment +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r_female + 
                                              S4NONWHTPCT_r_female + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              female_treat + female_med_schl_res + female_treat_med_schl_res +
                                              c1r4rtht_r_mean,
                                            data = analytic_sample)
  
  outcome_model_schl_dis_read5_female <- lm(c5r4rtht_r ~ 
                                              school_disorder + 
                                              school_disorder_x_treatment +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r_female + 
                                              S4NONWHTPCT_r_female + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              female_treat + female_med_schl_dis + female_treat_med_schl_dis +
                                              c1r4rtht_r_mean,
                                            data = analytic_sample)
  
  # At least some college
  outcome_model_schl_eff_math5_some_col <- eivreg(c5r4mtht_r ~ 
                                                    re_impact_math + 
                                                    math_impact_x_treatment_re +
                                                    trct_disadv_index2 + 
                                                    nschlnch99_percent_r_some_col + 
                                                    S4NONWHTPCT_r_some_col + 
                                                    c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                    mmarriedbirth + childweightlow + female +
                                                    black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                    high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                    d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                    m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                    at_least_some_col_treat + at_least_some_col_med_math_eff + at_least_some_col_treat_med_math_eff +
                                                    c1r4mtht_r_mean,
                                                  data = analytic_sample,
                                                  reliability = reliability_vector_math_re_some_col)
  
  outcome_model_schl_res_math5_some_col <- lm(c5r4mtht_r ~ 
                                                school_resources + 
                                                school_resources_x_treatment +
                                                trct_disadv_index2 + 
                                                nschlnch99_percent_r_some_col + 
                                                S4NONWHTPCT_r_some_col + 
                                                c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                at_least_some_col_treat + at_least_some_col_med_schl_res + at_least_some_col_treat_med_schl_res +
                                                c1r4mtht_r_mean,
                                              data = analytic_sample)
  
  outcome_model_schl_dis_math5_some_col <- lm(c5r4mtht_r ~ 
                                                school_disorder + 
                                                school_disorder_x_treatment +
                                                trct_disadv_index2 + 
                                                nschlnch99_percent_r_some_col + 
                                                S4NONWHTPCT_r_some_col + 
                                                c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                at_least_some_col_treat + at_least_some_col_med_schl_dis + at_least_some_col_treat_med_schl_dis +
                                                c1r4mtht_r_mean,
                                              data = analytic_sample)
  
  outcome_model_schl_eff_read5_some_col <- eivreg(c5r4rtht_r ~ 
                                                    re_impact_read + 
                                                    read_impact_x_treatment_re +
                                                    trct_disadv_index2 + 
                                                    nschlnch99_percent_r_some_col + 
                                                    S4NONWHTPCT_r_some_col + 
                                                    c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                    mmarriedbirth + childweightlow + female +
                                                    black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                    high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                    d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                    m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                    at_least_some_col_treat + at_least_some_col_med_read_eff + at_least_some_col_treat_med_read_eff +
                                                    c1r4rtht_r_mean,
                                                  data = analytic_sample,
                                                  reliability = reliability_vector_read_re_some_col)
  
  outcome_model_schl_res_read5_some_col <- lm(c5r4rtht_r ~ 
                                                school_resources + 
                                                school_resources_x_treatment +
                                                trct_disadv_index2 + 
                                                nschlnch99_percent_r_some_col + 
                                                S4NONWHTPCT_r_some_col + 
                                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                at_least_some_col_treat + at_least_some_col_med_schl_res + at_least_some_col_treat_med_schl_res +
                                                c1r4rtht_r_mean,
                                              data = analytic_sample)
  
  outcome_model_schl_dis_read5_some_col <- lm(c5r4rtht_r ~ 
                                                school_disorder + 
                                                school_disorder_x_treatment +
                                                trct_disadv_index2 + 
                                                nschlnch99_percent_r_some_col + 
                                                S4NONWHTPCT_r_some_col + 
                                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                at_least_some_col_treat + at_least_some_col_med_schl_dis + at_least_some_col_treat_med_schl_dis +
                                                c1r4rtht_r_mean,
                                              data = analytic_sample)
  
  # Additional models
  outcome_model_schl_res_math5_add <- lm(c5r4mtht_r ~ 
                                           puptchr99 + B4YRSTC_sch + YKBASSAL_sch + advdeg_sch + ndstexp99 + 
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4mtht_r_mean,
                                         data = analytic_sample)
  
  outcome_model_schl_res_read5_add <- lm(c5r4rtht_r ~ 
                                           puptchr99 + B4YRSTC_sch + YKBASSAL_sch + advdeg_sch + ndstexp99 + 
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4rtht_r_mean,
                                         data = analytic_sample)
  
  outcome_model_schl_dis_math5_add <- lm(c5r4mtht_r ~ 
                                           A4ABSEN_r_sch + A4BEHVR_r_sch + 
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4mtht_r_mean,
                                         data = analytic_sample)
  
  outcome_model_schl_dis_read5_add <- lm(c5r4rtht_r ~ 
                                           A4ABSEN_r_sch + A4BEHVR_r_sch + 
                                           trct_disadv_index2 + 
                                           nschlnch99_percent_r + 
                                           S4NONWHTPCT_r + 
                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                           c1r4rtht_r_mean,
                                         data = analytic_sample)
  
  outcome_model_schl_eff_math5_add <- eivreg(c5r4mtht_r ~ 
                                               re_impact_math + 
                                               trct_disadv_index2 + 
                                               nschlnch99_percent + 
                                               S4NONWHTPCT + 
                                               c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                               mmarriedbirth + childweightlow + female +
                                               black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                               high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                               d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                               m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                               school_resources + school_disorder +
                                               c1r4mtht_r_mean,
                                             data = analytic_sample,
                                             reliability = reliability_vector_math_re_add)
  
  outcome_model_schl_eff_read5_add <- eivreg(c5r4rtht_r ~ 
                                               re_impact_read + 
                                               trct_disadv_index2 + 
                                               nschlnch99_percent + 
                                               S4NONWHTPCT + 
                                               c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                               mmarriedbirth + childweightlow + female +
                                               black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                               high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                               d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                               m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                               school_resources + school_disorder +
                                               c1r4rtht_r_mean,
                                             data = analytic_sample,
                                             reliability = reliability_vector_read_re_add)
  
  # Table 4
  mibeta_cde[i,1]  <- (outcome_model_schl_eff_math5$coef[4] + outcome_model_schl_eff_math5$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,2]  <- (outcome_model_schl_res_math5$coef[4] + outcome_model_schl_res_math5$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,3]  <- (outcome_model_schl_dis_math5$coef[4] + outcome_model_schl_dis_math5$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintref[i,1]  <- outcome_model_schl_eff_math5$coef[3] * (schl_eff_math_on_treatment$coef[1] + schl_eff_math_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,2]  <- outcome_model_schl_res_math5$coef[3] * (schl_res_on_treatment$coef[1]      + schl_res_on_treatment$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,3]  <- outcome_model_schl_dis_math5$coef[3] * (schl_dis_on_treatment$coef[1]      + schl_dis_on_treatment$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])

  mibeta_rnde[i,1]  <- mibeta_cde[i,1]  + mibeta_rintref[i,1]
  mibeta_rnde[i,2]  <- mibeta_cde[i,2]  + mibeta_rintref[i,2]
  mibeta_rnde[i,3]  <- mibeta_cde[i,3]  + mibeta_rintref[i,3]
  
  mibeta_rpie[i,1]  <- (schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[2] + schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,2]  <- (schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math5$coef[2] + schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,3]  <- (schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math5$coef[2] + schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])

  mibeta_rintmed[i,1]  <- schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,2]  <- schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,3]  <- schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2

  mibeta_rnie[i,1]  <- mibeta_rpie[i,1]  + mibeta_rintmed[i,1]
  mibeta_rnie[i,2]  <- mibeta_rpie[i,2]  + mibeta_rintmed[i,2]
  mibeta_rnie[i,3]  <- mibeta_rpie[i,3]  + mibeta_rintmed[i,3]

  mibeta_rate[i,1]  <- mibeta_rnde[i,1]  + mibeta_rnie[i,1]
  mibeta_rate[i,2]  <- mibeta_rnde[i,2]  + mibeta_rnie[i,2]
  mibeta_rate[i,3]  <- mibeta_rnde[i,3]  + mibeta_rnie[i,3]

  mibeta_rnde_dagger[i,1]  <- mibeta_rnde[i,1]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,2]  <- mibeta_rnde[i,2]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_math5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_math5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,3]  <- mibeta_rnde[i,3]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_math5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_math5$coef[6]) * (pc_treatment[2] - pc_treatment[1])

  mibeta_rnie_dagger[i,1]  <- mibeta_rnie[i,1]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,2]  <- mibeta_rnie[i,2]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_math5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_math5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,3]  <- mibeta_rnie[i,3]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_math5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_math5$coef[6]) * (pc_treatment[2] - pc_treatment[1])

  # Table 5
  mibeta_cde[i,4]  <- (outcome_model_schl_eff_read5$coef[4] + outcome_model_schl_eff_read5$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,5]  <- (outcome_model_schl_res_read5$coef[4] + outcome_model_schl_res_read5$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,6]  <- (outcome_model_schl_dis_read5$coef[4] + outcome_model_schl_dis_read5$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintref[i,4]  <- outcome_model_schl_eff_read5$coef[3] * (schl_eff_read_on_treatment$coef[1] + schl_eff_read_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,5]  <- outcome_model_schl_res_read5$coef[3] * (schl_res_on_treatment$coef[1]      + schl_res_on_treatment$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,6]  <- outcome_model_schl_dis_read5$coef[3] * (schl_dis_on_treatment$coef[1]      + schl_dis_on_treatment$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rnde[i,4]  <- mibeta_cde[i,4]  + mibeta_rintref[i,4]
  mibeta_rnde[i,5]  <- mibeta_cde[i,5]  + mibeta_rintref[i,5]
  mibeta_rnde[i,6]  <- mibeta_cde[i,6]  + mibeta_rintref[i,6]
  
  mibeta_rpie[i,4]  <- (schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[2] + schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,5]  <- (schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read5$coef[2] + schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,6]  <- (schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read5$coef[2] + schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintmed[i,4]  <- schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,5]  <- schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,6]  <- schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  
  mibeta_rnie[i,4]  <- mibeta_rpie[i,4]  + mibeta_rintmed[i,4]
  mibeta_rnie[i,5]  <- mibeta_rpie[i,5]  + mibeta_rintmed[i,5]
  mibeta_rnie[i,6]  <- mibeta_rpie[i,6]  + mibeta_rintmed[i,6]
  
  mibeta_rate[i,4]  <- mibeta_rnde[i,4]  + mibeta_rnie[i,4]
  mibeta_rate[i,5]  <- mibeta_rnde[i,5]  + mibeta_rnie[i,5]
  mibeta_rate[i,6]  <- mibeta_rnde[i,6]  + mibeta_rnie[i,6]
  
  mibeta_rnde_dagger[i,4]  <- mibeta_rnde[i,4]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,5]  <- mibeta_rnde[i,5]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_read5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_read5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,6]  <- mibeta_rnde[i,6]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_read5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_read5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rnie_dagger[i,4]  <- mibeta_rnie[i,4]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,5]  <- mibeta_rnie[i,5]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_read5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_read5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,6]  <- mibeta_rnie[i,6]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_read5$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_read5$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  
  # Table 6
  mibeta_mediator_on_treatment[i,1] <- schl_eff_math_on_treatment$coef[2]
  mibeta_mediator_on_treatment[i,2] <- schl_eff_read_on_treatment$coef[2]
  mibeta_mediator_on_treatment[i,3] <- schl_res_on_treatment$coef[2]
  mibeta_mediator_on_treatment[i,4] <- schl_dis_on_treatment$coef[2]
  mibeta_mediator_on_treatment[i,5] <- free_lunch_on_treatment$coef[2]
  mibeta_mediator_on_treatment[i,6] <- racial_comp_on_treatment$coef[2]
  
  # Table 7
  mibeta_treatment[i,1]  <- outcome_model_schl_eff_math5$coef[4]
  mibeta_treatment[i,2]  <- outcome_model_schl_res_math5$coef[4]
  mibeta_treatment[i,3]  <- outcome_model_schl_dis_math5$coef[4]
  
  mibeta_schl_qual[i,1]  <- outcome_model_schl_eff_math5$coef[2]
  mibeta_schl_qual[i,2]  <- outcome_model_schl_res_math5$coef[2]
  mibeta_schl_qual[i,3]  <- outcome_model_schl_dis_math5$coef[2]
  
  mibeta_schl_qual_x_treatment[i,1]  <- outcome_model_schl_eff_math5$coef[3]
  mibeta_schl_qual_x_treatment[i,2]  <- outcome_model_schl_res_math5$coef[3]
  mibeta_schl_qual_x_treatment[i,3]  <- outcome_model_schl_dis_math5$coef[3]
  
  mibeta_free_lunch[i,1]  <- outcome_model_schl_eff_math5$coef[5]
  mibeta_free_lunch[i,2]  <- outcome_model_schl_res_math5$coef[5]
  mibeta_free_lunch[i,3]  <- outcome_model_schl_dis_math5$coef[5]
  
  mibeta_racial_comp[i,1]  <- outcome_model_schl_eff_math5$coef[6]
  mibeta_racial_comp[i,2]  <- outcome_model_schl_res_math5$coef[6]
  mibeta_racial_comp[i,3]  <- outcome_model_schl_dis_math5$coef[6]
  
  # Table 8
  mibeta_treatment[i,4]  <- outcome_model_schl_eff_read5$coef[4]
  mibeta_treatment[i,5]  <- outcome_model_schl_res_read5$coef[4]
  mibeta_treatment[i,6]  <- outcome_model_schl_dis_read5$coef[4]
  
  mibeta_schl_qual[i,4]  <- outcome_model_schl_eff_read5$coef[2]
  mibeta_schl_qual[i,5]  <- outcome_model_schl_res_read5$coef[2]
  mibeta_schl_qual[i,6]  <- outcome_model_schl_dis_read5$coef[2]
  
  mibeta_schl_qual_x_treatment[i,4]  <- outcome_model_schl_eff_read5$coef[3]
  mibeta_schl_qual_x_treatment[i,5]  <- outcome_model_schl_res_read5$coef[3]
  mibeta_schl_qual_x_treatment[i,6]  <- outcome_model_schl_dis_read5$coef[3]
  
  mibeta_free_lunch[i,4]  <- outcome_model_schl_eff_read5$coef[5]
  mibeta_free_lunch[i,5]  <- outcome_model_schl_res_read5$coef[5]
  mibeta_free_lunch[i,6]  <- outcome_model_schl_dis_read5$coef[5]
  
  mibeta_racial_comp[i,4]  <- outcome_model_schl_eff_read5$coef[6]
  mibeta_racial_comp[i,5]  <- outcome_model_schl_res_read5$coef[6]
  mibeta_racial_comp[i,6]  <- outcome_model_schl_dis_read5$coef[6]
  
  # Appendix B
  mibeta_cde[i,7]  <- (outcome_model_schl_eff_math6$coef[4] + outcome_model_schl_eff_math6$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,8]  <- (outcome_model_schl_res_math6$coef[4] + outcome_model_schl_res_math6$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,9]  <- (outcome_model_schl_dis_math6$coef[4] + outcome_model_schl_dis_math6$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,10] <- (outcome_model_schl_eff_read6$coef[4] + outcome_model_schl_eff_read6$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,11] <- (outcome_model_schl_res_read6$coef[4] + outcome_model_schl_res_read6$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,12] <- (outcome_model_schl_dis_read6$coef[4] + outcome_model_schl_dis_read6$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,13] <- (outcome_model_schl_eff_math7$coef[4] + outcome_model_schl_eff_math7$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,14] <- (outcome_model_schl_res_math7$coef[4] + outcome_model_schl_res_math7$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,15] <- (outcome_model_schl_dis_math7$coef[4] + outcome_model_schl_dis_math7$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,16] <- (outcome_model_schl_eff_read7$coef[4] + outcome_model_schl_eff_read7$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,17] <- (outcome_model_schl_res_read7$coef[4] + outcome_model_schl_res_read7$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,18] <- (outcome_model_schl_dis_read7$coef[4] + outcome_model_schl_dis_read7$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintref[i,7]  <- outcome_model_schl_eff_math6$coef[3] * (schl_eff_math_on_treatment$coef[1] + schl_eff_math_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,8]  <- outcome_model_schl_res_math6$coef[3] * (schl_res_on_treatment$coef[1]      + schl_res_on_treatment$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,9]  <- outcome_model_schl_dis_math6$coef[3] * (schl_dis_on_treatment$coef[1]      + schl_dis_on_treatment$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,10] <- outcome_model_schl_eff_read6$coef[3] * (schl_eff_read_on_treatment$coef[1] + schl_eff_read_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,11] <- outcome_model_schl_res_read6$coef[3] * (schl_res_on_treatment$coef[1]      + schl_res_on_treatment$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,12] <- outcome_model_schl_dis_read6$coef[3] * (schl_dis_on_treatment$coef[1]      + schl_dis_on_treatment$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,13] <- outcome_model_schl_eff_math7$coef[3] * (schl_eff_math_on_treatment$coef[1] + schl_eff_math_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,14] <- outcome_model_schl_res_math7$coef[3] * (schl_res_on_treatment$coef[1]      + schl_res_on_treatment$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,15] <- outcome_model_schl_dis_math7$coef[3] * (schl_dis_on_treatment$coef[1]      + schl_dis_on_treatment$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,16] <- outcome_model_schl_eff_read7$coef[3] * (schl_eff_read_on_treatment$coef[1] + schl_eff_read_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,17] <- outcome_model_schl_res_read7$coef[3] * (schl_res_on_treatment$coef[1]      + schl_res_on_treatment$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,18] <- outcome_model_schl_dis_read7$coef[3] * (schl_dis_on_treatment$coef[1]      + schl_dis_on_treatment$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rnde[i,7]  <- mibeta_cde[i,7]  + mibeta_rintref[i,7]
  mibeta_rnde[i,8]  <- mibeta_cde[i,8]  + mibeta_rintref[i,8]
  mibeta_rnde[i,9]  <- mibeta_cde[i,9]  + mibeta_rintref[i,9]
  mibeta_rnde[i,10] <- mibeta_cde[i,10] + mibeta_rintref[i,10]
  mibeta_rnde[i,11] <- mibeta_cde[i,11] + mibeta_rintref[i,11]
  mibeta_rnde[i,12] <- mibeta_cde[i,12] + mibeta_rintref[i,12]
  mibeta_rnde[i,13] <- mibeta_cde[i,13] + mibeta_rintref[i,13]
  mibeta_rnde[i,14] <- mibeta_cde[i,14] + mibeta_rintref[i,14]
  mibeta_rnde[i,15] <- mibeta_cde[i,15] + mibeta_rintref[i,15]
  mibeta_rnde[i,16] <- mibeta_cde[i,16] + mibeta_rintref[i,16]
  mibeta_rnde[i,17] <- mibeta_cde[i,17] + mibeta_rintref[i,17]
  mibeta_rnde[i,18] <- mibeta_cde[i,18] + mibeta_rintref[i,18]
  
  mibeta_rpie[i,7]  <- (schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math6$coef[2] + schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math6$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,8]  <- (schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math6$coef[2] + schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math6$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,9]  <- (schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math6$coef[2] + schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math6$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,10] <- (schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read6$coef[2] + schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read6$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,11] <- (schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read6$coef[2] + schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read6$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,12] <- (schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read6$coef[2] + schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read6$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,13] <- (schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math7$coef[2] + schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math7$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,14] <- (schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math7$coef[2] + schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math7$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,15] <- (schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math7$coef[2] + schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math7$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,16] <- (schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read7$coef[2] + schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read7$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,17] <- (schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read7$coef[2] + schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read7$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,18] <- (schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read7$coef[2] + schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read7$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintmed[i,7]  <- schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math6$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,8]  <- schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math6$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,9]  <- schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math6$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,10] <- schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read6$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,11] <- schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read6$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,12] <- schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read6$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,13] <- schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math7$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,14] <- schl_res_on_treatment$coef[2]      * outcome_model_schl_res_math7$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,15] <- schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_math7$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,16] <- schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read7$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,17] <- schl_res_on_treatment$coef[2]      * outcome_model_schl_res_read7$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,18] <- schl_dis_on_treatment$coef[2]      * outcome_model_schl_dis_read7$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  
  mibeta_rnie[i,7]  <- mibeta_rpie[i,7]  + mibeta_rintmed[i,7]
  mibeta_rnie[i,8]  <- mibeta_rpie[i,8]  + mibeta_rintmed[i,8]
  mibeta_rnie[i,9]  <- mibeta_rpie[i,9]  + mibeta_rintmed[i,9]
  mibeta_rnie[i,10] <- mibeta_rpie[i,10] + mibeta_rintmed[i,10]
  mibeta_rnie[i,11] <- mibeta_rpie[i,11] + mibeta_rintmed[i,11]
  mibeta_rnie[i,12] <- mibeta_rpie[i,12] + mibeta_rintmed[i,12]
  mibeta_rnie[i,13] <- mibeta_rpie[i,13] + mibeta_rintmed[i,13]
  mibeta_rnie[i,14] <- mibeta_rpie[i,14] + mibeta_rintmed[i,14]
  mibeta_rnie[i,15] <- mibeta_rpie[i,15] + mibeta_rintmed[i,15]
  mibeta_rnie[i,16] <- mibeta_rpie[i,16] + mibeta_rintmed[i,16]
  mibeta_rnie[i,17] <- mibeta_rpie[i,17] + mibeta_rintmed[i,17]
  mibeta_rnie[i,18] <- mibeta_rpie[i,18] + mibeta_rintmed[i,18]
  
  mibeta_rate[i,7]  <- mibeta_rnde[i,7]  + mibeta_rnie[i,7]
  mibeta_rate[i,8]  <- mibeta_rnde[i,8]  + mibeta_rnie[i,8]
  mibeta_rate[i,9]  <- mibeta_rnde[i,9]  + mibeta_rnie[i,9]
  mibeta_rate[i,10] <- mibeta_rnde[i,10] + mibeta_rnie[i,10]
  mibeta_rate[i,11] <- mibeta_rnde[i,11] + mibeta_rnie[i,11]
  mibeta_rate[i,12] <- mibeta_rnde[i,12] + mibeta_rnie[i,12]
  mibeta_rate[i,13] <- mibeta_rnde[i,13] + mibeta_rnie[i,13]
  mibeta_rate[i,14] <- mibeta_rnde[i,14] + mibeta_rnie[i,14]
  mibeta_rate[i,15] <- mibeta_rnde[i,15] + mibeta_rnie[i,15]
  mibeta_rate[i,16] <- mibeta_rnde[i,16] + mibeta_rnie[i,16]
  mibeta_rate[i,17] <- mibeta_rnde[i,17] + mibeta_rnie[i,17]
  mibeta_rate[i,18] <- mibeta_rnde[i,18] + mibeta_rnie[i,18]
  
  mibeta_rnde_dagger[i,7]  <- mibeta_rnde[i,7]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,8]  <- mibeta_rnde[i,8]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_math6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_math6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,9]  <- mibeta_rnde[i,9]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_math6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_math6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,10] <- mibeta_rnde[i,10] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,11] <- mibeta_rnde[i,11] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_read6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_read6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,12] <- mibeta_rnde[i,12] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_read6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_read6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,13] <- mibeta_rnde[i,13] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,14] <- mibeta_rnde[i,14] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_math7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_math7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,15] <- mibeta_rnde[i,15] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_math7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_math7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,16] <- mibeta_rnde[i,16] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,17] <- mibeta_rnde[i,17] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_read7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_read7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,18] <- mibeta_rnde[i,18] - (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_read7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_read7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rnie_dagger[i,7]  <- mibeta_rnie[i,7]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,8]  <- mibeta_rnie[i,8]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_math6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_math6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,9]  <- mibeta_rnie[i,9]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_math6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_math6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,10] <- mibeta_rnie[i,10] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,11] <- mibeta_rnie[i,11] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_read6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_read6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,12] <- mibeta_rnie[i,12] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_read6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_read6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,13] <- mibeta_rnie[i,13] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,14] <- mibeta_rnie[i,14] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_math7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_math7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,15] <- mibeta_rnie[i,15] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_math7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_math7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,16] <- mibeta_rnie[i,16] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,17] <- mibeta_rnie[i,17] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_res_read7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_res_read7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,18] <- mibeta_rnie[i,18] + (free_lunch_on_treatment$coef[2] * outcome_model_schl_dis_read7$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_dis_read7$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  
  # Appendix D
  mibeta_cde[i,19]  <- (outcome_model_schl_eff_math5_p8$coef[4] + outcome_model_schl_eff_math5_p8$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,20]  <- (outcome_model_schl_eff_read5_p8$coef[4] + outcome_model_schl_eff_read5_p8$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,21]  <- (outcome_model_schl_eff_math5_p6$coef[4] + outcome_model_schl_eff_math5_p6$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde[i,22]  <- (outcome_model_schl_eff_read5_p6$coef[4] + outcome_model_schl_eff_read5_p6$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintref[i,19]  <- outcome_model_schl_eff_math5_p8$coef[3] * (schl_eff_math_on_treatment$coef[1] + schl_eff_math_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,20]  <- outcome_model_schl_eff_read5_p8$coef[3] * (schl_eff_read_on_treatment$coef[1] + schl_eff_read_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,21]  <- outcome_model_schl_eff_math5_p6$coef[3] * (schl_eff_math_on_treatment$coef[1] + schl_eff_math_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,22]  <- outcome_model_schl_eff_read5_p6$coef[3] * (schl_eff_read_on_treatment$coef[1] + schl_eff_read_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rnde[i,19]  <- mibeta_cde[i,19]  + mibeta_rintref[i,19]
  mibeta_rnde[i,20]  <- mibeta_cde[i,20]  + mibeta_rintref[i,20]
  mibeta_rnde[i,21]  <- mibeta_cde[i,21]  + mibeta_rintref[i,21]
  mibeta_rnde[i,22]  <- mibeta_cde[i,22]  + mibeta_rintref[i,22]
  
  mibeta_rpie[i,19]  <- (schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5_p8$coef[2] + schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5_p8$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,20]  <- (schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5_p8$coef[2] + schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5_p8$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,21]  <- (schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5_p6$coef[2] + schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5_p6$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,22]  <- (schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5_p6$coef[2] + schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5_p6$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintmed[i,19]  <- schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5_p8$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,20]  <- schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5_p8$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,21]  <- schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5_p6$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed[i,22]  <- schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5_p6$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  
  mibeta_rnie[i,19]  <- mibeta_rpie[i,19]  + mibeta_rintmed[i,19]
  mibeta_rnie[i,20]  <- mibeta_rpie[i,20]  + mibeta_rintmed[i,20]
  mibeta_rnie[i,21]  <- mibeta_rpie[i,21]  + mibeta_rintmed[i,21]
  mibeta_rnie[i,22]  <- mibeta_rpie[i,22]  + mibeta_rintmed[i,22]
  
  mibeta_rate[i,19]  <- mibeta_rnde[i,19]  + mibeta_rnie[i,19]
  mibeta_rate[i,20]  <- mibeta_rnde[i,20]  + mibeta_rnie[i,20]
  mibeta_rate[i,21]  <- mibeta_rnde[i,21]  + mibeta_rnie[i,21]
  mibeta_rate[i,22]  <- mibeta_rnde[i,22]  + mibeta_rnie[i,22]
  
  mibeta_rnde_dagger[i,19]  <- mibeta_rnde[i,19]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math5_p8$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math5_p8$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,20]  <- mibeta_rnde[i,20]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read5_p8$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read5_p8$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,21]  <- mibeta_rnde[i,21]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math5_p6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math5_p6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger[i,22]  <- mibeta_rnde[i,22]  - (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read5_p6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read5_p6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rnie_dagger[i,19]  <- mibeta_rnie[i,19]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math5_p8$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math5_p8$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,20]  <- mibeta_rnie[i,20]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read5_p8$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read5_p8$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,21]  <- mibeta_rnie[i,21]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_math5_p6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_math5_p6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger[i,22]  <- mibeta_rnie[i,22]  + (free_lunch_on_treatment$coef[2] * outcome_model_schl_eff_read5_p6$coef[5] + racial_comp_on_treatment$coef[2] * outcome_model_schl_eff_read5_p6$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  
  # Appendix E
  mibeta_cde_het[i,1]   <- (outcome_model_schl_eff_math5_black$coef[4]    + outcome_model_schl_eff_math5_black$coef[3]    * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,2]   <- (outcome_model_schl_res_math5_black$coef[4]    + outcome_model_schl_res_math5_black$coef[3]    * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,3]   <- (outcome_model_schl_dis_math5_black$coef[4]    + outcome_model_schl_dis_math5_black$coef[3]    * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,4]   <- (outcome_model_schl_eff_read5_black$coef[4]    + outcome_model_schl_eff_read5_black$coef[3]    * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,5]   <- (outcome_model_schl_res_read5_black$coef[4]    + outcome_model_schl_res_read5_black$coef[3]    * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,6]   <- (outcome_model_schl_dis_read5_black$coef[4]    + outcome_model_schl_dis_read5_black$coef[3]    * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,7]   <- (outcome_model_schl_eff_math5_female$coef[4]   + outcome_model_schl_eff_math5_female$coef[3]   * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,8]   <- (outcome_model_schl_res_math5_female$coef[4]   + outcome_model_schl_res_math5_female$coef[3]   * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,9]   <- (outcome_model_schl_dis_math5_female$coef[4]   + outcome_model_schl_dis_math5_female$coef[3]   * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,10]  <- (outcome_model_schl_eff_read5_female$coef[4]   + outcome_model_schl_eff_read5_female$coef[3]   * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,11]  <- (outcome_model_schl_res_read5_female$coef[4]   + outcome_model_schl_res_read5_female$coef[3]   * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,12]  <- (outcome_model_schl_dis_read5_female$coef[4]   + outcome_model_schl_dis_read5_female$coef[3]   * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,13]  <- (outcome_model_schl_eff_math5_some_col$coef[4] + outcome_model_schl_eff_math5_some_col$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,14]  <- (outcome_model_schl_res_math5_some_col$coef[4] + outcome_model_schl_res_math5_some_col$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,15]  <- (outcome_model_schl_dis_math5_some_col$coef[4] + outcome_model_schl_dis_math5_some_col$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,16]  <- (outcome_model_schl_eff_read5_some_col$coef[4] + outcome_model_schl_eff_read5_some_col$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,17]  <- (outcome_model_schl_res_read5_some_col$coef[4] + outcome_model_schl_res_read5_some_col$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,18]  <- (outcome_model_schl_dis_read5_some_col$coef[4] + outcome_model_schl_dis_read5_some_col$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintref_het[i,1]   <- outcome_model_schl_eff_math5_black$coef[3]    * (schl_eff_math_on_treatment_black$coef[1]    + schl_eff_math_on_treatment_black$coef[2]    * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,2]   <- outcome_model_schl_res_math5_black$coef[3]    * (schl_res_on_treatment_black$coef[1]         + schl_res_on_treatment_black$coef[2]         * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,3]   <- outcome_model_schl_dis_math5_black$coef[3]    * (schl_dis_on_treatment_black$coef[1]         + schl_dis_on_treatment_black$coef[2]         * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,4]   <- outcome_model_schl_eff_read5_black$coef[3]    * (schl_eff_read_on_treatment_black$coef[1]    + schl_eff_read_on_treatment_black$coef[2]    * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,5]   <- outcome_model_schl_res_read5_black$coef[3]    * (schl_res_on_treatment_black$coef[1]         + schl_res_on_treatment_black$coef[2]         * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,6]   <- outcome_model_schl_dis_read5_black$coef[3]    * (schl_dis_on_treatment_black$coef[1]         + schl_dis_on_treatment_black$coef[2]         * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,7]   <- outcome_model_schl_eff_math5_female$coef[3]   * (schl_eff_math_on_treatment_female$coef[1]   + schl_eff_math_on_treatment_female$coef[2]   * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,8]   <- outcome_model_schl_res_math5_female$coef[3]   * (schl_res_on_treatment_female$coef[1]        + schl_res_on_treatment_female$coef[2]        * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,9]   <- outcome_model_schl_dis_math5_female$coef[3]   * (schl_dis_on_treatment_female$coef[1]        + schl_dis_on_treatment_female$coef[2]        * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,10]  <- outcome_model_schl_eff_read5_female$coef[3]   * (schl_eff_read_on_treatment_female$coef[1]   + schl_eff_read_on_treatment_female$coef[2]   * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,11]  <- outcome_model_schl_res_read5_female$coef[3]   * (schl_res_on_treatment_female$coef[1]        + schl_res_on_treatment_female$coef[2]        * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,12]  <- outcome_model_schl_dis_read5_female$coef[3]   * (schl_dis_on_treatment_female$coef[1]        + schl_dis_on_treatment_female$coef[2]        * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,13]  <- outcome_model_schl_eff_math5_some_col$coef[3] * (schl_eff_math_on_treatment_some_col$coef[1] + schl_eff_math_on_treatment_some_col$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,14]  <- outcome_model_schl_res_math5_some_col$coef[3] * (schl_res_on_treatment_some_col$coef[1]      + schl_res_on_treatment_some_col$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,15]  <- outcome_model_schl_dis_math5_some_col$coef[3] * (schl_dis_on_treatment_some_col$coef[1]      + schl_dis_on_treatment_some_col$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,16]  <- outcome_model_schl_eff_read5_some_col$coef[3] * (schl_eff_read_on_treatment_some_col$coef[1] + schl_eff_read_on_treatment_some_col$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,17]  <- outcome_model_schl_res_read5_some_col$coef[3] * (schl_res_on_treatment_some_col$coef[1]      + schl_res_on_treatment_some_col$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,18]  <- outcome_model_schl_dis_read5_some_col$coef[3] * (schl_dis_on_treatment_some_col$coef[1]      + schl_dis_on_treatment_some_col$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rnde_het[i,1]   <- mibeta_cde_het[i,1]   + mibeta_rintref_het[i,1]
  mibeta_rnde_het[i,2]   <- mibeta_cde_het[i,2]   + mibeta_rintref_het[i,2]
  mibeta_rnde_het[i,3]   <- mibeta_cde_het[i,3]   + mibeta_rintref_het[i,3]
  mibeta_rnde_het[i,4]   <- mibeta_cde_het[i,4]   + mibeta_rintref_het[i,4]
  mibeta_rnde_het[i,5]   <- mibeta_cde_het[i,5]   + mibeta_rintref_het[i,5]
  mibeta_rnde_het[i,6]   <- mibeta_cde_het[i,6]   + mibeta_rintref_het[i,6]
  mibeta_rnde_het[i,7]   <- mibeta_cde_het[i,7]   + mibeta_rintref_het[i,7]
  mibeta_rnde_het[i,8]   <- mibeta_cde_het[i,8]   + mibeta_rintref_het[i,8]
  mibeta_rnde_het[i,9]   <- mibeta_cde_het[i,9]   + mibeta_rintref_het[i,9]
  mibeta_rnde_het[i,10]  <- mibeta_cde_het[i,10]  + mibeta_rintref_het[i,10]
  mibeta_rnde_het[i,11]  <- mibeta_cde_het[i,11]  + mibeta_rintref_het[i,11]
  mibeta_rnde_het[i,12]  <- mibeta_cde_het[i,12]  + mibeta_rintref_het[i,12]
  mibeta_rnde_het[i,13]  <- mibeta_cde_het[i,13]  + mibeta_rintref_het[i,13]
  mibeta_rnde_het[i,14]  <- mibeta_cde_het[i,14]  + mibeta_rintref_het[i,14]
  mibeta_rnde_het[i,15]  <- mibeta_cde_het[i,15]  + mibeta_rintref_het[i,15]
  mibeta_rnde_het[i,16]  <- mibeta_cde_het[i,16]  + mibeta_rintref_het[i,16]
  mibeta_rnde_het[i,17]  <- mibeta_cde_het[i,17]  + mibeta_rintref_het[i,17]
  mibeta_rnde_het[i,18]  <- mibeta_cde_het[i,18]  + mibeta_rintref_het[i,18]
  
  mibeta_rpie_het[i,1]   <- (schl_eff_math_on_treatment_black$coef[2]    * outcome_model_schl_eff_math5_black$coef[2]    + schl_eff_math_on_treatment_black$coef[2]    * outcome_model_schl_eff_math5_black$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,2]   <- (schl_res_on_treatment_black$coef[2]         * outcome_model_schl_res_math5_black$coef[2]    + schl_res_on_treatment_black$coef[2]         * outcome_model_schl_res_math5_black$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,3]   <- (schl_dis_on_treatment_black$coef[2]         * outcome_model_schl_dis_math5_black$coef[2]    + schl_dis_on_treatment_black$coef[2]         * outcome_model_schl_dis_math5_black$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,4]   <- (schl_eff_read_on_treatment_black$coef[2]    * outcome_model_schl_eff_read5_black$coef[2]    + schl_eff_read_on_treatment_black$coef[2]    * outcome_model_schl_eff_read5_black$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,5]   <- (schl_res_on_treatment_black$coef[2]         * outcome_model_schl_res_read5_black$coef[2]    + schl_res_on_treatment_black$coef[2]         * outcome_model_schl_res_read5_black$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,6]   <- (schl_dis_on_treatment_black$coef[2]         * outcome_model_schl_dis_read5_black$coef[2]    + schl_dis_on_treatment_black$coef[2]         * outcome_model_schl_dis_read5_black$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,7]   <- (schl_eff_math_on_treatment_female$coef[2]   * outcome_model_schl_eff_math5_female$coef[2]   + schl_eff_math_on_treatment_female$coef[2]   * outcome_model_schl_eff_math5_female$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,8]   <- (schl_res_on_treatment_female$coef[2]        * outcome_model_schl_res_math5_female$coef[2]   + schl_res_on_treatment_female$coef[2]        * outcome_model_schl_res_math5_female$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,9]   <- (schl_dis_on_treatment_female$coef[2]        * outcome_model_schl_dis_math5_female$coef[2]   + schl_dis_on_treatment_female$coef[2]        * outcome_model_schl_dis_math5_female$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,10]  <- (schl_eff_read_on_treatment_female$coef[2]   * outcome_model_schl_eff_read5_female$coef[2]   + schl_eff_read_on_treatment_female$coef[2]   * outcome_model_schl_eff_read5_female$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,11]  <- (schl_res_on_treatment_female$coef[2]        * outcome_model_schl_res_read5_female$coef[2]   + schl_res_on_treatment_female$coef[2]        * outcome_model_schl_res_read5_female$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,12]  <- (schl_dis_on_treatment_female$coef[2]        * outcome_model_schl_dis_read5_female$coef[2]   + schl_dis_on_treatment_female$coef[2]        * outcome_model_schl_dis_read5_female$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,13]  <- (schl_eff_math_on_treatment_some_col$coef[2] * outcome_model_schl_eff_math5_some_col$coef[2] + schl_eff_math_on_treatment_some_col$coef[2] * outcome_model_schl_eff_math5_some_col$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,14]  <- (schl_res_on_treatment_some_col$coef[2]      * outcome_model_schl_res_math5_some_col$coef[2] + schl_res_on_treatment_some_col$coef[2]      * outcome_model_schl_res_math5_some_col$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,15]  <- (schl_dis_on_treatment_some_col$coef[2]      * outcome_model_schl_dis_math5_some_col$coef[2] + schl_dis_on_treatment_some_col$coef[2]      * outcome_model_schl_dis_math5_some_col$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,16]  <- (schl_eff_read_on_treatment_some_col$coef[2] * outcome_model_schl_eff_read5_some_col$coef[2] + schl_eff_read_on_treatment_some_col$coef[2] * outcome_model_schl_eff_read5_some_col$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,17]  <- (schl_res_on_treatment_some_col$coef[2]      * outcome_model_schl_res_read5_some_col$coef[2] + schl_res_on_treatment_some_col$coef[2]      * outcome_model_schl_res_read5_some_col$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,18]  <- (schl_dis_on_treatment_some_col$coef[2]      * outcome_model_schl_dis_read5_some_col$coef[2] + schl_dis_on_treatment_some_col$coef[2]      * outcome_model_schl_dis_read5_some_col$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintmed_het[i,1]   <- schl_eff_math_on_treatment_black$coef[2]    * outcome_model_schl_eff_math5_black$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,2]   <- schl_res_on_treatment_black$coef[2]         * outcome_model_schl_res_math5_black$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,3]   <- schl_dis_on_treatment_black$coef[2]         * outcome_model_schl_dis_math5_black$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,4]   <- schl_eff_read_on_treatment_black$coef[2]    * outcome_model_schl_eff_read5_black$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,5]   <- schl_res_on_treatment_black$coef[2]         * outcome_model_schl_res_read5_black$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,6]   <- schl_dis_on_treatment_black$coef[2]         * outcome_model_schl_dis_read5_black$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,7]   <- schl_eff_math_on_treatment_female$coef[2]   * outcome_model_schl_eff_math5_female$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,8]   <- schl_res_on_treatment_female$coef[2]        * outcome_model_schl_res_math5_female$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,9]   <- schl_dis_on_treatment_female$coef[2]        * outcome_model_schl_dis_math5_female$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,10]  <- schl_eff_read_on_treatment_female$coef[2]   * outcome_model_schl_eff_read5_female$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,11]  <- schl_res_on_treatment_female$coef[2]        * outcome_model_schl_res_read5_female$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,12]  <- schl_dis_on_treatment_female$coef[2]        * outcome_model_schl_dis_read5_female$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,13]  <- schl_eff_math_on_treatment_some_col$coef[2] * outcome_model_schl_eff_math5_some_col$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,14]  <- schl_res_on_treatment_some_col$coef[2]      * outcome_model_schl_res_math5_some_col$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,15]  <- schl_dis_on_treatment_some_col$coef[2]      * outcome_model_schl_dis_math5_some_col$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,16]  <- schl_eff_read_on_treatment_some_col$coef[2] * outcome_model_schl_eff_read5_some_col$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,17]  <- schl_res_on_treatment_some_col$coef[2]      * outcome_model_schl_res_read5_some_col$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,18]  <- schl_dis_on_treatment_some_col$coef[2]      * outcome_model_schl_dis_read5_some_col$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  
  mibeta_rnie_het[i,1]   <- mibeta_rpie_het[i,1]   + mibeta_rintmed_het[i,1]
  mibeta_rnie_het[i,2]   <- mibeta_rpie_het[i,2]   + mibeta_rintmed_het[i,2]
  mibeta_rnie_het[i,3]   <- mibeta_rpie_het[i,3]   + mibeta_rintmed_het[i,3]
  mibeta_rnie_het[i,4]   <- mibeta_rpie_het[i,4]   + mibeta_rintmed_het[i,4]
  mibeta_rnie_het[i,5]   <- mibeta_rpie_het[i,5]   + mibeta_rintmed_het[i,5]
  mibeta_rnie_het[i,6]   <- mibeta_rpie_het[i,6]   + mibeta_rintmed_het[i,6]
  mibeta_rnie_het[i,7]   <- mibeta_rpie_het[i,7]   + mibeta_rintmed_het[i,7]
  mibeta_rnie_het[i,8]   <- mibeta_rpie_het[i,8]   + mibeta_rintmed_het[i,8]
  mibeta_rnie_het[i,9]   <- mibeta_rpie_het[i,9]   + mibeta_rintmed_het[i,9]
  mibeta_rnie_het[i,10]  <- mibeta_rpie_het[i,10]  + mibeta_rintmed_het[i,10]
  mibeta_rnie_het[i,11]  <- mibeta_rpie_het[i,11]  + mibeta_rintmed_het[i,11]
  mibeta_rnie_het[i,12]  <- mibeta_rpie_het[i,12]  + mibeta_rintmed_het[i,12]
  mibeta_rnie_het[i,13]  <- mibeta_rpie_het[i,13]  + mibeta_rintmed_het[i,13]
  mibeta_rnie_het[i,14]  <- mibeta_rpie_het[i,14]  + mibeta_rintmed_het[i,14]
  mibeta_rnie_het[i,15]  <- mibeta_rpie_het[i,15]  + mibeta_rintmed_het[i,15]
  mibeta_rnie_het[i,16]  <- mibeta_rpie_het[i,16]  + mibeta_rintmed_het[i,16]
  mibeta_rnie_het[i,17]  <- mibeta_rpie_het[i,17]  + mibeta_rintmed_het[i,17]
  mibeta_rnie_het[i,18]  <- mibeta_rpie_het[i,18]  + mibeta_rintmed_het[i,18]
  
  mibeta_rate_het[i,1]   <- mibeta_rnde_het[i,1]   + mibeta_rnie_het[i,1]
  mibeta_rate_het[i,2]   <- mibeta_rnde_het[i,2]   + mibeta_rnie_het[i,2]
  mibeta_rate_het[i,3]   <- mibeta_rnde_het[i,3]   + mibeta_rnie_het[i,3]
  mibeta_rate_het[i,4]   <- mibeta_rnde_het[i,4]   + mibeta_rnie_het[i,4]
  mibeta_rate_het[i,5]   <- mibeta_rnde_het[i,5]   + mibeta_rnie_het[i,5]
  mibeta_rate_het[i,6]   <- mibeta_rnde_het[i,6]   + mibeta_rnie_het[i,6]
  mibeta_rate_het[i,7]   <- mibeta_rnde_het[i,7]   + mibeta_rnie_het[i,7]
  mibeta_rate_het[i,8]   <- mibeta_rnde_het[i,8]   + mibeta_rnie_het[i,8]
  mibeta_rate_het[i,9]   <- mibeta_rnde_het[i,9]   + mibeta_rnie_het[i,9]
  mibeta_rate_het[i,10]  <- mibeta_rnde_het[i,10]  + mibeta_rnie_het[i,10]
  mibeta_rate_het[i,11]  <- mibeta_rnde_het[i,11]  + mibeta_rnie_het[i,11]
  mibeta_rate_het[i,12]  <- mibeta_rnde_het[i,12]  + mibeta_rnie_het[i,12]
  mibeta_rate_het[i,13]  <- mibeta_rnde_het[i,13]  + mibeta_rnie_het[i,13]
  mibeta_rate_het[i,14]  <- mibeta_rnde_het[i,14]  + mibeta_rnie_het[i,14]
  mibeta_rate_het[i,15]  <- mibeta_rnde_het[i,15]  + mibeta_rnie_het[i,15]
  mibeta_rate_het[i,16]  <- mibeta_rnde_het[i,16]  + mibeta_rnie_het[i,16]
  mibeta_rate_het[i,17]  <- mibeta_rnde_het[i,17]  + mibeta_rnie_het[i,17]
  mibeta_rate_het[i,18]  <- mibeta_rnde_het[i,18]  + mibeta_rnie_het[i,18]
  
  mibeta_rnde_dagger_het[i,1]   <- mibeta_rnde_het[i,1]   - (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_eff_math5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_eff_math5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,2]   <- mibeta_rnde_het[i,2]   - (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_res_math5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_res_math5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,3]   <- mibeta_rnde_het[i,3]   - (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_dis_math5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_dis_math5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,4]   <- mibeta_rnde_het[i,4]   - (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_eff_read5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_eff_read5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,5]   <- mibeta_rnde_het[i,5]   - (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_res_read5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_res_read5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,6]   <- mibeta_rnde_het[i,6]   - (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_dis_read5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_dis_read5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,7]   <- mibeta_rnde_het[i,7]   - (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_eff_math5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_eff_math5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,8]   <- mibeta_rnde_het[i,8]   - (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_res_math5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_res_math5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,9]   <- mibeta_rnde_het[i,9]   - (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_dis_math5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_dis_math5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,10]  <- mibeta_rnde_het[i,10]  - (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_eff_read5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_eff_read5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,11]  <- mibeta_rnde_het[i,11]  - (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_res_read5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_res_read5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,12]  <- mibeta_rnde_het[i,12]  - (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_dis_read5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_dis_read5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,13]  <- mibeta_rnde_het[i,13]  - (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_eff_math5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_eff_math5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,14]  <- mibeta_rnde_het[i,14]  - (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_res_math5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_res_math5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,15]  <- mibeta_rnde_het[i,15]  - (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_dis_math5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_dis_math5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,16]  <- mibeta_rnde_het[i,16]  - (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_eff_read5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_eff_read5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,17]  <- mibeta_rnde_het[i,17]  - (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_res_read5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_res_read5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnde_dagger_het[i,18]  <- mibeta_rnde_het[i,18]  - (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_dis_read5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_dis_read5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rnie_dagger_het[i,1]   <- mibeta_rnie_het[i,1]   + (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_eff_math5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_eff_math5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,2]   <- mibeta_rnie_het[i,2]   + (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_res_math5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_res_math5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,3]   <- mibeta_rnie_het[i,3]   + (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_dis_math5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_dis_math5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,4]   <- mibeta_rnie_het[i,4]   + (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_eff_read5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_eff_read5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,5]   <- mibeta_rnie_het[i,5]   + (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_res_read5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_res_read5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,6]   <- mibeta_rnie_het[i,6]   + (free_lunch_on_treatment_black$coef[2]    * outcome_model_schl_dis_read5_black$coef[5]    + racial_comp_on_treatment_black$coef[2]    * outcome_model_schl_dis_read5_black$coef[6])    * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,7]   <- mibeta_rnie_het[i,7]   + (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_eff_math5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_eff_math5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,8]   <- mibeta_rnie_het[i,8]   + (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_res_math5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_res_math5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,9]   <- mibeta_rnie_het[i,9]   + (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_dis_math5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_dis_math5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,10]  <- mibeta_rnie_het[i,10]  + (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_eff_read5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_eff_read5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,11]  <- mibeta_rnie_het[i,11]  + (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_res_read5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_res_read5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,12]  <- mibeta_rnie_het[i,12]  + (free_lunch_on_treatment_female$coef[2]   * outcome_model_schl_dis_read5_female$coef[5]   + racial_comp_on_treatment_female$coef[2]   * outcome_model_schl_dis_read5_female$coef[6])   * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,13]  <- mibeta_rnie_het[i,13]  + (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_eff_math5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_eff_math5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,14]  <- mibeta_rnie_het[i,14]  + (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_res_math5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_res_math5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,15]  <- mibeta_rnie_het[i,15]  + (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_dis_math5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_dis_math5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,16]  <- mibeta_rnie_het[i,16]  + (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_eff_read5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_eff_read5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,17]  <- mibeta_rnie_het[i,17]  + (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_res_read5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_res_read5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rnie_dagger_het[i,18]  <- mibeta_rnie_het[i,18]  + (free_lunch_on_treatment_some_col$coef[2] * outcome_model_schl_dis_read5_some_col$coef[5] + racial_comp_on_treatment_some_col$coef[2] * outcome_model_schl_dis_read5_some_col$coef[6]) * (pc_treatment[2] - pc_treatment[1])
  
  # Additional models
  mibeta_additional[i,1] <- outcome_model_schl_res_math5_add$coef[7]
  mibeta_additional[i,2] <- outcome_model_schl_res_read5_add$coef[7]
  mibeta_additional[i,3] <- outcome_model_schl_dis_math5_add$coef[4]
  mibeta_additional[i,4] <- outcome_model_schl_dis_read5_add$coef[4]
  mibeta_additional[i,5] <- outcome_model_schl_eff_math5_add$coef[3]
  mibeta_additional[i,6] <- outcome_model_schl_eff_read5_add$coef[3]
  
  
  
  # Compute block bootstrap SEs
  
  set.seed(123)
  
  bootdist_rate <- matrix(data = NA, nrow = nboot, ncol = 22)
  
  bootdist_rnde    <- matrix(data = NA, nrow = nboot, ncol = 22)
  bootdist_cde     <- matrix(data = NA, nrow = nboot, ncol = 22)
  bootdist_rintref <- matrix(data = NA, nrow = nboot, ncol = 22)
  
  bootdist_rnie    <- matrix(data = NA, nrow = nboot, ncol = 22)
  bootdist_rpie    <- matrix(data = NA, nrow = nboot, ncol = 22)
  bootdist_rintmed <- matrix(data = NA, nrow = nboot, ncol = 22)
  
  bootdist_rnde_dagger <- matrix(data = NA, nrow = nboot, ncol = 22)
  bootdist_rnie_dagger <- matrix(data = NA, nrow = nboot, ncol = 22)
  
  bootdist_mediator_on_treatment <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  bootdist_treatment             <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_schl_qual             <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_schl_qual_x_treatment <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_free_lunch            <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_racial_comp           <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  bootdist_rate_het <- matrix(data = NA, nrow = nboot, ncol = 18)
  
  bootdist_rnde_het    <- matrix(data = NA, nrow = nboot, ncol = 18)
  bootdist_cde_het     <- matrix(data = NA, nrow = nboot, ncol = 18)
  bootdist_rintref_het <- matrix(data = NA, nrow = nboot, ncol = 18)
  
  bootdist_rnie_het    <- matrix(data = NA, nrow = nboot, ncol = 18)
  bootdist_rpie_het    <- matrix(data = NA, nrow = nboot, ncol = 18)
  bootdist_rintmed_het <- matrix(data = NA, nrow = nboot, ncol = 18)
  
  bootdist_rnde_dagger_het <- matrix(data = NA, nrow = nboot, ncol = 18)
  bootdist_rnie_dagger_het <- matrix(data = NA, nrow = nboot, ncol = 18)
  
  bootdist_additional <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  for (j in 1:nboot) {
    
    idboot.1 <- sample(unique(analytic_sample$S3_ID), replace=T)
    idboot.2 <- table(idboot.1)
    
    analytic_sample.boot <- NULL
    
    for (k in 1:max(idboot.2)) {
      
      boot.data <- analytic_sample[analytic_sample$S3_ID %in% names(idboot.2[idboot.2 %in% k]), ]
      
      for (l in 1:k) {
        
        analytic_sample.boot <- rbind(analytic_sample.boot, boot.data)
        
      }
      
    }
    
    # Fit Model 1: Mediator on treatment
    schl_eff_math_on_treatment.boot <- lm(re_impact_math ~ 
                                            trct_disadv_index2 + 
                                            c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                            mmarriedbirth + childweightlow + female +
                                            black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                            d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                            m_less_than_thirty_five_hrs_pw + m_emp_other +
                                            c1r4mtht_r_mean,
                                          data = analytic_sample.boot)
    
    schl_eff_read_on_treatment.boot <- lm(re_impact_read ~ 
                                            trct_disadv_index2 + 
                                            c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                            mmarriedbirth + childweightlow + female +
                                            black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                            d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                            m_less_than_thirty_five_hrs_pw + m_emp_other +
                                            c1r4rtht_r_mean,
                                          data = analytic_sample.boot)
    
    schl_res_on_treatment.boot <- lm(school_resources ~ 
                                       trct_disadv_index2 + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other +
                                       c1r4rtht_r_mean,
                                     data = analytic_sample.boot)
    
    schl_dis_on_treatment.boot <- lm(school_disorder ~ 
                                       trct_disadv_index2 + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other +
                                       c1r4rtht_r_mean,
                                     data = analytic_sample.boot)
    
    free_lunch_on_treatment.boot <- lm(nschlnch99_percent ~ 
                                         trct_disadv_index2 + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other +
                                         c1r4rtht_r_mean,
                                       data = analytic_sample.boot)
    
    racial_comp_on_treatment.boot <- lm(S4NONWHTPCT ~ 
                                          trct_disadv_index2 + 
                                          c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                          mmarriedbirth + childweightlow + female +
                                          black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                          high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                          d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                          m_less_than_thirty_five_hrs_pw + m_emp_other +
                                          c1r4rtht_r_mean,
                                        data = analytic_sample.boot)
    
    # RWR calculations for percent free lunch eligible
    analytic_sample.boot$nschlnch99_percent_r <- NA
    analytic_sample.boot$nschlnch99_percent_r <- residuals(free_lunch_on_treatment.boot)
    
    # RWR calculations for S4NONWHTPCT
    analytic_sample.boot$S4NONWHTPCT_r <- NA
    analytic_sample.boot$S4NONWHTPCT_r <- residuals(racial_comp_on_treatment.boot)
    
    
    
    # Model 1, Appendix E
    
    # Black
    schl_eff_math_on_treatment_black.boot <- lm(re_impact_math ~ 
                                                  trct_disadv_index2 + 
                                                  c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                  black_treat +
                                                  c1r4mtht_r_mean,
                                                data = analytic_sample.boot)
    
    schl_eff_read_on_treatment_black.boot <- lm(re_impact_read ~ 
                                                  trct_disadv_index2 + 
                                                  c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                  black_treat +
                                                  c1r4rtht_r_mean,
                                                data = analytic_sample.boot)
    
    schl_res_on_treatment_black.boot <- lm(school_resources ~ 
                                             trct_disadv_index2 + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other +
                                             black_treat +
                                             c1r4rtht_r_mean,
                                           data = analytic_sample.boot)
    
    schl_dis_on_treatment_black.boot <- lm(school_disorder ~ 
                                             trct_disadv_index2 + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other +
                                             black_treat +
                                             c1r4rtht_r_mean,
                                           data = analytic_sample.boot)
    
    free_lunch_on_treatment_black.boot <- lm(nschlnch99_percent ~ 
                                               trct_disadv_index2 + 
                                               c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                               mmarriedbirth + childweightlow + female +
                                               black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                               high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                               d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                               m_less_than_thirty_five_hrs_pw + m_emp_other +
                                               black_treat +
                                               c1r4rtht_r_mean,
                                             data = analytic_sample.boot)
    
    racial_comp_on_treatment_black.boot <- lm(S4NONWHTPCT ~ 
                                                trct_disadv_index2 + 
                                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                black_treat +
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot)
    
    # Female
    schl_eff_math_on_treatment_female.boot <- lm(re_impact_math ~ 
                                                   trct_disadv_index2 + 
                                                   c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                   mmarriedbirth + childweightlow + female +
                                                   black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                   high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                   d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                   m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                   female_treat +
                                                   c1r4mtht_r_mean,
                                                 data = analytic_sample.boot)
    
    schl_eff_read_on_treatment_female.boot <- lm(re_impact_read ~ 
                                                   trct_disadv_index2 + 
                                                   c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                   mmarriedbirth + childweightlow + female +
                                                   black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                   high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                   d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                   m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                   female_treat +
                                                   c1r4rtht_r_mean,
                                                 data = analytic_sample.boot)
    
    schl_res_on_treatment_female.boot <- lm(school_resources ~ 
                                              trct_disadv_index2 + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other +
                                              female_treat +
                                              c1r4rtht_r_mean,
                                            data = analytic_sample.boot)
    
    schl_dis_on_treatment_female.boot <- lm(school_disorder ~ 
                                              trct_disadv_index2 + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other +
                                              female_treat +
                                              c1r4rtht_r_mean,
                                            data = analytic_sample.boot)
    
    free_lunch_on_treatment_female.boot <- lm(nschlnch99_percent ~ 
                                                trct_disadv_index2 + 
                                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                female_treat +
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot)
    
    racial_comp_on_treatment_female.boot <- lm(S4NONWHTPCT ~ 
                                                 trct_disadv_index2 + 
                                                 c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                 mmarriedbirth + childweightlow + female +
                                                 black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                 high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                 d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                 m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                 female_treat +
                                                 c1r4rtht_r_mean,
                                               data = analytic_sample.boot)
    
    # At least some college
    schl_eff_math_on_treatment_some_col.boot <- lm(re_impact_math ~ 
                                                     trct_disadv_index2 + 
                                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                     mmarriedbirth + childweightlow + female +
                                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                     at_least_some_col_treat +
                                                     c1r4mtht_r_mean,
                                                   data = analytic_sample.boot)
    
    schl_eff_read_on_treatment_some_col.boot <- lm(re_impact_read ~ 
                                                     trct_disadv_index2 + 
                                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                     mmarriedbirth + childweightlow + female +
                                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                     at_least_some_col_treat +
                                                     c1r4rtht_r_mean,
                                                   data = analytic_sample.boot)
    
    schl_res_on_treatment_some_col.boot <- lm(school_resources ~ 
                                                trct_disadv_index2 + 
                                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                at_least_some_col_treat +
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot)
    
    schl_dis_on_treatment_some_col.boot <- lm(school_disorder ~ 
                                                trct_disadv_index2 + 
                                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                at_least_some_col_treat +
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot)
    
    free_lunch_on_treatment_some_col.boot <- lm(nschlnch99_percent ~ 
                                                  trct_disadv_index2 + 
                                                  c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                  at_least_some_col_treat +
                                                  c1r4rtht_r_mean,
                                                data = analytic_sample.boot)
    
    racial_comp_on_treatment_some_col.boot <- lm(S4NONWHTPCT ~ 
                                                   trct_disadv_index2 + 
                                                   c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                   mmarriedbirth + childweightlow + female +
                                                   black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                   high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                   d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                   m_less_than_thirty_five_hrs_pw + m_emp_other +
                                                   at_least_some_col_treat +
                                                   c1r4rtht_r_mean,
                                                 data = analytic_sample.boot)
    
    # RWR calculations, Appendix E
    analytic_sample.boot$nschlnch99_percent_r_black    <- NA
    analytic_sample.boot$nschlnch99_percent_r_female   <- NA
    analytic_sample.boot$nschlnch99_percent_r_some_col <- NA
    analytic_sample.boot$nschlnch99_percent_r_black    <- residuals(free_lunch_on_treatment_black.boot)
    analytic_sample.boot$nschlnch99_percent_r_female   <- residuals(free_lunch_on_treatment_female.boot)
    analytic_sample.boot$nschlnch99_percent_r_some_col <- residuals(free_lunch_on_treatment_some_col.boot)
    
    analytic_sample.boot$S4NONWHTPCT_r_black    <- NA
    analytic_sample.boot$S4NONWHTPCT_r_female   <- NA
    analytic_sample.boot$S4NONWHTPCT_r_some_col <- NA
    analytic_sample.boot$S4NONWHTPCT_r_black    <- residuals(racial_comp_on_treatment_black.boot)
    analytic_sample.boot$S4NONWHTPCT_r_female   <- residuals(racial_comp_on_treatment_female.boot)
    analytic_sample.boot$S4NONWHTPCT_r_some_col <- residuals(racial_comp_on_treatment_some_col.boot)
    
    
    
    # Add variables for mediator-by-treatment interaction
    analytic_sample.boot$math_impact_x_treatment_re <- analytic_sample.boot$re_impact_math * analytic_sample.boot$trct_disadv_index2
    analytic_sample.boot$read_impact_x_treatment_re <- analytic_sample.boot$re_impact_read * analytic_sample.boot$trct_disadv_index2
 
    analytic_sample.boot$school_resources_x_treatment <- analytic_sample.boot$school_resources * analytic_sample.boot$trct_disadv_index2
    analytic_sample.boot$school_disorder_x_treatment  <- analytic_sample.boot$school_disorder  * analytic_sample.boot$trct_disadv_index2
    
    
    
    # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
    
    outcome_model_schl_eff_math5.boot <- eivreg(c5r4mtht_r ~ 
                                             re_impact_math + 
                                             math_impact_x_treatment_re +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r + 
                                             S4NONWHTPCT_r + 
                                             c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             c1r4mtht_r_mean,
                                           data = analytic_sample.boot,
                                           reliability = reliability_vector_math_re_list[[2]])
    
    outcome_model_schl_res_math5.boot <- lm(c5r4mtht_r ~ 
                                         school_resources + 
                                         school_resources_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4mtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_dis_math5.boot <- lm(c5r4mtht_r ~ 
                                         school_disorder + 
                                         school_disorder_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4mtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_eff_read5.boot <- eivreg(c5r4rtht_r ~ 
                                             re_impact_read + 
                                             read_impact_x_treatment_re +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r + 
                                             S4NONWHTPCT_r + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             c1r4rtht_r_mean,
                                           data = analytic_sample.boot,
                                           reliability = reliability_vector_read_re_list[[2]])
    
    outcome_model_schl_res_read5.boot <- lm(c5r4rtht_r ~ 
                                         school_resources + 
                                         school_resources_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4rtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_dis_read5.boot <- lm(c5r4rtht_r ~ 
                                         school_disorder + 
                                         school_disorder_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4rtht_r_mean,
                                       data = analytic_sample.boot)
    
    # Appendix B
    outcome_model_schl_eff_math6.boot <- eivreg(c6r4mtht_r ~ 
                                             re_impact_math + 
                                             math_impact_x_treatment_re +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r + 
                                             S4NONWHTPCT_r + 
                                             c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             c1r4mtht_r_mean,
                                           data = analytic_sample.boot,
                                           reliability = reliability_vector_math_re_list[[2]])
    
    outcome_model_schl_res_math6.boot <- lm(c6r4mtht_r ~ 
                                         school_resources + 
                                         school_resources_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4mtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_dis_math6.boot <- lm(c6r4mtht_r ~ 
                                         school_disorder + 
                                         school_disorder_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4mtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_eff_read6.boot <- eivreg(c6r4rtht_r ~ 
                                             re_impact_read + 
                                             read_impact_x_treatment_re +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r + 
                                             S4NONWHTPCT_r + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             c1r4rtht_r_mean,
                                           data = analytic_sample.boot,
                                           reliability = reliability_vector_read_re_list[[2]])
    
    outcome_model_schl_res_read6.boot <- lm(c6r4rtht_r ~ 
                                         school_resources + 
                                         school_resources_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4rtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_dis_read6.boot <- lm(c6r4rtht_r ~ 
                                         school_disorder + 
                                         school_disorder_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4rtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_eff_math7.boot <- eivreg(c7r4mtht_r ~ 
                                             re_impact_math + 
                                             math_impact_x_treatment_re +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r + 
                                             S4NONWHTPCT_r + 
                                             c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             c1r4mtht_r_mean,
                                           data = analytic_sample.boot,
                                           reliability = reliability_vector_math_re_list[[2]])
    
    outcome_model_schl_res_math7.boot <- lm(c7r4mtht_r ~ 
                                         school_resources + 
                                         school_resources_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4mtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_dis_math7.boot <- lm(c7r4mtht_r ~ 
                                         school_disorder + 
                                         school_disorder_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4mtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_eff_read7.boot <- eivreg(c7r4rtht_r ~ 
                                             re_impact_read + 
                                             read_impact_x_treatment_re +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r + 
                                             S4NONWHTPCT_r + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             c1r4rtht_r_mean,
                                           data = analytic_sample.boot,
                                           reliability = reliability_vector_read_re_list[[2]])
    
    outcome_model_schl_res_read7.boot <- lm(c7r4rtht_r ~ 
                                         school_resources + 
                                         school_resources_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4rtht_r_mean,
                                       data = analytic_sample.boot)
    
    outcome_model_schl_dis_read7.boot <- lm(c7r4rtht_r ~ 
                                         school_disorder + 
                                         school_disorder_x_treatment +
                                         trct_disadv_index2 + 
                                         nschlnch99_percent_r + 
                                         S4NONWHTPCT_r + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                         c1r4rtht_r_mean,
                                       data = analytic_sample.boot)
    
    # Appendix D
    outcome_model_schl_eff_math5_p8.boot <- eivreg(c5r4mtht_r ~ 
                                                re_impact_math + 
                                                math_impact_x_treatment_re +
                                                trct_disadv_index2 + 
                                                nschlnch99_percent_r + 
                                                S4NONWHTPCT_r + 
                                                c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                c1r4mtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_math_re_list[[1]])
    
    outcome_model_schl_eff_read5_p8.boot <- eivreg(c5r4rtht_r ~ 
                                                re_impact_read + 
                                                read_impact_x_treatment_re +
                                                trct_disadv_index2 + 
                                                nschlnch99_percent_r + 
                                                S4NONWHTPCT_r + 
                                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_read_re_list[[1]])
    
    outcome_model_schl_eff_math5_p6.boot <- eivreg(c5r4mtht_r ~ 
                                                re_impact_math + 
                                                math_impact_x_treatment_re +
                                                trct_disadv_index2 + 
                                                nschlnch99_percent_r + 
                                                S4NONWHTPCT_r + 
                                                c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                c1r4mtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_math_re_list[[3]])
    
    outcome_model_schl_eff_read5_p6.boot <- eivreg(c5r4rtht_r ~ 
                                                re_impact_read + 
                                                read_impact_x_treatment_re +
                                                trct_disadv_index2 + 
                                                nschlnch99_percent_r + 
                                                S4NONWHTPCT_r + 
                                                c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                mmarriedbirth + childweightlow + female +
                                                black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_read_re_list[[3]])
    
    # Appendix E
    
    # Black
    outcome_model_schl_eff_math5_black.boot <- eivreg(c5r4mtht_r ~ 
                                                        re_impact_math + 
                                                        math_impact_x_treatment_re +
                                                        trct_disadv_index2 + 
                                                        nschlnch99_percent_r_black + 
                                                        S4NONWHTPCT_r_black + 
                                                        c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                        mmarriedbirth + childweightlow + female +
                                                        black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                        high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                        d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                        m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                        black_treat + black_med_math_eff + black_treat_med_math_eff +
                                                        c1r4mtht_r_mean,
                                                      data = analytic_sample.boot,
                                                      reliability = reliability_vector_math_re_black)
    
    outcome_model_schl_res_math5_black.boot <- lm(c5r4mtht_r ~ 
                                                    school_resources + 
                                                    school_resources_x_treatment +
                                                    trct_disadv_index2 + 
                                                    nschlnch99_percent_r_black + 
                                                    S4NONWHTPCT_r_black + 
                                                    c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                    mmarriedbirth + childweightlow + female +
                                                    black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                    high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                    d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                    m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                    black_treat + black_med_schl_res + black_treat_med_schl_res +
                                                    c1r4mtht_r_mean,
                                                  data = analytic_sample.boot)
    
    outcome_model_schl_dis_math5_black.boot <- lm(c5r4mtht_r ~ 
                                                    school_disorder + 
                                                    school_disorder_x_treatment +
                                                    trct_disadv_index2 + 
                                                    nschlnch99_percent_r_black + 
                                                    S4NONWHTPCT_r_black + 
                                                    c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                    mmarriedbirth + childweightlow + female +
                                                    black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                    high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                    d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                    m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                    black_treat + black_med_schl_dis + black_treat_med_schl_dis +
                                                    c1r4mtht_r_mean,
                                                  data = analytic_sample.boot)
    
    outcome_model_schl_eff_read5_black.boot <- eivreg(c5r4rtht_r ~ 
                                                        re_impact_read + 
                                                        read_impact_x_treatment_re +
                                                        trct_disadv_index2 + 
                                                        nschlnch99_percent_r_black + 
                                                        S4NONWHTPCT_r_black + 
                                                        c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                        mmarriedbirth + childweightlow + female +
                                                        black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                        high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                        d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                        m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                        black_treat + black_med_read_eff + black_treat_med_read_eff +
                                                        c1r4rtht_r_mean,
                                                      data = analytic_sample.boot,
                                                      reliability = reliability_vector_read_re_black)
    
    outcome_model_schl_res_read5_black.boot <- lm(c5r4rtht_r ~ 
                                                    school_resources + 
                                                    school_resources_x_treatment +
                                                    trct_disadv_index2 + 
                                                    nschlnch99_percent_r_black + 
                                                    S4NONWHTPCT_r_black + 
                                                    c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                    mmarriedbirth + childweightlow + female +
                                                    black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                    high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                    d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                    m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                    black_treat + black_med_schl_res + black_treat_med_schl_res +
                                                    c1r4rtht_r_mean,
                                                  data = analytic_sample.boot)
    
    outcome_model_schl_dis_read5_black.boot <- lm(c5r4rtht_r ~ 
                                                    school_disorder + 
                                                    school_disorder_x_treatment +
                                                    trct_disadv_index2 + 
                                                    nschlnch99_percent_r_black + 
                                                    S4NONWHTPCT_r_black + 
                                                    c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                    mmarriedbirth + childweightlow + female +
                                                    black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                    high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                    d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                    m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                    black_treat + black_med_schl_dis + black_treat_med_schl_dis +
                                                    c1r4rtht_r_mean,
                                                  data = analytic_sample.boot)
    
    # Female
    outcome_model_schl_eff_math5_female.boot <- eivreg(c5r4mtht_r ~ 
                                                         re_impact_math + 
                                                         math_impact_x_treatment_re +
                                                         trct_disadv_index2 + 
                                                         nschlnch99_percent_r_female + 
                                                         S4NONWHTPCT_r_female + 
                                                         c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                         mmarriedbirth + childweightlow + female +
                                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                         female_treat + female_med_math_eff + female_treat_med_math_eff +
                                                         c1r4mtht_r_mean,
                                                       data = analytic_sample.boot,
                                                       reliability = reliability_vector_math_re_female)
    
    outcome_model_schl_res_math5_female.boot <- lm(c5r4mtht_r ~ 
                                                     school_resources + 
                                                     school_resources_x_treatment +
                                                     trct_disadv_index2 + 
                                                     nschlnch99_percent_r_female + 
                                                     S4NONWHTPCT_r_female + 
                                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                     mmarriedbirth + childweightlow + female +
                                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                     m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                     female_treat + female_med_schl_res + female_treat_med_schl_res +
                                                     c1r4mtht_r_mean,
                                                   data = analytic_sample.boot)
    
    outcome_model_schl_dis_math5_female.boot <- lm(c5r4mtht_r ~ 
                                                     school_disorder + 
                                                     school_disorder_x_treatment +
                                                     trct_disadv_index2 + 
                                                     nschlnch99_percent_r_female + 
                                                     S4NONWHTPCT_r_female + 
                                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                     mmarriedbirth + childweightlow + female +
                                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                     m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                     female_treat + female_med_schl_dis + female_treat_med_schl_dis +
                                                     c1r4mtht_r_mean,
                                                   data = analytic_sample.boot)
    
    outcome_model_schl_eff_read5_female.boot <- eivreg(c5r4rtht_r ~ 
                                                         re_impact_read + 
                                                         read_impact_x_treatment_re +
                                                         trct_disadv_index2 + 
                                                         nschlnch99_percent_r_female + 
                                                         S4NONWHTPCT_r_female + 
                                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                         mmarriedbirth + childweightlow + female +
                                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                         m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                         female_treat + female_med_read_eff + female_treat_med_read_eff +
                                                         c1r4rtht_r_mean,
                                                       data = analytic_sample.boot,
                                                       reliability = reliability_vector_read_re_female)
    
    outcome_model_schl_res_read5_female.boot <- lm(c5r4rtht_r ~ 
                                                     school_resources + 
                                                     school_resources_x_treatment +
                                                     trct_disadv_index2 + 
                                                     nschlnch99_percent_r_female + 
                                                     S4NONWHTPCT_r_female + 
                                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                     mmarriedbirth + childweightlow + female +
                                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                     m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                     female_treat + female_med_schl_res + female_treat_med_schl_res +
                                                     c1r4rtht_r_mean,
                                                   data = analytic_sample.boot)
    
    outcome_model_schl_dis_read5_female.boot <- lm(c5r4rtht_r ~ 
                                                     school_disorder + 
                                                     school_disorder_x_treatment +
                                                     trct_disadv_index2 + 
                                                     nschlnch99_percent_r_female + 
                                                     S4NONWHTPCT_r_female + 
                                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                     mmarriedbirth + childweightlow + female +
                                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                     m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                     female_treat + female_med_schl_dis + female_treat_med_schl_dis +
                                                     c1r4rtht_r_mean,
                                                   data = analytic_sample.boot)
    
    # At least some college
    outcome_model_schl_eff_math5_some_col.boot <- eivreg(c5r4mtht_r ~ 
                                                           re_impact_math + 
                                                           math_impact_x_treatment_re +
                                                           trct_disadv_index2 + 
                                                           nschlnch99_percent_r_some_col + 
                                                           S4NONWHTPCT_r_some_col + 
                                                           c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                           mmarriedbirth + childweightlow + female +
                                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                           at_least_some_col_treat + at_least_some_col_med_math_eff + at_least_some_col_treat_med_math_eff +
                                                           c1r4mtht_r_mean,
                                                         data = analytic_sample.boot,
                                                         reliability = reliability_vector_math_re_some_col)
    
    outcome_model_schl_res_math5_some_col.boot <- lm(c5r4mtht_r ~ 
                                                       school_resources + 
                                                       school_resources_x_treatment +
                                                       trct_disadv_index2 + 
                                                       nschlnch99_percent_r_some_col + 
                                                       S4NONWHTPCT_r_some_col + 
                                                       c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                       mmarriedbirth + childweightlow + female +
                                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                       at_least_some_col_treat + at_least_some_col_med_schl_res + at_least_some_col_treat_med_schl_res +
                                                       c1r4mtht_r_mean,
                                                     data = analytic_sample.boot)
    
    outcome_model_schl_dis_math5_some_col.boot <- lm(c5r4mtht_r ~ 
                                                       school_disorder + 
                                                       school_disorder_x_treatment +
                                                       trct_disadv_index2 + 
                                                       nschlnch99_percent_r_some_col + 
                                                       S4NONWHTPCT_r_some_col + 
                                                       c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                       mmarriedbirth + childweightlow + female +
                                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                       at_least_some_col_treat + at_least_some_col_med_schl_dis + at_least_some_col_treat_med_schl_dis +
                                                       c1r4mtht_r_mean,
                                                     data = analytic_sample.boot)
    
    outcome_model_schl_eff_read5_some_col.boot <- eivreg(c5r4rtht_r ~ 
                                                           re_impact_read + 
                                                           read_impact_x_treatment_re +
                                                           trct_disadv_index2 + 
                                                           nschlnch99_percent_r_some_col + 
                                                           S4NONWHTPCT_r_some_col + 
                                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                           mmarriedbirth + childweightlow + female +
                                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                           m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                           at_least_some_col_treat + at_least_some_col_med_read_eff + at_least_some_col_treat_med_read_eff +
                                                           c1r4rtht_r_mean,
                                                         data = analytic_sample.boot,
                                                         reliability = reliability_vector_read_re_some_col)
    
    outcome_model_schl_res_read5_some_col.boot <- lm(c5r4rtht_r ~ 
                                                       school_resources + 
                                                       school_resources_x_treatment +
                                                       trct_disadv_index2 + 
                                                       nschlnch99_percent_r_some_col + 
                                                       S4NONWHTPCT_r_some_col + 
                                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                       mmarriedbirth + childweightlow + female +
                                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                       at_least_some_col_treat + at_least_some_col_med_schl_res + at_least_some_col_treat_med_schl_res +
                                                       c1r4rtht_r_mean,
                                                     data = analytic_sample.boot)
    
    outcome_model_schl_dis_read5_some_col.boot <- lm(c5r4rtht_r ~ 
                                                       school_disorder + 
                                                       school_disorder_x_treatment +
                                                       trct_disadv_index2 + 
                                                       nschlnch99_percent_r_some_col + 
                                                       S4NONWHTPCT_r_some_col + 
                                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                       mmarriedbirth + childweightlow + female +
                                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                       m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                       at_least_some_col_treat + at_least_some_col_med_schl_dis + at_least_some_col_treat_med_schl_dis +
                                                       c1r4rtht_r_mean,
                                                     data = analytic_sample.boot)
    
  
    # Additional models
    outcome_model_schl_res_math5_add.boot <- lm(c5r4mtht_r ~ 
                                                  puptchr99 + B4YRSTC_sch + YKBASSAL_sch + advdeg_sch + ndstexp99 + 
                                                  trct_disadv_index2 + 
                                                  nschlnch99_percent_r + 
                                                  S4NONWHTPCT_r + 
                                                  c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                  c1r4mtht_r_mean,
                                                data = analytic_sample.boot )
    
    outcome_model_schl_res_read5_add.boot <- lm(c5r4rtht_r ~ 
                                                  puptchr99 + B4YRSTC_sch + YKBASSAL_sch + advdeg_sch + ndstexp99 + 
                                                  trct_disadv_index2 + 
                                                  nschlnch99_percent_r + 
                                                  S4NONWHTPCT_r + 
                                                  c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                  c1r4rtht_r_mean,
                                                data = analytic_sample.boot )
    
    outcome_model_schl_dis_math5_add.boot <- lm(c5r4mtht_r ~ 
                                                  A4ABSEN_r_sch + A4BEHVR_r_sch + 
                                                  trct_disadv_index2 + 
                                                  nschlnch99_percent_r + 
                                                  S4NONWHTPCT_r + 
                                                  c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                  c1r4mtht_r_mean,
                                                data = analytic_sample.boot )
    
    outcome_model_schl_dis_read5_add.boot <- lm(c5r4rtht_r ~ 
                                                  A4ABSEN_r_sch + A4BEHVR_r_sch + 
                                                  trct_disadv_index2 + 
                                                  nschlnch99_percent_r + 
                                                  S4NONWHTPCT_r + 
                                                  c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                  c1r4rtht_r_mean,
                                                data = analytic_sample.boot)
    
    outcome_model_schl_eff_math5_add.boot <- eivreg(c5r4mtht_r ~ 
                                                      re_impact_math + 
                                                      trct_disadv_index2 + 
                                                      nschlnch99_percent + 
                                                      S4NONWHTPCT + 
                                                      c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                      mmarriedbirth + childweightlow + female +
                                                      black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                      high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                      d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                      m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                      school_resources + school_disorder +
                                                      c1r4mtht_r_mean,
                                                    data = analytic_sample.boot,
                                                    reliability = reliability_vector_math_re_add)
    
    outcome_model_schl_eff_read5_add.boot <- eivreg(c5r4rtht_r ~ 
                                                      re_impact_read + 
                                                      trct_disadv_index2 + 
                                                      nschlnch99_percent + 
                                                      S4NONWHTPCT + 
                                                      c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                      mmarriedbirth + childweightlow + female +
                                                      black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                      high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                      d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                      m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                      school_resources + school_disorder +
                                                      c1r4rtht_r_mean,
                                                    data = analytic_sample.boot,
                                                    reliability = reliability_vector_read_re_add)
    
    # Table 4
    bootdist_cde[j,1]  <- (outcome_model_schl_eff_math5.boot$coef[4] + outcome_model_schl_eff_math5.boot$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,2]  <- (outcome_model_schl_res_math5.boot$coef[4] + outcome_model_schl_res_math5.boot$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,3]  <- (outcome_model_schl_dis_math5.boot$coef[4] + outcome_model_schl_dis_math5.boot$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintref[j,1]  <- outcome_model_schl_eff_math5.boot$coef[3] * (schl_eff_math_on_treatment.boot$coef[1] + schl_eff_math_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,2]  <- outcome_model_schl_res_math5.boot$coef[3] * (schl_res_on_treatment.boot$coef[1]      + schl_res_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,3]  <- outcome_model_schl_dis_math5.boot$coef[3] * (schl_dis_on_treatment.boot$coef[1]      + schl_dis_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnde[j,1]  <- bootdist_cde[j,1]  + bootdist_rintref[j,1]
    bootdist_rnde[j,2]  <- bootdist_cde[j,2]  + bootdist_rintref[j,2]
    bootdist_rnde[j,3]  <- bootdist_cde[j,3]  + bootdist_rintref[j,3]
    
    bootdist_rpie[j,1]  <- (schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[2] + schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,2]  <- (schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math5.boot$coef[2] + schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,3]  <- (schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math5.boot$coef[2] + schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintmed[j,1]  <- schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,2]  <- schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,3]  <- schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    
    bootdist_rnie[j,1]  <- bootdist_rpie[j,1]  + bootdist_rintmed[j,1]
    bootdist_rnie[j,2]  <- bootdist_rpie[j,2]  + bootdist_rintmed[j,2]
    bootdist_rnie[j,3]  <- bootdist_rpie[j,3]  + bootdist_rintmed[j,3]
    
    bootdist_rate[j,1]  <- bootdist_rnde[j,1]  + bootdist_rnie[j,1]
    bootdist_rate[j,2]  <- bootdist_rnde[j,2]  + bootdist_rnie[j,2]
    bootdist_rate[j,3]  <- bootdist_rnde[j,3]  + bootdist_rnie[j,3]
    
    bootdist_rnde_dagger[j,1]  <- bootdist_rnde[j,1]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,2]  <- bootdist_rnde[j,2]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_math5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_math5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,3]  <- bootdist_rnde[j,3]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_math5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_math5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnie_dagger[j,1]  <- bootdist_rnie[j,1]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,2]  <- bootdist_rnie[j,2]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_math5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_math5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,3]  <- bootdist_rnie[j,3]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_math5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_math5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    # Table 5
    bootdist_cde[j,4]  <- (outcome_model_schl_eff_read5.boot$coef[4] + outcome_model_schl_eff_read5.boot$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,5]  <- (outcome_model_schl_res_read5.boot$coef[4] + outcome_model_schl_res_read5.boot$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,6]  <- (outcome_model_schl_dis_read5.boot$coef[4] + outcome_model_schl_dis_read5.boot$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintref[j,4]  <- outcome_model_schl_eff_read5.boot$coef[3] * (schl_eff_read_on_treatment.boot$coef[1] + schl_eff_read_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,5]  <- outcome_model_schl_res_read5.boot$coef[3] * (schl_res_on_treatment.boot$coef[1]      + schl_res_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,6]  <- outcome_model_schl_dis_read5.boot$coef[3] * (schl_dis_on_treatment.boot$coef[1]      + schl_dis_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnde[j,4]  <- bootdist_cde[j,4]  + bootdist_rintref[j,4]
    bootdist_rnde[j,5]  <- bootdist_cde[j,5]  + bootdist_rintref[j,5]
    bootdist_rnde[j,6]  <- bootdist_cde[j,6]  + bootdist_rintref[j,6]
    
    bootdist_rpie[j,4]  <- (schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[2] + schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,5]  <- (schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read5.boot$coef[2] + schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,6]  <- (schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read5.boot$coef[2] + schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintmed[j,4]  <- schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,5]  <- schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,6]  <- schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    
    bootdist_rnie[j,4]  <- bootdist_rpie[j,4]  + bootdist_rintmed[j,4]
    bootdist_rnie[j,5]  <- bootdist_rpie[j,5]  + bootdist_rintmed[j,5]
    bootdist_rnie[j,6]  <- bootdist_rpie[j,6]  + bootdist_rintmed[j,6]
    
    bootdist_rate[j,4]  <- bootdist_rnde[j,4]  + bootdist_rnie[j,4]
    bootdist_rate[j,5]  <- bootdist_rnde[j,5]  + bootdist_rnie[j,5]
    bootdist_rate[j,6]  <- bootdist_rnde[j,6]  + bootdist_rnie[j,6]
    
    bootdist_rnde_dagger[j,4]  <- bootdist_rnde[j,4]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,5]  <- bootdist_rnde[j,5]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_read5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_read5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,6]  <- bootdist_rnde[j,6]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_read5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_read5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnie_dagger[j,4]  <- bootdist_rnie[j,4]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,5]  <- bootdist_rnie[j,5]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_read5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_read5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,6]  <- bootdist_rnie[j,6]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_read5.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_read5.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    # Table 6
    bootdist_mediator_on_treatment[j,1] <- schl_eff_math_on_treatment.boot$coef[2]
    bootdist_mediator_on_treatment[j,2] <- schl_eff_read_on_treatment.boot$coef[2]
    bootdist_mediator_on_treatment[j,3] <- schl_res_on_treatment.boot$coef[2]
    bootdist_mediator_on_treatment[j,4] <- schl_dis_on_treatment.boot$coef[2]
    bootdist_mediator_on_treatment[j,5] <- free_lunch_on_treatment.boot$coef[2]
    bootdist_mediator_on_treatment[j,6] <- racial_comp_on_treatment.boot$coef[2]
    
    # Table 7
    bootdist_treatment[j,1]  <- outcome_model_schl_eff_math5.boot$coef[4]
    bootdist_treatment[j,2]  <- outcome_model_schl_res_math5.boot$coef[4]
    bootdist_treatment[j,3]  <- outcome_model_schl_dis_math5.boot$coef[4]
    
    bootdist_schl_qual[j,1]  <- outcome_model_schl_eff_math5.boot$coef[2]
    bootdist_schl_qual[j,2]  <- outcome_model_schl_res_math5.boot$coef[2]
    bootdist_schl_qual[j,3]  <- outcome_model_schl_dis_math5.boot$coef[2]
    
    bootdist_schl_qual_x_treatment[j,1]  <- outcome_model_schl_eff_math5.boot$coef[3]
    bootdist_schl_qual_x_treatment[j,2]  <- outcome_model_schl_res_math5.boot$coef[3]
    bootdist_schl_qual_x_treatment[j,3]  <- outcome_model_schl_dis_math5.boot$coef[3]
    
    bootdist_free_lunch[j,1]  <- outcome_model_schl_eff_math5.boot$coef[5]
    bootdist_free_lunch[j,2]  <- outcome_model_schl_res_math5.boot$coef[5]
    bootdist_free_lunch[j,3]  <- outcome_model_schl_dis_math5.boot$coef[5]
    
    bootdist_racial_comp[j,1]  <- outcome_model_schl_eff_math5.boot$coef[6]
    bootdist_racial_comp[j,2]  <- outcome_model_schl_res_math5.boot$coef[6]
    bootdist_racial_comp[j,3]  <- outcome_model_schl_dis_math5.boot$coef[6]
    
    # Table 8
    bootdist_treatment[j,4]  <- outcome_model_schl_eff_read5.boot$coef[4]
    bootdist_treatment[j,5]  <- outcome_model_schl_res_read5.boot$coef[4]
    bootdist_treatment[j,6]  <- outcome_model_schl_dis_read5.boot$coef[4]
    
    bootdist_schl_qual[j,4]  <- outcome_model_schl_eff_read5.boot$coef[2]
    bootdist_schl_qual[j,5]  <- outcome_model_schl_res_read5.boot$coef[2]
    bootdist_schl_qual[j,6]  <- outcome_model_schl_dis_read5.boot$coef[2]
    
    bootdist_schl_qual_x_treatment[j,4]  <- outcome_model_schl_eff_read5.boot$coef[3]
    bootdist_schl_qual_x_treatment[j,5]  <- outcome_model_schl_res_read5.boot$coef[3]
    bootdist_schl_qual_x_treatment[j,6]  <- outcome_model_schl_dis_read5.boot$coef[3]
    
    bootdist_free_lunch[j,4]  <- outcome_model_schl_eff_read5.boot$coef[5]
    bootdist_free_lunch[j,5]  <- outcome_model_schl_res_read5.boot$coef[5]
    bootdist_free_lunch[j,6]  <- outcome_model_schl_dis_read5.boot$coef[5]
    
    bootdist_racial_comp[j,4]  <- outcome_model_schl_eff_read5.boot$coef[6]
    bootdist_racial_comp[j,5]  <- outcome_model_schl_res_read5.boot$coef[6]
    bootdist_racial_comp[j,6]  <- outcome_model_schl_dis_read5.boot$coef[6]
    
    # Appendix B
    bootdist_cde[j,7]  <- (outcome_model_schl_eff_math6.boot$coef[4] + outcome_model_schl_eff_math6.boot$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,8]  <- (outcome_model_schl_res_math6.boot$coef[4] + outcome_model_schl_res_math6.boot$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,9]  <- (outcome_model_schl_dis_math6.boot$coef[4] + outcome_model_schl_dis_math6.boot$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,10] <- (outcome_model_schl_eff_read6.boot$coef[4] + outcome_model_schl_eff_read6.boot$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,11] <- (outcome_model_schl_res_read6.boot$coef[4] + outcome_model_schl_res_read6.boot$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,12] <- (outcome_model_schl_dis_read6.boot$coef[4] + outcome_model_schl_dis_read6.boot$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,13] <- (outcome_model_schl_eff_math7.boot$coef[4] + outcome_model_schl_eff_math7.boot$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,14] <- (outcome_model_schl_res_math7.boot$coef[4] + outcome_model_schl_res_math7.boot$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,15] <- (outcome_model_schl_dis_math7.boot$coef[4] + outcome_model_schl_dis_math7.boot$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,16] <- (outcome_model_schl_eff_read7.boot$coef[4] + outcome_model_schl_eff_read7.boot$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,17] <- (outcome_model_schl_res_read7.boot$coef[4] + outcome_model_schl_res_read7.boot$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,18] <- (outcome_model_schl_dis_read7.boot$coef[4] + outcome_model_schl_dis_read7.boot$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintref[j,7]  <- outcome_model_schl_eff_math6.boot$coef[3] * (schl_eff_math_on_treatment.boot$coef[1] + schl_eff_math_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,8]  <- outcome_model_schl_res_math6.boot$coef[3] * (schl_res_on_treatment.boot$coef[1]      + schl_res_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,9]  <- outcome_model_schl_dis_math6.boot$coef[3] * (schl_dis_on_treatment.boot$coef[1]      + schl_dis_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,10] <- outcome_model_schl_eff_read6.boot$coef[3] * (schl_eff_read_on_treatment.boot$coef[1] + schl_eff_read_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,11] <- outcome_model_schl_res_read6.boot$coef[3] * (schl_res_on_treatment.boot$coef[1]      + schl_res_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,12] <- outcome_model_schl_dis_read6.boot$coef[3] * (schl_dis_on_treatment.boot$coef[1]      + schl_dis_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,13] <- outcome_model_schl_eff_math7.boot$coef[3] * (schl_eff_math_on_treatment.boot$coef[1] + schl_eff_math_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,14] <- outcome_model_schl_res_math7.boot$coef[3] * (schl_res_on_treatment.boot$coef[1]      + schl_res_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,15] <- outcome_model_schl_dis_math7.boot$coef[3] * (schl_dis_on_treatment.boot$coef[1]      + schl_dis_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,16] <- outcome_model_schl_eff_read7.boot$coef[3] * (schl_eff_read_on_treatment.boot$coef[1] + schl_eff_read_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,17] <- outcome_model_schl_res_read7.boot$coef[3] * (schl_res_on_treatment.boot$coef[1]      + schl_res_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,18] <- outcome_model_schl_dis_read7.boot$coef[3] * (schl_dis_on_treatment.boot$coef[1]      + schl_dis_on_treatment.boot$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnde[j,7]  <- bootdist_cde[j,7]  + bootdist_rintref[j,7]
    bootdist_rnde[j,8]  <- bootdist_cde[j,8]  + bootdist_rintref[j,8]
    bootdist_rnde[j,9]  <- bootdist_cde[j,9]  + bootdist_rintref[j,9]
    bootdist_rnde[j,10] <- bootdist_cde[j,10] + bootdist_rintref[j,10]
    bootdist_rnde[j,11] <- bootdist_cde[j,11] + bootdist_rintref[j,11]
    bootdist_rnde[j,12] <- bootdist_cde[j,12] + bootdist_rintref[j,12]
    bootdist_rnde[j,13] <- bootdist_cde[j,13] + bootdist_rintref[j,13]
    bootdist_rnde[j,14] <- bootdist_cde[j,14] + bootdist_rintref[j,14]
    bootdist_rnde[j,15] <- bootdist_cde[j,15] + bootdist_rintref[j,15]
    bootdist_rnde[j,16] <- bootdist_cde[j,16] + bootdist_rintref[j,16]
    bootdist_rnde[j,17] <- bootdist_cde[j,17] + bootdist_rintref[j,17]
    bootdist_rnde[j,18] <- bootdist_cde[j,18] + bootdist_rintref[j,18]
    
    bootdist_rpie[j,7]  <- (schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math6.boot$coef[2] + schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math6.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,8]  <- (schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math6.boot$coef[2] + schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math6.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,9]  <- (schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math6.boot$coef[2] + schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math6.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,10] <- (schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read6.boot$coef[2] + schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read6.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,11] <- (schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read6.boot$coef[2] + schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read6.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,12] <- (schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read6.boot$coef[2] + schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read6.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,13] <- (schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math7.boot$coef[2] + schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math7.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,14] <- (schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math7.boot$coef[2] + schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math7.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,15] <- (schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math7.boot$coef[2] + schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math7.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,16] <- (schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read7.boot$coef[2] + schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read7.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,17] <- (schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read7.boot$coef[2] + schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read7.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,18] <- (schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read7.boot$coef[2] + schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read7.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintmed[j,7]  <- schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math6.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,8]  <- schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math6.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,9]  <- schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math6.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,10] <- schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read6.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,11] <- schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read6.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,12] <- schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read6.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,13] <- schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math7.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,14] <- schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_math7.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,15] <- schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_math7.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,16] <- schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read7.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,17] <- schl_res_on_treatment.boot$coef[2]      * outcome_model_schl_res_read7.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,18] <- schl_dis_on_treatment.boot$coef[2]      * outcome_model_schl_dis_read7.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    
    bootdist_rnie[j,7]  <- bootdist_rpie[j,7]  + bootdist_rintmed[j,7]
    bootdist_rnie[j,8]  <- bootdist_rpie[j,8]  + bootdist_rintmed[j,8]
    bootdist_rnie[j,9]  <- bootdist_rpie[j,9]  + bootdist_rintmed[j,9]
    bootdist_rnie[j,10] <- bootdist_rpie[j,10] + bootdist_rintmed[j,10]
    bootdist_rnie[j,11] <- bootdist_rpie[j,11] + bootdist_rintmed[j,11]
    bootdist_rnie[j,12] <- bootdist_rpie[j,12] + bootdist_rintmed[j,12]
    bootdist_rnie[j,13] <- bootdist_rpie[j,13] + bootdist_rintmed[j,13]
    bootdist_rnie[j,14] <- bootdist_rpie[j,14] + bootdist_rintmed[j,14]
    bootdist_rnie[j,15] <- bootdist_rpie[j,15] + bootdist_rintmed[j,15]
    bootdist_rnie[j,16] <- bootdist_rpie[j,16] + bootdist_rintmed[j,16]
    bootdist_rnie[j,17] <- bootdist_rpie[j,17] + bootdist_rintmed[j,17]
    bootdist_rnie[j,18] <- bootdist_rpie[j,18] + bootdist_rintmed[j,18]
    
    bootdist_rate[j,7]  <- bootdist_rnde[j,7]  + bootdist_rnie[j,7]
    bootdist_rate[j,8]  <- bootdist_rnde[j,8]  + bootdist_rnie[j,8]
    bootdist_rate[j,9]  <- bootdist_rnde[j,9]  + bootdist_rnie[j,9]
    bootdist_rate[j,10] <- bootdist_rnde[j,10] + bootdist_rnie[j,10]
    bootdist_rate[j,11] <- bootdist_rnde[j,11] + bootdist_rnie[j,11]
    bootdist_rate[j,12] <- bootdist_rnde[j,12] + bootdist_rnie[j,12]
    bootdist_rate[j,13] <- bootdist_rnde[j,13] + bootdist_rnie[j,13]
    bootdist_rate[j,14] <- bootdist_rnde[j,14] + bootdist_rnie[j,14]
    bootdist_rate[j,15] <- bootdist_rnde[j,15] + bootdist_rnie[j,15]
    bootdist_rate[j,16] <- bootdist_rnde[j,16] + bootdist_rnie[j,16]
    bootdist_rate[j,17] <- bootdist_rnde[j,17] + bootdist_rnie[j,17]
    bootdist_rate[j,18] <- bootdist_rnde[j,18] + bootdist_rnie[j,18]
    
    bootdist_rnde_dagger[j,7]  <- bootdist_rnde[j,7]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,8]  <- bootdist_rnde[j,8]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_math6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_math6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,9]  <- bootdist_rnde[j,9]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_math6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_math6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,10] <- bootdist_rnde[j,10] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,11] <- bootdist_rnde[j,11] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_read6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_read6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,12] <- bootdist_rnde[j,12] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_read6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_read6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,13] <- bootdist_rnde[j,13] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,14] <- bootdist_rnde[j,14] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_math7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_math7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,15] <- bootdist_rnde[j,15] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_math7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_math7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,16] <- bootdist_rnde[j,16] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,17] <- bootdist_rnde[j,17] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_read7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_read7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,18] <- bootdist_rnde[j,18] - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_read7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_read7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnie_dagger[j,7]  <- bootdist_rnie[j,7]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,8]  <- bootdist_rnie[j,8]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_math6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_math6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,9]  <- bootdist_rnie[j,9]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_math6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_math6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,10] <- bootdist_rnie[j,10] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,11] <- bootdist_rnie[j,11] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_read6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_read6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,12] <- bootdist_rnie[j,12] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_read6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_read6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,13] <- bootdist_rnie[j,13] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,14] <- bootdist_rnie[j,14] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_math7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_math7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,15] <- bootdist_rnie[j,15] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_math7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_math7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,16] <- bootdist_rnie[j,16] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,17] <- bootdist_rnie[j,17] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_res_read7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_res_read7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,18] <- bootdist_rnie[j,18] + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_dis_read7.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_dis_read7.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    # Appendix D
    bootdist_cde[j,19]  <- (outcome_model_schl_eff_math5_p8.boot$coef[4] + outcome_model_schl_eff_math5_p8.boot$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,20]  <- (outcome_model_schl_eff_read5_p8.boot$coef[4] + outcome_model_schl_eff_read5_p8.boot$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,21]  <- (outcome_model_schl_eff_math5_p6.boot$coef[4] + outcome_model_schl_eff_math5_p6.boot$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde[j,22]  <- (outcome_model_schl_eff_read5_p6.boot$coef[4] + outcome_model_schl_eff_read5_p6.boot$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintref[j,19]  <- outcome_model_schl_eff_math5_p8.boot$coef[3] * (schl_eff_math_on_treatment.boot$coef[1] + schl_eff_math_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,20]  <- outcome_model_schl_eff_read5_p8.boot$coef[3] * (schl_eff_read_on_treatment.boot$coef[1] + schl_eff_read_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,21]  <- outcome_model_schl_eff_math5_p6.boot$coef[3] * (schl_eff_math_on_treatment.boot$coef[1] + schl_eff_math_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref[j,22]  <- outcome_model_schl_eff_read5_p6.boot$coef[3] * (schl_eff_read_on_treatment.boot$coef[1] + schl_eff_read_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnde[j,19]  <- bootdist_cde[j,19]  + bootdist_rintref[j,19]
    bootdist_rnde[j,20]  <- bootdist_cde[j,20]  + bootdist_rintref[j,20]
    bootdist_rnde[j,21]  <- bootdist_cde[j,21]  + bootdist_rintref[j,21]
    bootdist_rnde[j,22]  <- bootdist_cde[j,22]  + bootdist_rintref[j,22]
    
    bootdist_rpie[j,19]  <- (schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p8.boot$coef[2] + schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p8.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,20]  <- (schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p8.boot$coef[2] + schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p8.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,21]  <- (schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p6.boot$coef[2] + schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p6.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie[j,22]  <- (schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p6.boot$coef[2] + schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p6.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintmed[j,19]  <- schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p8.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,20]  <- schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p8.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,21]  <- schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p6.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed[j,22]  <- schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p6.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    
    bootdist_rnie[j,19]  <- bootdist_rpie[j,19]  + bootdist_rintmed[j,19]
    bootdist_rnie[j,20]  <- bootdist_rpie[j,20]  + bootdist_rintmed[j,20]
    bootdist_rnie[j,21]  <- bootdist_rpie[j,21]  + bootdist_rintmed[j,21]
    bootdist_rnie[j,22]  <- bootdist_rpie[j,22]  + bootdist_rintmed[j,22]
    
    bootdist_rate[j,19]  <- bootdist_rnde[j,19]  + bootdist_rnie[j,19]
    bootdist_rate[j,20]  <- bootdist_rnde[j,20]  + bootdist_rnie[j,20]
    bootdist_rate[j,21]  <- bootdist_rnde[j,21]  + bootdist_rnie[j,21]
    bootdist_rate[j,22]  <- bootdist_rnde[j,22]  + bootdist_rnie[j,22]
    
    bootdist_rnde_dagger[j,19]  <- bootdist_rnde[j,19]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p8.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p8.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,20]  <- bootdist_rnde[j,20]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p8.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p8.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,21]  <- bootdist_rnde[j,21]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger[j,22]  <- bootdist_rnde[j,22]  - (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnie_dagger[j,19]  <- bootdist_rnie[j,19]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p8.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p8.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,20]  <- bootdist_rnie[j,20]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p8.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p8.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,21]  <- bootdist_rnie[j,21]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5_p6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger[j,22]  <- bootdist_rnie[j,22]  + (free_lunch_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p6.boot$coef[5] + racial_comp_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5_p6.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    # Appendix E
    bootdist_cde_het[j,1]   <- (outcome_model_schl_eff_math5_black.boot$coef[4]    + outcome_model_schl_eff_math5_black.boot$coef[3]    * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,2]   <- (outcome_model_schl_res_math5_black.boot$coef[4]    + outcome_model_schl_res_math5_black.boot$coef[3]    * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,3]   <- (outcome_model_schl_dis_math5_black.boot$coef[4]    + outcome_model_schl_dis_math5_black.boot$coef[3]    * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,4]   <- (outcome_model_schl_eff_read5_black.boot$coef[4]    + outcome_model_schl_eff_read5_black.boot$coef[3]    * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,5]   <- (outcome_model_schl_res_read5_black.boot$coef[4]    + outcome_model_schl_res_read5_black.boot$coef[3]    * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,6]   <- (outcome_model_schl_dis_read5_black.boot$coef[4]    + outcome_model_schl_dis_read5_black.boot$coef[3]    * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,7]   <- (outcome_model_schl_eff_math5_female.boot$coef[4]   + outcome_model_schl_eff_math5_female.boot$coef[3]   * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,8]   <- (outcome_model_schl_res_math5_female.boot$coef[4]   + outcome_model_schl_res_math5_female.boot$coef[3]   * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,9]   <- (outcome_model_schl_dis_math5_female.boot$coef[4]   + outcome_model_schl_dis_math5_female.boot$coef[3]   * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,10]  <- (outcome_model_schl_eff_read5_female.boot$coef[4]   + outcome_model_schl_eff_read5_female.boot$coef[3]   * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,11]  <- (outcome_model_schl_res_read5_female.boot$coef[4]   + outcome_model_schl_res_read5_female.boot$coef[3]   * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,12]  <- (outcome_model_schl_dis_read5_female.boot$coef[4]   + outcome_model_schl_dis_read5_female.boot$coef[3]   * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,13]  <- (outcome_model_schl_eff_math5_some_col.boot$coef[4] + outcome_model_schl_eff_math5_some_col.boot$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,14]  <- (outcome_model_schl_res_math5_some_col.boot$coef[4] + outcome_model_schl_res_math5_some_col.boot$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,15]  <- (outcome_model_schl_dis_math5_some_col.boot$coef[4] + outcome_model_schl_dis_math5_some_col.boot$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,16]  <- (outcome_model_schl_eff_read5_some_col.boot$coef[4] + outcome_model_schl_eff_read5_some_col.boot$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,17]  <- (outcome_model_schl_res_read5_some_col.boot$coef[4] + outcome_model_schl_res_read5_some_col.boot$coef[3] * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,18]  <- (outcome_model_schl_dis_read5_some_col.boot$coef[4] + outcome_model_schl_dis_read5_some_col.boot$coef[3] * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintref_het[j,1]   <- outcome_model_schl_eff_math5_black.boot$coef[3]    * (schl_eff_math_on_treatment_black.boot$coef[1]    + schl_eff_math_on_treatment_black.boot$coef[2]    * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,2]   <- outcome_model_schl_res_math5_black.boot$coef[3]    * (schl_res_on_treatment_black.boot$coef[1]         + schl_res_on_treatment_black.boot$coef[2]         * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,3]   <- outcome_model_schl_dis_math5_black.boot$coef[3]    * (schl_dis_on_treatment_black.boot$coef[1]         + schl_dis_on_treatment_black.boot$coef[2]         * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,4]   <- outcome_model_schl_eff_read5_black.boot$coef[3]    * (schl_eff_read_on_treatment_black.boot$coef[1]    + schl_eff_read_on_treatment_black.boot$coef[2]    * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,5]   <- outcome_model_schl_res_read5_black.boot$coef[3]    * (schl_res_on_treatment_black.boot$coef[1]         + schl_res_on_treatment_black.boot$coef[2]         * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,6]   <- outcome_model_schl_dis_read5_black.boot$coef[3]    * (schl_dis_on_treatment_black.boot$coef[1]         + schl_dis_on_treatment_black.boot$coef[2]         * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,7]   <- outcome_model_schl_eff_math5_female.boot$coef[3]   * (schl_eff_math_on_treatment_female.boot$coef[1]   + schl_eff_math_on_treatment_female.boot$coef[2]   * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,8]   <- outcome_model_schl_res_math5_female.boot$coef[3]   * (schl_res_on_treatment_female.boot$coef[1]        + schl_res_on_treatment_female.boot$coef[2]        * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,9]   <- outcome_model_schl_dis_math5_female.boot$coef[3]   * (schl_dis_on_treatment_female.boot$coef[1]        + schl_dis_on_treatment_female.boot$coef[2]        * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,10]  <- outcome_model_schl_eff_read5_female.boot$coef[3]   * (schl_eff_read_on_treatment_female.boot$coef[1]   + schl_eff_read_on_treatment_female.boot$coef[2]   * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,11]  <- outcome_model_schl_res_read5_female.boot$coef[3]   * (schl_res_on_treatment_female.boot$coef[1]        + schl_res_on_treatment_female.boot$coef[2]        * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,12]  <- outcome_model_schl_dis_read5_female.boot$coef[3]   * (schl_dis_on_treatment_female.boot$coef[1]        + schl_dis_on_treatment_female.boot$coef[2]        * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,13]  <- outcome_model_schl_eff_math5_some_col.boot$coef[3] * (schl_eff_math_on_treatment_some_col.boot$coef[1] + schl_eff_math_on_treatment_some_col.boot$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,14]  <- outcome_model_schl_res_math5_some_col.boot$coef[3] * (schl_res_on_treatment_some_col.boot$coef[1]      + schl_res_on_treatment_some_col.boot$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,15]  <- outcome_model_schl_dis_math5_some_col.boot$coef[3] * (schl_dis_on_treatment_some_col.boot$coef[1]      + schl_dis_on_treatment_some_col.boot$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,16]  <- outcome_model_schl_eff_read5_some_col.boot$coef[3] * (schl_eff_read_on_treatment_some_col.boot$coef[1] + schl_eff_read_on_treatment_some_col.boot$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,17]  <- outcome_model_schl_res_read5_some_col.boot$coef[3] * (schl_res_on_treatment_some_col.boot$coef[1]      + schl_res_on_treatment_some_col.boot$coef[2]      * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,18]  <- outcome_model_schl_dis_read5_some_col.boot$coef[3] * (schl_dis_on_treatment_some_col.boot$coef[1]      + schl_dis_on_treatment_some_col.boot$coef[2]      * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnde_het[j,1]   <- bootdist_cde_het[j,1]   + bootdist_rintref_het[j,1]
    bootdist_rnde_het[j,2]   <- bootdist_cde_het[j,2]   + bootdist_rintref_het[j,2]
    bootdist_rnde_het[j,3]   <- bootdist_cde_het[j,3]   + bootdist_rintref_het[j,3]
    bootdist_rnde_het[j,4]   <- bootdist_cde_het[j,4]   + bootdist_rintref_het[j,4]
    bootdist_rnde_het[j,5]   <- bootdist_cde_het[j,5]   + bootdist_rintref_het[j,5]
    bootdist_rnde_het[j,6]   <- bootdist_cde_het[j,6]   + bootdist_rintref_het[j,6]
    bootdist_rnde_het[j,7]   <- bootdist_cde_het[j,7]   + bootdist_rintref_het[j,7]
    bootdist_rnde_het[j,8]   <- bootdist_cde_het[j,8]   + bootdist_rintref_het[j,8]
    bootdist_rnde_het[j,9]   <- bootdist_cde_het[j,9]   + bootdist_rintref_het[j,9]
    bootdist_rnde_het[j,10]  <- bootdist_cde_het[j,10]  + bootdist_rintref_het[j,10]
    bootdist_rnde_het[j,11]  <- bootdist_cde_het[j,11]  + bootdist_rintref_het[j,11]
    bootdist_rnde_het[j,12]  <- bootdist_cde_het[j,12]  + bootdist_rintref_het[j,12]
    bootdist_rnde_het[j,13]  <- bootdist_cde_het[j,13]  + bootdist_rintref_het[j,13]
    bootdist_rnde_het[j,14]  <- bootdist_cde_het[j,14]  + bootdist_rintref_het[j,14]
    bootdist_rnde_het[j,15]  <- bootdist_cde_het[j,15]  + bootdist_rintref_het[j,15]
    bootdist_rnde_het[j,16]  <- bootdist_cde_het[j,16]  + bootdist_rintref_het[j,16]
    bootdist_rnde_het[j,17]  <- bootdist_cde_het[j,17]  + bootdist_rintref_het[j,17]
    bootdist_rnde_het[j,18]  <- bootdist_cde_het[j,18]  + bootdist_rintref_het[j,18]
    
    bootdist_rpie_het[j,1]   <- (schl_eff_math_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_math5_black.boot$coef[2]    + schl_eff_math_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_math5_black.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,2]   <- (schl_res_on_treatment_black.boot$coef[2]         * outcome_model_schl_res_math5_black.boot$coef[2]    + schl_res_on_treatment_black.boot$coef[2]         * outcome_model_schl_res_math5_black.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,3]   <- (schl_dis_on_treatment_black.boot$coef[2]         * outcome_model_schl_dis_math5_black.boot$coef[2]    + schl_dis_on_treatment_black.boot$coef[2]         * outcome_model_schl_dis_math5_black.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,4]   <- (schl_eff_read_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_read5_black.boot$coef[2]    + schl_eff_read_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_read5_black.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,5]   <- (schl_res_on_treatment_black.boot$coef[2]         * outcome_model_schl_res_read5_black.boot$coef[2]    + schl_res_on_treatment_black.boot$coef[2]         * outcome_model_schl_res_read5_black.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,6]   <- (schl_dis_on_treatment_black.boot$coef[2]         * outcome_model_schl_dis_read5_black.boot$coef[2]    + schl_dis_on_treatment_black.boot$coef[2]         * outcome_model_schl_dis_read5_black.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,7]   <- (schl_eff_math_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_math5_female.boot$coef[2]   + schl_eff_math_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_math5_female.boot$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,8]   <- (schl_res_on_treatment_female.boot$coef[2]        * outcome_model_schl_res_math5_female.boot$coef[2]   + schl_res_on_treatment_female.boot$coef[2]        * outcome_model_schl_res_math5_female.boot$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,9]   <- (schl_dis_on_treatment_female.boot$coef[2]        * outcome_model_schl_dis_math5_female.boot$coef[2]   + schl_dis_on_treatment_female.boot$coef[2]        * outcome_model_schl_dis_math5_female.boot$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,10]  <- (schl_eff_read_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_read5_female.boot$coef[2]   + schl_eff_read_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_read5_female.boot$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,11]  <- (schl_res_on_treatment_female.boot$coef[2]        * outcome_model_schl_res_read5_female.boot$coef[2]   + schl_res_on_treatment_female.boot$coef[2]        * outcome_model_schl_res_read5_female.boot$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,12]  <- (schl_dis_on_treatment_female.boot$coef[2]        * outcome_model_schl_dis_read5_female.boot$coef[2]   + schl_dis_on_treatment_female.boot$coef[2]        * outcome_model_schl_dis_read5_female.boot$coef[3]   * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,13]  <- (schl_eff_math_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_math5_some_col.boot$coef[2] + schl_eff_math_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_math5_some_col.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,14]  <- (schl_res_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_res_math5_some_col.boot$coef[2] + schl_res_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_res_math5_some_col.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,15]  <- (schl_dis_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_dis_math5_some_col.boot$coef[2] + schl_dis_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_dis_math5_some_col.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,16]  <- (schl_eff_read_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_read5_some_col.boot$coef[2] + schl_eff_read_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_read5_some_col.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,17]  <- (schl_res_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_res_read5_some_col.boot$coef[2] + schl_res_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_res_read5_some_col.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,18]  <- (schl_dis_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_dis_read5_some_col.boot$coef[2] + schl_dis_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_dis_read5_some_col.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintmed_het[j,1]   <- schl_eff_math_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_math5_black.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,2]   <- schl_res_on_treatment_black.boot$coef[2]         * outcome_model_schl_res_math5_black.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,3]   <- schl_dis_on_treatment_black.boot$coef[2]         * outcome_model_schl_dis_math5_black.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,4]   <- schl_eff_read_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_read5_black.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,5]   <- schl_res_on_treatment_black.boot$coef[2]         * outcome_model_schl_res_read5_black.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,6]   <- schl_dis_on_treatment_black.boot$coef[2]         * outcome_model_schl_dis_read5_black.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,7]   <- schl_eff_math_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_math5_female.boot$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,8]   <- schl_res_on_treatment_female.boot$coef[2]        * outcome_model_schl_res_math5_female.boot$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,9]   <- schl_dis_on_treatment_female.boot$coef[2]        * outcome_model_schl_dis_math5_female.boot$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,10]  <- schl_eff_read_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_read5_female.boot$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,11]  <- schl_res_on_treatment_female.boot$coef[2]        * outcome_model_schl_res_read5_female.boot$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,12]  <- schl_dis_on_treatment_female.boot$coef[2]        * outcome_model_schl_dis_read5_female.boot$coef[3]   * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,13]  <- schl_eff_math_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_math5_some_col.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,14]  <- schl_res_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_res_math5_some_col.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,15]  <- schl_dis_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_dis_math5_some_col.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,16]  <- schl_eff_read_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_read5_some_col.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,17]  <- schl_res_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_res_read5_some_col.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,18]  <- schl_dis_on_treatment_some_col.boot$coef[2]      * outcome_model_schl_dis_read5_some_col.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    
    bootdist_rnie_het[j,1]   <- bootdist_rpie_het[j,1]   + bootdist_rintmed_het[j,1]
    bootdist_rnie_het[j,2]   <- bootdist_rpie_het[j,2]   + bootdist_rintmed_het[j,2]
    bootdist_rnie_het[j,3]   <- bootdist_rpie_het[j,3]   + bootdist_rintmed_het[j,3]
    bootdist_rnie_het[j,4]   <- bootdist_rpie_het[j,4]   + bootdist_rintmed_het[j,4]
    bootdist_rnie_het[j,5]   <- bootdist_rpie_het[j,5]   + bootdist_rintmed_het[j,5]
    bootdist_rnie_het[j,6]   <- bootdist_rpie_het[j,6]   + bootdist_rintmed_het[j,6]
    bootdist_rnie_het[j,7]   <- bootdist_rpie_het[j,7]   + bootdist_rintmed_het[j,7]
    bootdist_rnie_het[j,8]   <- bootdist_rpie_het[j,8]   + bootdist_rintmed_het[j,8]
    bootdist_rnie_het[j,9]   <- bootdist_rpie_het[j,9]   + bootdist_rintmed_het[j,9]
    bootdist_rnie_het[j,10]  <- bootdist_rpie_het[j,10]  + bootdist_rintmed_het[j,10]
    bootdist_rnie_het[j,11]  <- bootdist_rpie_het[j,11]  + bootdist_rintmed_het[j,11]
    bootdist_rnie_het[j,12]  <- bootdist_rpie_het[j,12]  + bootdist_rintmed_het[j,12]
    bootdist_rnie_het[j,13]  <- bootdist_rpie_het[j,13]  + bootdist_rintmed_het[j,13]
    bootdist_rnie_het[j,14]  <- bootdist_rpie_het[j,14]  + bootdist_rintmed_het[j,14]
    bootdist_rnie_het[j,15]  <- bootdist_rpie_het[j,15]  + bootdist_rintmed_het[j,15]
    bootdist_rnie_het[j,16]  <- bootdist_rpie_het[j,16]  + bootdist_rintmed_het[j,16]
    bootdist_rnie_het[j,17]  <- bootdist_rpie_het[j,17]  + bootdist_rintmed_het[j,17]
    bootdist_rnie_het[j,18]  <- bootdist_rpie_het[j,18]  + bootdist_rintmed_het[j,18]
    
    bootdist_rate_het[j,1]   <- bootdist_rnde_het[j,1]   + bootdist_rnie_het[j,1]
    bootdist_rate_het[j,2]   <- bootdist_rnde_het[j,2]   + bootdist_rnie_het[j,2]
    bootdist_rate_het[j,3]   <- bootdist_rnde_het[j,3]   + bootdist_rnie_het[j,3]
    bootdist_rate_het[j,4]   <- bootdist_rnde_het[j,4]   + bootdist_rnie_het[j,4]
    bootdist_rate_het[j,5]   <- bootdist_rnde_het[j,5]   + bootdist_rnie_het[j,5]
    bootdist_rate_het[j,6]   <- bootdist_rnde_het[j,6]   + bootdist_rnie_het[j,6]
    bootdist_rate_het[j,7]   <- bootdist_rnde_het[j,7]   + bootdist_rnie_het[j,7]
    bootdist_rate_het[j,8]   <- bootdist_rnde_het[j,8]   + bootdist_rnie_het[j,8]
    bootdist_rate_het[j,9]   <- bootdist_rnde_het[j,9]   + bootdist_rnie_het[j,9]
    bootdist_rate_het[j,10]  <- bootdist_rnde_het[j,10]  + bootdist_rnie_het[j,10]
    bootdist_rate_het[j,11]  <- bootdist_rnde_het[j,11]  + bootdist_rnie_het[j,11]
    bootdist_rate_het[j,12]  <- bootdist_rnde_het[j,12]  + bootdist_rnie_het[j,12]
    bootdist_rate_het[j,13]  <- bootdist_rnde_het[j,13]  + bootdist_rnie_het[j,13]
    bootdist_rate_het[j,14]  <- bootdist_rnde_het[j,14]  + bootdist_rnie_het[j,14]
    bootdist_rate_het[j,15]  <- bootdist_rnde_het[j,15]  + bootdist_rnie_het[j,15]
    bootdist_rate_het[j,16]  <- bootdist_rnde_het[j,16]  + bootdist_rnie_het[j,16]
    bootdist_rate_het[j,17]  <- bootdist_rnde_het[j,17]  + bootdist_rnie_het[j,17]
    bootdist_rate_het[j,18]  <- bootdist_rnde_het[j,18]  + bootdist_rnie_het[j,18]
    
    bootdist_rnde_dagger_het[j,1]   <- bootdist_rnde_het[j,1]   - (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_math5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_math5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,2]   <- bootdist_rnde_het[j,2]   - (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_res_math5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_res_math5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,3]   <- bootdist_rnde_het[j,3]   - (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_dis_math5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_dis_math5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,4]   <- bootdist_rnde_het[j,4]   - (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_read5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_read5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,5]   <- bootdist_rnde_het[j,5]   - (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_res_read5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_res_read5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,6]   <- bootdist_rnde_het[j,6]   - (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_dis_read5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_dis_read5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,7]   <- bootdist_rnde_het[j,7]   - (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_math5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_math5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,8]   <- bootdist_rnde_het[j,8]   - (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_res_math5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_res_math5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,9]   <- bootdist_rnde_het[j,9]   - (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_dis_math5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_dis_math5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,10]  <- bootdist_rnde_het[j,10]  - (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_read5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_read5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,11]  <- bootdist_rnde_het[j,11]  - (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_res_read5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_res_read5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,12]  <- bootdist_rnde_het[j,12]  - (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_dis_read5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_dis_read5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,13]  <- bootdist_rnde_het[j,13]  - (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_math5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_math5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,14]  <- bootdist_rnde_het[j,14]  - (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_res_math5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_res_math5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,15]  <- bootdist_rnde_het[j,15]  - (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_dis_math5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_dis_math5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,16]  <- bootdist_rnde_het[j,16]  - (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_read5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_read5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,17]  <- bootdist_rnde_het[j,17]  - (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_res_read5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_res_read5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnde_dagger_het[j,18]  <- bootdist_rnde_het[j,18]  - (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_dis_read5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_dis_read5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rnie_dagger_het[j,1]   <- bootdist_rnie_het[j,1]   + (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_math5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_math5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,2]   <- bootdist_rnie_het[j,2]   + (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_res_math5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_res_math5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,3]   <- bootdist_rnie_het[j,3]   + (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_dis_math5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_dis_math5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,4]   <- bootdist_rnie_het[j,4]   + (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_read5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_eff_read5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,5]   <- bootdist_rnie_het[j,5]   + (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_res_read5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_res_read5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,6]   <- bootdist_rnie_het[j,6]   + (free_lunch_on_treatment_black.boot$coef[2]    * outcome_model_schl_dis_read5_black.boot$coef[5]    + racial_comp_on_treatment_black.boot$coef[2]    * outcome_model_schl_dis_read5_black.boot$coef[6])    * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,7]   <- bootdist_rnie_het[j,7]   + (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_math5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_math5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,8]   <- bootdist_rnie_het[j,8]   + (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_res_math5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_res_math5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,9]   <- bootdist_rnie_het[j,9]   + (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_dis_math5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_dis_math5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,10]  <- bootdist_rnie_het[j,10]  + (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_read5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_eff_read5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,11]  <- bootdist_rnie_het[j,11]  + (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_res_read5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_res_read5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,12]  <- bootdist_rnie_het[j,12]  + (free_lunch_on_treatment_female.boot$coef[2]   * outcome_model_schl_dis_read5_female.boot$coef[5]   + racial_comp_on_treatment_female.boot$coef[2]   * outcome_model_schl_dis_read5_female.boot$coef[6])   * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,13]  <- bootdist_rnie_het[j,13]  + (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_math5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_math5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,14]  <- bootdist_rnie_het[j,14]  + (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_res_math5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_res_math5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,15]  <- bootdist_rnie_het[j,15]  + (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_dis_math5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_dis_math5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,16]  <- bootdist_rnie_het[j,16]  + (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_read5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_eff_read5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,17]  <- bootdist_rnie_het[j,17]  + (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_res_read5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_res_read5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rnie_dagger_het[j,18]  <- bootdist_rnie_het[j,18]  + (free_lunch_on_treatment_some_col.boot$coef[2] * outcome_model_schl_dis_read5_some_col.boot$coef[5] + racial_comp_on_treatment_some_col.boot$coef[2] * outcome_model_schl_dis_read5_some_col.boot$coef[6]) * (pc_treatment[2] - pc_treatment[1])
    
 
    # Additional models
    bootdist_additional[j,1] <- outcome_model_schl_res_math5_add.boot$coef[7]
    bootdist_additional[j,2] <- outcome_model_schl_res_read5_add.boot$coef[7]
    bootdist_additional[j,3] <- outcome_model_schl_dis_math5_add.boot$coef[4]
    bootdist_additional[j,4] <- outcome_model_schl_dis_read5_add.boot$coef[4]
    bootdist_additional[j,5] <- outcome_model_schl_eff_math5_add.boot$coef[3]
    bootdist_additional[j,6] <- outcome_model_schl_eff_read5_add.boot$coef[3]
    
  }
  
  for (m in 1:22) {
    
    # Tables 4, 5, Appendices B, D
    mivar_rate[i,m]        <- var(bootdist_rate[,m])
    mivar_rnde[i,m]        <- var(bootdist_rnde[,m])
    mivar_cde[i,m]         <- var(bootdist_cde[,m])
    mivar_rintref[i,m]     <- var(bootdist_rintref[,m])
    mivar_rnie[i,m]        <- var(bootdist_rnie[,m])
    mivar_rpie[i,m]        <- var(bootdist_rpie[,m])
    mivar_rintmed[i,m]     <- var(bootdist_rintmed[,m])
    mivar_rnde_dagger[i,m] <- var(bootdist_rnde_dagger[,m])
    mivar_rnie_dagger[i,m] <- var(bootdist_rnie_dagger[,m])
    
  }
  
  for (m in 1:6) {
    
    # Table 6
    mivar_mediator_on_treatment[i,m]  <- var(bootdist_mediator_on_treatment[,m])
    
    # Tables 7, 8
    mivar_treatment[i,m]             <- var(bootdist_treatment[,m])
    mivar_schl_qual[i,m]             <- var(bootdist_schl_qual[,m])
    mivar_schl_qual_x_treatment[i,m] <- var(bootdist_schl_qual_x_treatment[,m])
    mivar_free_lunch[i,m]            <- var(bootdist_free_lunch[,m])
    mivar_racial_comp[i,m]           <- var(bootdist_racial_comp[,m])
    
    # Additional models
    mivar_additional[i,m] <- var(bootdist_additional[,m])
  
  }
  
  for (m in 1:18) {
    
    # Appendix E
    mivar_rate_het[i,m]        <- var(bootdist_rate_het[,m])
    mivar_rnde_het[i,m]        <- var(bootdist_rnde_het[,m])
    mivar_cde_het[i,m]         <- var(bootdist_cde_het[,m])
    mivar_rintref_het[i,m]     <- var(bootdist_rintref_het[,m])
    mivar_rnie_het[i,m]        <- var(bootdist_rnie_het[,m])
    mivar_rpie_het[i,m]        <- var(bootdist_rpie_het[,m])
    mivar_rintmed_het[i,m]     <- var(bootdist_rintmed_het[,m])
    mivar_rnde_dagger_het[i,m] <- var(bootdist_rnde_dagger_het[,m])
    mivar_rnie_dagger_het[i,m] <- var(bootdist_rnie_dagger_het[,m])
    
  }
  
}





### Combine MI estimates ###

# Tables 4, 5, Appendices B, D
rate_est        <- matrix(data=NA, nrow=22, ncol=4)
rnde_est        <- matrix(data=NA, nrow=22, ncol=4)
cde_est         <- matrix(data=NA, nrow=22, ncol=4)
rintref_est     <- matrix(data=NA, nrow=22, ncol=4)
rnie_est        <- matrix(data=NA, nrow=22, ncol=4)
rpie_est        <- matrix(data=NA, nrow=22, ncol=4)
rintmed_est     <- matrix(data=NA, nrow=22, ncol=4)
rnde_dagger_est <- matrix(data=NA, nrow=22, ncol=4)
rnie_dagger_est <- matrix(data=NA, nrow=22, ncol=4)

# Table 6
mediator_on_treatment_est <- matrix(data=NA, nrow=6, ncol=4)

# Tables 7, 8
treatment_est             <- matrix(data=NA, nrow=6, ncol=4)
schl_qual_est             <- matrix(data=NA, nrow=6, ncol=4)
schl_qual_x_treatment_est <- matrix(data=NA, nrow=6, ncol=4)
free_lunch_est            <- matrix(data=NA, nrow=6, ncol=4)
racial_comp_est           <- matrix(data=NA, nrow=6, ncol=4)

# Appendix E 
rate_het_est        <- matrix(data=NA, nrow=18, ncol=4)
rnde_het_est        <- matrix(data=NA, nrow=18, ncol=4)
cde_het_est         <- matrix(data=NA, nrow=18, ncol=4)
rintref_het_est     <- matrix(data=NA, nrow=18, ncol=4)
rnie_het_est        <- matrix(data=NA, nrow=18, ncol=4)
rpie_het_est        <- matrix(data=NA, nrow=18, ncol=4)
rintmed_het_est     <- matrix(data=NA, nrow=18, ncol=4)
rnde_dagger_het_est <- matrix(data=NA, nrow=18, ncol=4)
rnie_dagger_het_est <- matrix(data=NA, nrow=18, ncol=4)

# Additional models
additional_est <- matrix(data=NA, nrow=6, ncol=4)

for (i in 1:22) {
  
  # Tables 4, 5, Appendices B, D
  rate_est[i,1] <- round(mean(mibeta_rate[,i]), digits=4)
  rate_est[i,2] <- round(sqrt(mean(mivar_rate[,i]) + (var(mibeta_rate[,i]) * (1 + (1/nmi)))), digits=4)
  rate_est[i,3] <- round((rate_est[i,1]/rate_est[i,2]), digits=4)
  rate_est[i,4] <- round((pnorm(abs(rate_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rnde_est[i,1] <- round(mean(mibeta_rnde[,i]), digits=4)
  rnde_est[i,2] <- round(sqrt(mean(mivar_rnde[,i]) + (var(mibeta_rnde[,i]) * (1 + (1/nmi)))), digits=4)
  rnde_est[i,3] <- round((rnde_est[i,1]/rnde_est[i,2]), digits=4)
  rnde_est[i,4] <- round((pnorm(abs(rnde_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  cde_est[i,1] <- round(mean(mibeta_cde[,i]), digits=4)
  cde_est[i,2] <- round(sqrt(mean(mivar_cde[,i]) + (var(mibeta_cde[,i]) * (1 + (1/nmi)))), digits=4)
  cde_est[i,3] <- round((cde_est[i,1]/cde_est[i,2]), digits=4)
  cde_est[i,4] <- round((pnorm(abs(cde_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rintref_est[i,1] <- round(mean(mibeta_rintref[,i]), digits=4)
  rintref_est[i,2] <- round(sqrt(mean(mivar_rintref[,i]) + (var(mibeta_rintref[,i]) * (1 + (1/nmi)))), digits=4)
  rintref_est[i,3] <- round((rintref_est[i,1]/rintref_est[i,2]), digits=4)
  rintref_est[i,4] <- round((pnorm(abs(rintref_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rnie_est[i,1] <- round(mean(mibeta_rnie[,i]), digits=4)
  rnie_est[i,2] <- round(sqrt(mean(mivar_rnie[,i]) + (var(mibeta_rnie[,i]) * (1 + (1/nmi)))), digits=4)
  rnie_est[i,3] <- round((rnie_est[i,1]/rnie_est[i,2]), digits=4)
  rnie_est[i,4] <- round((pnorm(abs(rnie_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rpie_est[i,1] <- round(mean(mibeta_rpie[,i]), digits=4)
  rpie_est[i,2] <- round(sqrt(mean(mivar_rpie[,i]) + (var(mibeta_rpie[,i]) * (1 + (1/nmi)))), digits=4)
  rpie_est[i,3] <- round((rpie_est[i,1]/rpie_est[i,2]), digits=4)
  rpie_est[i,4] <- round((pnorm(abs(rpie_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rintmed_est[i,1] <- round(mean(mibeta_rintmed[,i]), digits=4)
  rintmed_est[i,2] <- round(sqrt(mean(mivar_rintmed[,i]) + (var(mibeta_rintmed[,i]) * (1 + (1/nmi)))), digits=4)
  rintmed_est[i,3] <- round((rintmed_est[i,1]/rintmed_est[i,2]), digits=4)
  rintmed_est[i,4] <- round((pnorm(abs(rintmed_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rnde_dagger_est[i,1] <- round(mean(mibeta_rnde_dagger[,i]), digits=4)
  rnde_dagger_est[i,2] <- round(sqrt(mean(mivar_rnde_dagger[,i]) + (var(mibeta_rnde_dagger[,i]) * (1 + (1/nmi)))), digits=4)
  rnde_dagger_est[i,3] <- round((rnde_dagger_est[i,1]/rnde_dagger_est[i,2]), digits=4)
  rnde_dagger_est[i,4] <- round((pnorm(abs(rnde_dagger_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rnie_dagger_est[i,1] <- round(mean(mibeta_rnie_dagger[,i]), digits=4)
  rnie_dagger_est[i,2] <- round(sqrt(mean(mivar_rnie_dagger[,i]) + (var(mivar_rnie_dagger[,i]) * (1 + (1/nmi)))), digits=4)
  rnie_dagger_est[i,3] <- round((rnie_dagger_est[i,1]/rnie_dagger_est[i,2]), digits=4)
  rnie_dagger_est[i,4] <- round((pnorm(abs(rnie_dagger_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
}

for (i in 1:6) {
  
  # Table 6
  mediator_on_treatment_est[i,1] <- round(mean(mibeta_mediator_on_treatment[,i]), digits=4)
  mediator_on_treatment_est[i,2] <- round(sqrt(mean(mivar_mediator_on_treatment[,i]) + (var(mivar_mediator_on_treatment[,i]) * (1 + (1/nmi)))), digits=4)
  mediator_on_treatment_est[i,3] <- round((mediator_on_treatment_est[i,1]/mediator_on_treatment_est[i,2]), digits=4)
  mediator_on_treatment_est[i,4] <- round((pnorm(abs(mediator_on_treatment_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  # Tables 7, 8
  treatment_est[i,1] <- round(mean(mibeta_treatment[,i]), digits=4)
  treatment_est[i,2] <- round(sqrt(mean(mivar_treatment[,i]) + (var(mibeta_treatment[,i]) * (1 + (1/nmi)))), digits=4)
  treatment_est[i,3] <- round((treatment_est[i,1]/treatment_est[i,2]), digits=4)
  treatment_est[i,4] <- round((pnorm(abs(treatment_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  schl_qual_est[i,1] <- round(mean(mibeta_schl_qual[,i]), digits=4)
  schl_qual_est[i,2] <- round(sqrt(mean(mivar_schl_qual[,i]) + (var(mibeta_schl_qual[,i]) * (1 + (1/nmi)))), digits=4)
  schl_qual_est[i,3] <- round((schl_qual_est[i,1]/schl_qual_est[i,2]), digits=4)
  schl_qual_est[i,4] <- round((pnorm(abs(schl_qual_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  schl_qual_x_treatment_est[i,1] <- round(mean(mibeta_schl_qual_x_treatment[,i]), digits=4)
  schl_qual_x_treatment_est[i,2] <- round(sqrt(mean(mivar_schl_qual_x_treatment[,i]) + (var(mibeta_schl_qual_x_treatment[,i]) * (1 + (1/nmi)))), digits=4)
  schl_qual_x_treatment_est[i,3] <- round((schl_qual_x_treatment_est[i,1]/schl_qual_x_treatment_est[i,2]), digits=4)
  schl_qual_x_treatment_est[i,4] <- round((pnorm(abs(schl_qual_x_treatment_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  free_lunch_est[i,1] <- round(mean(mibeta_free_lunch[,i]), digits=4)
  free_lunch_est[i,2] <- round(sqrt(mean(mivar_free_lunch[,i]) + (var(mibeta_free_lunch[,i]) * (1 + (1/nmi)))), digits=4)
  free_lunch_est[i,3] <- round((free_lunch_est[i,1]/free_lunch_est[i,2]), digits=4)
  free_lunch_est[i,4] <- round((pnorm(abs(free_lunch_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  racial_comp_est[i,1] <- round(mean(mibeta_racial_comp[,i]), digits=4)
  racial_comp_est[i,2] <- round(sqrt(mean(mivar_racial_comp[,i]) + (var(mibeta_racial_comp[,i]) * (1 + (1/nmi)))), digits=4)
  racial_comp_est[i,3] <- round((racial_comp_est[i,1]/racial_comp_est[i,2]), digits=4)
  racial_comp_est[i,4] <- round((pnorm(abs(racial_comp_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  # Additional models
  additional_est[i,1] <- round(mean(mibeta_additional[,i]), digits=4)
  additional_est[i,2] <- round(sqrt(mean(mivar_additional[,i]) + (var(mibeta_additional[,i]) * (1 + (1/nmi)))), digits=4)
  additional_est[i,3] <- round((additional_est[i,1]/additional_est[i,2]), digits=4)
  additional_est[i,4] <- round((pnorm(abs(additional_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
}

for (i in 1:18) {
  
  # Appendix E 
  rate_het_est[i,1] <- round(mean(mibeta_rate_het[,i]), digits=4)
  rate_het_est[i,2] <- round(sqrt(mean(mivar_rate_het[,i]) + (var(mibeta_rate_het[,i]) * (1 + (1/nmi)))), digits=4)
  rate_het_est[i,3] <- round((rate_het_est[i,1]/rate_het_est[i,2]), digits=4)
  rate_het_est[i,4] <- round((pnorm(abs(rate_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rnde_het_est[i,1] <- round(mean(mibeta_rnde_het[,i]), digits=4)
  rnde_het_est[i,2] <- round(sqrt(mean(mivar_rnde_het[,i]) + (var(mibeta_rnde_het[,i]) * (1 + (1/nmi)))), digits=4)
  rnde_het_est[i,3] <- round((rnde_het_est[i,1]/rnde_het_est[i,2]), digits=4)
  rnde_het_est[i,4] <- round((pnorm(abs(rnde_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  cde_het_est[i,1] <- round(mean(mibeta_cde_het[,i]), digits=4)
  cde_het_est[i,2] <- round(sqrt(mean(mivar_cde_het[,i]) + (var(mibeta_cde_het[,i]) * (1 + (1/nmi)))), digits=4)
  cde_het_est[i,3] <- round((cde_het_est[i,1]/cde_het_est[i,2]), digits=4)
  cde_het_est[i,4] <- round((pnorm(abs(cde_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rintref_het_est[i,1] <- round(mean(mibeta_rintref_het[,i]), digits=4)
  rintref_het_est[i,2] <- round(sqrt(mean(mivar_rintref_het[,i]) + (var(mibeta_rintref_het[,i]) * (1 + (1/nmi)))), digits=4)
  rintref_het_est[i,3] <- round((rintref_het_est[i,1]/rintref_het_est[i,2]), digits=4)
  rintref_het_est[i,4] <- round((pnorm(abs(rintref_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rnie_het_est[i,1] <- round(mean(mibeta_rnie_het[,i]), digits=4)
  rnie_het_est[i,2] <- round(sqrt(mean(mivar_rnie_het[,i]) + (var(mibeta_rnie_het[,i]) * (1 + (1/nmi)))), digits=4)
  rnie_het_est[i,3] <- round((rnie_het_est[i,1]/rnie_het_est[i,2]), digits=4)
  rnie_het_est[i,4] <- round((pnorm(abs(rnie_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rpie_het_est[i,1] <- round(mean(mibeta_rpie_het[,i]), digits=4)
  rpie_het_est[i,2] <- round(sqrt(mean(mivar_rpie_het[,i]) + (var(mibeta_rpie_het[,i]) * (1 + (1/nmi)))), digits=4)
  rpie_het_est[i,3] <- round((rpie_het_est[i,1]/rpie_het_est[i,2]), digits=4)
  rpie_het_est[i,4] <- round((pnorm(abs(rpie_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rintmed_het_est[i,1] <- round(mean(mibeta_rintmed_het[,i]), digits=4)
  rintmed_het_est[i,2] <- round(sqrt(mean(mivar_rintmed_het[,i]) + (var(mibeta_rintmed_het[,i]) * (1 + (1/nmi)))), digits=4)
  rintmed_het_est[i,3] <- round((rintmed_het_est[i,1]/rintmed_het_est[i,2]), digits=4)
  rintmed_het_est[i,4] <- round((pnorm(abs(rintmed_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rnde_dagger_het_est[i,1] <- round(mean(mibeta_rnde_dagger_het[,i]), digits=4)
  rnde_dagger_het_est[i,2] <- round(sqrt(mean(mivar_rnde_dagger_het[,i]) + (var(mibeta_rnde_dagger_het[,i]) * (1 + (1/nmi)))), digits=4)
  rnde_dagger_het_est[i,3] <- round((rnde_dagger_het_est[i,1]/rnde_dagger_het_est[i,2]), digits=4)
  rnde_dagger_het_est[i,4] <- round((pnorm(abs(rnde_dagger_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
  rnie_dagger_het_est[i,1] <- round(mean(mibeta_rnie_dagger_het[,i]), digits=4)
  rnie_dagger_het_est[i,2] <- round(sqrt(mean(mivar_rnie_dagger_het[,i]) + (var(mivar_rnie_dagger_het[,i]) * (1 + (1/nmi)))), digits=4)
  rnie_dagger_het_est[i,3] <- round((rnie_dagger_het_est[i,1]/rnie_dagger_het_est[i,2]), digits=4)
  rnie_dagger_het_est[i,4] <- round((pnorm(abs(rnie_dagger_het_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=4)
  
}





### Print results ###

sink("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/logs-replicate-study/3-analyze-data/3-tables-4-5-6-7-8-b-d-e-add.txt")

cat("===========================================\n")
cat("Table 4\n")
cat("RATE\n")
print(rate_est[1:3,])
cat("RNDE\n")
print(rnde_est[1:3,])
cat("CDE(0)\n")
print(cde_est[1:3,])
cat("RINT_ref\n")
print(rintref_est[1:3,])
cat("RNIE\n")
print(rnie_est[1:3,])
cat("RPIE\n")
print(rpie_est[1:3,])
cat("RINT_med\n")
print(rintmed_est[1:3,])
cat("RNDE^dagger\n")
print(rnde_dagger_est[1:3,])
cat("RNIE^dagger\n")
print(rnie_dagger_est[1:3,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Table 5\n")
cat("RATE\n")
print(rate_est[4:6,])
cat("RNDE\n")
print(rnde_est[4:6,])
cat("CDE(0)\n")
print(cde_est[4:6,])
cat("RINT_ref\n")
print(rintref_est[4:6,])
cat("RNIE\n")
print(rnie_est[4:6,])
cat("RPIE\n")
print(rpie_est[4:6,])
cat("RINT_med\n")
print(rintmed_est[4:6,])
cat("RNDE^dagger\n")
print(rnde_dagger_est[4:6,])
cat("RNIE^dagger\n")
print(rnie_dagger_est[4:6,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Table 6\n")
cat("School effectiveness (math)\n")
print(mediator_on_treatment_est[1,])
cat("School effectiveness (read)\n")
print(mediator_on_treatment_est[2,])
cat("School resources\n")
print(mediator_on_treatment_est[3,])
cat("School disorder\n")
print(mediator_on_treatment_est[4,])
cat("Free lunch\n")
print(mediator_on_treatment_est[5,])
cat("Racial composition\n")
print(mediator_on_treatment_est[6,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Table 7\n")
cat("Treatment\n")
print(treatment_est[1:3,])
cat("School quality\n")
print(schl_qual_est[1:3,])
cat("School quality x treatment\n")
print(schl_qual_x_treatment_est[1:3,])
cat("Free lunch\n")
print(free_lunch_est[1:3,])
cat("Racial composition\n")
print(racial_comp_est[1:3,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Table 8\n")
cat("Treatment\n")
print(treatment_est[4:6,])
cat("School quality\n")
print(schl_qual_est[4:6,])
cat("School quality x treatment\n")
print(schl_qual_x_treatment_est[4:6,])
cat("Free lunch\n")
print(free_lunch_est[4:6,])
cat("Racial composition\n")
print(racial_comp_est[4:6,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix B.1\n")
cat("RATE\n")
print(rate_est[7:9,])
cat("RNDE\n")
print(rnde_est[7:9,])
cat("CDE(0)\n")
print(cde_est[7:9,])
cat("RINT_ref\n")
print(rintref_est[7:9,])
cat("RNIE\n")
print(rnie_est[7:9,])
cat("RPIE\n")
print(rpie_est[7:9,])
cat("RINT_med\n")
print(rintmed_est[7:9,])
cat("RNDE^dagger\n")
print(rnde_dagger_est[7:9,])
cat("RNIE^dagger\n")
print(rnie_dagger_est[7:9,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix B.2\n")
cat("RATE\n")
print(rate_est[10:12,])
cat("RNDE\n")
print(rnde_est[10:12,])
cat("CDE(0)\n")
print(cde_est[10:12,])
cat("RINT_ref\n")
print(rintref_est[10:12,])
cat("RNIE\n")
print(rnie_est[10:12,])
cat("RPIE\n")
print(rpie_est[10:12,])
cat("RINT_med\n")
print(rintmed_est[10:12,])
cat("RNDE^dagger\n")
print(rnde_dagger_est[10:12,])
cat("RNIE^dagger\n")
print(rnie_dagger_est[10:12,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix B.3\n")
cat("RATE\n")
print(rate_est[13:15,])
cat("RNDE\n")
print(rnde_est[13:15,])
cat("CDE(0)\n")
print(cde_est[13:15,])
cat("RINT_ref\n")
print(rintref_est[13:15,])
cat("RNIE\n")
print(rnie_est[13:15,])
cat("RPIE\n")
print(rpie_est[13:15,])
cat("RINT_med\n")
print(rintmed_est[13:15,])
cat("RNDE^dagger\n")
print(rnde_dagger_est[13:15,])
cat("RNIE^dagger\n")
print(rnie_dagger_est[13:15,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix B.4\n")
cat("RATE\n")
print(rate_est[16:18,])
cat("RNDE\n")
print(rnde_est[16:18,])
cat("CDE(0)\n")
print(cde_est[16:18,])
cat("RINT_ref\n")
print(rintref_est[16:18,])
cat("RNIE\n")
print(rnie_est[16:18,])
cat("RPIE\n")
print(rpie_est[16:18,])
cat("RINT_med\n")
print(rintmed_est[16:18,])
cat("RNDE^dagger\n")
print(rnde_dagger_est[16:18,])
cat("RNIE^dagger\n")
print(rnie_dagger_est[16:18,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix D.1\n")
cat("RATE\n")
print(rate_est[19:20,])
cat("RNDE\n")
print(rnde_est[19:20,])
cat("CDE(0)\n")
print(cde_est[19:20,])
cat("RINT_ref\n")
print(rintref_est[19:20,])
cat("RNIE\n")
print(rnie_est[19:20,])
cat("RPIE\n")
print(rpie_est[19:20,])
cat("RINT_med\n")
print(rintmed_est[19:20,])
cat("RNDE^dagger\n")
print(rnde_dagger_est[19:20,])
cat("RNIE^dagger\n")
print(rnie_dagger_est[19:20,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix D.2\n")
cat("RATE\n")
print(rate_est[21:22,])
cat("RNDE\n")
print(rnde_est[21:22,])
cat("CDE(0)\n")
print(cde_est[21:22,])
cat("RINT_ref\n")
print(rintref_est[21:22,])
cat("RNIE\n")
print(rnie_est[21:22,])
cat("RPIE\n")
print(rpie_est[21:22,])
cat("RINT_med\n")
print(rintmed_est[21:22,])
cat("RNDE^dagger\n")
print(rnde_dagger_est[21:22,])
cat("RNIE^dagger\n")
print(rnie_dagger_est[21:22,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix E.1\n")
cat("RATE\n")
print(rate_het_est[1:3,])
cat("RNDE\n")
print(rnde_het_est[1:3,])
cat("CDE(0)\n")
print(cde_het_est[1:3,])
cat("RINT_ref\n")
print(rintref_het_est[1:3,])
cat("RNIE\n")
print(rnie_het_est[1:3,])
cat("RPIE\n")
print(rpie_het_est[1:3,])
cat("RINT_med\n")
print(rintmed_het_est[1:3,])
cat("RNDE^dagger\n")
print(rnde_dagger_het_est[1:3,])
cat("RNIE^dagger\n")
print(rnie_dagger_het_est[1:3,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix E.2\n")
cat("RATE\n")
print(rate_het_est[4:6,])
cat("RNDE\n")
print(rnde_het_est[4:6,])
cat("CDE(0)\n")
print(cde_het_est[4:6,])
cat("RINT_ref\n")
print(rintref_het_est[4:6,])
cat("RNIE\n")
print(rnie_het_est[4:6,])
cat("RPIE\n")
print(rpie_het_est[4:6,])
cat("RINT_med\n")
print(rintmed_het_est[4:6,])
cat("RNDE^dagger\n")
print(rnde_dagger_het_est[4:6,])
cat("RNIE^dagger\n")
print(rnie_dagger_het_est[4:6,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix E.3\n")
cat("RATE\n")
print(rate_het_est[7:9,])
cat("RNDE\n")
print(rnde_het_est[7:9,])
cat("CDE(0)\n")
print(cde_het_est[7:9,])
cat("RINT_ref\n")
print(rintref_het_est[7:9,])
cat("RNIE\n")
print(rnie_het_est[7:9,])
cat("RPIE\n")
print(rpie_het_est[7:9,])
cat("RINT_med\n")
print(rintmed_het_est[7:9,])
cat("RNDE^dagger\n")
print(rnde_dagger_het_est[7:9,])
cat("RNIE^dagger\n")
print(rnie_dagger_het_est[7:9,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix E.4\n")
cat("RATE\n")
print(rate_het_est[10:12,])
cat("RNDE\n")
print(rnde_het_est[10:12,])
cat("CDE(0)\n")
print(cde_het_est[10:12,])
cat("RINT_ref\n")
print(rintref_het_est[10:12,])
cat("RNIE\n")
print(rnie_het_est[10:12,])
cat("RPIE\n")
print(rpie_het_est[10:12,])
cat("RINT_med\n")
print(rintmed_het_est[10:12,])
cat("RNDE^dagger\n")
print(rnde_dagger_het_est[10:12,])
cat("RNIE^dagger\n")
print(rnie_dagger_het_est[10:12,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix E.5\n")
cat("RATE\n")
print(rate_het_est[13:15,])
cat("RNDE\n")
print(rnde_het_est[13:15,])
cat("CDE(0)\n")
print(cde_het_est[13:15,])
cat("RINT_ref\n")
print(rintref_het_est[13:15,])
cat("RNIE\n")
print(rnie_het_est[13:15,])
cat("RPIE\n")
print(rpie_het_est[13:15,])
cat("RINT_med\n")
print(rintmed_het_est[13:15,])
cat("RNDE^dagger\n")
print(rnde_dagger_het_est[13:15,])
cat("RNIE^dagger\n")
print(rnie_dagger_het_est[13:15,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

cat("===========================================\n")
cat("Appendix E.6\n")
cat("RATE\n")
print(rate_het_est[16:18,])
cat("RNDE\n")
print(rnde_het_est[16:18,])
cat("CDE(0)\n")
print(cde_het_est[16:18,])
cat("RINT_ref\n")
print(rintref_het_est[16:18,])
cat("RNIE\n")
print(rnie_het_est[16:18,])
cat("RPIE\n")
print(rpie_het_est[16:18,])
cat("RINT_med\n")
print(rintmed_het_est[16:18,])
cat("RNDE^dagger\n")
print(rnde_dagger_het_est[16:18,])
cat("RNIE^dagger\n")
print(rnie_dagger_het_est[16:18,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")


cat("===========================================\n")
cat("Additional models\n")
cat("Treatment (school resources model)\n")
print(additional_est[1:2,])
cat("Treatment (school disorder model)\n")
print(additional_est[3:4,])
cat("Treatment (five mediators model)\n")
print(additional_est[5:6,])
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

sink()
