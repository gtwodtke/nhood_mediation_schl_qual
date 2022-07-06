###########################################################################
# COMPUTE ESTIMATES BASED ON ALTERNATIVE MEASURES OF SCHOOL EFFECTIVENESS #
###########################################################################

rm(list=ls())

library(foreign)
library(eivtools)

nmi <- 50
nboot <- 500

#########################
### INPUT/RECODE DATA ###
#########################

### Input data ###
analytic_sample_post_mi <- read.dta("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/data-replicate-study/data-replicate-study/Merge/analytic-sample-post-mi-R.dta")

### Remove original non-imputed dataset ###
vars <- c(
  "c5r4mtht_r", "c5r4rtht_r", "c6r4mtht_r", "c6r4rtht_r", "c7r4mtht_r", "c7r4rtht_r",
  "re_impact_math", "re_impact_math_ver2", "re_impact_math_ver3",
  "re_impact_read", "re_impact_read_ver2", "re_impact_read_ver3",
  "re_impact_read_first_only", "re_impact_math_first_only",
  "re_impact_read_summer_only", "re_impact_math_summer_only",
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
  "S3_ID", "_mi_m")

analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" != 0), vars]

### Create alternative measures of school effectiveness ###
analytic_sample_post_mi$re_impact_read_ver2 <- analytic_sample_post_mi$re_impact_read_first_only
analytic_sample_post_mi$re_impact_math_ver2 <- analytic_sample_post_mi$re_impact_math_first_only

analytic_sample_post_mi$re_impact_read_ver3 <- analytic_sample_post_mi$re_impact_read_first_only - (0.5*analytic_sample_post_mi$re_impact_read_summer_only)
analytic_sample_post_mi$re_impact_math_ver3 <- analytic_sample_post_mi$re_impact_math_first_only - (0.5*analytic_sample_post_mi$re_impact_math_summer_only)

analytic_sample_post_mi$re_impact_read_ver4 <- 0.5*(analytic_sample_post_mi$re_impact_read_first_only + analytic_sample_post_mi$re_impact_read_summer_only)
analytic_sample_post_mi$re_impact_math_ver4 <- 0.5*(analytic_sample_post_mi$re_impact_math_first_only + analytic_sample_post_mi$re_impact_math_summer_only)

analytic_sample_post_mi$re_impact_read_ver5 <- (0.75*analytic_sample_post_mi$re_impact_read_first_only) + (0.25*analytic_sample_post_mi$re_impact_read_summer_only)
analytic_sample_post_mi$re_impact_math_ver5 <- (0.75*analytic_sample_post_mi$re_impact_math_first_only) + (0.25*analytic_sample_post_mi$re_impact_math_summer_only)

### Standardize variables ###
# Outcome
analytic_sample_post_mi$c5r4mtht_r <- ((analytic_sample_post_mi$c5r4mtht_r - mean(analytic_sample_post_mi$c5r4mtht_r)) / sd(analytic_sample_post_mi$c5r4mtht_r))
analytic_sample_post_mi$c5r4rtht_r <- ((analytic_sample_post_mi$c5r4rtht_r - mean(analytic_sample_post_mi$c5r4rtht_r)) / sd(analytic_sample_post_mi$c5r4rtht_r))

# Mediator: school effectiveness
analytic_sample_post_mi$re_impact_math_ver2 <- ((analytic_sample_post_mi$re_impact_math_ver2 - mean(analytic_sample_post_mi$re_impact_math_ver2)) / sd(analytic_sample_post_mi$re_impact_math_ver2))
analytic_sample_post_mi$re_impact_read_ver2 <- ((analytic_sample_post_mi$re_impact_read_ver2 - mean(analytic_sample_post_mi$re_impact_read_ver2)) / sd(analytic_sample_post_mi$re_impact_read_ver2))

analytic_sample_post_mi$re_impact_math_ver3 <- ((analytic_sample_post_mi$re_impact_math_ver3 - mean(analytic_sample_post_mi$re_impact_math_ver3)) / sd(analytic_sample_post_mi$re_impact_math_ver3))
analytic_sample_post_mi$re_impact_read_ver3 <- ((analytic_sample_post_mi$re_impact_read_ver3 - mean(analytic_sample_post_mi$re_impact_read_ver3)) / sd(analytic_sample_post_mi$re_impact_read_ver3))

analytic_sample_post_mi$re_impact_math_ver4 <- ((analytic_sample_post_mi$re_impact_math_ver4 - mean(analytic_sample_post_mi$re_impact_math_ver4)) / sd(analytic_sample_post_mi$re_impact_math_ver4))
analytic_sample_post_mi$re_impact_read_ver4 <- ((analytic_sample_post_mi$re_impact_read_ver4 - mean(analytic_sample_post_mi$re_impact_read_ver4)) / sd(analytic_sample_post_mi$re_impact_read_ver4))

analytic_sample_post_mi$re_impact_math_ver5 <- ((analytic_sample_post_mi$re_impact_math_ver5 - mean(analytic_sample_post_mi$re_impact_math_ver5)) / sd(analytic_sample_post_mi$re_impact_math_ver5))
analytic_sample_post_mi$re_impact_read_ver5 <- ((analytic_sample_post_mi$re_impact_read_ver5 - mean(analytic_sample_post_mi$re_impact_read_ver5)) / sd(analytic_sample_post_mi$re_impact_read_ver5))

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

mibeta_rate <- matrix(data = NA, nrow = nmi, ncol = 8) 
mivar_rate  <- matrix(data = NA, nrow = nmi, ncol = 8)

mibeta_rnde    <- matrix(data = NA, nrow = nmi, ncol = 8)
mivar_rnde     <- matrix(data = NA, nrow = nmi, ncol = 8)
mibeta_cde     <- matrix(data = NA, nrow = nmi, ncol = 8)
mivar_cde      <- matrix(data = NA, nrow = nmi, ncol = 8)
mibeta_rintref <- matrix(data = NA, nrow = nmi, ncol = 8)
mivar_rintref  <- matrix(data = NA, nrow = nmi, ncol = 8)

mibeta_rnie    <- matrix(data = NA, nrow = nmi, ncol = 8)
mivar_rnie     <- matrix(data = NA, nrow = nmi, ncol = 8)
mibeta_rpie    <- matrix(data = NA, nrow = nmi, ncol = 8)
mivar_rpie     <- matrix(data = NA, nrow = nmi, ncol = 8)
mibeta_rintmed <- matrix(data = NA, nrow = nmi, ncol = 8)
mivar_rintmed  <- matrix(data = NA, nrow = nmi, ncol = 8)

### Loop through imputed datasets ###

for (i in 1:nmi) {
  
  # Select imputed dataset
  analytic_sample <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" == i), ]
    
  # Percentile calculations
  
  # Treatment
  pc_treatment <- quantile(analytic_sample$trct_disadv_index2, probs=c(0.2, 0.8), na.rm=TRUE)
  
  # Math impact score
  pc_schl_eff_math_ver2 <- quantile(analytic_sample$re_impact_math_ver2, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_schl_eff_math_ver3 <- quantile(analytic_sample$re_impact_math_ver3, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_schl_eff_math_ver4 <- quantile(analytic_sample$re_impact_math_ver4, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_schl_eff_math_ver5 <- quantile(analytic_sample$re_impact_math_ver5, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  
  # Reading impact score
  pc_schl_eff_read_ver2 <- quantile(analytic_sample$re_impact_read_ver2, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_schl_eff_read_ver3 <- quantile(analytic_sample$re_impact_read_ver3, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_schl_eff_read_ver4 <- quantile(analytic_sample$re_impact_read_ver4, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_schl_eff_read_ver5 <- quantile(analytic_sample$re_impact_read_ver5, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)

  m_star_eff_math_ver2 <- pc_schl_eff_math_ver2[2]
  m_star_eff_math_ver3 <- pc_schl_eff_math_ver3[2] 
  m_star_eff_math_ver4 <- pc_schl_eff_math_ver4[2]
  m_star_eff_math_ver5 <- pc_schl_eff_math_ver5[2]

  m_star_eff_read_ver2 <- pc_schl_eff_read_ver2[2]
  m_star_eff_read_ver3 <- pc_schl_eff_read_ver3[2]  
  m_star_eff_read_ver4 <- pc_schl_eff_read_ver4[2]
  m_star_eff_read_ver5 <- pc_schl_eff_read_ver5[2]
  
  # Compute impact-by-treatment correlations
  cor_impact_treatment_math_re_ver2 <- cor(analytic_sample$re_impact_math_ver2, analytic_sample$trct_disadv_index2)
  cor_impact_treatment_read_re_ver2 <- cor(analytic_sample$re_impact_read_ver2, analytic_sample$trct_disadv_index2)

  cor_impact_treatment_math_re_ver3 <- cor(analytic_sample$re_impact_math_ver3, analytic_sample$trct_disadv_index2)
  cor_impact_treatment_read_re_ver3 <- cor(analytic_sample$re_impact_read_ver3, analytic_sample$trct_disadv_index2)

  cor_impact_treatment_math_re_ver4 <- cor(analytic_sample$re_impact_math_ver4, analytic_sample$trct_disadv_index2)
  cor_impact_treatment_read_re_ver4 <- cor(analytic_sample$re_impact_read_ver4, analytic_sample$trct_disadv_index2)
  
  cor_impact_treatment_math_re_ver5 <- cor(analytic_sample$re_impact_math_ver5, analytic_sample$trct_disadv_index2)
  cor_impact_treatment_read_re_ver5 <- cor(analytic_sample$re_impact_read_ver5, analytic_sample$trct_disadv_index2)
    
  # Reliabilities
  reliabilities <- seq(from = 0.8, to = 0.6, by = -0.1)
  idx <- 1

  interaction_rel_math_re_ver2_vec <- c()
  interaction_rel_read_re_ver2_vec <- c()

  interaction_rel_math_re_ver3_vec <- c()
  interaction_rel_read_re_ver3_vec <- c()

  interaction_rel_math_re_ver4_vec <- c()
  interaction_rel_read_re_ver4_vec <- c()
  
  interaction_rel_math_re_ver5_vec <- c()
  interaction_rel_read_re_ver5_vec <- c()

  reliability_vector_math_re_ver2_list <- list()
  reliability_vector_read_re_ver2_list <- list()

  reliability_vector_math_re_ver3_list <- list()
  reliability_vector_read_re_ver3_list <- list()
  
  reliability_vector_math_re_ver4_list <- list()
  reliability_vector_read_re_ver4_list <- list()
  
  reliability_vector_math_re_ver5_list <- list()
  reliability_vector_read_re_ver5_list <- list()
 
  for (r in reliabilities) {

    interaction_rel_math_re_ver2 <- (r + cor_impact_treatment_math_re_ver2^2) / (1 + cor_impact_treatment_math_re_ver2^2)
    interaction_rel_read_re_ver2 <- (r + cor_impact_treatment_read_re_ver2^2) / (1 + cor_impact_treatment_read_re_ver2^2)

    interaction_rel_math_re_ver3 <- (r + cor_impact_treatment_math_re_ver3^2) / (1 + cor_impact_treatment_math_re_ver3^2)
    interaction_rel_read_re_ver3 <- (r + cor_impact_treatment_read_re_ver3^2) / (1 + cor_impact_treatment_read_re_ver3^2)

    interaction_rel_math_re_ver4 <- (r + cor_impact_treatment_math_re_ver4^2) / (1 + cor_impact_treatment_math_re_ver4^2)
    interaction_rel_read_re_ver4 <- (r + cor_impact_treatment_read_re_ver4^2) / (1 + cor_impact_treatment_read_re_ver4^2)
    
    interaction_rel_math_re_ver5 <- (r + cor_impact_treatment_math_re_ver5^2) / (1 + cor_impact_treatment_math_re_ver5^2)
    interaction_rel_read_re_ver5 <- (r + cor_impact_treatment_read_re_ver5^2) / (1 + cor_impact_treatment_read_re_ver5^2)

    interaction_rel_math_re_ver2_vec <- c(interaction_rel_math_re_ver2_vec, interaction_rel_math_re_ver2)
    interaction_rel_read_re_ver2_vec <- c(interaction_rel_read_re_ver2_vec, interaction_rel_read_re_ver2)

    interaction_rel_math_re_ver3_vec <- c(interaction_rel_math_re_ver3_vec, interaction_rel_math_re_ver3)
    interaction_rel_read_re_ver3_vec <- c(interaction_rel_read_re_ver3_vec, interaction_rel_read_re_ver3)
    
    interaction_rel_math_re_ver4_vec <- c(interaction_rel_math_re_ver4_vec, interaction_rel_math_re_ver4)
    interaction_rel_read_re_ver4_vec <- c(interaction_rel_read_re_ver4_vec, interaction_rel_read_re_ver4)
    
    interaction_rel_math_re_ver5_vec <- c(interaction_rel_math_re_ver5_vec, interaction_rel_math_re_ver5)
    interaction_rel_read_re_ver5_vec <- c(interaction_rel_read_re_ver5_vec, interaction_rel_read_re_ver5)
    
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

    reliability_vector_math_re_ver2 <- c(r, 
                                         interaction_rel_math_re_ver2, 
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
    
    reliability_vector_read_re_ver2 <- c(r, 
                                         interaction_rel_read_re_ver2,
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

    reliability_vector_math_re_ver3 <- c(r, 
                                         interaction_rel_math_re_ver3, 
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
    
    reliability_vector_read_re_ver3 <- c(r, 
                                         interaction_rel_read_re_ver3,
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
    
    reliability_vector_math_re_ver4 <- c(r, 
                                         interaction_rel_math_re_ver4, 
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
    
    reliability_vector_read_re_ver4 <- c(r, 
                                         interaction_rel_read_re_ver4,
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
    
    reliability_vector_math_re_ver5 <- c(r, 
                                         interaction_rel_math_re_ver5, 
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
    
    reliability_vector_read_re_ver5 <- c(r, 
                                         interaction_rel_read_re_ver5,
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

    names(reliability_vector_math_re_ver2) <- 
      c("re_impact_math_ver2", 
        "math_impact_x_treatment_re_ver2", 
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
    
    names(reliability_vector_read_re_ver2) <- 
      c("re_impact_read_ver2", 
        "read_impact_x_treatment_re_ver2", 
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

    names(reliability_vector_math_re_ver3) <- 
      c("re_impact_math_ver3", 
        "math_impact_x_treatment_re_ver3", 
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
    
    names(reliability_vector_read_re_ver3) <- 
      c("re_impact_read_ver3", 
        "read_impact_x_treatment_re_ver3", 
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
    
    names(reliability_vector_math_re_ver4) <- 
      c("re_impact_math_ver4", 
        "math_impact_x_treatment_re_ver4", 
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
    
    names(reliability_vector_read_re_ver4) <- 
      c("re_impact_read_ver4", 
        "read_impact_x_treatment_re_ver4", 
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
    
    names(reliability_vector_math_re_ver5) <- 
      c("re_impact_math_ver5", 
        "math_impact_x_treatment_re_ver5", 
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
    
    names(reliability_vector_read_re_ver5) <- 
      c("re_impact_read_ver5", 
        "read_impact_x_treatment_re_ver5", 
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

    reliability_vector_math_re_ver2_list[[idx]] <- reliability_vector_math_re_ver2
    reliability_vector_read_re_ver2_list[[idx]] <- reliability_vector_read_re_ver2

    reliability_vector_math_re_ver3_list[[idx]] <- reliability_vector_math_re_ver3
    reliability_vector_read_re_ver3_list[[idx]] <- reliability_vector_read_re_ver3
    
    reliability_vector_math_re_ver4_list[[idx]] <- reliability_vector_math_re_ver4
    reliability_vector_read_re_ver4_list[[idx]] <- reliability_vector_read_re_ver4
    
    reliability_vector_math_re_ver5_list[[idx]] <- reliability_vector_math_re_ver5
    reliability_vector_read_re_ver5_list[[idx]] <- reliability_vector_read_re_ver5
    
    idx <- idx + 1
    
  }

  # Fit Model 1: Mediator on treatment
  schl_eff_math_on_treatment_ver2 <- lm(re_impact_math_ver2 ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample)
  
  schl_eff_read_on_treatment_ver2 <- lm(re_impact_read_ver2 ~ 
                                     trct_disadv_index2 + 
                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4rtht_r_mean,
                                   data = analytic_sample)

  schl_eff_math_on_treatment_ver3 <- lm(re_impact_math_ver3 ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample)
  
  schl_eff_read_on_treatment_ver3 <- lm(re_impact_read_ver3 ~ 
                                     trct_disadv_index2 + 
                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4rtht_r_mean,
                                   data = analytic_sample)

  schl_eff_math_on_treatment_ver4 <- lm(re_impact_math_ver4 ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample)
  
  schl_eff_read_on_treatment_ver4 <- lm(re_impact_read_ver4 ~ 
                                     trct_disadv_index2 + 
                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4rtht_r_mean,
                                   data = analytic_sample)

  schl_eff_math_on_treatment_ver5 <- lm(re_impact_math_ver5 ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample)
  
  schl_eff_read_on_treatment_ver5 <- lm(re_impact_read_ver5 ~ 
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
  analytic_sample$math_impact_x_treatment_re_ver2 <- analytic_sample$re_impact_math_ver2 * analytic_sample$trct_disadv_index2
  analytic_sample$read_impact_x_treatment_re_ver2 <- analytic_sample$re_impact_read_ver2 * analytic_sample$trct_disadv_index2

  analytic_sample$math_impact_x_treatment_re_ver3 <- analytic_sample$re_impact_math_ver3 * analytic_sample$trct_disadv_index2
  analytic_sample$read_impact_x_treatment_re_ver3 <- analytic_sample$re_impact_read_ver3 * analytic_sample$trct_disadv_index2

  analytic_sample$math_impact_x_treatment_re_ver4 <- analytic_sample$re_impact_math_ver4 * analytic_sample$trct_disadv_index2
  analytic_sample$read_impact_x_treatment_re_ver4 <- analytic_sample$re_impact_read_ver4 * analytic_sample$trct_disadv_index2
  
  analytic_sample$math_impact_x_treatment_re_ver5 <- analytic_sample$re_impact_math_ver5 * analytic_sample$trct_disadv_index2
  analytic_sample$read_impact_x_treatment_re_ver5 <- analytic_sample$re_impact_read_ver5 * analytic_sample$trct_disadv_index2

  # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
    outcome_model_schl_eff_math5_ver2 <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math_ver2 + 
                                           math_impact_x_treatment_re_ver2 +
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
                                         reliability = reliability_vector_math_re_ver2_list[[2]])

    outcome_model_schl_eff_math5_ver3 <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math_ver3 + 
                                           math_impact_x_treatment_re_ver3 +
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
                                         reliability = reliability_vector_math_re_ver3_list[[2]])

    outcome_model_schl_eff_math5_ver4 <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math_ver4 + 
                                           math_impact_x_treatment_re_ver4 +
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
                                         reliability = reliability_vector_math_re_ver4_list[[2]])

  outcome_model_schl_eff_math5_ver5 <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math_ver5 + 
                                           math_impact_x_treatment_re_ver5 +
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
                                         reliability = reliability_vector_math_re_ver5_list[[2]])

  outcome_model_schl_eff_read5_ver2 <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read_ver2 + 
                                           read_impact_x_treatment_re_ver2 +
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
                                         reliability = reliability_vector_read_re_ver2_list[[2]])

  outcome_model_schl_eff_read5_ver3 <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read_ver3 + 
                                           read_impact_x_treatment_re_ver3 +
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
                                         reliability = reliability_vector_read_re_ver3_list[[2]])

  outcome_model_schl_eff_read5_ver4 <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read_ver4 + 
                                           read_impact_x_treatment_re_ver4 +
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
                                         reliability = reliability_vector_read_re_ver4_list[[2]])

  outcome_model_schl_eff_read5_ver5 <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read_ver5 + 
                                           read_impact_x_treatment_re_ver5 +
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
                                         reliability = reliability_vector_read_re_ver5_list[[2]])

  # Version 2 of School Effectiveness (1st grade learning rate), Math
  mibeta_cde[i,1]  <- (outcome_model_schl_eff_math5_ver2$coef[4] + outcome_model_schl_eff_math5_ver2$coef[3] * m_star_eff_math_ver2) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,1]  <- outcome_model_schl_eff_math5_ver2$coef[3] * (schl_eff_math_on_treatment_ver2$coef[1] + schl_eff_math_on_treatment_ver2$coef[2] * pc_treatment[1] - m_star_eff_math_ver2) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,1]  <- (schl_eff_math_on_treatment_ver2$coef[2] * outcome_model_schl_eff_math5_ver2$coef[2] + schl_eff_math_on_treatment_ver2$coef[2] * outcome_model_schl_eff_math5_ver2$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,1]  <- schl_eff_math_on_treatment_ver2$coef[2] * outcome_model_schl_eff_math5_ver2$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,1]  <- mibeta_cde[i,1]  + mibeta_rintref[i,1]
  mibeta_rnie[i,1]  <- mibeta_rpie[i,1]  + mibeta_rintmed[i,1]
  mibeta_rate[i,1]  <- mibeta_rnde[i,1]  + mibeta_rnie[i,1]

  # Version 2 of School Effectiveness (1st grade learning rate), Reading
  mibeta_cde[i,2]  <- (outcome_model_schl_eff_read5_ver2$coef[4] + outcome_model_schl_eff_read5_ver2$coef[3] * m_star_eff_read_ver2) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,2]  <- outcome_model_schl_eff_read5_ver2$coef[3] * (schl_eff_read_on_treatment_ver2$coef[1] + schl_eff_read_on_treatment_ver2$coef[2] * pc_treatment[1] - m_star_eff_read_ver2) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,2]  <- (schl_eff_read_on_treatment_ver2$coef[2] * outcome_model_schl_eff_read5_ver2$coef[2] + schl_eff_read_on_treatment_ver2$coef[2] * outcome_model_schl_eff_read5_ver2$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,2]  <- schl_eff_read_on_treatment_ver2$coef[2] * outcome_model_schl_eff_read5_ver2$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,2]  <- mibeta_cde[i,2]  + mibeta_rintref[i,2]
  mibeta_rnie[i,2]  <- mibeta_rpie[i,2]  + mibeta_rintmed[i,2]
  mibeta_rate[i,2]  <- mibeta_rnde[i,2]  + mibeta_rnie[i,2]

  # Version 3 of School Effectiveness (1st grade learning rate minus one-half the summer learning rate), Math
  mibeta_cde[i,3]  <- (outcome_model_schl_eff_math5_ver3$coef[4] + outcome_model_schl_eff_math5_ver3$coef[3] * m_star_eff_math_ver3) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,3]  <- outcome_model_schl_eff_math5_ver3$coef[3] * (schl_eff_math_on_treatment_ver3$coef[1] + schl_eff_math_on_treatment_ver3$coef[2] * pc_treatment[1] - m_star_eff_math_ver3) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,3]  <- (schl_eff_math_on_treatment_ver3$coef[2] * outcome_model_schl_eff_math5_ver3$coef[2] + schl_eff_math_on_treatment_ver3$coef[2] * outcome_model_schl_eff_math5_ver3$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,3]  <- schl_eff_math_on_treatment_ver3$coef[2] * outcome_model_schl_eff_math5_ver3$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,3]  <- mibeta_cde[i,3]  + mibeta_rintref[i,3]
  mibeta_rnie[i,3]  <- mibeta_rpie[i,3]  + mibeta_rintmed[i,3]
  mibeta_rate[i,3]  <- mibeta_rnde[i,3]  + mibeta_rnie[i,3]

  # Version 3 of School Effectiveness (1st grade learning rate minus one-half the summer learning rate), Reading
  mibeta_cde[i,4]  <- (outcome_model_schl_eff_read5_ver3$coef[4] + outcome_model_schl_eff_read5_ver3$coef[3] * m_star_eff_read_ver3) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,4]  <- outcome_model_schl_eff_read5_ver3$coef[3] * (schl_eff_read_on_treatment_ver3$coef[1] + schl_eff_read_on_treatment_ver3$coef[2] * pc_treatment[1] - m_star_eff_read_ver3) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,4]  <- (schl_eff_read_on_treatment_ver3$coef[2] * outcome_model_schl_eff_read5_ver3$coef[2] + schl_eff_read_on_treatment_ver3$coef[2] * outcome_model_schl_eff_read5_ver3$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,4]  <- schl_eff_read_on_treatment_ver3$coef[2] * outcome_model_schl_eff_read5_ver3$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,4]  <- mibeta_cde[i,4]  + mibeta_rintref[i,4]
  mibeta_rnie[i,4]  <- mibeta_rpie[i,4]  + mibeta_rintmed[i,4]
  mibeta_rate[i,4]  <- mibeta_rnde[i,4]  + mibeta_rnie[i,4]

  # Version 4 of School Effectiveness (simple average of 1st grade and summer learning rates), Math
  mibeta_cde[i,5]  <- (outcome_model_schl_eff_math5_ver4$coef[4] + outcome_model_schl_eff_math5_ver4$coef[3] * m_star_eff_math_ver4) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,5]  <- outcome_model_schl_eff_math5_ver4$coef[3] * (schl_eff_math_on_treatment_ver4$coef[1] + schl_eff_math_on_treatment_ver4$coef[2] * pc_treatment[1] - m_star_eff_math_ver4) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,5]  <- (schl_eff_math_on_treatment_ver4$coef[2] * outcome_model_schl_eff_math5_ver4$coef[2] + schl_eff_math_on_treatment_ver4$coef[2] * outcome_model_schl_eff_math5_ver4$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,5]  <- schl_eff_math_on_treatment_ver4$coef[2] * outcome_model_schl_eff_math5_ver4$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,5]  <- mibeta_cde[i,5]  + mibeta_rintref[i,5]
  mibeta_rnie[i,5]  <- mibeta_rpie[i,5]  + mibeta_rintmed[i,5]
  mibeta_rate[i,5]  <- mibeta_rnde[i,5]  + mibeta_rnie[i,5]

  # Version 4 of School Effectiveness (simple average of 1st grade and summer learning rates), Reading
  mibeta_cde[i,6]  <- (outcome_model_schl_eff_read5_ver4$coef[4] + outcome_model_schl_eff_read5_ver4$coef[3] * m_star_eff_read_ver4) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,6]  <- outcome_model_schl_eff_read5_ver4$coef[3] * (schl_eff_read_on_treatment_ver4$coef[1] + schl_eff_read_on_treatment_ver4$coef[2] * pc_treatment[1] - m_star_eff_read_ver4) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,6]  <- (schl_eff_read_on_treatment_ver4$coef[2] * outcome_model_schl_eff_read5_ver4$coef[2] + schl_eff_read_on_treatment_ver4$coef[2] * outcome_model_schl_eff_read5_ver4$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,6]  <- schl_eff_read_on_treatment_ver4$coef[2] * outcome_model_schl_eff_read5_ver4$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,6]  <- mibeta_cde[i,6]  + mibeta_rintref[i,6]
  mibeta_rnie[i,6]  <- mibeta_rpie[i,6]  + mibeta_rintmed[i,6]
  mibeta_rate[i,6]  <- mibeta_rnde[i,6]  + mibeta_rnie[i,6]

  # Version 5 of School Effectiveness (weighted average of 1st grade and summer learning rates), Math
  mibeta_cde[i,7]  <- (outcome_model_schl_eff_math5_ver5$coef[4] + outcome_model_schl_eff_math5_ver5$coef[3] * m_star_eff_math_ver5) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,7]  <- outcome_model_schl_eff_math5_ver5$coef[3] * (schl_eff_math_on_treatment_ver5$coef[1] + schl_eff_math_on_treatment_ver5$coef[2] * pc_treatment[1] - m_star_eff_math_ver5) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,7]  <- (schl_eff_math_on_treatment_ver5$coef[2] * outcome_model_schl_eff_math5_ver5$coef[2] + schl_eff_math_on_treatment_ver5$coef[2] * outcome_model_schl_eff_math5_ver5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,7]  <- schl_eff_math_on_treatment_ver5$coef[2] * outcome_model_schl_eff_math5_ver5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,7]  <- mibeta_cde[i,7]  + mibeta_rintref[i,7]
  mibeta_rnie[i,7]  <- mibeta_rpie[i,7]  + mibeta_rintmed[i,7]
  mibeta_rate[i,7]  <- mibeta_rnde[i,7]  + mibeta_rnie[i,7]

  # Version 5 of School Effectiveness (weighted average of 1st grade and summer learning rates), Reading
  mibeta_cde[i,8]  <- (outcome_model_schl_eff_read5_ver5$coef[4] + outcome_model_schl_eff_read5_ver5$coef[3] * m_star_eff_read_ver5) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,8]  <- outcome_model_schl_eff_read5_ver5$coef[3] * (schl_eff_read_on_treatment_ver5$coef[1] + schl_eff_read_on_treatment_ver5$coef[2] * pc_treatment[1] - m_star_eff_read_ver5) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,8]  <- (schl_eff_read_on_treatment_ver5$coef[2] * outcome_model_schl_eff_read5_ver5$coef[2] + schl_eff_read_on_treatment_ver5$coef[2] * outcome_model_schl_eff_read5_ver5$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,8]  <- schl_eff_read_on_treatment_ver5$coef[2] * outcome_model_schl_eff_read5_ver5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,8]  <- mibeta_cde[i,8]  + mibeta_rintref[i,8]
  mibeta_rnie[i,8]  <- mibeta_rpie[i,8]  + mibeta_rintmed[i,8]
  mibeta_rate[i,8]  <- mibeta_rnde[i,8]  + mibeta_rnie[i,8]

  # Compute block bootstrap SEs
  
  set.seed(123)
  
  bootdist_rate <- matrix(data = NA, nrow = nboot, ncol = 8)

  bootdist_rnde    <- matrix(data = NA, nrow = nboot, ncol = 8)
  bootdist_cde     <- matrix(data = NA, nrow = nboot, ncol = 8)
  bootdist_rintref <- matrix(data = NA, nrow = nboot, ncol = 8)
  
  bootdist_rnie    <- matrix(data = NA, nrow = nboot, ncol = 8)
  bootdist_rpie    <- matrix(data = NA, nrow = nboot, ncol = 8)
  bootdist_rintmed <- matrix(data = NA, nrow = nboot, ncol = 8)
  
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
   schl_eff_math_on_treatment_ver2.boot <- lm(re_impact_math_ver2 ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample.boot)
  
  schl_eff_read_on_treatment_ver2.boot <- lm(re_impact_read_ver2 ~ 
                                     trct_disadv_index2 + 
                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4rtht_r_mean,
                                   data = analytic_sample.boot)

  schl_eff_math_on_treatment_ver3.boot <- lm(re_impact_math_ver3 ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample.boot)
  
  schl_eff_read_on_treatment_ver3.boot <- lm(re_impact_read_ver3 ~ 
                                     trct_disadv_index2 + 
                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4rtht_r_mean,
                                   data = analytic_sample.boot)

  schl_eff_math_on_treatment_ver4.boot <- lm(re_impact_math_ver4 ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample.boot)
  
  schl_eff_read_on_treatment_ver4.boot <- lm(re_impact_read_ver4 ~ 
                                     trct_disadv_index2 + 
                                     c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4rtht_r_mean,
                                   data = analytic_sample.boot)

  schl_eff_math_on_treatment_ver5.boot <- lm(re_impact_math_ver5 ~ 
                                     trct_disadv_index2 + 
                                     c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                     mmarriedbirth + childweightlow + female +
                                     black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                     high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                     d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                     m_less_than_thirty_five_hrs_pw + m_emp_other +
                                     c1r4mtht_r_mean,
                                   data = analytic_sample.boot)
  
  schl_eff_read_on_treatment_ver5.boot <- lm(re_impact_read_ver5 ~ 
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
    outcome_model_schl_eff_math5_ver2.boot <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math_ver2 + 
                                           math_impact_x_treatment_re_ver2 +
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
                                         reliability = reliability_vector_math_re_ver2_list[[2]])

    outcome_model_schl_eff_math5_ver3.boot <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math_ver3 + 
                                           math_impact_x_treatment_re_ver3 +
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
                                         reliability = reliability_vector_math_re_ver3_list[[2]])

    outcome_model_schl_eff_math5_ver4.boot <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math_ver4 + 
                                           math_impact_x_treatment_re_ver4 +
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
                                         reliability = reliability_vector_math_re_ver4_list[[2]])

  outcome_model_schl_eff_math5_ver5.boot <- eivreg(c5r4mtht_r ~ 
                                           re_impact_math_ver5 + 
                                           math_impact_x_treatment_re_ver5 +
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
                                         reliability = reliability_vector_math_re_ver5_list[[2]])

  outcome_model_schl_eff_read5_ver2.boot <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read_ver2 + 
                                           read_impact_x_treatment_re_ver2 +
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
                                         reliability = reliability_vector_read_re_ver2_list[[2]])

  outcome_model_schl_eff_read5_ver3.boot <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read_ver3 + 
                                           read_impact_x_treatment_re_ver3 +
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
                                         reliability = reliability_vector_read_re_ver3_list[[2]])

  outcome_model_schl_eff_read5_ver4.boot <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read_ver4 + 
                                           read_impact_x_treatment_re_ver4 +
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
                                         reliability = reliability_vector_read_re_ver4_list[[2]])

  outcome_model_schl_eff_read5_ver5.boot <- eivreg(c5r4rtht_r ~ 
                                           re_impact_read_ver5 + 
                                           read_impact_x_treatment_re_ver5 +
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
                                         reliability = reliability_vector_read_re_ver5_list[[2]])

  bootdist_cde[j,1]  <- (outcome_model_schl_eff_math5_ver2.boot$coef[4] + outcome_model_schl_eff_math5_ver2.boot$coef[3] * m_star_eff_math_ver2) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,1]  <- outcome_model_schl_eff_math5_ver2.boot$coef[3] * (schl_eff_math_on_treatment_ver2.boot$coef[1] + schl_eff_math_on_treatment_ver2.boot$coef[2] * pc_treatment[1] - m_star_eff_math_ver2) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,1]  <- (schl_eff_math_on_treatment_ver2.boot$coef[2] * outcome_model_schl_eff_math5_ver2.boot$coef[2] + schl_eff_math_on_treatment_ver2.boot$coef[2] * outcome_model_schl_eff_math5_ver2.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,1]  <- schl_eff_math_on_treatment_ver2.boot$coef[2] * outcome_model_schl_eff_math5_ver2.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,1]  <- bootdist_cde[j,1]  + bootdist_rintref[j,1]
  bootdist_rnie[j,1]  <- bootdist_rpie[j,1]  + bootdist_rintmed[j,1]
  bootdist_rate[j,1]  <- bootdist_rnde[j,1]  + bootdist_rnie[j,1]

  bootdist_cde[j,2]  <- (outcome_model_schl_eff_read5_ver2.boot$coef[4] + outcome_model_schl_eff_read5_ver2.boot$coef[3] * m_star_eff_read_ver2) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,2]  <- outcome_model_schl_eff_read5_ver2.boot$coef[3] * (schl_eff_read_on_treatment_ver2.boot$coef[1] + schl_eff_read_on_treatment_ver2.boot$coef[2] * pc_treatment[1] - m_star_eff_read_ver2) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,2]  <- (schl_eff_read_on_treatment_ver2.boot$coef[2] * outcome_model_schl_eff_read5_ver2.boot$coef[2] + schl_eff_read_on_treatment_ver2.boot$coef[2] * outcome_model_schl_eff_read5_ver2.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,2]  <- schl_eff_read_on_treatment_ver2.boot$coef[2] * outcome_model_schl_eff_read5_ver2.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,2]  <- bootdist_cde[j,2]  + bootdist_rintref[j,2]
  bootdist_rnie[j,2]  <- bootdist_rpie[j,2]  + bootdist_rintmed[j,2]
  bootdist_rate[j,2]  <- bootdist_rnde[j,2]  + bootdist_rnie[j,2]

  bootdist_cde[j,3]  <- (outcome_model_schl_eff_math5_ver3.boot$coef[4] + outcome_model_schl_eff_math5_ver3.boot$coef[3] * m_star_eff_math_ver3) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,3]  <- outcome_model_schl_eff_math5_ver3.boot$coef[3] * (schl_eff_math_on_treatment_ver3.boot$coef[1] + schl_eff_math_on_treatment_ver3.boot$coef[2] * pc_treatment[1] - m_star_eff_math_ver3) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,3]  <- (schl_eff_math_on_treatment_ver3.boot$coef[2] * outcome_model_schl_eff_math5_ver3.boot$coef[2] + schl_eff_math_on_treatment_ver3.boot$coef[2] * outcome_model_schl_eff_math5_ver3.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,3]  <- schl_eff_math_on_treatment_ver3.boot$coef[2] * outcome_model_schl_eff_math5_ver3.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,3]  <- bootdist_cde[j,3]  + bootdist_rintref[j,3]
  bootdist_rnie[j,3]  <- bootdist_rpie[j,3]  + bootdist_rintmed[j,3]
  bootdist_rate[j,3]  <- bootdist_rnde[j,3]  + bootdist_rnie[j,3]

  bootdist_cde[j,4]  <- (outcome_model_schl_eff_read5_ver3.boot$coef[4] + outcome_model_schl_eff_read5_ver3.boot$coef[3] * m_star_eff_read_ver3) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,4]  <- outcome_model_schl_eff_read5_ver3.boot$coef[3] * (schl_eff_read_on_treatment_ver3.boot$coef[1] + schl_eff_read_on_treatment_ver3.boot$coef[2] * pc_treatment[1] - m_star_eff_read_ver3) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,4]  <- (schl_eff_read_on_treatment_ver3.boot$coef[2] * outcome_model_schl_eff_read5_ver3.boot$coef[2] + schl_eff_read_on_treatment_ver3.boot$coef[2] * outcome_model_schl_eff_read5_ver3.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,4]  <- schl_eff_read_on_treatment_ver3.boot$coef[2] * outcome_model_schl_eff_read5_ver3.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,4]  <- bootdist_cde[j,4]  + bootdist_rintref[j,4]
  bootdist_rnie[j,4]  <- bootdist_rpie[j,4]  + bootdist_rintmed[j,4]
  bootdist_rate[j,4]  <- bootdist_rnde[j,4]  + bootdist_rnie[j,4]

  bootdist_cde[j,5]  <- (outcome_model_schl_eff_math5_ver4.boot$coef[4] + outcome_model_schl_eff_math5_ver4.boot$coef[3] * m_star_eff_math_ver4) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,5]  <- outcome_model_schl_eff_math5_ver4.boot$coef[3] * (schl_eff_math_on_treatment_ver4.boot$coef[1] + schl_eff_math_on_treatment_ver4.boot$coef[2] * pc_treatment[1] - m_star_eff_math_ver4) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,5]  <- (schl_eff_math_on_treatment_ver4.boot$coef[2] * outcome_model_schl_eff_math5_ver4.boot$coef[2] + schl_eff_math_on_treatment_ver4.boot$coef[2] * outcome_model_schl_eff_math5_ver4.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,5]  <- schl_eff_math_on_treatment_ver4.boot$coef[2] * outcome_model_schl_eff_math5_ver4.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,5]  <- bootdist_cde[j,5]  + bootdist_rintref[j,5]
  bootdist_rnie[j,5]  <- bootdist_rpie[j,5]  + bootdist_rintmed[j,5]
  bootdist_rate[j,5]  <- bootdist_rnde[j,5]  + bootdist_rnie[j,5]

  bootdist_cde[j,6]  <- (outcome_model_schl_eff_read5_ver4.boot$coef[4] + outcome_model_schl_eff_read5_ver4.boot$coef[3] * m_star_eff_read_ver4) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,6]  <- outcome_model_schl_eff_read5_ver4.boot$coef[3] * (schl_eff_read_on_treatment_ver4.boot$coef[1] + schl_eff_read_on_treatment_ver4.boot$coef[2] * pc_treatment[1] - m_star_eff_read_ver4) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,6]  <- (schl_eff_read_on_treatment_ver4.boot$coef[2] * outcome_model_schl_eff_read5_ver4.boot$coef[2] + schl_eff_read_on_treatment_ver4.boot$coef[2] * outcome_model_schl_eff_read5_ver4.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,6]  <- schl_eff_read_on_treatment_ver4.boot$coef[2] * outcome_model_schl_eff_read5_ver4.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,6]  <- bootdist_cde[j,6]  + bootdist_rintref[j,6]
  bootdist_rnie[j,6]  <- bootdist_rpie[j,6]  + bootdist_rintmed[j,6]
  bootdist_rate[j,6]  <- bootdist_rnde[j,6]  + bootdist_rnie[j,6]

  bootdist_cde[j,7]  <- (outcome_model_schl_eff_math5_ver5.boot$coef[4] + outcome_model_schl_eff_math5_ver5.boot$coef[3] * m_star_eff_math_ver5) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,7]  <- outcome_model_schl_eff_math5_ver5.boot$coef[3] * (schl_eff_math_on_treatment_ver5.boot$coef[1] + schl_eff_math_on_treatment_ver5.boot$coef[2] * pc_treatment[1] - m_star_eff_math_ver5) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,7]  <- (schl_eff_math_on_treatment_ver5.boot$coef[2] * outcome_model_schl_eff_math5_ver5.boot$coef[2] + schl_eff_math_on_treatment_ver5.boot$coef[2] * outcome_model_schl_eff_math5_ver5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,7]  <- schl_eff_math_on_treatment_ver5.boot$coef[2] * outcome_model_schl_eff_math5_ver5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,7]  <- bootdist_cde[j,7]  + bootdist_rintref[j,7]
  bootdist_rnie[j,7]  <- bootdist_rpie[j,7]  + bootdist_rintmed[j,7]
  bootdist_rate[j,7]  <- bootdist_rnde[j,7]  + bootdist_rnie[j,7]

  bootdist_cde[j,8]  <- (outcome_model_schl_eff_read5_ver5.boot$coef[4] + outcome_model_schl_eff_read5_ver5.boot$coef[3] * m_star_eff_read_ver5) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,8]  <- outcome_model_schl_eff_read5_ver5.boot$coef[3] * (schl_eff_read_on_treatment_ver5.boot$coef[1] + schl_eff_read_on_treatment_ver5.boot$coef[2] * pc_treatment[1] - m_star_eff_read_ver5) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,8]  <- (schl_eff_read_on_treatment_ver5.boot$coef[2] * outcome_model_schl_eff_read5_ver5.boot$coef[2] + schl_eff_read_on_treatment_ver5.boot$coef[2] * outcome_model_schl_eff_read5_ver5.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,8]  <- schl_eff_read_on_treatment_ver5.boot$coef[2] * outcome_model_schl_eff_read5_ver5.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,8]  <- bootdist_cde[j,8]  + bootdist_rintref[j,8]
  bootdist_rnie[j,8]  <- bootdist_rpie[j,8]  + bootdist_rintmed[j,8]
  bootdist_rate[j,8]  <- bootdist_rnde[j,8]  + bootdist_rnie[j,8]

  }
  
  for (m in 1:8) {
    
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
rate_est        <- matrix(data=NA, nrow=8, ncol=4)
rnde_est        <- matrix(data=NA, nrow=8, ncol=4)
cde_est         <- matrix(data=NA, nrow=8, ncol=4)
rintref_est     <- matrix(data=NA, nrow=8, ncol=4)
rnie_est        <- matrix(data=NA, nrow=8, ncol=4)
rpie_est        <- matrix(data=NA, nrow=8, ncol=4)
rintmed_est     <- matrix(data=NA, nrow=8, ncol=4)

for (i in 1:8) {
  
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
sink("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/logs-replicate-study/3-analyze-data/10-generate-alt-schl-effectiveness-est.txt")

cat("===========================================\n")
cat("Table F.1: School Effectiveness = 1st Grade Learning Rate\n")
cat("RATE\n")
print(rate_est[1:2,])
cat("\n")
cat("RNDE\n")
print(rnde_est[1:2,])
cat("\n")
cat("CDE(0)\n")
print(cde_est[1:2,])
cat("\n")
cat("RINT_ref\n")
print(rintref_est[1:2,])
cat("\n")
cat("RNIE\n")
print(rnie_est[1:2,])
cat("\n")
cat("RPIE\n")
print(rpie_est[1:2,])
cat("\n")
cat("RINT_med\n")
print(rintmed_est[1:2,])
cat("===========================================\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")
cat("\n")
cat("\n")

cat("===========================================\n")
cat("Table F.2: School Effectiveness = 1st Grade Learning Rate - 0.5*Summer Learning Rate\n")
cat("RATE\n")
print(rate_est[3:4,])
cat("\n")
cat("RNDE\n")
print(rnde_est[3:4,])
cat("\n")
cat("CDE(0)\n")
print(cde_est[3:4,])
cat("\n")
cat("RINT_ref\n")
print(rintref_est[3:4,])
cat("\n")
cat("RNIE\n")
print(rnie_est[3:4,])
cat("\n")
cat("RPIE\n")
print(rpie_est[3:4,])
cat("\n")
cat("RINT_med\n")
print(rintmed_est[3:4,])
cat("===========================================\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")
cat("\n")
cat("\n")

cat("===========================================\n")
cat("Table F.3: School Effectiveness = Avg(1st Grade Learning Rate,Summer Learning Rate)\n")
cat("RATE\n")
print(rate_est[5:6,])
cat("\n")
cat("RNDE\n")
print(rnde_est[5:6,])
cat("\n")
cat("CDE(0)\n")
print(cde_est[5:6,])
cat("\n")
cat("RINT_ref\n")
print(rintref_est[5:6,])
cat("\n")
cat("RNIE\n")
print(rnie_est[5:6,])
cat("\n")
cat("RPIE\n")
print(rpie_est[5:6,])
cat("\n")
cat("RINT_med\n")
print(rintmed_est[5:6,])
cat("===========================================\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")
cat("\n")
cat("\n")

cat("===========================================\n")
cat("Table F.4: School Effectiveness = Wtd.Avg(1st Grade Learning Rate,Summer Learning Rate)\n")
cat("RATE\n")
print(rate_est[7:8,])
cat("\n")
cat("RNDE\n")
print(rnde_est[7:8,])
cat("\n")
cat("CDE(0)\n")
print(cde_est[7:8,])
cat("\n")
cat("RINT_ref\n")
print(rintref_est[7:8,])
cat("\n")
cat("RNIE\n")
print(rnie_est[7:8,])
cat("\n")
cat("RPIE\n")
print(rpie_est[7:8,])
cat("\n")
cat("RINT_med\n")
print(rintmed_est[7:8,])
cat("===========================================\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")

sink()
