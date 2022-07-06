#######################################################################################
# COMPUTE ESTIMATES BASED ON CONVENTIONAL VALUE-ADDED MEASURE OF SCHOOL EFFECTIVENESS #
#######################################################################################

rm(list=ls())

library(foreign)
library(eivtools)

nmi <- 50
nboot <- 500

#########################
### INPUT/RECODE DATA ###
#########################

### Input data ###
analytic_sample_post_mi <- read.dta("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/data-replicate-study/data-replicate-study/Merge/ancillary-analytic-sample-post-mi.dta")

### Remove original non-imputed dataset ###
vars <- c(
  "c5r4mtht_r", "c5r4rtht_r",
  "valueAdd_read", "valueAdd_math",
  "puptchr99", "B4YRSTC_sch", "YKBASSAL_sch", "advdeg_sch", "ndstexp99",
  "A4ABSEN_r_sch", "A4BEHVR_r_sch",
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
  "S3_ID", "_mi_m")

analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" != 0), vars]

### Standardize variables ###
# Outcome
analytic_sample_post_mi$c5r4mtht_r <- ((analytic_sample_post_mi$c5r4mtht_r - mean(analytic_sample_post_mi$c5r4mtht_r)) / sd(analytic_sample_post_mi$c5r4mtht_r))
analytic_sample_post_mi$c5r4rtht_r <- ((analytic_sample_post_mi$c5r4rtht_r - mean(analytic_sample_post_mi$c5r4rtht_r)) / sd(analytic_sample_post_mi$c5r4rtht_r))

# Mediator: school effectiveness
analytic_sample_post_mi$valueAdd_read <- ((analytic_sample_post_mi$valueAdd_read - mean(analytic_sample_post_mi$valueAdd_read)) / sd(analytic_sample_post_mi$valueAdd_read))
analytic_sample_post_mi$valueAdd_math <- ((analytic_sample_post_mi$valueAdd_math - mean(analytic_sample_post_mi$valueAdd_math)) / sd(analytic_sample_post_mi$valueAdd_math))

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

####################
### CALCULATIONS ###
####################

### Initialize matrices to store beta/var values ###

mibeta_rate <- matrix(data = NA, nrow = nmi, ncol = 2) 
mivar_rate  <- matrix(data = NA, nrow = nmi, ncol = 2)

mibeta_rnde    <- matrix(data = NA, nrow = nmi, ncol = 2)
mivar_rnde     <- matrix(data = NA, nrow = nmi, ncol = 2)
mibeta_cde     <- matrix(data = NA, nrow = nmi, ncol = 2)
mivar_cde      <- matrix(data = NA, nrow = nmi, ncol = 2)
mibeta_rintref <- matrix(data = NA, nrow = nmi, ncol = 2)
mivar_rintref  <- matrix(data = NA, nrow = nmi, ncol = 2)

mibeta_rnie    <- matrix(data = NA, nrow = nmi, ncol = 2)
mivar_rnie     <- matrix(data = NA, nrow = nmi, ncol = 2)
mibeta_rpie    <- matrix(data = NA, nrow = nmi, ncol = 2)
mivar_rpie     <- matrix(data = NA, nrow = nmi, ncol = 2)
mibeta_rintmed <- matrix(data = NA, nrow = nmi, ncol = 2)
mivar_rintmed  <- matrix(data = NA, nrow = nmi, ncol = 2)

### Loop through imputed datasets ###

for (i in 1:nmi) {
  
  # Select imputed dataset
  analytic_sample <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" == i), ]
    
  # Percentile calculations
  
  # Treatment
  pc_treatment <- quantile(analytic_sample$trct_disadv_index2, probs=c(0.2, 0.8), na.rm=TRUE)
  
  # Value add
  pc_valueAdd_read <- quantile(analytic_sample$valueAdd_read, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_valueAdd_math <- quantile(analytic_sample$valueAdd_read, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  
  m_star_eff_read <- pc_valueAdd_read[2]
  m_star_eff_math <- pc_valueAdd_math[2] 
  
  # Compute mediator-by-treatment correlations
  cor_valueAdd_treatment_math <- cor(analytic_sample$valueAdd_math, analytic_sample$trct_disadv_index2)
  cor_valueAdd_treatment_read <- cor(analytic_sample$valueAdd_read, analytic_sample$trct_disadv_index2)

  # Reliabilities
  reliabilities <- seq(from = 0.8, to = 0.6, by = -0.1)
  idx <- 1

  interaction_rel_math <- c()
  interaction_rel_read <- c()

  interaction_rel_math_vec <- c()
  interaction_rel_read_vec <- c()

  reliability_vector_math_list <- list()
  reliability_vector_read_list <- list()
 
  for (r in reliabilities) {

    interaction_rel_math <- (r + cor_valueAdd_treatment_math^2) / (1 + cor_valueAdd_treatment_math^2)
    interaction_rel_read <- (r + cor_valueAdd_treatment_read^2) / (1 + cor_valueAdd_treatment_read^2)

    interaction_rel_math_vec <- c(interaction_rel_math_vec, interaction_rel_math)
    interaction_rel_read_vec <- c(interaction_rel_read_vec, interaction_rel_read)
    
    # Generate reliability vectors
    # valueAdded
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

    reliability_vector_math		 <- c(r, 
                                         interaction_rel_math, 
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
    
    reliability_vector_read		 <- c(r, 
                                         interaction_rel_read,
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

    names(reliability_vector_math) <- 
      c("valueAdd_math", 
        "valueAdd_math_x_treatment", 
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
    
    names(reliability_vector_read) <- 
      c("valueAdd_read", 
        "valueAdd_read_x_treatment", 
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

    reliability_vector_math_list[[idx]] <- reliability_vector_math
    reliability_vector_read_list[[idx]] <- reliability_vector_read
    
    idx <- idx + 1
    
  }

  # Fit Model 1: Mediator on treatment
  schl_eff_math_on_treatment <- lm(valueAdd_math ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample)
  
  schl_eff_read_on_treatment <- lm(valueAdd_read ~ 
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
   
  # Add variables for mediator-by-treatment interaction
  analytic_sample$valueAdd_math_x_treatment <- analytic_sample$valueAdd_math * analytic_sample$trct_disadv_index2
  analytic_sample$valueAdd_read_x_treatment <- analytic_sample$valueAdd_read * analytic_sample$trct_disadv_index2

  # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
    outcome_model_schl_eff_math5 <- eivreg(c5r4mtht_r ~ 
                                           valueAdd_math + 
                                           valueAdd_math_x_treatment +
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
                                         reliability = reliability_vector_math_list[[2]])


  outcome_model_schl_eff_read5 <- eivreg(c5r4rtht_r ~ 
                                           valueAdd_read + 
                                           valueAdd_read_x_treatment +
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
                                         reliability = reliability_vector_read_list[[2]])

  # Effects based on conventional value-added measures, Math
  mibeta_cde[i,1]  <- (outcome_model_schl_eff_math5$coef[4] + outcome_model_schl_eff_math5$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,1]  <- outcome_model_schl_eff_math5$coef[3] * (schl_eff_math_on_treatment$coef[1] + schl_eff_math_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,1]  <- (schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[2] + schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,1]  <- schl_eff_math_on_treatment$coef[2] * outcome_model_schl_eff_math5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,1]  <- mibeta_cde[i,1]  + mibeta_rintref[i,1]
  mibeta_rnie[i,1]  <- mibeta_rpie[i,1]  + mibeta_rintmed[i,1]
  mibeta_rate[i,1]  <- mibeta_rnde[i,1]  + mibeta_rnie[i,1]

  # Effects based on conventional value-added measures, Read
  mibeta_cde[i,2]  <- (outcome_model_schl_eff_read5$coef[4] + outcome_model_schl_eff_read5$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,2]  <- outcome_model_schl_eff_read5$coef[3] * (schl_eff_read_on_treatment$coef[1] + schl_eff_read_on_treatment$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,2]  <- (schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[2] + schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,2]  <- schl_eff_read_on_treatment$coef[2] * outcome_model_schl_eff_read5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,2]  <- mibeta_cde[i,2]  + mibeta_rintref[i,2]
  mibeta_rnie[i,2]  <- mibeta_rpie[i,2]  + mibeta_rintmed[i,2]
  mibeta_rate[i,2]  <- mibeta_rnde[i,2]  + mibeta_rnie[i,2]

  # Compute block bootstrap SEs
  
  set.seed(123)
  
  bootdist_rate <- matrix(data = NA, nrow = nboot, ncol = 2)

  bootdist_rnde    <- matrix(data = NA, nrow = nboot, ncol = 2)
  bootdist_cde     <- matrix(data = NA, nrow = nboot, ncol = 2)
  bootdist_rintref <- matrix(data = NA, nrow = nboot, ncol = 2)
  
  bootdist_rnie    <- matrix(data = NA, nrow = nboot, ncol = 2)
  bootdist_rpie    <- matrix(data = NA, nrow = nboot, ncol = 2)
  bootdist_rintmed <- matrix(data = NA, nrow = nboot, ncol = 2)
  
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
  schl_eff_math_on_treatment.boot <- lm(valueAdd_math ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample.boot)
  
  schl_eff_read_on_treatment.boot <- lm(valueAdd_read ~ 
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
 
    # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
    outcome_model_schl_eff_math5.boot <- eivreg(c5r4mtht_r ~ 
                                           valueAdd_math + 
                                           valueAdd_math_x_treatment +
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
                                         reliability = reliability_vector_math_list[[2]])


  outcome_model_schl_eff_read5.boot <- eivreg(c5r4rtht_r ~ 
                                           valueAdd_read + 
                                           valueAdd_read_x_treatment +
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
                                         reliability = reliability_vector_read_list[[2]])

  # Effects based on conventional value-added measures, Math
  bootdist_cde[j,1]  <- (outcome_model_schl_eff_math5.boot$coef[4] + outcome_model_schl_eff_math5.boot$coef[3] * m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,1]  <- outcome_model_schl_eff_math5.boot$coef[3] * (schl_eff_math_on_treatment.boot$coef[1] + schl_eff_math_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_math) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,1]  <- (schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[2] + schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,1]  <- schl_eff_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_math5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,1]  <- bootdist_cde[j,1]  + bootdist_rintref[j,1]
  bootdist_rnie[j,1]  <- bootdist_rpie[j,1]  + bootdist_rintmed[j,1]
  bootdist_rate[j,1]  <- bootdist_rnde[j,1]  + bootdist_rnie[j,1]

  # Effects based on conventional value-added measures, Read
  bootdist_cde[j,2]  <- (outcome_model_schl_eff_read5.boot$coef[4] + outcome_model_schl_eff_read5.boot$coef[3] * m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,2]  <- outcome_model_schl_eff_read5.boot$coef[3] * (schl_eff_read_on_treatment.boot$coef[1] + schl_eff_read_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_eff_read) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,2]  <- (schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[2] + schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,2]  <- schl_eff_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_read5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,2]  <- bootdist_cde[j,2]  + bootdist_rintref[j,2]
  bootdist_rnie[j,2]  <- bootdist_rpie[j,2]  + bootdist_rintmed[j,2]
  bootdist_rate[j,2]  <- bootdist_rnde[j,2]  + bootdist_rnie[j,2]

  }
  
  for (m in 1:2) {
    
    mivar_rate[i,m]        <- var(bootdist_rate[,m])
    mivar_rnde[i,m]        <- var(bootdist_rnde[,m])
    mivar_cde[i,m]         <- var(bootdist_cde[,m])
    mivar_rintref[i,m]     <- var(bootdist_rintref[,m])
    mivar_rnie[i,m]        <- var(bootdist_rnie[,m])
    mivar_rpie[i,m]        <- var(bootdist_rpie[,m])
    mivar_rintmed[i,m]     <- var(bootdist_rintmed[,m])

  }

}

### Combine MI estimates ###
rate_est        <- matrix(data=NA, nrow=2, ncol=4)
rnde_est        <- matrix(data=NA, nrow=2, ncol=4)
cde_est         <- matrix(data=NA, nrow=2, ncol=4)
rintref_est     <- matrix(data=NA, nrow=2, ncol=4)
rnie_est        <- matrix(data=NA, nrow=2, ncol=4)
rpie_est        <- matrix(data=NA, nrow=2, ncol=4)
rintmed_est     <- matrix(data=NA, nrow=2, ncol=4)

for (i in 1:2) {
  
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

}

### Print results ###
sink("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/logs-replicate-study/4-ancillary-analyses/3-generate-valueAdd-schl-effectiveness-est.txt")

cat("===========================================\n")
cat("Table F.5: School Effectiveness = conventional value-added esti from lagged DV model\n")
cat("RATE\n")
print(rate_est)
cat("\n")
cat("RNDE\n")
print(rnde_est)
cat("\n")
cat("CDE(0)\n")
print(cde_est)
cat("\n")
cat("RINT_ref\n")
print(rintref_est)
cat("\n")
cat("RNIE\n")
print(rnie_est)
cat("\n")
cat("RPIE\n")
print(rpie_est)
cat("\n")
cat("RINT_med\n")
print(rintmed_est)
cat("===========================================\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")

sink()
