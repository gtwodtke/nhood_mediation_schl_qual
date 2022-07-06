####################
# TABLES 4-8 (MID) #
####################

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
  "c5r4mtht_r", "c5r4rtht_r",
  "re_impact_math",
  "re_impact_read",
  "school_resources",
  "school_disorder",
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
  "S3_ID", "_mi_m", "_mi_id"
)

mid_remove_ids <- subset(analytic_sample_post_mi, is.na(c5r4mtht_r) | is.na(c5r4rtht_r) | is.na(re_impact_read) | is.na(re_impact_math) | is.na(school_resources) | is.na(school_disorder))[["_mi_id"]]

`%notin%` <- Negate(`%in%`)

analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" != 0), vars]
analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_id" %notin% mid_remove_ids), vars]



### Standardize variables ###

# Outcome
analytic_sample_post_mi$c5r4mtht_r <- ((analytic_sample_post_mi$c5r4mtht_r - mean(analytic_sample_post_mi$c5r4mtht_r)) / sd(analytic_sample_post_mi$c5r4mtht_r))
analytic_sample_post_mi$c5r4rtht_r <- ((analytic_sample_post_mi$c5r4rtht_r - mean(analytic_sample_post_mi$c5r4rtht_r)) / sd(analytic_sample_post_mi$c5r4rtht_r))

# Mediator: school effectiveness
analytic_sample_post_mi$re_impact_math      <- ((analytic_sample_post_mi$re_impact_math      - mean(analytic_sample_post_mi$re_impact_math))      / sd(analytic_sample_post_mi$re_impact_math))
analytic_sample_post_mi$re_impact_read      <- ((analytic_sample_post_mi$re_impact_read      - mean(analytic_sample_post_mi$re_impact_read))      / sd(analytic_sample_post_mi$re_impact_read))

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





####################
### CALCULATIONS ###
####################

### Initialize matrices to store beta/var values ###
  
# Table 4 --> 3 columns
# Table 5 --> 3 columns
mibeta_rate <- matrix(data = NA, nrow = nmi, ncol = 6) 
mivar_rate  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_rnde    <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rnde     <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_cde     <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_cde      <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_rintref <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rintref  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_rnie    <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rnie     <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_rpie    <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rpie     <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_rintmed <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rintmed  <- matrix(data = NA, nrow = nmi, ncol = 6)

mibeta_rnde_dagger <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rnde_dagger  <- matrix(data = NA, nrow = nmi, ncol = 6)
mibeta_rnie_dagger <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_rnie_dagger  <- matrix(data = NA, nrow = nmi, ncol = 6)

# Table 6 (four mediators, two post-treatment confounders)
mibeta_mediator_on_treatment <- matrix(data = NA, nrow = nmi, ncol = 6)
mivar_mediator_on_treatment  <- matrix(data = NA, nrow = nmi, ncol = 6)

# Tables 7, 8 (3rd grade outcomes only)
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
  
  
  
  # Compute reliabilities for the impact-by-treatment interaction terms
  r = 0.7
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
  
  
  
  # Fit Model 1: Mediator on treatment (Table 6)
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
  
  
  
  # Add variables for mediator-by-treatment interaction
  analytic_sample$math_impact_x_treatment_re <- analytic_sample$re_impact_math * analytic_sample$trct_disadv_index2
  analytic_sample$read_impact_x_treatment_re <- analytic_sample$re_impact_read * analytic_sample$trct_disadv_index2
  
  analytic_sample$school_resources_x_treatment <- analytic_sample$school_resources * analytic_sample$trct_disadv_index2
  analytic_sample$school_disorder_x_treatment  <- analytic_sample$school_disorder  * analytic_sample$trct_disadv_index2
  
  
  
  # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
  
  # Tables 4, 7 (math scores)
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
                                         reliability = reliability_vector_math_re)
  
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
  
  # Tables 5, 8 (reading scores)
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
                                         reliability = reliability_vector_read_re)
  
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
  
  
  
  # Compute block bootstrap SEs
  
  set.seed(123)
  
  # Table 4 --> 3 columns
  # Table 5 --> 3 columns
  bootdist_rate <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  bootdist_rnde    <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_cde     <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_rintref <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  bootdist_rnie    <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_rpie    <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_rintmed <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  bootdist_rnde_dagger <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_rnie_dagger <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  # Table 6
  bootdist_mediator_on_treatment <- matrix(data = NA, nrow = nboot, ncol = 6)
  
  # Tables 7, 8
  bootdist_treatment             <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_schl_qual             <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_schl_qual_x_treatment <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_free_lunch            <- matrix(data = NA, nrow = nboot, ncol = 6)
  bootdist_racial_comp           <- matrix(data = NA, nrow = nboot, ncol = 6)
  
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
    
    # Fit Model 1: Mediator on treatment (Table 6)
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
    
    
    
    # Add variables for mediator-by-treatment interaction
    analytic_sample.boot$math_impact_x_treatment_re <- analytic_sample.boot$re_impact_math * analytic_sample.boot$trct_disadv_index2
    analytic_sample.boot$read_impact_x_treatment_re <- analytic_sample.boot$re_impact_read * analytic_sample.boot$trct_disadv_index2

    analytic_sample.boot$school_resources_x_treatment <- analytic_sample.boot$school_resources * analytic_sample.boot$trct_disadv_index2
    analytic_sample.boot$school_disorder_x_treatment  <- analytic_sample.boot$school_disorder  * analytic_sample.boot$trct_disadv_index2
    
    
    
    # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
    
    # Tables 4, 7 (math scores)
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
                                           reliability = reliability_vector_math_re)
    
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
    
    # Tables 5, 8 (reading scores)
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
                                           reliability = reliability_vector_read_re)
    
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
    
  }
  
  for (m in 1:6) {
    
    # Tables 4, 5
    mivar_rate[i,m]        <- var(bootdist_rate[,m])
    mivar_rnde[i,m]        <- var(bootdist_rnde[,m])
    mivar_cde[i,m]         <- var(bootdist_cde[,m])
    mivar_rintref[i,m]     <- var(bootdist_rintref[,m])
    mivar_rnie[i,m]        <- var(bootdist_rnie[,m])
    mivar_rpie[i,m]        <- var(bootdist_rpie[,m])
    mivar_rintmed[i,m]     <- var(bootdist_rintmed[,m])
    mivar_rnde_dagger[i,m] <- var(bootdist_rnde_dagger[,m])
    mivar_rnie_dagger[i,m] <- var(bootdist_rnie_dagger[,m])
    
    # Table 6
    mivar_mediator_on_treatment[i,m]  <- var(bootdist_mediator_on_treatment[,m])
    
    # Tables 7, 8
    mivar_treatment[i,m]             <- var(bootdist_treatment[,m])
    mivar_schl_qual[i,m]             <- var(bootdist_schl_qual[,m])
    mivar_schl_qual_x_treatment[i,m] <- var(bootdist_schl_qual_x_treatment[,m])
    mivar_free_lunch[i,m]            <- var(bootdist_free_lunch[,m])
    mivar_racial_comp[i,m]           <- var(bootdist_racial_comp[,m])
  
  }
  
}





### Combine MI estimates ###

# Tables 4, 5
rate_est        <- matrix(data=NA, nrow=6, ncol=4)
rnde_est        <- matrix(data=NA, nrow=6, ncol=4)
cde_est         <- matrix(data=NA, nrow=6, ncol=4)
rintref_est     <- matrix(data=NA, nrow=6, ncol=4)
rnie_est        <- matrix(data=NA, nrow=6, ncol=4)
rpie_est        <- matrix(data=NA, nrow=6, ncol=4)
rintmed_est     <- matrix(data=NA, nrow=6, ncol=4)
rnde_dagger_est <- matrix(data=NA, nrow=6, ncol=4)
rnie_dagger_est <- matrix(data=NA, nrow=6, ncol=4)

# Table 6
mediator_on_treatment_est <- matrix(data=NA, nrow=6, ncol=4)

# Tables 7, 8
treatment_est             <- matrix(data=NA, nrow=6, ncol=4)
schl_qual_est             <- matrix(data=NA, nrow=6, ncol=4)
schl_qual_x_treatment_est <- matrix(data=NA, nrow=6, ncol=4)
free_lunch_est            <- matrix(data=NA, nrow=6, ncol=4)
racial_comp_est           <- matrix(data=NA, nrow=6, ncol=4)

for (i in 1:6) {
  
  # Tables 4, 5
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
  
}





### Print results ###

sink("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/logs-replicate-study/3-analyze-data/5-mid-main-tables.txt")

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

sink()
