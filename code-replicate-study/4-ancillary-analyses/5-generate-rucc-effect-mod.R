###################################################
# EFFECTS BASED ON MODELS WITH MODERATION BY RUCC #
###################################################

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
analytic_sample_post_mi <- read.dta("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/data-replicate-study/data-replicate-study/Merge/ancillary-analytic-sample-post-mi-2.dta")


### Remove original non-imputed dataset ###
vars <- c(
  "c5r4mtht_r", "c5r4rtht_r", 
  "re_impact_math_ver1", "re_impact_math_ver2", "re_impact_math_ver3",
  "re_impact_read_ver1", "re_impact_read_ver2", "re_impact_read_ver3",
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
  "S3_ID", "_mi_m", "rucc"
)

analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" != 0), vars]


### Standardize variables ###

# Outcome
analytic_sample_post_mi$c5r4mtht_r <- ((analytic_sample_post_mi$c5r4mtht_r - mean(analytic_sample_post_mi$c5r4mtht_r)) / sd(analytic_sample_post_mi$c5r4mtht_r))
analytic_sample_post_mi$c5r4rtht_r <- ((analytic_sample_post_mi$c5r4rtht_r - mean(analytic_sample_post_mi$c5r4rtht_r)) / sd(analytic_sample_post_mi$c5r4rtht_r))

# Mediator: school effectiveness
analytic_sample_post_mi$re_impact_math      <- ((analytic_sample_post_mi$re_impact_math_ver1      - mean(analytic_sample_post_mi$re_impact_math_ver1))      / sd(analytic_sample_post_mi$re_impact_math_ver1))
analytic_sample_post_mi$re_impact_read      <- ((analytic_sample_post_mi$re_impact_read_ver1      - mean(analytic_sample_post_mi$re_impact_read_ver1))      / sd(analytic_sample_post_mi$re_impact_read_ver1))

# Mediator: school resources
analytic_sample_post_mi$school_resources <- ((analytic_sample_post_mi$school_resources - mean(analytic_sample_post_mi$school_resources)) / sd(analytic_sample_post_mi$school_resources))

# Mediator: school disorder
analytic_sample_post_mi$school_disorder <- ((analytic_sample_post_mi$school_disorder - mean(analytic_sample_post_mi$school_disorder)) / sd(analytic_sample_post_mi$school_disorder))

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

analytic_sample_post_mi$rucc                    <- ((analytic_sample_post_mi$rucc                    - mean(analytic_sample_post_mi$rucc))                    / sd(analytic_sample_post_mi$rucc))

analytic_sample_post_mi$rucc_treat              <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$trct_disadv_index2
analytic_sample_post_mi$rucc_med_math_eff       <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$re_impact_math
analytic_sample_post_mi$rucc_treat_med_math_eff <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$re_impact_math
analytic_sample_post_mi$rucc_med_read_eff       <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$re_impact_read
analytic_sample_post_mi$rucc_treat_med_read_eff <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$re_impact_read
analytic_sample_post_mi$rucc_med_schl_res       <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$school_resources
analytic_sample_post_mi$rucc_treat_med_schl_res <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$school_resources
analytic_sample_post_mi$rucc_med_schl_dis       <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$school_disorder
analytic_sample_post_mi$rucc_treat_med_schl_dis <- analytic_sample_post_mi$rucc * analytic_sample_post_mi$trct_disadv_index2 * analytic_sample_post_mi$school_disorder

####################
### CALCULATIONS ###
####################

### Initialize matrices to store beta/var values ###
  
mibeta_rate_het <- matrix(data = NA, nrow = nmi, ncol = 6) 
mivar_rate_het  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_rnde_het    <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rnde_het     <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_cde_het     <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_cde_het      <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_rintref_het <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rintref_het  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_rnie_het    <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rnie_het     <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_rpie_het    <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rpie_het     <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_rintmed_het <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rintmed_het  <- matrix(data = NA, nrow = nmi, ncol = 6)

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
  # rucc
  
  reliability_vector_math_re_rucc <- c(0.7, 
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
                                        1,
                                        1)
  
  reliability_vector_read_re_rucc <- c(0.7, 
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
                                        1,
                                        1)
  
  names(reliability_vector_math_re_rucc) <- 
    c("re_impact_math", 
      "math_impact_x_treatment_re", 
      "trct_disadv_index2", 
      "nschlnch99_percent_r_rucc",
      "S4NONWHTPCT_r_rucc",
      "c1r4mtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "rucc_treat", "rucc_med_math_eff", "rucc_treat_med_math_eff",
      "c1r4mtht_r_mean",
      "rucc")
  
  names(reliability_vector_read_re_rucc) <- 
    c("re_impact_read", 
      "read_impact_x_treatment_re", 
      "trct_disadv_index2", 
      "nschlnch99_percent_r_rucc",
      "S4NONWHTPCT_r_rucc",
      "c1r4rtht_r",
      "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
      "mmarriedbirth", "childweightlow", "female",
      "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
      "high_school_diploma_equivalent", "voc_tech_program", "some_college", "bachelor_s_degree", "graduate",
      "d_less_than_thirty_five_hrs_pw", "d_emp_other",
      "m_less_than_thirty_five_hrs_pw", "m_emp_other",
      "rucc_treat", "rucc_med_read_eff", "rucc_treat_med_read_eff",
      "c1r4rtht_r_mean",
      "rucc")

  
  # Fit Model 1: Mediator on treatment
  schl_eff_math_on_treatment_rucc <- lm(re_impact_math ~ 
                                           trct_disadv_index2 + 
                                           c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other +
                                           rucc_treat + rucc +
                                           c1r4mtht_r_mean,
                                         data = analytic_sample)
  
  schl_eff_read_on_treatment_rucc <- lm(re_impact_read ~ 
                                           trct_disadv_index2 + 
                                           c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                           mmarriedbirth + childweightlow + female +
                                           black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                           high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                           d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                           m_less_than_thirty_five_hrs_pw + m_emp_other +
                                           rucc_treat + rucc +
                                           c1r4rtht_r_mean,
                                         data = analytic_sample)
  
  schl_res_on_treatment_rucc <- lm(school_resources ~ 
                                      trct_disadv_index2 + 
                                      c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                      mmarriedbirth + childweightlow + female +
                                      black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                      high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                      d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                      m_less_than_thirty_five_hrs_pw + m_emp_other +
                                      rucc_treat + rucc +
                                      c1r4rtht_r_mean,
                                    data = analytic_sample)
  
  schl_dis_on_treatment_rucc <- lm(school_disorder ~ 
                                      trct_disadv_index2 + 
                                      c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                      mmarriedbirth + childweightlow + female +
                                      black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                      high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                      d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                      m_less_than_thirty_five_hrs_pw + m_emp_other +
                                      rucc_treat + rucc +
                                      c1r4rtht_r_mean,
                                    data = analytic_sample)
  
  free_lunch_on_treatment_rucc <- lm(nschlnch99_percent ~ 
                                        trct_disadv_index2 + 
                                        c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                        mmarriedbirth + childweightlow + female +
                                        black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                        high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                        d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                        m_less_than_thirty_five_hrs_pw + m_emp_other +
                                        rucc_treat + rucc +
                                        c1r4rtht_r_mean,
                                      data = analytic_sample)
  
  racial_comp_on_treatment_rucc <- lm(S4NONWHTPCT ~ 
                                         trct_disadv_index2 + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other +
                                         rucc_treat + rucc +
                                         c1r4rtht_r_mean,
                                       data = analytic_sample)
  
  # RWR calculations
  analytic_sample$nschlnch99_percent_r_rucc    <- NA
  analytic_sample$nschlnch99_percent_r_rucc    <- residuals(free_lunch_on_treatment_rucc)

  analytic_sample$S4NONWHTPCT_r_rucc    <- NA
  analytic_sample$S4NONWHTPCT_r_rucc    <- residuals(racial_comp_on_treatment_rucc)

  # Add variables for mediator-by-treatment interaction
  analytic_sample$math_impact_x_treatment_re <- analytic_sample$re_impact_math * analytic_sample$trct_disadv_index2
  analytic_sample$read_impact_x_treatment_re <- analytic_sample$re_impact_read * analytic_sample$trct_disadv_index2
  
  analytic_sample$school_resources_x_treatment <- analytic_sample$school_resources * analytic_sample$trct_disadv_index2
  analytic_sample$school_disorder_x_treatment  <- analytic_sample$school_disorder  * analytic_sample$trct_disadv_index2
  
  
  
  # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
  outcome_model_schl_eff_math5_rucc <- eivreg(c5r4mtht_r ~ 
                                                 re_impact_math + 
                                                 math_impact_x_treatment_re +
                                                 trct_disadv_index2 + 
                                                 nschlnch99_percent_r_rucc + 
                                                 S4NONWHTPCT_r_rucc + 
                                                 c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                 mmarriedbirth + childweightlow + female +
                                                 black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                 high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                 d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                 m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                 rucc_treat + rucc_med_math_eff + rucc_treat_med_math_eff + rucc +
                                                 c1r4mtht_r_mean,
                                               data = analytic_sample,
                                               reliability = reliability_vector_math_re_rucc)
  
  outcome_model_schl_res_math5_rucc <- lm(c5r4mtht_r ~ 
                                             school_resources + 
                                             school_resources_x_treatment +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r_rucc + 
                                             S4NONWHTPCT_r_rucc + 
                                             c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             rucc_treat + rucc_med_schl_res + rucc_treat_med_schl_res + rucc +
                                             c1r4mtht_r_mean,
                                           data = analytic_sample)
  
  outcome_model_schl_dis_math5_rucc <- lm(c5r4mtht_r ~ 
                                             school_disorder + 
                                             school_disorder_x_treatment +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r_rucc + 
                                             S4NONWHTPCT_r_rucc + 
                                             c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             rucc_treat + rucc_med_schl_dis + rucc_treat_med_schl_dis + rucc +
                                             c1r4mtht_r_mean,
                                           data = analytic_sample)
  
  outcome_model_schl_eff_read5_rucc <- eivreg(c5r4rtht_r ~ 
                                                 re_impact_read + 
                                                 read_impact_x_treatment_re +
                                                 trct_disadv_index2 + 
                                                 nschlnch99_percent_r_rucc + 
                                                 S4NONWHTPCT_r_rucc + 
                                                 c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                 mmarriedbirth + childweightlow + female +
                                                 black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                 high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                 d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                 m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                 rucc_treat + rucc_med_read_eff + rucc_treat_med_read_eff + rucc +
                                                 c1r4rtht_r_mean,
                                               data = analytic_sample,
                                               reliability = reliability_vector_read_re_rucc)
  
  outcome_model_schl_res_read5_rucc <- lm(c5r4rtht_r ~ 
                                             school_resources + 
                                             school_resources_x_treatment +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r_rucc + 
                                             S4NONWHTPCT_r_rucc + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             rucc_treat + rucc_med_schl_res + rucc_treat_med_schl_res + rucc +
                                             c1r4rtht_r_mean,
                                           data = analytic_sample)
  
  outcome_model_schl_dis_read5_rucc <- lm(c5r4rtht_r ~ 
                                             school_disorder + 
                                             school_disorder_x_treatment +
                                             trct_disadv_index2 + 
                                             nschlnch99_percent_r_rucc + 
                                             S4NONWHTPCT_r_rucc + 
                                             c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                             mmarriedbirth + childweightlow + female +
                                             black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                             high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                             d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                             m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                             rucc_treat + rucc_med_schl_dis + rucc_treat_med_schl_dis + rucc +
                                             c1r4rtht_r_mean,
                                           data = analytic_sample)
  
  # Appendix E
  mibeta_cde_het[i,1]   <- (outcome_model_schl_eff_math5_rucc$coef[4]    + outcome_model_schl_eff_math5_rucc$coef[3]    * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,2]   <- (outcome_model_schl_res_math5_rucc$coef[4]    + outcome_model_schl_res_math5_rucc$coef[3]    * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,3]   <- (outcome_model_schl_dis_math5_rucc$coef[4]    + outcome_model_schl_dis_math5_rucc$coef[3]    * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,4]   <- (outcome_model_schl_eff_read5_rucc$coef[4]    + outcome_model_schl_eff_read5_rucc$coef[3]    * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,5]   <- (outcome_model_schl_res_read5_rucc$coef[4]    + outcome_model_schl_res_read5_rucc$coef[3]    * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_cde_het[i,6]   <- (outcome_model_schl_dis_read5_rucc$coef[4]    + outcome_model_schl_dis_read5_rucc$coef[3]    * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  
  mibeta_rintref_het[i,1]   <- outcome_model_schl_eff_math5_rucc$coef[3]    * (schl_eff_math_on_treatment_rucc$coef[1]    + schl_eff_math_on_treatment_rucc$coef[2]    * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,2]   <- outcome_model_schl_res_math5_rucc$coef[3]    * (schl_res_on_treatment_rucc$coef[1]         + schl_res_on_treatment_rucc$coef[2]         * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,3]   <- outcome_model_schl_dis_math5_rucc$coef[3]    * (schl_dis_on_treatment_rucc$coef[1]         + schl_dis_on_treatment_rucc$coef[2]         * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,4]   <- outcome_model_schl_eff_read5_rucc$coef[3]    * (schl_eff_read_on_treatment_rucc$coef[1]    + schl_eff_read_on_treatment_rucc$coef[2]    * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,5]   <- outcome_model_schl_res_read5_rucc$coef[3]    * (schl_res_on_treatment_rucc$coef[1]         + schl_res_on_treatment_rucc$coef[2]         * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref_het[i,6]   <- outcome_model_schl_dis_read5_rucc$coef[3]    * (schl_dis_on_treatment_rucc$coef[1]         + schl_dis_on_treatment_rucc$coef[2]         * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])

  mibeta_rnde_het[i,1]   <- mibeta_cde_het[i,1]   + mibeta_rintref_het[i,1]
  mibeta_rnde_het[i,2]   <- mibeta_cde_het[i,2]   + mibeta_rintref_het[i,2]
  mibeta_rnde_het[i,3]   <- mibeta_cde_het[i,3]   + mibeta_rintref_het[i,3]
  mibeta_rnde_het[i,4]   <- mibeta_cde_het[i,4]   + mibeta_rintref_het[i,4]
  mibeta_rnde_het[i,5]   <- mibeta_cde_het[i,5]   + mibeta_rintref_het[i,5]
  mibeta_rnde_het[i,6]   <- mibeta_cde_het[i,6]   + mibeta_rintref_het[i,6]

  mibeta_rpie_het[i,1]   <- (schl_eff_math_on_treatment_rucc$coef[2]    * outcome_model_schl_eff_math5_rucc$coef[2]    + schl_eff_math_on_treatment_rucc$coef[2]    * outcome_model_schl_eff_math5_rucc$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,2]   <- (schl_res_on_treatment_rucc$coef[2]         * outcome_model_schl_res_math5_rucc$coef[2]    + schl_res_on_treatment_rucc$coef[2]         * outcome_model_schl_res_math5_rucc$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,3]   <- (schl_dis_on_treatment_rucc$coef[2]         * outcome_model_schl_dis_math5_rucc$coef[2]    + schl_dis_on_treatment_rucc$coef[2]         * outcome_model_schl_dis_math5_rucc$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,4]   <- (schl_eff_read_on_treatment_rucc$coef[2]    * outcome_model_schl_eff_read5_rucc$coef[2]    + schl_eff_read_on_treatment_rucc$coef[2]    * outcome_model_schl_eff_read5_rucc$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,5]   <- (schl_res_on_treatment_rucc$coef[2]         * outcome_model_schl_res_read5_rucc$coef[2]    + schl_res_on_treatment_rucc$coef[2]         * outcome_model_schl_res_read5_rucc$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie_het[i,6]   <- (schl_dis_on_treatment_rucc$coef[2]         * outcome_model_schl_dis_read5_rucc$coef[2]    + schl_dis_on_treatment_rucc$coef[2]         * outcome_model_schl_dis_read5_rucc$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])

  mibeta_rintmed_het[i,1]   <- schl_eff_math_on_treatment_rucc$coef[2]    * outcome_model_schl_eff_math5_rucc$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,2]   <- schl_res_on_treatment_rucc$coef[2]         * outcome_model_schl_res_math5_rucc$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,3]   <- schl_dis_on_treatment_rucc$coef[2]         * outcome_model_schl_dis_math5_rucc$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,4]   <- schl_eff_read_on_treatment_rucc$coef[2]    * outcome_model_schl_eff_read5_rucc$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,5]   <- schl_res_on_treatment_rucc$coef[2]         * outcome_model_schl_res_read5_rucc$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rintmed_het[i,6]   <- schl_dis_on_treatment_rucc$coef[2]         * outcome_model_schl_dis_read5_rucc$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2

  mibeta_rnie_het[i,1]   <- mibeta_rpie_het[i,1]   + mibeta_rintmed_het[i,1]
  mibeta_rnie_het[i,2]   <- mibeta_rpie_het[i,2]   + mibeta_rintmed_het[i,2]
  mibeta_rnie_het[i,3]   <- mibeta_rpie_het[i,3]   + mibeta_rintmed_het[i,3]
  mibeta_rnie_het[i,4]   <- mibeta_rpie_het[i,4]   + mibeta_rintmed_het[i,4]
  mibeta_rnie_het[i,5]   <- mibeta_rpie_het[i,5]   + mibeta_rintmed_het[i,5]
  mibeta_rnie_het[i,6]   <- mibeta_rpie_het[i,6]   + mibeta_rintmed_het[i,6]

  mibeta_rate_het[i,1]   <- mibeta_rnde_het[i,1]   + mibeta_rnie_het[i,1]
  mibeta_rate_het[i,2]   <- mibeta_rnde_het[i,2]   + mibeta_rnie_het[i,2]
  mibeta_rate_het[i,3]   <- mibeta_rnde_het[i,3]   + mibeta_rnie_het[i,3]
  mibeta_rate_het[i,4]   <- mibeta_rnde_het[i,4]   + mibeta_rnie_het[i,4]
  mibeta_rate_het[i,5]   <- mibeta_rnde_het[i,5]   + mibeta_rnie_het[i,5]
  mibeta_rate_het[i,6]   <- mibeta_rnde_het[i,6]   + mibeta_rnie_het[i,6]

  # Compute block bootstrap SEs
  
  set.seed(123)
  
  bootdist_rate_het <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  bootdist_rnde_het    <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_cde_het     <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_rintref_het <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  bootdist_rnie_het    <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_rpie_het    <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_rintmed_het <- matrix(data = NA, nrow = nboot, ncol = 6)
  
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
    schl_eff_math_on_treatment_rucc.boot <- lm(re_impact_math ~ 
                                            trct_disadv_index2 + 
                                            c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                            mmarriedbirth + childweightlow + female +
                                            black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                            d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                            m_less_than_thirty_five_hrs_pw + m_emp_other +
                                            rucc_treat + rucc +
                                            c1r4mtht_r_mean,
                                          data = analytic_sample.boot)
    
    schl_eff_read_on_treatment_rucc.boot <- lm(re_impact_read ~ 
                                            trct_disadv_index2 + 
                                            c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                            mmarriedbirth + childweightlow + female +
                                            black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                            d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                            m_less_than_thirty_five_hrs_pw + m_emp_other +
                                            rucc_treat + rucc +
                                            c1r4rtht_r_mean,
                                          data = analytic_sample.boot)
    
    schl_res_on_treatment_rucc.boot <- lm(school_resources ~ 
                                       trct_disadv_index2 + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other +
                                       rucc_treat + rucc +
                                     c1r4rtht_r_mean,
                                     data = analytic_sample.boot)
    
    schl_dis_on_treatment_rucc.boot <- lm(school_disorder ~ 
                                       trct_disadv_index2 + 
                                       c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                       mmarriedbirth + childweightlow + female +
                                       black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                       high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                       d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                       m_less_than_thirty_five_hrs_pw + m_emp_other +
                                       rucc_treat + rucc +
                                       c1r4rtht_r_mean,
                                     data = analytic_sample.boot)
    
    free_lunch_on_treatment_rucc.boot <- lm(nschlnch99_percent ~ 
                                         trct_disadv_index2 + 
                                         c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                         mmarriedbirth + childweightlow + female +
                                         black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                         high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                         d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                         m_less_than_thirty_five_hrs_pw + m_emp_other +
                                         rucc_treat + rucc +
                                         c1r4rtht_r_mean,
                                       data = analytic_sample.boot)
    
    racial_comp_on_treatment_rucc.boot <- lm(S4NONWHTPCT ~ 
                                          trct_disadv_index2 + 
                                          c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                          mmarriedbirth + childweightlow + female +
                                          black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                          high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                          d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                          m_less_than_thirty_five_hrs_pw + m_emp_other +
                                          rucc_treat + rucc +
                                          c1r4rtht_r_mean,
                                        data = analytic_sample.boot)
    
    # RWR calculations
    analytic_sample.boot$nschlnch99_percent_r_rucc    <- NA
    analytic_sample.boot$nschlnch99_percent_r_rucc    <- residuals(free_lunch_on_treatment_rucc.boot)
    
    analytic_sample.boot$S4NONWHTPCT_r_rucc    <- NA
    analytic_sample.boot$S4NONWHTPCT_r_rucc    <- residuals(racial_comp_on_treatment_rucc.boot)
    
    # Add variables for mediator-by-treatment interaction
    analytic_sample.boot$math_impact_x_treatment_re <- analytic_sample.boot$re_impact_math * analytic_sample.boot$trct_disadv_index2
    analytic_sample.boot$read_impact_x_treatment_re <- analytic_sample.boot$re_impact_read * analytic_sample.boot$trct_disadv_index2
    
    analytic_sample.boot$school_resources_x_treatment <- analytic_sample.boot$school_resources * analytic_sample.boot$trct_disadv_index2
    analytic_sample.boot$school_disorder_x_treatment  <- analytic_sample.boot$school_disorder  * analytic_sample.boot$trct_disadv_index2
    
    
    
    # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
    outcome_model_schl_eff_math5_rucc.boot <- eivreg(c5r4mtht_r ~ 
                                                  re_impact_math + 
                                                  math_impact_x_treatment_re +
                                                  trct_disadv_index2 + 
                                                  nschlnch99_percent_r_rucc + 
                                                  S4NONWHTPCT_r_rucc + 
                                                  c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                  rucc_treat + rucc_med_math_eff + rucc_treat_med_math_eff + rucc +
                                                  c1r4mtht_r_mean,
                                                data = analytic_sample.boot,
                                                reliability = reliability_vector_math_re_rucc)
    
    outcome_model_schl_res_math5_rucc.boot <- lm(c5r4mtht_r ~ 
                                              school_resources + 
                                              school_resources_x_treatment +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r_rucc + 
                                              S4NONWHTPCT_r_rucc + 
                                              c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              rucc_treat + rucc_med_schl_res + rucc_treat_med_schl_res + rucc +
                                              c1r4mtht_r_mean,
                                            data = analytic_sample.boot)
    
    outcome_model_schl_dis_math5_rucc.boot <- lm(c5r4mtht_r ~ 
                                              school_disorder + 
                                              school_disorder_x_treatment +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r_rucc + 
                                              S4NONWHTPCT_r_rucc + 
                                              c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              rucc_treat + rucc_med_schl_dis + rucc_treat_med_schl_dis + rucc +
                                              c1r4mtht_r_mean,
                                            data = analytic_sample.boot)
    
    outcome_model_schl_eff_read5_rucc.boot <- eivreg(c5r4rtht_r ~ 
                                                  re_impact_read + 
                                                  read_impact_x_treatment_re +
                                                  trct_disadv_index2 + 
                                                  nschlnch99_percent_r_rucc + 
                                                  S4NONWHTPCT_r_rucc + 
                                                  c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                                  mmarriedbirth + childweightlow + female +
                                                  black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                                  high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                                  d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                                  m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                                  rucc_treat + rucc_med_read_eff + rucc_treat_med_read_eff + rucc +
                                                  c1r4rtht_r_mean,
                                                data = analytic_sample.boot,
                                                reliability = reliability_vector_read_re_rucc)
    
    outcome_model_schl_res_read5_rucc.boot <- lm(c5r4rtht_r ~ 
                                              school_resources + 
                                              school_resources_x_treatment +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r_rucc + 
                                              S4NONWHTPCT_r_rucc + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              rucc_treat + rucc_med_schl_res + rucc_treat_med_schl_res + rucc +
                                              c1r4rtht_r_mean,
                                            data = analytic_sample.boot)
    
    outcome_model_schl_dis_read5_rucc.boot <- lm(c5r4rtht_r ~ 
                                              school_disorder + 
                                              school_disorder_x_treatment +
                                              trct_disadv_index2 + 
                                              nschlnch99_percent_r_rucc + 
                                              S4NONWHTPCT_r_rucc + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other + 
                                              rucc_treat + rucc_med_schl_dis + rucc_treat_med_schl_dis + rucc +
                                              c1r4rtht_r_mean,
                                            data = analytic_sample.boot)
    
    # Appendix E
    bootdist_cde_het[j,1]   <- (outcome_model_schl_eff_math5_rucc.boot$coef[4]    + outcome_model_schl_eff_math5_rucc.boot$coef[3]    * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,2]   <- (outcome_model_schl_res_math5_rucc.boot$coef[4]    + outcome_model_schl_res_math5_rucc.boot$coef[3]    * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,3]   <- (outcome_model_schl_dis_math5_rucc.boot$coef[4]    + outcome_model_schl_dis_math5_rucc.boot$coef[3]    * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,4]   <- (outcome_model_schl_eff_read5_rucc.boot$coef[4]    + outcome_model_schl_eff_read5_rucc.boot$coef[3]    * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,5]   <- (outcome_model_schl_res_read5_rucc.boot$coef[4]    + outcome_model_schl_res_read5_rucc.boot$coef[3]    * m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_cde_het[j,6]   <- (outcome_model_schl_dis_read5_rucc.boot$coef[4]    + outcome_model_schl_dis_read5_rucc.boot$coef[3]    * m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintref_het[j,1]   <- outcome_model_schl_eff_math5_rucc.boot$coef[3]    * (schl_eff_math_on_treatment_rucc.boot$coef[1]    + schl_eff_math_on_treatment_rucc.boot$coef[2]    * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,2]   <- outcome_model_schl_res_math5_rucc.boot$coef[3]    * (schl_res_on_treatment_rucc.boot$coef[1]         + schl_res_on_treatment_rucc.boot$coef[2]         * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,3]   <- outcome_model_schl_dis_math5_rucc.boot$coef[3]    * (schl_dis_on_treatment_rucc.boot$coef[1]         + schl_dis_on_treatment_rucc.boot$coef[2]         * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,4]   <- outcome_model_schl_eff_read5_rucc.boot$coef[3]    * (schl_eff_read_on_treatment_rucc.boot$coef[1]    + schl_eff_read_on_treatment_rucc.boot$coef[2]    * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,5]   <- outcome_model_schl_res_read5_rucc.boot$coef[3]    * (schl_res_on_treatment_rucc.boot$coef[1]         + schl_res_on_treatment_rucc.boot$coef[2]         * pc_treatment[1] - m_star_res)      * (pc_treatment[2] - pc_treatment[1])
    bootdist_rintref_het[j,6]   <- outcome_model_schl_dis_read5_rucc.boot$coef[3]    * (schl_dis_on_treatment_rucc.boot$coef[1]         + schl_dis_on_treatment_rucc.boot$coef[2]         * pc_treatment[1] - m_star_dis)      * (pc_treatment[2] - pc_treatment[1])

    bootdist_rnde_het[j,1]   <- bootdist_cde_het[j,1]   + bootdist_rintref_het[j,1]
    bootdist_rnde_het[j,2]   <- bootdist_cde_het[j,2]   + bootdist_rintref_het[j,2]
    bootdist_rnde_het[j,3]   <- bootdist_cde_het[j,3]   + bootdist_rintref_het[j,3]
    bootdist_rnde_het[j,4]   <- bootdist_cde_het[j,4]   + bootdist_rintref_het[j,4]
    bootdist_rnde_het[j,5]   <- bootdist_cde_het[j,5]   + bootdist_rintref_het[j,5]
    bootdist_rnde_het[j,6]   <- bootdist_cde_het[j,6]   + bootdist_rintref_het[j,6]
    
    bootdist_rpie_het[j,1]   <- (schl_eff_math_on_treatment_rucc.boot$coef[2]    * outcome_model_schl_eff_math5_rucc.boot$coef[2]    + schl_eff_math_on_treatment_rucc.boot$coef[2]    * outcome_model_schl_eff_math5_rucc.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,2]   <- (schl_res_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_res_math5_rucc.boot$coef[2]    + schl_res_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_res_math5_rucc.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,3]   <- (schl_dis_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_dis_math5_rucc.boot$coef[2]    + schl_dis_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_dis_math5_rucc.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,4]   <- (schl_eff_read_on_treatment_rucc.boot$coef[2]    * outcome_model_schl_eff_read5_rucc.boot$coef[2]    + schl_eff_read_on_treatment_rucc.boot$coef[2]    * outcome_model_schl_eff_read5_rucc.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,5]   <- (schl_res_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_res_read5_rucc.boot$coef[2]    + schl_res_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_res_read5_rucc.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    bootdist_rpie_het[j,6]   <- (schl_dis_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_dis_read5_rucc.boot$coef[2]    + schl_dis_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_dis_read5_rucc.boot$coef[3]    * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
    
    bootdist_rintmed_het[j,1]   <- schl_eff_math_on_treatment_rucc.boot$coef[2]    * outcome_model_schl_eff_math5_rucc.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,2]   <- schl_res_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_res_math5_rucc.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,3]   <- schl_dis_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_dis_math5_rucc.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,4]   <- schl_eff_read_on_treatment_rucc.boot$coef[2]    * outcome_model_schl_eff_read5_rucc.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,5]   <- schl_res_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_res_read5_rucc.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    bootdist_rintmed_het[j,6]   <- schl_dis_on_treatment_rucc.boot$coef[2]         * outcome_model_schl_dis_read5_rucc.boot$coef[3]    * (pc_treatment[2] - pc_treatment[1])^2
    
    bootdist_rnie_het[j,1]   <- bootdist_rpie_het[j,1]   + bootdist_rintmed_het[j,1]
    bootdist_rnie_het[j,2]   <- bootdist_rpie_het[j,2]   + bootdist_rintmed_het[j,2]
    bootdist_rnie_het[j,3]   <- bootdist_rpie_het[j,3]   + bootdist_rintmed_het[j,3]
    bootdist_rnie_het[j,4]   <- bootdist_rpie_het[j,4]   + bootdist_rintmed_het[j,4]
    bootdist_rnie_het[j,5]   <- bootdist_rpie_het[j,5]   + bootdist_rintmed_het[j,5]
    bootdist_rnie_het[j,6]   <- bootdist_rpie_het[j,6]   + bootdist_rintmed_het[j,6]
    
    bootdist_rate_het[j,1]   <- bootdist_rnde_het[j,1]   + bootdist_rnie_het[j,1]
    bootdist_rate_het[j,2]   <- bootdist_rnde_het[j,2]   + bootdist_rnie_het[j,2]
    bootdist_rate_het[j,3]   <- bootdist_rnde_het[j,3]   + bootdist_rnie_het[j,3]
    bootdist_rate_het[j,4]   <- bootdist_rnde_het[j,4]   + bootdist_rnie_het[j,4]
    bootdist_rate_het[j,5]   <- bootdist_rnde_het[j,5]   + bootdist_rnie_het[j,5]
    bootdist_rate_het[j,6]   <- bootdist_rnde_het[j,6]   + bootdist_rnie_het[j,6]

    }
  
  for (m in 1:6) {
    
    mivar_rate_het[i,m]        <- var(bootdist_rate_het[,m])
    mivar_rnde_het[i,m]        <- var(bootdist_rnde_het[,m])
    mivar_cde_het[i,m]         <- var(bootdist_cde_het[,m])
    mivar_rintref_het[i,m]     <- var(bootdist_rintref_het[,m])
    mivar_rnie_het[i,m]        <- var(bootdist_rnie_het[,m])
    mivar_rpie_het[i,m]        <- var(bootdist_rpie_het[,m])
    mivar_rintmed_het[i,m]     <- var(bootdist_rintmed_het[,m])
    
  }
  
}





### Combine MI estimates ###

rate_het_est        <- matrix(data=NA, nrow=6, ncol=4)
rnde_het_est        <- matrix(data=NA, nrow=6, ncol=4)
cde_het_est         <- matrix(data=NA, nrow=6, ncol=4)
rintref_het_est     <- matrix(data=NA, nrow=6, ncol=4)
rnie_het_est        <- matrix(data=NA, nrow=6, ncol=4)
rpie_het_est        <- matrix(data=NA, nrow=6, ncol=4)
rintmed_het_est     <- matrix(data=NA, nrow=6, ncol=4)

for (i in 1:6) {
  
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

}





### Print results ###

sink("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/logs-replicate-study/4-ancillary-analyses/5-generate-rucc-effect-mod.txt")

cat("===========================================\n")

cat("===========================================\n")
cat("Appendix E.7\n")
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
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")
cat("\n")
cat("\n")

cat("===========================================\n")
cat("Appendix E.8\n")
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
cat("\n")
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")


sink()
