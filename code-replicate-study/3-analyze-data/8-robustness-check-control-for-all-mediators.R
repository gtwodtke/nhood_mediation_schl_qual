###############################################
# ROBUSTNESS CHECK: CONTROL FOR ALL MEDIATORS #
###############################################

rm(list=ls())





#################
### LIBRARIES ###
#################

library(foreign)
library(dplyr)
library(tidyr)
library(CBPS)
library(ggplot2)
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
  "trct_disadv_index2",
  "nschlnch99_percent", 
  "S4NONWHTPCT",
  "re_impact_math",
  "re_impact_read",
  "male", "female",
  "white_non_hispanic", "black_or_aa_non_hispanic", "hispanic", "asian", "race_other",
  "childweightlow",
  "c1r4mtht_r", "c1r4rtht_r",
  "c5r4mtht_r", "c5r4rtht_r", "c6r4mtht_r", "c6r4rtht_r", "c7r4mtht_r", "c7r4rtht_r",
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
  "CHILDID",
  "S1_ID", "S2_ID", "S3_ID", "S4_ID",
  "_mi_id", "_mi_miss", "_mi_m",
  "C1CW0", "C2CW0", "C3CW0", "C4CW0",
  "c1r4mtht_r_mean", "c1r4rtht_r_mean"
)

analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" != 0), vars]



### Standardize variables ###

# Outcome
analytic_sample_post_mi$c5r4mtht_r <- 
  ((analytic_sample_post_mi$c5r4mtht_r - mean(analytic_sample_post_mi$c5r4mtht_r)) / 
     sd(analytic_sample_post_mi$c5r4mtht_r))
analytic_sample_post_mi$c5r4rtht_r <- 
  ((analytic_sample_post_mi$c5r4rtht_r - mean(analytic_sample_post_mi$c5r4rtht_r)) / 
     sd(analytic_sample_post_mi$c5r4rtht_r))

analytic_sample_post_mi$c6r4mtht_r <- 
  ((analytic_sample_post_mi$c6r4mtht_r - mean(analytic_sample_post_mi$c6r4mtht_r)) / 
     sd(analytic_sample_post_mi$c6r4mtht_r))
analytic_sample_post_mi$c6r4rtht_r <- 
  ((analytic_sample_post_mi$c6r4rtht_r - mean(analytic_sample_post_mi$c6r4rtht_r)) / 
     sd(analytic_sample_post_mi$c6r4rtht_r))

analytic_sample_post_mi$c7r4mtht_r <- 
  ((analytic_sample_post_mi$c7r4mtht_r - mean(analytic_sample_post_mi$c7r4mtht_r)) / 
     sd(analytic_sample_post_mi$c7r4mtht_r))
analytic_sample_post_mi$c7r4rtht_r <- 
  ((analytic_sample_post_mi$c7r4rtht_r - mean(analytic_sample_post_mi$c7r4rtht_r)) / 
     sd(analytic_sample_post_mi$c7r4rtht_r))

# Treatment
analytic_sample_post_mi$trct_disadv_index2 <- 
  ((analytic_sample_post_mi$trct_disadv_index2 - mean(analytic_sample_post_mi$trct_disadv_index2)) / 
     sd(analytic_sample_post_mi$trct_disadv_index2))

# Mediator
analytic_sample_post_mi$re_impact_math <- 
  ((analytic_sample_post_mi$re_impact_math - mean(analytic_sample_post_mi$re_impact_math)) / 
     sd(analytic_sample_post_mi$re_impact_math))

analytic_sample_post_mi$re_impact_read <- 
  ((analytic_sample_post_mi$re_impact_read - mean(analytic_sample_post_mi$re_impact_read)) / 
     sd(analytic_sample_post_mi$re_impact_read))

# Post-treatment confounders
analytic_sample_post_mi$nschlnch99_percent <- 
  ((analytic_sample_post_mi$nschlnch99_percent - mean(analytic_sample_post_mi$nschlnch99_percent)) / 
     sd(analytic_sample_post_mi$nschlnch99_percent))

analytic_sample_post_mi$S4NONWHTPCT <- 
  ((analytic_sample_post_mi$S4NONWHTPCT - mean(analytic_sample_post_mi$S4NONWHTPCT)) / 
     sd(analytic_sample_post_mi$S4NONWHTPCT))

# Pre-treatment confounders
analytic_sample_post_mi$female <- 
  ((analytic_sample_post_mi$female - mean(analytic_sample_post_mi$female)) / 
     sd(analytic_sample_post_mi$female))

analytic_sample_post_mi$black_or_aa_non_hispanic <- 
  ((analytic_sample_post_mi$black_or_aa_non_hispanic - mean(analytic_sample_post_mi$black_or_aa_non_hispanic)) / 
     sd(analytic_sample_post_mi$black_or_aa_non_hispanic))
analytic_sample_post_mi$hispanic <- 
  ((analytic_sample_post_mi$hispanic - mean(analytic_sample_post_mi$hispanic)) / 
     sd(analytic_sample_post_mi$hispanic))
analytic_sample_post_mi$asian <- 
  ((analytic_sample_post_mi$asian - mean(analytic_sample_post_mi$asian)) / 
     sd(analytic_sample_post_mi$asian))
analytic_sample_post_mi$race_other <- 
  ((analytic_sample_post_mi$race_other - mean(analytic_sample_post_mi$race_other)) / 
     sd(analytic_sample_post_mi$race_other))

analytic_sample_post_mi$childweightlow <- 
  ((analytic_sample_post_mi$childweightlow - mean(analytic_sample_post_mi$childweightlow)) / 
     sd(analytic_sample_post_mi$childweightlow))

analytic_sample_post_mi$c1r4mtht_r <- 
  ((analytic_sample_post_mi$c1r4mtht_r - mean(analytic_sample_post_mi$c1r4mtht_r)) / 
     sd(analytic_sample_post_mi$c1r4mtht_r))
analytic_sample_post_mi$c1r4rtht_r <- 
  ((analytic_sample_post_mi$c1r4rtht_r - mean(analytic_sample_post_mi$c1r4rtht_r)) / 
     sd(analytic_sample_post_mi$c1r4rtht_r))

analytic_sample_post_mi$cogstim_scale <- 
  ((analytic_sample_post_mi$cogstim_scale - mean(analytic_sample_post_mi$cogstim_scale)) / 
     sd(analytic_sample_post_mi$cogstim_scale))

analytic_sample_post_mi$magebirth <- 
  ((analytic_sample_post_mi$magebirth - mean(analytic_sample_post_mi$magebirth)) / 
     sd(analytic_sample_post_mi$magebirth))

analytic_sample_post_mi$parprac_scale <- 
  ((analytic_sample_post_mi$parprac_scale - mean(analytic_sample_post_mi$parprac_scale)) / 
     sd(analytic_sample_post_mi$parprac_scale))

analytic_sample_post_mi$pmh_scale_ver_one_2 <- 
  ((analytic_sample_post_mi$pmh_scale_ver_one_2 - mean(analytic_sample_post_mi$pmh_scale_ver_one_2)) / 
     sd(analytic_sample_post_mi$pmh_scale_ver_one_2))

analytic_sample_post_mi$P2INCOME <- log(analytic_sample_post_mi$P2INCOME + 1) # first take log of income
analytic_sample_post_mi$P2INCOME <- 
  ((analytic_sample_post_mi$P2INCOME - mean(analytic_sample_post_mi$P2INCOME)) / 
     sd(analytic_sample_post_mi$P2INCOME))

analytic_sample_post_mi$P1HTOTAL <- 
  ((analytic_sample_post_mi$P1HTOTAL - mean(analytic_sample_post_mi$P1HTOTAL)) / 
     sd(analytic_sample_post_mi$P1HTOTAL))

analytic_sample_post_mi$high_school_diploma_equivalent <- 
  ((analytic_sample_post_mi$high_school_diploma_equivalent - mean(analytic_sample_post_mi$high_school_diploma_equivalent)) / 
     sd(analytic_sample_post_mi$high_school_diploma_equivalent))
analytic_sample_post_mi$voc_tech_program <- 
  ((analytic_sample_post_mi$voc_tech_program - mean(analytic_sample_post_mi$voc_tech_program)) / 
     sd(analytic_sample_post_mi$voc_tech_program))
analytic_sample_post_mi$some_college <- 
  ((analytic_sample_post_mi$some_college - mean(analytic_sample_post_mi$some_college)) / 
     sd(analytic_sample_post_mi$some_college))
analytic_sample_post_mi$bachelor_s_degree <- 
  ((analytic_sample_post_mi$bachelor_s_degree - mean(analytic_sample_post_mi$bachelor_s_degree)) / 
     sd(analytic_sample_post_mi$bachelor_s_degree))
analytic_sample_post_mi$graduate <- 
  ((analytic_sample_post_mi$graduate - mean(analytic_sample_post_mi$graduate)) / 
     sd(analytic_sample_post_mi$graduate))

analytic_sample_post_mi$mmarriedbirth <- 
  ((analytic_sample_post_mi$mmarriedbirth - mean(analytic_sample_post_mi$mmarriedbirth)) / 
     sd(analytic_sample_post_mi$mmarriedbirth))

analytic_sample_post_mi$d_less_than_thirty_five_hrs_pw <- 
  ((analytic_sample_post_mi$d_less_than_thirty_five_hrs_pw - mean(analytic_sample_post_mi$d_less_than_thirty_five_hrs_pw)) / 
     sd(analytic_sample_post_mi$d_less_than_thirty_five_hrs_pw))
analytic_sample_post_mi$d_emp_other <- 
  ((analytic_sample_post_mi$d_emp_other - mean(analytic_sample_post_mi$d_emp_other)) / 
     sd(analytic_sample_post_mi$d_emp_other))

analytic_sample_post_mi$m_less_than_thirty_five_hrs_pw <- 
  ((analytic_sample_post_mi$m_less_than_thirty_five_hrs_pw - mean(analytic_sample_post_mi$m_less_than_thirty_five_hrs_pw)) / 
     sd(analytic_sample_post_mi$m_less_than_thirty_five_hrs_pw))
analytic_sample_post_mi$m_emp_other <- 
  ((analytic_sample_post_mi$m_emp_other - mean(analytic_sample_post_mi$m_emp_other)) / 
     sd(analytic_sample_post_mi$m_emp_other))

analytic_sample_post_mi$c1r4mtht_r_mean <- 
  ((analytic_sample_post_mi$c1r4mtht_r_mean - mean(analytic_sample_post_mi$c1r4mtht_r_mean)) / 
     sd(analytic_sample_post_mi$c1r4mtht_r_mean))
analytic_sample_post_mi$c1r4rtht_r_mean <- 
  ((analytic_sample_post_mi$c1r4rtht_r_mean - mean(analytic_sample_post_mi$c1r4rtht_r_mean)) / 
     sd(analytic_sample_post_mi$c1r4rtht_r_mean))





####################
### CALCULATIONS ###
####################

mibeta_cde_matrices <- list()
mivar_cde_matrices <- list()

idx <- 1

for (r in c(0.7)) {
  
  # First row:  results from dependent variable as third grade math scores
  # Second row: results from dependent variable as third grade reading scores
  # Third row:  results from dependent variable as fifth grade math scores
  # Fourth row: results from dependent variable as fifth grade reading scores
  # Fifth row:  results from dependent variable as eighth grade math scores
  # Sixth row:  results from dependent variable as eighth grade reading scores
  
  mibeta_cde <- matrix(data = NA, nrow = nmi, ncol = 6)
  mivar_cde <- matrix(data = NA, nrow = nmi, ncol = 6)

  ### Loop through imputed datasets ###
  
  for (i in 1:nmi) {
    
    # Select imputed dataset
    
    analytic_sample <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" == i), ]
    
    
    
    # Percentile calculations
    
    # Treatment
    pc_treatment <- quantile(analytic_sample$trct_disadv_index2, probs=c(0.2, 0.8), na.rm=TRUE)
    
    
    
    # Generate reliability vectors
    
    # Impact
    
    # trct_disadv_index2
    # nschlnch99_percent
    # S4NONWHTPCT
    # c1r4mtht_r/c1r4rtht_r
    # cogstim_scale, magebirth, parprac_scale, pmh_scale_ver_one_2, P2INCOME, P1HTOTAL
    # mmarriedbirth, childweightlow, female
    # black_or_aa_non_hispanic, hispanic, asian, race_other
    # high_school_diploma_equivalent, voc_tech_program, some_college, bachelor_s_degree, graduate
    # d_less_than_thirty_five_hrs_pw, d_emp_other
    # m_less_than_thirty_five_hrs_pw, m_emp_other
    # c1r4mtht_r_mean/c1r4rtht_r_mean
    
    reliability_vector_math_re <- c(r, 
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
        "c1r4mtht_r_mean")
    
    names(reliability_vector_read_re) <- 
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
        "c1r4rtht_r_mean")


    
    # Math scores + math impact (RE)
    
    rate_math_scores_math_re5 <- eivreg(c5r4mtht_r ~ 
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
                                         c1r4mtht_r_mean,
                                      data = analytic_sample,
                                      reliability = reliability_vector_math_re)
    
    rate_math_scores_math_re6 <- eivreg(c6r4mtht_r ~ 
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
                                         c1r4mtht_r_mean,
                                      data = analytic_sample,
                                      reliability = reliability_vector_math_re)
    
    rate_math_scores_math_re7 <- eivreg(c7r4mtht_r ~ 
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
                                         c1r4mtht_r_mean,
                                      data = analytic_sample,
                                      reliability = reliability_vector_math_re)
    
    # Reading scores + reading impact (RE)
    
    rate_read_scores_read_re5 <- eivreg(c5r4rtht_r ~ 
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
                                         c1r4rtht_r_mean,
                                      data = analytic_sample,
                                      reliability = reliability_vector_read_re)
    
    rate_read_scores_read_re6 <- eivreg(c6r4rtht_r ~ 
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
                                         c1r4rtht_r_mean,
                                      data = analytic_sample,
                                      reliability = reliability_vector_read_re)
    
    rate_read_scores_read_re7 <- eivreg(c7r4rtht_r ~ 
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
                                         c1r4rtht_r_mean,
                                      data = analytic_sample,
                                      reliability = reliability_vector_read_re)
    
    mibeta_cde[i,1] <- rate_math_scores_math_re5$coef[3] * (pc_treatment[2] - pc_treatment[1])
    mibeta_cde[i,2] <- rate_read_scores_read_re5$coef[3] * (pc_treatment[2] - pc_treatment[1])
    mibeta_cde[i,3] <- rate_math_scores_math_re6$coef[3] * (pc_treatment[2] - pc_treatment[1])
    mibeta_cde[i,4] <- rate_read_scores_read_re6$coef[3] * (pc_treatment[2] - pc_treatment[1])
    mibeta_cde[i,5] <- rate_math_scores_math_re7$coef[3] * (pc_treatment[2] - pc_treatment[1])
    mibeta_cde[i,6] <- rate_read_scores_read_re7$coef[3] * (pc_treatment[2] - pc_treatment[1])
    
    
    
    # Compute block bootstrap SEs
    
    set.seed(123)
    
    bootdist_cde <- matrix(data = NA, nrow = nboot, ncol = 6)
    
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
      

      
      # Math scores + math impact (RE)
      
      rate_math_scores_math_re_boot5 <- eivreg(c5r4mtht_r ~ 
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
                                                c1r4mtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_math_re)
      
      rate_math_scores_math_re_boot6 <- eivreg(c6r4mtht_r ~ 
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
                                                c1r4mtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_math_re)
      
      rate_math_scores_math_re_boot7 <- eivreg(c7r4mtht_r ~ 
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
                                                c1r4mtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_math_re)
      
      # Reading scores + reading impact (RE)
      
      rate_read_scores_read_re_boot5 <- eivreg(c5r4rtht_r ~ 
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
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_read_re)
      
      rate_read_scores_read_re_boot6 <- eivreg(c6r4rtht_r ~ 
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
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_read_re)
      
      rate_read_scores_read_re_boot7 <- eivreg(c7r4rtht_r ~ 
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
                                                c1r4rtht_r_mean,
                                              data = analytic_sample.boot,
                                              reliability = reliability_vector_read_re)
      
      bootdist_cde[j,1] <- rate_math_scores_math_re_boot5$coef[3] * (pc_treatment[2] - pc_treatment[1])
      bootdist_cde[j,2] <- rate_read_scores_read_re_boot5$coef[3] * (pc_treatment[2] - pc_treatment[1])
      bootdist_cde[j,3] <- rate_math_scores_math_re_boot6$coef[3] * (pc_treatment[2] - pc_treatment[1])
      bootdist_cde[j,4] <- rate_read_scores_read_re_boot6$coef[3] * (pc_treatment[2] - pc_treatment[1])
      bootdist_cde[j,5] <- rate_math_scores_math_re_boot7$coef[3] * (pc_treatment[2] - pc_treatment[1])
      bootdist_cde[j,6] <- rate_read_scores_read_re_boot7$coef[3] * (pc_treatment[2] - pc_treatment[1])
      
    }
    
    for (m in 1:6) {
      
      mivar_cde[i,m] <- var(bootdist_cde[,m])
      
    }
    
  }
  
  mibeta_cde_matrices[[idx]] <- mibeta_cde
  mivar_cde_matrices[[idx]] <- mivar_cde
  
  idx <- idx + 1
  
}





### Combine MI estimates ###

cde_est_matrices <- list()

idx <- 1

while (idx < 2) {
  
  cde_est <- matrix(data=NA, nrow=6, ncol=4)
  
  for (i in 1:6) {
    
    cde_est[i,1] <- round(mean(mibeta_cde_matrices[[idx]][,i]), digits=3)
    cde_est[i,2] <- round(sqrt(mean(mivar_cde_matrices[[idx]][,i]) + (var(mibeta_cde_matrices[[idx]][,i]) * (1 + (1/nmi)))), digits=3)
    cde_est[i,3] <- round((cde_est[i,1]/cde_est[i,2]), digits=3)
    cde_est[i,4] <- round((pnorm(abs(cde_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=3)

  }
  
  cde_est_matrices[[idx]] <- cde_est
  
  idx <- idx + 1
  
}





### Print results ###

sink("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/logs-replicate-study/3-analyze-data/6-robustness-check-control-for-all-mediators.txt")

cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("RELIABILITY: 0.7\n")
cat("===========================================\n")
cat("CDE(0)\n")
print(cde_est_matrices[[1]])
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")
cat("\n")

sink()
