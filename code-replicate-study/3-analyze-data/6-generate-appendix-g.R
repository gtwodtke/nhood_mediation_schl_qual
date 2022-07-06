##############
# APPENDIX G #
##############

rm(list=ls())





#################
### LIBRARIES ###
#################

library(foreign)
library(ggplot2)
library(eivtools)
library(psych)
library(gridExtra)

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



### Recode parental education ###

analytic_sample_post_mi[analytic_sample_post_mi$less_than_hs_diploma == 1,           "parental_education"] <- 10
analytic_sample_post_mi[analytic_sample_post_mi$high_school_diploma_equivalent == 1, "parental_education"] <- 12
analytic_sample_post_mi[analytic_sample_post_mi$voc_tech_program == 1,               "parental_education"] <- 14
analytic_sample_post_mi[analytic_sample_post_mi$some_college == 1,                   "parental_education"] <- 14
analytic_sample_post_mi[analytic_sample_post_mi$bachelor_s_degree == 1,              "parental_education"] <- 16
analytic_sample_post_mi[analytic_sample_post_mi$graduate == 1,                       "parental_education"] <- 18



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

analytic_sample_post_mi$parental_education <- 
  ((analytic_sample_post_mi$parental_education - mean(analytic_sample_post_mi$parental_education)) / 
     sd(analytic_sample_post_mi$parental_education))



### Calculate a, a*, and a* - a ###

vec_a <- c()
vec_a_star <- c()
for (i in 1:nmi) {
  analytic_sample <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" == i), ]
  pc_treatment <- quantile(analytic_sample$trct_disadv_index2, probs=c(0.2, 0.8), na.rm=TRUE)
  vec_a <- c(vec_a, pc_treatment[1])
  vec_a_star <- c(vec_a_star, pc_treatment[2])
}
a <- mean(vec_a)
a_star <- mean(vec_a_star)
a_star_minus_a <- a_star - a



### Calculate partial correlations with parental education ###

par_A_math <- partial.r(data = analytic_sample_post_mi[,-c(56)], 
                        x = c("trct_disadv_index2", "parental_education"), 
                        y = c("c1r4mtht_r", "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
                              "mmarriedbirth", "childweightlow", "female",
                              "black_or_aa_non_hispanic", "hispanic", "asian", "race_other", 
                              "d_less_than_thirty_five_hrs_pw", "d_emp_other", 
                              "m_less_than_thirty_five_hrs_pw", "m_emp_other", 
                              "c1r4mtht_r_mean"))[2]

par_A_read <- partial.r(data = analytic_sample_post_mi[,-c(56)], 
                        x = c("trct_disadv_index2", "parental_education"), 
                        y = c("c1r4rtht_r", "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
                              "mmarriedbirth", "childweightlow", "female",
                              "black_or_aa_non_hispanic", "hispanic", "asian", "race_other", 
                              "d_less_than_thirty_five_hrs_pw", "d_emp_other", 
                              "m_less_than_thirty_five_hrs_pw", "m_emp_other", 
                              "c1r4rtht_r_mean"))[2]

par_M_math <- partial.r(data = analytic_sample_post_mi[,-c(56)], 
                        x = c("re_impact_math", "parental_education"), 
                        y = c("trct_disadv_index2",
                              "c1r4mtht_r", "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
                              "mmarriedbirth", "childweightlow", "female",
                              "black_or_aa_non_hispanic", "hispanic", "asian", "race_other", 
                              "d_less_than_thirty_five_hrs_pw", "d_emp_other", 
                              "m_less_than_thirty_five_hrs_pw", "m_emp_other", 
                              "c1r4mtht_r_mean"))[2]

par_M_read <- partial.r(data = analytic_sample_post_mi[,-c(56)], 
                        x = c("re_impact_read", "parental_education"), 
                        y = c("trct_disadv_index2",
                              "c1r4rtht_r", "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
                              "mmarriedbirth", "childweightlow", "female",
                              "black_or_aa_non_hispanic", "hispanic", "asian", "race_other", 
                              "d_less_than_thirty_five_hrs_pw", "d_emp_other", 
                              "m_less_than_thirty_five_hrs_pw", "m_emp_other", 
                              "c1r4rtht_r_mean"))[2]

par_Y_math <- partial.r(data = analytic_sample_post_mi[,-c(56)], 
                        x = c("c5r4mtht_r", "parental_education"), 
                        y = c("re_impact_math",
                              "nschlnch99_percent", "S4NONWHTPCT",
                              "trct_disadv_index2",
                              "c1r4mtht_r", "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
                              "mmarriedbirth", "childweightlow", "female",
                              "black_or_aa_non_hispanic", "hispanic", "asian", "race_other", 
                              "d_less_than_thirty_five_hrs_pw", "d_emp_other", 
                              "m_less_than_thirty_five_hrs_pw", "m_emp_other", 
                              "c1r4mtht_r_mean"))[2]

par_Y_read <- partial.r(data = analytic_sample_post_mi[,-c(56)], 
                        x = c("c5r4rtht_r", "parental_education"), 
                        y = c("re_impact_read", 
                              "nschlnch99_percent", "S4NONWHTPCT",
                              "trct_disadv_index2",
                              "c1r4rtht_r", "cogstim_scale", "magebirth", "parprac_scale", "pmh_scale_ver_one_2", "P2INCOME", "P1HTOTAL",
                              "mmarriedbirth", "childweightlow", "female",
                              "black_or_aa_non_hispanic", "hispanic", "asian", "race_other", 
                              "d_less_than_thirty_five_hrs_pw", "d_emp_other", 
                              "m_less_than_thirty_five_hrs_pw", "m_emp_other", 
                              "c1r4rtht_r_mean"))[2]



####################
### CALCULATIONS ###
####################

### Initialize a set range of reliability values and a list to store beta/var matrices ###

reliabilities <- c(0.7)

# math5, read5
mibeta_rnde_matrices <- list()
mivar_rnde_matrices <- list()
mibeta_rnie_matrices <- list()
mivar_rnie_matrices <- list()

mibeta_impact_matrices <- list()
mibeta_impact_x_treatment_matrices <- list()
mibeta_impact_on_treatment_matrices <- list()
mibeta_treatment_on_covs_matrices <- list()

mibeta_error_sds_matrices0 <- list()
mibeta_error_sds_matrices1 <- list()
mibeta_error_sds_matrices2 <- list()



### Compute and save values ###

idx <- 1

for (r in reliabilities) {
  
  # Within each subtable, results are presented as:
  # First row:  results from dependent variable as third grade math scores
  # Second row: results from dependent variable as third grade reading scores
  
  # math5, read5
  mibeta_rnde <- matrix(data = NA, nrow = nmi, ncol = 2)
  mivar_rnde <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_rnie <- matrix(data = NA, nrow = nmi, ncol = 2)
  mivar_rnie <- matrix(data = NA, nrow = nmi, ncol = 2)
  
  mibeta_cde <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_rintref <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_rpie <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_rintmed <- matrix(data = NA, nrow = nmi, ncol = 2)
  
  mibeta_impact <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_impact_x_treatment <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_impact_on_treatment <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_treatment_on_covs <- matrix(data = NA, nrow = nmi, ncol = 2)
  
  mibeta_error_sds0 <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_error_sds1 <- matrix(data = NA, nrow = nmi, ncol = 2)
  mibeta_error_sds2 <- matrix(data = NA, nrow = nmi, ncol = 2)
  
  
  
  ### Loop through imputed datasets ###
  
  for (i in 1:nmi) {
    
    # Select imputed dataset
    
    analytic_sample <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" == i), ]
    
    
    
    # Percentile calculations
    
    # Treatment
    pc_treatment <- quantile(analytic_sample$trct_disadv_index2, probs=c(0.2, 0.8), na.rm=TRUE)
    
    # Math impact score (RE)
    pc_re_impact_math <- quantile(analytic_sample$re_impact_math, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)

    # Reading impact score (RE)
    pc_re_impact_read <- quantile(analytic_sample$re_impact_read, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
    
    m_star_math <- pc_re_impact_math[2]
    m_star_read <- pc_re_impact_read[2]
    
    
    
    # Compute impact-by-treatment correlations
  
    cor_impact_treatment_math_re <- cor(analytic_sample$re_impact_math, analytic_sample$trct_disadv_index2)
    cor_impact_treatment_read_re <- cor(analytic_sample$re_impact_read, analytic_sample$trct_disadv_index2)
    
    
    
    # Compute reliabilities for the impact-by-treatment interaction terms
      
    interaction_rel_math_re <- (r + cor_impact_treatment_math_re^2) / (1 + cor_impact_treatment_math_re^2)
    interaction_rel_read_re <- (r + cor_impact_treatment_read_re^2) / (1 + cor_impact_treatment_read_re^2)
    
    
    
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
    
    
    
    # RWR calculations for percent free lunch eligible
    
    analytic_sample$nschlnch99_percent_r <- NA
    
    analytic_sample$nschlnch99_percent_r <- 
      residuals(
        lm(
          nschlnch99_percent ~ 
            trct_disadv_index2 + 
            c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
            mmarriedbirth + childweightlow + female +
            black_or_aa_non_hispanic + hispanic + asian + race_other + 
            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
            d_less_than_thirty_five_hrs_pw + d_emp_other + 
            m_less_than_thirty_five_hrs_pw + m_emp_other +
            c1r4rtht_r_mean,
          data = analytic_sample)
      )
    
    
    # RWR calculations for S4NONWHTPCT
    
    analytic_sample$S4NONWHTPCT_r <- NA
    
    analytic_sample$S4NONWHTPCT_r <- 
      residuals(
        lm(
          S4NONWHTPCT ~ 
            trct_disadv_index2 + 
            c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
            mmarriedbirth + childweightlow + female +
            black_or_aa_non_hispanic + hispanic + asian + race_other + 
            high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
            d_less_than_thirty_five_hrs_pw + d_emp_other + 
            m_less_than_thirty_five_hrs_pw + m_emp_other +
            c1r4rtht_r_mean,
          data = analytic_sample)
      )
    
    
    
    # Add variables for impact-by-treatment interaction
    
    analytic_sample$math_impact_x_treatment_re <- analytic_sample$re_impact_math * analytic_sample$trct_disadv_index2
    analytic_sample$read_impact_x_treatment_re <- analytic_sample$re_impact_read * analytic_sample$trct_disadv_index2

      

    # Model 0
    
    # Math
    treatment_on_covs_math <- lm(trct_disadv_index2 ~ 
                                   c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                   mmarriedbirth + childweightlow + female +
                                   black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                   high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                   d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                   m_less_than_thirty_five_hrs_pw + m_emp_other +
                                   c1r4mtht_r_mean,
                                 data = analytic_sample)
    
    # Reading
    treatment_on_covs_read <- lm(trct_disadv_index2 ~ 
                                   c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                   mmarriedbirth + childweightlow + female +
                                   black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                   high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                   d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                   m_less_than_thirty_five_hrs_pw + m_emp_other +
                                   c1r4rtht_r_mean,
                                 data = analytic_sample)
    
    
    
    # Model 1
    
    # Math
    re_impact_on_treatment_math <- lm(re_impact_math ~ 
                                        trct_disadv_index2 + 
                                        c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                        mmarriedbirth + childweightlow + female +
                                        black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                        high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                        d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                        m_less_than_thirty_five_hrs_pw + m_emp_other +
                                        c1r4mtht_r_mean,
                                      data = analytic_sample)
    
    # Reading
    re_impact_on_treatment_read <- lm(re_impact_read ~ 
                                        trct_disadv_index2 + 
                                        c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                        mmarriedbirth + childweightlow + female +
                                        black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                        high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                        d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                        m_less_than_thirty_five_hrs_pw + m_emp_other +
                                        c1r4rtht_r_mean,
                                      data = analytic_sample)
    
    
    
    # Model 2
    
    # Math scores + math impact (RE)
    rate_math_scores_math_re5 <- eivreg(c5r4mtht_r ~ 
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
                                      reliability = reliability_vector_math_re)
    
    # Reading scores + reading impact (RE)
    rate_read_scores_read_re5 <- eivreg(c5r4rtht_r ~ 
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
                                      reliability = reliability_vector_read_re)
    

    
    # RNDE
    mibeta_cde[i,1] <- (rate_math_scores_math_re5$coef[4] + rate_math_scores_math_re5$coef[3] * m_star_math) * (pc_treatment[2] - pc_treatment[1])
    mibeta_cde[i,2] <- (rate_read_scores_read_re5$coef[4] + rate_read_scores_read_re5$coef[3] * m_star_read) * (pc_treatment[2] - pc_treatment[1])
    
    mibeta_rintref[i,1] <- rate_math_scores_math_re5$coef[3] * 
                          (re_impact_on_treatment_math$coef[1] + re_impact_on_treatment_math$coef[2] * pc_treatment[1] - m_star_math) * 
                          (pc_treatment[2] - pc_treatment[1])
    mibeta_rintref[i,2] <- rate_read_scores_read_re5$coef[3] * 
                          (re_impact_on_treatment_read$coef[1] + re_impact_on_treatment_read$coef[2] * pc_treatment[1] - m_star_read) * 
                          (pc_treatment[2] - pc_treatment[1])

    mibeta_rnde[i,1] <- mibeta_cde[i,1] + mibeta_rintref[i,1]
    mibeta_rnde[i,2] <- mibeta_cde[i,2] + mibeta_rintref[i,2]
    
    # RNIE
    mibeta_rpie[i,1] <- (re_impact_on_treatment_math$coef[2] * rate_math_scores_math_re5$coef[2] + 
                         re_impact_on_treatment_math$coef[2] * rate_math_scores_math_re5$coef[3] * pc_treatment[1]) * 
                        (pc_treatment[2] - pc_treatment[1])
    mibeta_rpie[i,2] <- (re_impact_on_treatment_read$coef[2] * rate_read_scores_read_re5$coef[2] + 
                         re_impact_on_treatment_read$coef[2] * rate_read_scores_read_re5$coef[3] * pc_treatment[1]) * 
                        (pc_treatment[2] - pc_treatment[1])
    
    mibeta_rintmed[i,1] <- re_impact_on_treatment_math$coef[2] * rate_math_scores_math_re5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
    mibeta_rintmed[i,2] <- re_impact_on_treatment_read$coef[2] * rate_read_scores_read_re5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2

    mibeta_rnie[i,1] <- mibeta_rpie[i,1] + mibeta_rintmed[i,1]
    mibeta_rnie[i,2] <- mibeta_rpie[i,2] + mibeta_rintmed[i,2]
    
    # Impact
    mibeta_impact[i,1] <- rate_math_scores_math_re5$coef[2]
    mibeta_impact[i,2] <- rate_read_scores_read_re5$coef[2]
    
    # Impact x treatment
    mibeta_impact_x_treatment[i,1] <- rate_math_scores_math_re5$coef[3]
    mibeta_impact_x_treatment[i,2] <- rate_read_scores_read_re5$coef[3]
    
    # Treatment (impact on treatment)
    mibeta_impact_on_treatment[i,1] <- re_impact_on_treatment_math$coef[2]
    mibeta_impact_on_treatment[i,2] <- re_impact_on_treatment_read$coef[2]
    
    # Intercept (treatment on covs)
    mibeta_treatment_on_covs[i,1] <- treatment_on_covs_math$coef[1]
    mibeta_treatment_on_covs[i,2] <- treatment_on_covs_read$coef[1]
    
    # Error SDs 0
    mibeta_error_sds0[i,1] <- sd(residuals(treatment_on_covs_math))
    mibeta_error_sds0[i,2] <- sd(residuals(treatment_on_covs_read))
    
    # Error SDs 1
    mibeta_error_sds1[i,1] <- sd(residuals(re_impact_on_treatment_math))
    mibeta_error_sds1[i,2] <- sd(residuals(re_impact_on_treatment_read))
    
    # Error SDs 2
    mibeta_error_sds2[i,1] <- sd(residuals(rate_math_scores_math_re5))
    mibeta_error_sds2[i,2] <- sd(residuals(rate_read_scores_read_re5))
    
    

    # Compute block bootstrap SEs
    
    set.seed(123)
    
    # math5, read5
    bootdist_rnde <- matrix(data = NA, nrow = nboot, ncol = 2)
    bootdist_cde <- matrix(data = NA, nrow = nboot, ncol = 2)
    bootdist_rintref <- matrix(data = NA, nrow = nboot, ncol = 2)
    
    bootdist_rnie <- matrix(data = NA, nrow = nboot, ncol = 2)
    bootdist_rpie <- matrix(data = NA, nrow = nboot, ncol = 2)
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
      
      
      
      # RWR calculations for percent free lunch eligible
      
      analytic_sample.boot$nschlnch99_percent_r <- NA
      
      analytic_sample.boot$nschlnch99_percent_r <- 
        residuals(
          lm(
            nschlnch99_percent ~ 
              trct_disadv_index2 + 
              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
              mmarriedbirth + childweightlow + female +
              black_or_aa_non_hispanic + hispanic + asian + race_other + 
              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
              d_less_than_thirty_five_hrs_pw + d_emp_other + 
              m_less_than_thirty_five_hrs_pw + m_emp_other +
              c1r4rtht_r_mean,
            data = analytic_sample.boot)
        )
      
      
      
      # RWR calculations for S4NONWHTPCT
      
      analytic_sample.boot$S4NONWHTPCT_r <- NA
      
      analytic_sample.boot$S4NONWHTPCT_r <- 
        residuals(
          lm(
            S4NONWHTPCT ~ 
              trct_disadv_index2 + 
              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
              mmarriedbirth + childweightlow + female +
              black_or_aa_non_hispanic + hispanic + asian + race_other + 
              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
              d_less_than_thirty_five_hrs_pw + d_emp_other + 
              m_less_than_thirty_five_hrs_pw + m_emp_other +
              c1r4rtht_r_mean,
            data = analytic_sample.boot)
        )
      
      
      
      # Add variables for impact-by-treatment interaction
      
      analytic_sample.boot$math_impact_x_treatment_re <- analytic_sample.boot$re_impact_math * analytic_sample.boot$trct_disadv_index2
      analytic_sample.boot$read_impact_x_treatment_re <- analytic_sample.boot$re_impact_read * analytic_sample.boot$trct_disadv_index2
      
      
      
      # Model 0
      
      # Math
      treatment_on_covs_math_boot <- lm(trct_disadv_index2 ~ 
                                          c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                          mmarriedbirth + childweightlow + female +
                                          black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                          high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                          d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                          m_less_than_thirty_five_hrs_pw + m_emp_other +
                                          c1r4mtht_r_mean,
                                        data = analytic_sample.boot)
      
      # Reading
      treatment_on_covs_read_boot <- lm(trct_disadv_index2 ~ 
                                          c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                          mmarriedbirth + childweightlow + female +
                                          black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                          high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                          d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                          m_less_than_thirty_five_hrs_pw + m_emp_other +
                                          c1r4rtht_r_mean,
                                        data = analytic_sample.boot)
      
      
      
      # Model 1
      
      # Math
      re_impact_on_treatment_math_boot <- lm(re_impact_math ~ 
                                              trct_disadv_index2 + 
                                              c1r4mtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other +
                                              c1r4mtht_r_mean,
                                            data = analytic_sample.boot)
      
      # Reading
      re_impact_on_treatment_read_boot <- lm(re_impact_read ~ 
                                              trct_disadv_index2 + 
                                              c1r4rtht_r + cogstim_scale + magebirth + parprac_scale + pmh_scale_ver_one_2 + P2INCOME + P1HTOTAL + 
                                              mmarriedbirth + childweightlow + female +
                                              black_or_aa_non_hispanic + hispanic + asian + race_other + 
                                              high_school_diploma_equivalent + voc_tech_program + some_college + bachelor_s_degree + graduate +
                                              d_less_than_thirty_five_hrs_pw + d_emp_other + 
                                              m_less_than_thirty_five_hrs_pw + m_emp_other +
                                              c1r4rtht_r_mean,
                                            data = analytic_sample.boot)
      
      
      
      # Model 2
      
      # Math scores + math impact (RE)
      rate_math_scores_math_re_boot5 <- eivreg(c5r4mtht_r ~ 
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
                                              reliability = reliability_vector_math_re)

      # Reading scores + reading impact (RE)
      rate_read_scores_read_re_boot5 <- eivreg(c5r4rtht_r ~ 
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
                                              reliability = reliability_vector_read_re)

      # RNDE
      bootdist_cde[j,1] <- (rate_math_scores_math_re_boot5$coef[4] - rate_math_scores_math_re_boot5$coef[3] * m_star_math) * (pc_treatment[2] - pc_treatment[1])
      bootdist_cde[j,2] <- (rate_read_scores_read_re_boot5$coef[4] - rate_read_scores_read_re_boot5$coef[3] * m_star_read) * (pc_treatment[2] - pc_treatment[1])

      bootdist_rintref[j,1] <- rate_math_scores_math_re_boot5$coef[3] * 
                              (re_impact_on_treatment_math_boot$coef[1] + re_impact_on_treatment_math_boot$coef[2] * pc_treatment[1] - m_star_math) * 
                              (pc_treatment[2] - pc_treatment[1])
      bootdist_rintref[j,2] <- rate_read_scores_read_re_boot5$coef[3] * 
                              (re_impact_on_treatment_read_boot$coef[1] + re_impact_on_treatment_read_boot$coef[2] * pc_treatment[1] - m_star_read) * 
                              (pc_treatment[2] - pc_treatment[1])
      
      bootdist_rnde[j,1] <- bootdist_cde[j,1] + bootdist_rintref[j,1]
      bootdist_rnde[j,2] <- bootdist_cde[j,2] + bootdist_rintref[j,2]
      
      # RNIE
      bootdist_rpie[j,1] <- (re_impact_on_treatment_math_boot$coef[2] * rate_math_scores_math_re_boot5$coef[2] + 
                             re_impact_on_treatment_math_boot$coef[2] * rate_math_scores_math_re_boot5$coef[3] * pc_treatment[1]) * 
                            (pc_treatment[2] - pc_treatment[1])
      bootdist_rpie[j,2] <- (re_impact_on_treatment_read_boot$coef[2] * rate_read_scores_read_re_boot5$coef[2] + 
                             re_impact_on_treatment_read_boot$coef[2] * rate_read_scores_read_re_boot5$coef[3] * pc_treatment[1]) * 
                            (pc_treatment[2] - pc_treatment[1])
      
      bootdist_rintmed[j,1] <- re_impact_on_treatment_math_boot$coef[2] * rate_math_scores_math_re_boot5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
      bootdist_rintmed[j,2] <- re_impact_on_treatment_read_boot$coef[2] * rate_read_scores_read_re_boot5$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
      
      bootdist_rnie[j,1] <- bootdist_rpie[j,1] + bootdist_rintmed[j,1]
      bootdist_rnie[j,2] <- bootdist_rpie[j,2] + bootdist_rintmed[j,2]
      
    }
    
    for (m in 1:2) {
      
      # math5, read5
      mivar_rnde[i,m] <- var(bootdist_rnde[,m])
      mivar_rnie[i,m] <- var(bootdist_rnie[,m])
      
    }
    
  }
  
  # math5, read5
  mibeta_rnde_matrices[[idx]] <- mibeta_rnde
  mivar_rnde_matrices[[idx]] <- mivar_rnde
  mibeta_rnie_matrices[[idx]] <- mibeta_rnie
  mivar_rnie_matrices[[idx]] <- mivar_rnie
  
  mibeta_impact_matrices[[idx]] <- mibeta_impact
  mibeta_impact_x_treatment_matrices[[idx]] <- mibeta_impact_x_treatment
  mibeta_impact_on_treatment_matrices[[idx]] <- mibeta_impact_on_treatment
  mibeta_treatment_on_covs_matrices[[idx]] <- mibeta_treatment_on_covs
  
  mibeta_error_sds_matrices0[[idx]] <- mibeta_error_sds0
  mibeta_error_sds_matrices1[[idx]] <- mibeta_error_sds1
  mibeta_error_sds_matrices2[[idx]] <- mibeta_error_sds2
  
  idx <- idx + 1
  
}





### Combine MI estimates ###

# math5, read5
rnde_est_matrices <- list()
rnie_est_matrices <- list()

impact_est_matrices <- list()
impact_x_treatment_est_matrices <- list()
impact_on_treatment_est_matrices <- list()
treatment_on_covs_est_matrices <- list()

error_sds_est_matrices0 <- list()
error_sds_est_matrices1 <- list()
error_sds_est_matrices2 <- list()

idx <- 1

while (idx < 2) {
  
  # math5, read5
  rnde_est <- matrix(data=NA, nrow=2, ncol=4)
  rnie_est <- matrix(data=NA, nrow=2, ncol=4)
  
  impact_est <- matrix(data=NA, nrow=2, ncol=4)
  impact_x_treatment_est <- matrix(data=NA, nrow=2, ncol=4)
  impact_on_treatment_est <- matrix(data=NA, nrow=2, ncol=4)
  treatment_on_covs_est <- matrix(data=NA, nrow=2, ncol=4)
  
  error_sds_est0 <- matrix(data=NA, nrow=2, ncol=4)
  error_sds_est1 <- matrix(data=NA, nrow=2, ncol=4)
  error_sds_est2 <- matrix(data=NA, nrow=2, ncol=4)
  
  for (i in 1:2) {
    
    # math5, read5
    rnde_est[i,1] <- round(mean(mibeta_rnde_matrices[[idx]][,i]), digits=3)
    rnde_est[i,2] <- round(sqrt(mean(mivar_rnde_matrices[[idx]][,i]) + (var(mibeta_rnde_matrices[[idx]][,i]) * (1 + (1/nmi)))), digits=3)
    rnde_est[i,3] <- round((rnde_est[i,1]/rnde_est[i,2]), digits=3)
    rnde_est[i,4] <- round((pnorm(abs(rnde_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=3)
    
    rnie_est[i,1] <- round(mean(mibeta_rnie_matrices[[idx]][,i]), digits=3)
    rnie_est[i,2] <- round(sqrt(mean(mivar_rnie_matrices[[idx]][,i]) + (var(mibeta_rnie_matrices[[idx]][,i]) * (1 + (1/nmi)))), digits=3)
    rnie_est[i,3] <- round((rnie_est[i,1]/rnie_est[i,2]), digits=3)
    rnie_est[i,4] <- round((pnorm(abs(rnie_est[i,3]), 0, 1, lower.tail=FALSE) * 2), digits=3)
    
    impact_est[i,1] <- round(mean(mibeta_impact_matrices[[idx]][,i]), digits=3)
    impact_x_treatment_est[i,1] <- round(mean(mibeta_impact_x_treatment_matrices[[idx]][,i]), digits=3)
    impact_on_treatment_est[i,1] <- round(mean(mibeta_impact_on_treatment_matrices[[idx]][,i]), digits=3)
    treatment_on_covs_est[i,1] <- round(mean(mibeta_treatment_on_covs_matrices[[idx]][,i]), digits=3)
    
    error_sds_est0[i,1] <- round(mean(mibeta_error_sds_matrices0[[idx]][,i]), digits=3)
    error_sds_est1[i,1] <- round(mean(mibeta_error_sds_matrices1[[idx]][,i]), digits=3)
    error_sds_est2[i,1] <- round(mean(mibeta_error_sds_matrices2[[idx]][,i]), digits=3)
    
  }
  
  # math5, read5
  rnde_est_matrices[[idx]] <- rnde_est
  rnie_est_matrices[[idx]] <- rnie_est

  impact_est_matrices[[idx]] <- impact_est
  impact_x_treatment_est_matrices[[idx]] <- impact_x_treatment_est
  impact_on_treatment_est_matrices[[idx]] <- impact_on_treatment_est
  treatment_on_covs_est_matrices[[idx]] <- treatment_on_covs_est
  
  error_sds_est_matrices0[[idx]] <- error_sds_est0
  error_sds_est_matrices1[[idx]] <- error_sds_est1
  error_sds_est_matrices2[[idx]] <- error_sds_est2
  
  idx <- idx + 1
  
}





### Print results ###

sink("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/logs-replicate-study/3-analyze-data/4-appendix-g.txt")

cat("===========================================\n")
cat("APPENDIX G\n")
cat("RNDE\n")
print(rnde_est_matrices[[1]])
cat("RNIE\n")
print(rnie_est_matrices[[1]])
cat("\n")
cat("Impact (M)\n")
print(impact_est_matrices[[1]])
cat("Treatment (A) x impact (M)\n")
print(impact_x_treatment_est_matrices[[1]])
cat("Treatment (A) (impact on treatment)\n")
print(impact_on_treatment_est_matrices[[1]])
cat("Intercept (treatment on covs)\n")
print(treatment_on_covs_est_matrices[[1]])
cat("\n")
cat("Errors SDs (treatment)\n")
print(error_sds_est_matrices0[[1]])
cat("Errors SDs (mediator)\n")
print(error_sds_est_matrices1[[1]])
cat("Errors SDs (outcome)\n")
print(error_sds_est_matrices2[[1]])
cat("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
cat("Note: Table Columns = Est / SE / Z / Pvalue\n")

cat("\n")
cat("a\n")
print(a)
cat("\n")
cat("a*\n")
print(a_star)
cat("\n")
cat("a* - a\n")
print(a_star_minus_a)
cat("\n")

cat("\n")
cat("Partial correlation with A (math)\n")
print(par_A_math)
cat("\n")
cat("Partial correlation with A (read)\n")
print(par_A_read)
cat("\n")
cat("Partial correlation with M (math)\n")
print(par_M_math)
cat("\n")
cat("Partial correlation with M (read)\n")
print(par_M_read)
cat("\n")
cat("Partial correlation with Y (math)\n")
print(par_Y_math)
cat("\n")
cat("Partial correlation with Y (read)\n")
print(par_Y_read)
cat("\n")

sink()





########################
### GENERATE FIGURES ###
########################

gamma_0_math <- treatment_on_covs_est_matrices[[1]][1]
gamma_0_read <- treatment_on_covs_est_matrices[[1]][2]

theta_2_math <- impact_on_treatment_est_matrices[[1]][1]
theta_2_read <- impact_on_treatment_est_matrices[[1]][2]

lambda_4_math <- impact_est_matrices[[1]][1]
lambda_4_read <- impact_est_matrices[[1]][2]

lambda_5_math <- impact_x_treatment_est_matrices[[1]][1]
lambda_5_read <- impact_x_treatment_est_matrices[[1]][2]

sd_A_math <- error_sds_est_matrices0[[1]][1]
sd_A_read <- error_sds_est_matrices0[[1]][2]

sd_M_math <- error_sds_est_matrices1[[1]][1]
sd_M_read <- error_sds_est_matrices1[[1]][2]

sd_Y_math <- error_sds_est_matrices2[[1]][1]
sd_Y_read <- error_sds_est_matrices2[[1]][2]

RNDE_math <- c(rnde_est_matrices[[1]][1] - 1.96 * rnde_est_matrices[[1]][3],
               rnde_est_matrices[[1]][1],
               rnde_est_matrices[[1]][1] + 1.96 * rnde_est_matrices[[1]][3])
  
RNDE_read <- c(rnde_est_matrices[[1]][2] - 1.96 * rnde_est_matrices[[1]][4],
               rnde_est_matrices[[1]][2],
               rnde_est_matrices[[1]][2] + 1.96 * rnde_est_matrices[[1]][4])

RNIE_math <- c(rnie_est_matrices[[1]][1] - 1.96 * rnie_est_matrices[[1]][3],
               rnie_est_matrices[[1]][1],
               rnie_est_matrices[[1]][1] + 1.96 * rnie_est_matrices[[1]][3])

RNIE_read <- c(rnie_est_matrices[[1]][2] - 1.96 * rnie_est_matrices[[1]][4],
               rnie_est_matrices[[1]][2],
               rnie_est_matrices[[1]][2] + 1.96 * rnie_est_matrices[[1]][4])

a <- a
a_star <- a_star

calc_bias_AY_RNDE <- function(sd_Y, sd_A, rho) {
  return(sd_Y / sd_A * rho / sqrt(1 - rho^2) * (a_star - a))
}

calc_bias_MY_RNDE <- function(theta_2, sd_Y, sd_M, rho) {
  return(-theta_2 * sd_Y / sd_M * rho / sqrt(1 - rho^2) * (a_star - a))
}
calc_bias_MY_RNIE <- function(theta_2, sd_Y, sd_M, rho) {
  return(theta_2 * sd_Y / sd_M * rho / sqrt(1 - rho^2) * (a_star - a))
}

calc_bias_AM_RNDE <- function(sd_M, sd_A, lambda_5, gamma_0, rho) {
  return(sd_M / sd_A * rho / sqrt(1 - rho^2) * lambda_5 * (a - gamma_0) * (a_star - a))
}
calc_bias_AM_RNIE <- function(sd_M, sd_A, lambda_4, lambda_5, rho) {
  return(sd_M / sd_A * rho / sqrt(1 - rho^2) * (lambda_4 + lambda_5 * a_star) * (a_star - a))
}

bias_AY_adj_RNDE_vals_math_lower <- c()
bias_AY_adj_RNDE_vals_math_point <- c()
bias_AY_adj_RNDE_vals_math_upper <- c()
bias_AY_adj_RNDE_vals_read_lower <- c()
bias_AY_adj_RNDE_vals_read_point <- c()
bias_AY_adj_RNDE_vals_read_upper <- c()

bias_MY_adj_RNDE_vals_math_lower <- c()
bias_MY_adj_RNDE_vals_math_point <- c()
bias_MY_adj_RNDE_vals_math_upper <- c()
bias_MY_adj_RNDE_vals_read_lower <- c()
bias_MY_adj_RNDE_vals_read_point <- c()
bias_MY_adj_RNDE_vals_read_upper <- c()
bias_MY_adj_RNIE_vals_math_lower <- c()
bias_MY_adj_RNIE_vals_math_point <- c()
bias_MY_adj_RNIE_vals_math_upper <- c()
bias_MY_adj_RNIE_vals_read_lower <- c()
bias_MY_adj_RNIE_vals_read_point <- c()
bias_MY_adj_RNIE_vals_read_upper <- c()

bias_AM_adj_RNDE_vals_math_lower <- c()
bias_AM_adj_RNDE_vals_math_point <- c()
bias_AM_adj_RNDE_vals_math_upper <- c()
bias_AM_adj_RNDE_vals_read_lower <- c()
bias_AM_adj_RNDE_vals_read_point <- c()
bias_AM_adj_RNDE_vals_read_upper <- c()
bias_AM_adj_RNIE_vals_math_lower <- c()
bias_AM_adj_RNIE_vals_math_point <- c()
bias_AM_adj_RNIE_vals_math_upper <- c()
bias_AM_adj_RNIE_vals_read_lower <- c()
bias_AM_adj_RNIE_vals_read_point <- c()
bias_AM_adj_RNIE_vals_read_upper <- c()

rhos <- seq(from = -0.3, to = 0.3, by = 0.01)

for (rho in rhos) {
  bias_AY_RNDE_math <- calc_bias_AY_RNDE(sd_Y_math, sd_A_math, rho)
  bias_AY_adj_RNDE_vals_math_lower <- c(bias_AY_adj_RNDE_vals_math_lower, RNDE_math[1] - bias_AY_RNDE_math)
  bias_AY_adj_RNDE_vals_math_point <- c(bias_AY_adj_RNDE_vals_math_point, RNDE_math[2] - bias_AY_RNDE_math)
  bias_AY_adj_RNDE_vals_math_upper <- c(bias_AY_adj_RNDE_vals_math_upper, RNDE_math[3] - bias_AY_RNDE_math)
  bias_AY_RNDE_read <- calc_bias_AY_RNDE(sd_Y_read, sd_A_read, rho)
  bias_AY_adj_RNDE_vals_read_lower <- c(bias_AY_adj_RNDE_vals_read_lower, RNDE_read[1] - bias_AY_RNDE_read)
  bias_AY_adj_RNDE_vals_read_point <- c(bias_AY_adj_RNDE_vals_read_point, RNDE_read[2] - bias_AY_RNDE_read)
  bias_AY_adj_RNDE_vals_read_upper <- c(bias_AY_adj_RNDE_vals_read_upper, RNDE_read[3] - bias_AY_RNDE_read)
  
  bias_MY_RNDE_math <- calc_bias_MY_RNDE(theta_2_math, sd_Y_math, sd_M_math, rho)
  bias_MY_adj_RNDE_vals_math_lower <- c(bias_MY_adj_RNDE_vals_math_lower, RNDE_math[1] - bias_MY_RNDE_math)
  bias_MY_adj_RNDE_vals_math_point <- c(bias_MY_adj_RNDE_vals_math_point, RNDE_math[2] - bias_MY_RNDE_math)
  bias_MY_adj_RNDE_vals_math_upper <- c(bias_MY_adj_RNDE_vals_math_upper, RNDE_math[3] - bias_MY_RNDE_math)
  bias_MY_RNDE_read <- calc_bias_MY_RNDE(theta_2_read, sd_Y_read, sd_M_read, rho)
  bias_MY_adj_RNDE_vals_read_lower <- c(bias_MY_adj_RNDE_vals_read_lower, RNDE_read[1] - bias_MY_RNDE_read)
  bias_MY_adj_RNDE_vals_read_point <- c(bias_MY_adj_RNDE_vals_read_point, RNDE_read[2] - bias_MY_RNDE_read)
  bias_MY_adj_RNDE_vals_read_upper <- c(bias_MY_adj_RNDE_vals_read_upper, RNDE_read[3] - bias_MY_RNDE_read)
  bias_MY_RNIE_math <- calc_bias_MY_RNIE(theta_2_math, sd_Y_math, sd_M_math, rho)
  bias_MY_adj_RNIE_vals_math_lower <- c(bias_MY_adj_RNIE_vals_math_lower, RNIE_math[1] - bias_MY_RNIE_math)
  bias_MY_adj_RNIE_vals_math_point <- c(bias_MY_adj_RNIE_vals_math_point, RNIE_math[2] - bias_MY_RNIE_math)
  bias_MY_adj_RNIE_vals_math_upper <- c(bias_MY_adj_RNIE_vals_math_upper, RNIE_math[3] - bias_MY_RNIE_math)
  bias_MY_RNIE_read <- calc_bias_MY_RNIE(theta_2_read, sd_Y_read, sd_M_read, rho)
  bias_MY_adj_RNIE_vals_read_lower <- c(bias_MY_adj_RNIE_vals_read_lower, RNIE_read[1] - bias_MY_RNIE_read)
  bias_MY_adj_RNIE_vals_read_point <- c(bias_MY_adj_RNIE_vals_read_point, RNIE_read[2] - bias_MY_RNIE_read)
  bias_MY_adj_RNIE_vals_read_upper <- c(bias_MY_adj_RNIE_vals_read_upper, RNIE_read[3] - bias_MY_RNIE_read)
  
  bias_AM_RNDE_math <- calc_bias_AM_RNDE(sd_M_math, sd_A_math, lambda_5_math, gamma_0_math, rho)
  bias_AM_adj_RNDE_vals_math_lower <- c(bias_AM_adj_RNDE_vals_math_lower, RNDE_math[1] - bias_AM_RNDE_math)
  bias_AM_adj_RNDE_vals_math_point <- c(bias_AM_adj_RNDE_vals_math_point, RNDE_math[2] - bias_AM_RNDE_math)
  bias_AM_adj_RNDE_vals_math_upper <- c(bias_AM_adj_RNDE_vals_math_upper, RNDE_math[3] - bias_AM_RNDE_math)
  bias_AM_RNDE_read <- calc_bias_AM_RNDE(sd_M_read, sd_A_read, lambda_5_read, gamma_0_read, rho)
  bias_AM_adj_RNDE_vals_read_lower <- c(bias_AM_adj_RNDE_vals_read_lower, RNDE_read[1] - bias_AM_RNDE_read)
  bias_AM_adj_RNDE_vals_read_point <- c(bias_AM_adj_RNDE_vals_read_point, RNDE_read[2] - bias_AM_RNDE_read)
  bias_AM_adj_RNDE_vals_read_upper <- c(bias_AM_adj_RNDE_vals_read_upper, RNDE_read[3] - bias_AM_RNDE_read)
  bias_AM_RNIE_math <- calc_bias_AM_RNIE(sd_M_math, sd_A_math, lambda_4_math, lambda_5_math, rho)
  bias_AM_adj_RNIE_vals_math_lower <- c(bias_AM_adj_RNIE_vals_math_lower, RNIE_math[1] - bias_AM_RNIE_math)
  bias_AM_adj_RNIE_vals_math_point <- c(bias_AM_adj_RNIE_vals_math_point, RNIE_math[2] - bias_AM_RNIE_math)
  bias_AM_adj_RNIE_vals_math_upper <- c(bias_AM_adj_RNIE_vals_math_upper, RNIE_math[3] - bias_AM_RNIE_math)
  bias_AM_RNIE_read <- calc_bias_AM_RNIE(sd_M_read, sd_A_read, lambda_4_read, lambda_5_read, rho)
  bias_AM_adj_RNIE_vals_read_lower <- c(bias_AM_adj_RNIE_vals_read_lower, RNIE_read[1] - bias_AM_RNIE_read)
  bias_AM_adj_RNIE_vals_read_point <- c(bias_AM_adj_RNIE_vals_read_point, RNIE_read[2] - bias_AM_RNIE_read)
  bias_AM_adj_RNIE_vals_read_upper <- c(bias_AM_adj_RNIE_vals_read_upper, RNIE_read[3] - bias_AM_RNIE_read)
}

df <- data.frame(
  rhos = rhos,
  bias_AY_adj_RNDE_vals_math_lower = bias_AY_adj_RNDE_vals_math_lower,
  bias_AY_adj_RNDE_vals_math_point = bias_AY_adj_RNDE_vals_math_point,
  bias_AY_adj_RNDE_vals_math_upper = bias_AY_adj_RNDE_vals_math_upper,
  bias_AY_adj_RNDE_vals_read_lower = bias_AY_adj_RNDE_vals_read_lower,
  bias_AY_adj_RNDE_vals_read_point = bias_AY_adj_RNDE_vals_read_point,
  bias_AY_adj_RNDE_vals_read_upper = bias_AY_adj_RNDE_vals_read_upper,  
  bias_MY_adj_RNDE_vals_math_lower = bias_MY_adj_RNDE_vals_math_lower,
  bias_MY_adj_RNDE_vals_math_point = bias_MY_adj_RNDE_vals_math_point,
  bias_MY_adj_RNDE_vals_math_upper = bias_MY_adj_RNDE_vals_math_upper,
  bias_MY_adj_RNDE_vals_read_lower = bias_MY_adj_RNDE_vals_read_lower,
  bias_MY_adj_RNDE_vals_read_point = bias_MY_adj_RNDE_vals_read_point,
  bias_MY_adj_RNDE_vals_read_upper = bias_MY_adj_RNDE_vals_read_upper,  
  bias_MY_adj_RNIE_vals_math_lower = bias_MY_adj_RNIE_vals_math_lower,
  bias_MY_adj_RNIE_vals_math_point = bias_MY_adj_RNIE_vals_math_point,
  bias_MY_adj_RNIE_vals_math_upper = bias_MY_adj_RNIE_vals_math_upper,
  bias_MY_adj_RNIE_vals_read_lower = bias_MY_adj_RNIE_vals_read_lower,
  bias_MY_adj_RNIE_vals_read_point = bias_MY_adj_RNIE_vals_read_point,
  bias_MY_adj_RNIE_vals_read_upper = bias_MY_adj_RNIE_vals_read_upper,
  bias_AM_adj_RNDE_vals_math_lower = bias_AM_adj_RNDE_vals_math_lower,
  bias_AM_adj_RNDE_vals_math_point = bias_AM_adj_RNDE_vals_math_point,
  bias_AM_adj_RNDE_vals_math_upper = bias_AM_adj_RNDE_vals_math_upper,
  bias_AM_adj_RNDE_vals_read_lower = bias_AM_adj_RNDE_vals_read_lower,
  bias_AM_adj_RNDE_vals_read_point = bias_AM_adj_RNDE_vals_read_point,
  bias_AM_adj_RNDE_vals_read_upper = bias_AM_adj_RNDE_vals_read_upper,  
  bias_AM_adj_RNIE_vals_math_lower = bias_AM_adj_RNIE_vals_math_lower,
  bias_AM_adj_RNIE_vals_math_point = bias_AM_adj_RNIE_vals_math_point,
  bias_AM_adj_RNIE_vals_math_upper = bias_AM_adj_RNIE_vals_math_upper,
  bias_AM_adj_RNIE_vals_read_lower = bias_AM_adj_RNIE_vals_read_lower,
  bias_AM_adj_RNIE_vals_read_point = bias_AM_adj_RNIE_vals_read_point,
  bias_AM_adj_RNIE_vals_read_upper = bias_AM_adj_RNIE_vals_read_upper
)

# Figure G.1

path <- "C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/figures-replicate-study/3-analyze-data/figure-g-1.tiff"
tiff(path, width = 8, height = 4, units = 'in', res = 600)

rnde_math <- ggplot(df[1:31, ], aes(x = rhos, y = bias_AY_adj_RNDE_vals_math_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_AY_adj_RNDE_vals_math_upper, ymin = bias_AY_adj_RNDE_vals_math_lower), alpha= 0.25) + 
  xlab("Error correlation (rho)") + 
  ylab("Bias-adjusted estimate of the RNDE") + 
  ggtitle("Math scores") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  ylim(-0.35, 0.55) + 
  geom_hline(yintercept = 0, linetype = "dashed")
rnde_read <- ggplot(df[1:31, ], aes(x = rhos, y = bias_AY_adj_RNDE_vals_read_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_AY_adj_RNDE_vals_read_upper, ymin = bias_AY_adj_RNDE_vals_read_lower), alpha = 0.25) + 
  xlab("Error correlation (rho)") + 
  ylab("") + 
  ggtitle("Reading scores") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  ylim(-0.35, 0.55) + 
  geom_hline(yintercept = 0, linetype = "dashed")
grid.arrange(rnde_math, 
             rnde_read, 
             ncol = 2, 
             top = "Bias-adjusted estimates of the RNDE as a function of the error correlation")

dev.off()

# Figure G.2

path <- "C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/figures-replicate-study/3-analyze-data/figure-g-2.tiff"
tiff(path, width = 8, height = 8, units = 'in', res = 600)

rnde_math <- ggplot(df, aes(x = rhos, y = bias_MY_adj_RNDE_vals_math_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_MY_adj_RNDE_vals_math_upper, ymin = bias_MY_adj_RNDE_vals_math_lower), alpha = 0.25) + 
  xlab("") + 
  ylab("Bias-adjusted estimate of the RNDE") + 
  ggtitle("Math scores") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  ylim(-0.35, 0.5) + 
  geom_hline(yintercept = 0, linetype = "dashed")
rnde_read <- ggplot(df, aes(x = rhos, y = bias_MY_adj_RNDE_vals_read_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_MY_adj_RNDE_vals_read_upper, ymin = bias_MY_adj_RNDE_vals_read_lower), alpha = 0.25) + 
  xlab("") + 
  ylab("") + 
  ggtitle("Reading scores") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  ylim(-0.35, 0.5) + 
  geom_hline(yintercept = 0, linetype = "dashed")
rnie_math <- ggplot(df, aes(x = rhos, y = bias_MY_adj_RNIE_vals_math_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_MY_adj_RNIE_vals_math_upper, ymin = bias_MY_adj_RNIE_vals_math_lower), alpha = 0.25) + 
  xlab("Error correlation (rho)") + 
  ylab("Bias-adjusted estimate of the RNIE") + 
  ylim(-0.035, 0.055) + 
  geom_hline(yintercept = 0, linetype = "dashed")
rnie_read <- ggplot(df, aes(x = rhos, y = bias_MY_adj_RNIE_vals_read_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_MY_adj_RNIE_vals_read_upper, ymin = bias_MY_adj_RNIE_vals_read_lower), alpha = 0.25) + 
  xlab("Error correlation (rho)") + 
  ylab("") + #ylim(-0.5, 0.5) + 
  ylim(-0.035, 0.055) + 
  geom_hline(yintercept = 0, linetype = "dashed")
grid.arrange(rnde_math, 
             rnde_read, 
             rnie_math, 
             rnie_read, 
             ncol = 2,
             top = "Bias-adjusted estimates of the RNDE and RNIE as a function of the error correlation")

dev.off()

# Figure G.3

path <- "C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/figures-replicate-study/3-analyze-data/figure-g-3.tiff"
tiff(path, width = 8, height = 8, units = 'in', res = 600)

rnde_math <- ggplot(df[1:31, ], aes(x = rhos, y = bias_AM_adj_RNDE_vals_math_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_AM_adj_RNDE_vals_math_upper, ymin = bias_AM_adj_RNDE_vals_math_lower), alpha = 0.25) + 
  xlab("") + 
  ylab("Bias-adjusted estimate of the RNDE") + 
  ggtitle("Math scores") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  ylim(-0.35, 0.5) +
  geom_hline(yintercept = 0, linetype = "dashed")
rnde_read <- ggplot(df[1:31, ], aes(x = rhos, y = bias_AM_adj_RNDE_vals_read_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_AM_adj_RNDE_vals_read_upper, ymin = bias_AM_adj_RNDE_vals_read_lower), alpha = 0.25) + 
  xlab("") + 
  ylab("") + 
  ggtitle("Reading scores") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  ylim(-0.35, 0.5) +
  geom_hline(yintercept = 0, linetype = "dashed")
rnie_math <- ggplot(df[1:31, ], aes(x = rhos, y = bias_AM_adj_RNIE_vals_math_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_AM_adj_RNIE_vals_math_upper, ymin = bias_AM_adj_RNIE_vals_math_lower), alpha = 0.25) + 
  xlab("Error correlation (rho)") + 
  ylab("Bias-adjusted estimate of the RNIE") + 
  ylim(-0.02, 0.15) +
  geom_hline(yintercept = 0, linetype = "dashed")
rnie_read <- ggplot(df[1:31, ], aes(x = rhos, y = bias_AM_adj_RNIE_vals_read_point)) + 
  geom_line() +
  geom_ribbon(aes(ymax = bias_AM_adj_RNIE_vals_read_upper, ymin = bias_AM_adj_RNIE_vals_read_lower), alpha = 0.25) + 
  xlab("Error correlation (rho)") + 
  ylab("") + 
  ylim(-0.02, 0.15) +
  geom_hline(yintercept = 0, linetype = "dashed")
grid.arrange(rnde_math, 
             rnde_read, 
             rnie_math, 
             rnie_read, 
             ncol = 2, 
             top = "Bias-adjusted estimates of the RNDE and RNIE as a function of the error correlation")

dev.off()
