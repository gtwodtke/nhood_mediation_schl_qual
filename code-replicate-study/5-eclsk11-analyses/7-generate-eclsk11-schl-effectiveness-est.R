#############################################################################
# COMPUTE ESTIMATES BASED ON SCHOOL EFFECTIVENESS MEASURES FROM ECLS-K 2011 #
#############################################################################

rm(list=ls())

library(foreign)
library(eivtools)

nmi <- 50
nboot <- 500

#########################
### INPUT/RECODE DATA ###
#########################

### Input data ###
eclsk.mi <- read.dta("C:\\Users\\wodtke\\Desktop\\projects\\nhood_mediation_schl_qual\\replication\\data-replicate-study\\data-replicate-study\\eclsk11\\eclsk11\\eclsk11mi.dta")
eclsk.mi <- as.data.frame(eclsk.mi[which(eclsk.mi$minum!=0),])

all.vars<-c(
	"re_impact_read",
	"re_impact2_read",
	"re_impact_math",
	"re_impact2_math",
	"rdtheta1",
	"rdtheta7",
	"mththeta1",
	"mththeta7",
	"rdtheta1_mean",
	"mththeta1_mean",
	"gender",
	"race_2","race_3","race_4","race_5",
	"hhtot1",
	"faminc2",
	"marbrth",
	"brthwt",
	"pared_2","pared_3","pared_4","pared_5",
	"paremp_2","paremp_3",
	"parage",
	"cogstim",
	"pardepres",
	"ownhome",
	"parinvolve",
	"sfrlnch4",
	"snonwht4",
	"nhdadvg")

### Standardize variables ###
for (v in 1:length(all.vars)) {
	eclsk.mi[,all.vars[v]]<-(eclsk.mi[,all.vars[v]]-mean(eclsk.mi[,all.vars[v]]))/sd(eclsk.mi[,all.vars[v]])
	}

####################
### CALCULATIONS ###
####################

### Initialize matrices to store beta/var values ###

mibeta_rate <- matrix(data = NA, nrow = nmi, ncol = 4) 
mivar_rate  <- matrix(data = NA, nrow = nmi, ncol = 4)

mibeta_rnde    <- matrix(data = NA, nrow = nmi, ncol = 4)
mivar_rnde     <- matrix(data = NA, nrow = nmi, ncol = 4)
mibeta_cde     <- matrix(data = NA, nrow = nmi, ncol = 4)
mivar_cde      <- matrix(data = NA, nrow = nmi, ncol = 4)
mibeta_rintref <- matrix(data = NA, nrow = nmi, ncol = 4)
mivar_rintref  <- matrix(data = NA, nrow = nmi, ncol = 4)

mibeta_rnie    <- matrix(data = NA, nrow = nmi, ncol = 4)
mivar_rnie     <- matrix(data = NA, nrow = nmi, ncol = 4)
mibeta_rpie    <- matrix(data = NA, nrow = nmi, ncol = 4)
mivar_rpie     <- matrix(data = NA, nrow = nmi, ncol = 4)
mibeta_rintmed <- matrix(data = NA, nrow = nmi, ncol = 4)
mivar_rintmed  <- matrix(data = NA, nrow = nmi, ncol = 4)

### Loop through imputed datasets ###

for (i in 1:nmi) {
  
  print(i)

  # Select imputed dataset
  analytic_sample <- eclsk.mi[which(eclsk.mi$minum == i), ]
    
  # Percentile calculations
  
  # Treatment
  pc_treatment <- quantile(analytic_sample$nhdadvg, probs=c(0.2, 0.8), na.rm=TRUE)
  
  # Schl effectiveness
  pc_schlv1_read <- quantile(analytic_sample$re_impact_read, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_schlv1_math <- quantile(analytic_sample$re_impact_math, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)

  pc_schlv2_read <- quantile(analytic_sample$re_impact2_read, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  pc_schlv2_math <- quantile(analytic_sample$re_impact2_math, probs=c(0.25, 0.5, 0.75), na.rm=TRUE)
  
  m_star_schlv1_read <- pc_schlv1_read[2]
  m_star_schlv1_math <- pc_schlv1_math[2] 

  m_star_schlv2_read <- pc_schlv2_read[2]
  m_star_schlv2_math <- pc_schlv2_math[2] 
  
  # Compute mediator-by-treatment correlations
  cor_schlv1_treatment_math <- cor(analytic_sample$re_impact_read, analytic_sample$nhdadvg)
  cor_schlv1_treatment_read <- cor(analytic_sample$re_impact_math, analytic_sample$nhdadvg)

  cor_schlv2_treatment_math <- cor(analytic_sample$re_impact2_read, analytic_sample$nhdadvg)
  cor_schlv2_treatment_read <- cor(analytic_sample$re_impact2_math, analytic_sample$nhdadvg)

  # Reliabilities
  reliabilities <- seq(from = 0.8, to = 0.6, by = -0.1)
  idx <- 1

  interaction_rel_v1_math <- c()
  interaction_rel_v1_read <- c()

  interaction_rel_v1_math_vec <- c()
  interaction_rel_v1_read_vec <- c()

  reliability_vector_v1_math_list <- list()
  reliability_vector_v1_read_list <- list()

  interaction_rel_v2_math <- c()
  interaction_rel_v2_read <- c()

  interaction_rel_v2_math_vec <- c()
  interaction_rel_v2_read_vec <- c()

  reliability_vector_v2_math_list <- list()
  reliability_vector_v2_read_list <- list()
 
  for (r in reliabilities) {

    interaction_rel_v1_math <- (r + cor_schlv1_treatment_math^2) / (1 + cor_schlv1_treatment_math^2)
    interaction_rel_v1_read <- (r + cor_schlv1_treatment_read^2) / (1 + cor_schlv1_treatment_read^2)

    interaction_rel_v2_math <- (r + cor_schlv2_treatment_math^2) / (1 + cor_schlv2_treatment_math^2)
    interaction_rel_v2_read <- (r + cor_schlv2_treatment_read^2) / (1 + cor_schlv2_treatment_read^2)

    interaction_rel_v1_math_vec <- c(interaction_rel_v1_math_vec, interaction_rel_v1_math)
    interaction_rel_v1_read_vec <- c(interaction_rel_v1_read_vec, interaction_rel_v1_read)

    interaction_rel_v2_math_vec <- c(interaction_rel_v2_math_vec, interaction_rel_v2_math)
    interaction_rel_v2_read_vec <- c(interaction_rel_v2_read_vec, interaction_rel_v2_read)
    
    ### Generate reliability vectors
	#mediator,
	#mediator x treatment,
	#treatment,
	#sfrlnch4,
	#snonwht4,
	#rdtheta1_mean/mththeta1_mean,
	#rdtheta1/mththeta1,
	#gender,
	#race_2,race_3,race_4,race_5,
	#hhtot1,
	#faminc2,
	#marbrth,
	#brthwt,
	#pared_2,pared_3,pared_4,pared_5,
	#paremp_2,paremp_3,
	#parage,
	#cogstim,
	#pardepres
	#ownhome
	#parinvolve

    reliability_vector_v1_math	 <- 	c(r,
							interaction_rel_v1_math,
							1,
							1,
							1,
							1,
							1,
							1,
							1,1,1,1,
							1,
							1,
							1,
							1,
							1,1,1,1,
							1,1,
							1,
							1,
							1,
							1,
							1)

    reliability_vector_v1_read	 <- 	c(r,
							interaction_rel_v1_read,
							1,
							1,
							1,
							1,
							1,
							1,
							1,1,1,1,
							1,
							1,
							1,
							1,
							1,1,1,1,
							1,1,
							1,
							1,
							1,
							1,
							1)

    reliability_vector_v2_math	 <- 	c(r,
							interaction_rel_v2_math,
							1,
							1,
							1,
							1,
							1,
							1,
							1,1,1,1,
							1,
							1,
							1,
							1,
							1,1,1,1,
							1,1,
							1,
							1,
							1,
							1,
							1)

    reliability_vector_v2_read	 <- 	c(r,
							interaction_rel_v2_read,
							1,
							1,
							1,
							1,
							1,
							1,
							1,1,1,1,
							1,
							1,
							1,
							1,
							1,1,1,1,
							1,1,
							1,
							1,
							1,
							1,
							1)

    names(reliability_vector_v1_math) <- c(
	"re_impact_math",
	"re_impact_math_x_treatment",
	"nhdadvg",
	"sfrlnch4_r",
	"snonwht4_r",
	"mththeta1_mean",
	"mththeta1",
	"gender",
	"race_2","race_3","race_4","race_5",
	"hhtot1",
	"faminc2",
	"marbrth",
	"brthwt",
	"pared_2","pared_3","pared_4","pared_5",
	"paremp_2","paremp_3",
	"parage",
	"cogstim",
	"pardepres",
	"ownhome",
	"parinvolve")

    names(reliability_vector_v1_read) <- c(
	"re_impact_read",
	"re_impact_read_x_treatment",
	"nhdadvg",
	"sfrlnch4_r",
	"snonwht4_r",
	"rdtheta1_mean",
	"rdtheta1",
	"gender",
	"race_2","race_3","race_4","race_5",
	"hhtot1",
	"faminc2",
	"marbrth",
	"brthwt",
	"pared_2","pared_3","pared_4","pared_5",
	"paremp_2","paremp_3",
	"parage",
	"cogstim",
	"pardepres",
	"ownhome",
	"parinvolve")

    names(reliability_vector_v2_math) <- c(
	"re_impact2_math",
	"re_impact2_math_x_treatment",
	"nhdadvg",
	"sfrlnch4_r",
	"snonwht4_r",
	"mththeta1_mean",
	"mththeta1",
	"gender",
	"race_2","race_3","race_4","race_5",
	"hhtot1",
	"faminc2",
	"marbrth",
	"brthwt",
	"pared_2","pared_3","pared_4","pared_5",
	"paremp_2","paremp_3",
	"parage",
	"cogstim",
	"pardepres",
	"ownhome",
	"parinvolve")

    names(reliability_vector_v2_read) <- c(
	"re_impact2_read",
	"re_impact2_read_x_treatment",
	"nhdadvg",
	"sfrlnch4_r",
	"snonwht4_r",
	"rdtheta1_mean",
	"rdtheta1",
	"gender",
	"race_2","race_3","race_4","race_5",
	"hhtot1",
	"faminc2",
	"marbrth",
	"brthwt",
	"pared_2","pared_3","pared_4","pared_5",
	"paremp_2","paremp_3",
	"parage",
	"cogstim",
	"pardepres",
	"ownhome",
	"parinvolve")

    reliability_vector_v1_math_list[[idx]] <- reliability_vector_v1_math
    reliability_vector_v1_read_list[[idx]] <- reliability_vector_v1_read

    reliability_vector_v2_math_list[[idx]] <- reliability_vector_v2_math
    reliability_vector_v2_read_list[[idx]] <- reliability_vector_v2_read
    
    idx <- idx + 1
    }

  # Fit Model 1: Mediator on treatment
  schl_eff_v1_math_on_treatment <- lm(re_impact_math ~ 
                                    nhdadvg + 
						mththeta1_mean +
						mththeta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
						data = analytic_sample)
  
  schl_eff_v1_read_on_treatment <- lm(re_impact_read ~ 
                                    nhdadvg + 
						rdtheta1_mean +
						rdtheta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
						data = analytic_sample)

  schl_eff_v2_math_on_treatment <- lm(re_impact2_math ~ 
                                    nhdadvg + 
						mththeta1_mean +
						mththeta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
						data = analytic_sample)
  
  schl_eff_v2_read_on_treatment <- lm(re_impact2_read ~ 
                                    nhdadvg + 
						rdtheta1_mean +
						rdtheta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
						data = analytic_sample)

  free_lunch_on_treatment <- lm(sfrlnch4 ~ 
                                    nhdadvg + 
						mththeta1_mean + rdtheta1_mean +
						mththeta1 + rdtheta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
                                data = analytic_sample)
  
  racial_comp_on_treatment <- lm(snonwht4 ~ 
                                   nhdadvg + 
						mththeta1_mean + rdtheta1_mean +
						mththeta1 + rdtheta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
                                 data = analytic_sample)
  
  # RWR calculations
  analytic_sample$sfrlnch4_r <- NA
  analytic_sample$sfrlnch4_r <- residuals(free_lunch_on_treatment)
  
  analytic_sample$snonwht4_r <- NA
  analytic_sample$snonwht4_r <- residuals(racial_comp_on_treatment)
   
  # Add variables for mediator-by-treatment interaction
  analytic_sample$re_impact_math_x_treatment <- analytic_sample$re_impact_math * analytic_sample$nhdadvg
  analytic_sample$re_impact_read_x_treatment <- analytic_sample$re_impact_read * analytic_sample$nhdadvg

  analytic_sample$re_impact2_math_x_treatment <- analytic_sample$re_impact2_math * analytic_sample$nhdadvg
  analytic_sample$re_impact2_read_x_treatment <- analytic_sample$re_impact2_read * analytic_sample$nhdadvg

  # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
    outcome_model_schl_eff_v1_math <- eivreg(mththeta7 ~ 
							re_impact_math +
							re_impact_math_x_treatment +
							nhdadvg +
							sfrlnch4_r +
							snonwht4_r +
							mththeta1_mean +
							mththeta1 +
							gender +
							race_2 + race_3 + race_4 + race_5 +
							hhtot1 +
							faminc2 +
							marbrth +
							brthwt +
							pared_2 + pared_3 + pared_4 + pared_5 +
							paremp_2 + paremp_3 +
							parage +	
							cogstim +
							pardepres +
							ownhome +
							parinvolve,
                                         data = analytic_sample,
                                         reliability = reliability_vector_v1_math_list[[1]])

    outcome_model_schl_eff_v1_read <- eivreg(rdtheta7 ~ 
							re_impact_read +
							re_impact_read_x_treatment +
							nhdadvg +
							sfrlnch4_r +
							snonwht4_r +
							rdtheta1_mean +
							rdtheta1 +
							gender +
							race_2 + race_3 + race_4 + race_5 +
							hhtot1 +
							faminc2 +
							marbrth +
							brthwt +
							pared_2 + pared_3 + pared_4 + pared_5 +
							paremp_2 + paremp_3 +
							parage +	
							cogstim +
							pardepres +
							ownhome +
							parinvolve,
                                         data = analytic_sample,
                                         reliability = reliability_vector_v1_read_list[[1]])

    outcome_model_schl_eff_v2_math <- eivreg(mththeta7 ~ 
							re_impact2_math +
							re_impact2_math_x_treatment +
							nhdadvg +
							sfrlnch4_r +
							snonwht4_r +
							mththeta1_mean +
							mththeta1 +
							gender +
							race_2 + race_3 + race_4 + race_5 +
							hhtot1 +
							faminc2 +
							marbrth +
							brthwt +
							pared_2 + pared_3 + pared_4 + pared_5 +
							paremp_2 + paremp_3 +
							parage +	
							cogstim +
							pardepres +
							ownhome +
							parinvolve,
                                         data = analytic_sample,
                                         reliability = reliability_vector_v2_math_list[[1]])

    outcome_model_schl_eff_v2_read <- eivreg(rdtheta7 ~ 
							re_impact2_read +
							re_impact2_read_x_treatment +
							nhdadvg +
							sfrlnch4_r +
							snonwht4_r +
							rdtheta1_mean +
							rdtheta1 +
							gender +
							race_2 + race_3 + race_4 + race_5 +
							hhtot1 +
							faminc2 +
							marbrth +
							brthwt +
							pared_2 + pared_3 + pared_4 + pared_5 +
							paremp_2 + paremp_3 +
							parage +	
							cogstim +
							pardepres +
							ownhome +
							parinvolve,
                                         data = analytic_sample,
                                         reliability = reliability_vector_v2_read_list[[1]])

  # Effects - version 1 - Math
  mibeta_cde[i,1]  <- (outcome_model_schl_eff_v1_math$coef[4] + outcome_model_schl_eff_v1_math$coef[3] * m_star_schlv1_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,1]  <- outcome_model_schl_eff_v1_math$coef[3] * (schl_eff_v1_math_on_treatment$coef[1] + schl_eff_v1_math_on_treatment$coef[2] * pc_treatment[1] - m_star_schlv1_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,1]  <- (schl_eff_v1_math_on_treatment$coef[2] * outcome_model_schl_eff_v1_math$coef[2] + schl_eff_v1_math_on_treatment$coef[2] * outcome_model_schl_eff_v1_math$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,1]  <- schl_eff_v1_math_on_treatment$coef[2] * outcome_model_schl_eff_v1_math$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,1]  <- mibeta_cde[i,1]  + mibeta_rintref[i,1]
  mibeta_rnie[i,1]  <- mibeta_rpie[i,1]  + mibeta_rintmed[i,1]
  mibeta_rate[i,1]  <- mibeta_rnde[i,1]  + mibeta_rnie[i,1]

  # Effects - version 1 - Read
  mibeta_cde[i,2]  <- (outcome_model_schl_eff_v1_read$coef[4] + outcome_model_schl_eff_v1_read$coef[3] * m_star_schlv1_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,2]  <- outcome_model_schl_eff_v1_read$coef[3] * (schl_eff_v1_read_on_treatment$coef[1] + schl_eff_v1_read_on_treatment$coef[2] * pc_treatment[1] - m_star_schlv1_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,2]  <- (schl_eff_v1_read_on_treatment$coef[2] * outcome_model_schl_eff_v1_read$coef[2] + schl_eff_v1_read_on_treatment$coef[2] * outcome_model_schl_eff_v1_read$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,2]  <- schl_eff_v1_read_on_treatment$coef[2] * outcome_model_schl_eff_v1_read$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,2]  <- mibeta_cde[i,2]  + mibeta_rintref[i,2]
  mibeta_rnie[i,2]  <- mibeta_rpie[i,2]  + mibeta_rintmed[i,2]
  mibeta_rate[i,2]  <- mibeta_rnde[i,2]  + mibeta_rnie[i,2]

  # Effects - version 2 - Math
  mibeta_cde[i,3]  <- (outcome_model_schl_eff_v2_math$coef[4] + outcome_model_schl_eff_v2_math$coef[3] * m_star_schlv1_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,3]  <- outcome_model_schl_eff_v2_math$coef[3] * (schl_eff_v2_math_on_treatment$coef[1] + schl_eff_v2_math_on_treatment$coef[2] * pc_treatment[1] - m_star_schlv1_math) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,3]  <- (schl_eff_v2_math_on_treatment$coef[2] * outcome_model_schl_eff_v2_math$coef[2] + schl_eff_v2_math_on_treatment$coef[2] * outcome_model_schl_eff_v2_math$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,3]  <- schl_eff_v2_math_on_treatment$coef[2] * outcome_model_schl_eff_v2_math$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,3]  <- mibeta_cde[i,3]  + mibeta_rintref[i,3]
  mibeta_rnie[i,3]  <- mibeta_rpie[i,3]  + mibeta_rintmed[i,3]
  mibeta_rate[i,3]  <- mibeta_rnde[i,3]  + mibeta_rnie[i,3]

  # Effects - version 2 - Read
  mibeta_cde[i,4]  <- (outcome_model_schl_eff_v2_read$coef[4] + outcome_model_schl_eff_v2_read$coef[3] * m_star_schlv2_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintref[i,4]  <- outcome_model_schl_eff_v2_read$coef[3] * (schl_eff_v2_read_on_treatment$coef[1] + schl_eff_v2_read_on_treatment$coef[2] * pc_treatment[1] - m_star_schlv2_read) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rpie[i,4]  <- (schl_eff_v2_read_on_treatment$coef[2] * outcome_model_schl_eff_v2_read$coef[2] + schl_eff_v2_read_on_treatment$coef[2] * outcome_model_schl_eff_v2_read$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  mibeta_rintmed[i,4]  <- schl_eff_v2_read_on_treatment$coef[2] * outcome_model_schl_eff_v2_read$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  mibeta_rnde[i,4]  <- mibeta_cde[i,4]  + mibeta_rintref[i,4]
  mibeta_rnie[i,4]  <- mibeta_rpie[i,4]  + mibeta_rintmed[i,4]
  mibeta_rate[i,4]  <- mibeta_rnde[i,4]  + mibeta_rnie[i,4]

  # Compute block bootstrap SEs
  
  set.seed(123)
  
  bootdist_rate <- matrix(data = NA, nrow = nboot, ncol = 4)

  bootdist_rnde    <- matrix(data = NA, nrow = nboot, ncol = 4)
  bootdist_cde     <- matrix(data = NA, nrow = nboot, ncol = 4)
  bootdist_rintref <- matrix(data = NA, nrow = nboot, ncol = 4)
  
  bootdist_rnie    <- matrix(data = NA, nrow = nboot, ncol = 4)
  bootdist_rpie    <- matrix(data = NA, nrow = nboot, ncol = 4)
  bootdist_rintmed <- matrix(data = NA, nrow = nboot, ncol = 4)
  
  for (j in 1:nboot) {
    
    idboot.1 <- sample(unique(analytic_sample$s3_id), replace=T)
    idboot.2 <- table(idboot.1)
    
    analytic_sample.boot <- NULL
    
    for (k in 1:max(idboot.2)) {
      
      boot.data <- analytic_sample[analytic_sample$s3_id %in% names(idboot.2[idboot.2 %in% k]), ]
      
      for (l in 1:k) {
        
        analytic_sample.boot <- rbind(analytic_sample.boot, boot.data)
        
      }
      
    }
    
  # Fit Model 1: Mediator on treatment
  schl_eff_v1_math_on_treatment.boot <- lm(re_impact_math ~ 
                                    nhdadvg + 
						mththeta1_mean +
						mththeta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
						data = analytic_sample.boot)
  
  schl_eff_v1_read_on_treatment.boot <- lm(re_impact_read ~ 
                                    nhdadvg + 
						rdtheta1_mean +
						rdtheta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
						data = analytic_sample.boot)

  schl_eff_v2_math_on_treatment.boot <- lm(re_impact2_math ~ 
                                    nhdadvg + 
						mththeta1_mean +
						mththeta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
						data = analytic_sample.boot)
  
  schl_eff_v2_read_on_treatment.boot <- lm(re_impact2_read ~ 
                                    nhdadvg + 
						rdtheta1_mean +
						rdtheta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
						data = analytic_sample.boot)

  free_lunch_on_treatment.boot <- lm(sfrlnch4 ~ 
                                    nhdadvg + 
						mththeta1_mean + rdtheta1_mean +
						mththeta1 + rdtheta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
                                data = analytic_sample.boot)
  
  racial_comp_on_treatment.boot <- lm(snonwht4 ~ 
                                   nhdadvg + 
						mththeta1_mean + rdtheta1_mean +
						mththeta1 + rdtheta1 +
						gender +
						race_2 + race_3 + race_4 + race_5 +
						hhtot1 +
						faminc2 +
						marbrth +
						brthwt +
						pared_2 + pared_3 + pared_4 + pared_5 +
						paremp_2 + paremp_3 +
						parage +
						cogstim +
						pardepres +
						ownhome +
						parinvolve,
                                 data = analytic_sample.boot)
  
  # RWR calculations
  analytic_sample.boot$sfrlnch4_r <- NA
  analytic_sample.boot$sfrlnch4_r <- residuals(free_lunch_on_treatment.boot)
  
  analytic_sample.boot$snonwht4_r <- NA
  analytic_sample.boot$snonwht4_r <- residuals(racial_comp_on_treatment.boot)
 
  # Fit Model 2: Outcome on treatment, mediator, treatment x mediator
    outcome_model_schl_eff_v1_math.boot <- eivreg(mththeta7 ~ 
							re_impact_math +
							re_impact_math_x_treatment +
							nhdadvg +
							sfrlnch4_r +
							snonwht4_r +
							mththeta1_mean +
							mththeta1 +
							gender +
							race_2 + race_3 + race_4 + race_5 +
							hhtot1 +
							faminc2 +
							marbrth +
							brthwt +
							pared_2 + pared_3 + pared_4 + pared_5 +
							paremp_2 + paremp_3 +
							parage +	
							cogstim +
							pardepres +
							ownhome +
							parinvolve,
                                         data = analytic_sample.boot,
                                         reliability = reliability_vector_v1_math_list[[1]])

    outcome_model_schl_eff_v1_read.boot <- eivreg(rdtheta7 ~ 
							re_impact_read +
							re_impact_read_x_treatment +
							nhdadvg +
							sfrlnch4_r +
							snonwht4_r +
							rdtheta1_mean +
							rdtheta1 +
							gender +
							race_2 + race_3 + race_4 + race_5 +
							hhtot1 +
							faminc2 +
							marbrth +
							brthwt +
							pared_2 + pared_3 + pared_4 + pared_5 +
							paremp_2 + paremp_3 +
							parage +	
							cogstim +
							pardepres +
							ownhome +
							parinvolve,
                                         data = analytic_sample.boot,
                                         reliability = reliability_vector_v1_read_list[[1]])

    outcome_model_schl_eff_v2_math.boot <- eivreg(mththeta7 ~ 
							re_impact2_math +
							re_impact2_math_x_treatment +
							nhdadvg +
							sfrlnch4_r +
							snonwht4_r +
							mththeta1_mean +
							mththeta1 +
							gender +
							race_2 + race_3 + race_4 + race_5 +
							hhtot1 +
							faminc2 +
							marbrth +
							brthwt +
							pared_2 + pared_3 + pared_4 + pared_5 +
							paremp_2 + paremp_3 +
							parage +	
							cogstim +
							pardepres +
							ownhome +
							parinvolve,
                                         data = analytic_sample.boot,
                                         reliability = reliability_vector_v2_math_list[[1]])

    outcome_model_schl_eff_v2_read.boot <- eivreg(rdtheta7 ~ 
							re_impact2_read +
							re_impact2_read_x_treatment +
							nhdadvg +
							sfrlnch4_r +
							snonwht4_r +
							rdtheta1_mean +
							rdtheta1 +
							gender +
							race_2 + race_3 + race_4 + race_5 +
							hhtot1 +
							faminc2 +
							marbrth +
							brthwt +
							pared_2 + pared_3 + pared_4 + pared_5 +
							paremp_2 + paremp_3 +
							parage +	
							cogstim +
							pardepres +
							ownhome +
							parinvolve,
                                         data = analytic_sample.boot,
                                         reliability = reliability_vector_v2_read_list[[1]])

  # Effects - version 1 - Math
  bootdist_cde[j,1]  <- (outcome_model_schl_eff_v1_math.boot$coef[4] + outcome_model_schl_eff_v1_math.boot$coef[3] * m_star_schlv1_math) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,1]  <- outcome_model_schl_eff_v1_math.boot$coef[3] * (schl_eff_v1_math_on_treatment.boot$coef[1] + schl_eff_v1_math_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_schlv1_math) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,1]  <- (schl_eff_v1_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_v1_math.boot$coef[2] + schl_eff_v1_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_v1_math.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,1]  <- schl_eff_v1_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_v1_math.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,1]  <- bootdist_cde[j,1]  + bootdist_rintref[j,1]
  bootdist_rnie[j,1]  <- bootdist_rpie[j,1]  + bootdist_rintmed[j,1]
  bootdist_rate[j,1]  <- bootdist_rnde[j,1]  + bootdist_rnie[j,1]

  # Effects - version 1 - Read
  bootdist_cde[j,2]  <- (outcome_model_schl_eff_v1_read.boot$coef[4] + outcome_model_schl_eff_v1_read.boot$coef[3] * m_star_schlv1_read) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,2]  <- outcome_model_schl_eff_v1_read.boot$coef[3] * (schl_eff_v1_read_on_treatment.boot$coef[1] + schl_eff_v1_read_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_schlv1_read) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,2]  <- (schl_eff_v1_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_v1_read.boot$coef[2] + schl_eff_v1_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_v1_read.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,2]  <- schl_eff_v1_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_v1_read.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,2]  <- bootdist_cde[j,2]  + bootdist_rintref[j,2]
  bootdist_rnie[j,2]  <- bootdist_rpie[j,2]  + bootdist_rintmed[j,2]
  bootdist_rate[j,2]  <- bootdist_rnde[j,2]  + bootdist_rnie[j,2]

  # Effects - version 2 - Math
  bootdist_cde[j,3]  <- (outcome_model_schl_eff_v2_math.boot$coef[4] + outcome_model_schl_eff_v2_math.boot$coef[3] * m_star_schlv1_math) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,3]  <- outcome_model_schl_eff_v2_math.boot$coef[3] * (schl_eff_v2_math_on_treatment.boot$coef[1] + schl_eff_v2_math_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_schlv1_math) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,3]  <- (schl_eff_v2_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_v2_math.boot$coef[2] + schl_eff_v2_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_v2_math.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,3]  <- schl_eff_v2_math_on_treatment.boot$coef[2] * outcome_model_schl_eff_v2_math.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,3]  <- bootdist_cde[j,3]  + bootdist_rintref[j,3]
  bootdist_rnie[j,3]  <- bootdist_rpie[j,3]  + bootdist_rintmed[j,3]
  bootdist_rate[j,3]  <- bootdist_rnde[j,3]  + bootdist_rnie[j,3]

  # Effects - version 2 - Read
  bootdist_cde[j,4]  <- (outcome_model_schl_eff_v2_read.boot$coef[4] + outcome_model_schl_eff_v2_read.boot$coef[3] * m_star_schlv2_read) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintref[j,4]  <- outcome_model_schl_eff_v2_read.boot$coef[3] * (schl_eff_v2_read_on_treatment.boot$coef[1] + schl_eff_v2_read_on_treatment.boot$coef[2] * pc_treatment[1] - m_star_schlv2_read) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rpie[j,4]  <- (schl_eff_v2_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_v2_read.boot$coef[2] + schl_eff_v2_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_v2_read.boot$coef[3] * pc_treatment[1]) * (pc_treatment[2] - pc_treatment[1])
  bootdist_rintmed[j,4]  <- schl_eff_v2_read_on_treatment.boot$coef[2] * outcome_model_schl_eff_v2_read.boot$coef[3] * (pc_treatment[2] - pc_treatment[1])^2
  bootdist_rnde[j,4]  <- bootdist_cde[j,4]  + bootdist_rintref[j,4]
  bootdist_rnie[j,4]  <- bootdist_rpie[j,4]  + bootdist_rintmed[j,4]
  bootdist_rate[j,4]  <- bootdist_rnde[j,4]  + bootdist_rnie[j,4]

  }
  
  for (m in 1:4) {
    
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
rate_est        <- matrix(data=NA, nrow=4, ncol=4)
rnde_est        <- matrix(data=NA, nrow=4, ncol=4)
cde_est         <- matrix(data=NA, nrow=4, ncol=4)
rintref_est     <- matrix(data=NA, nrow=4, ncol=4)
rnie_est        <- matrix(data=NA, nrow=4, ncol=4)
rpie_est        <- matrix(data=NA, nrow=4, ncol=4)
rintmed_est     <- matrix(data=NA, nrow=4, ncol=4)

for (i in 1:4) {
  
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
sink("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/logs-replicate-study/5-eclsk11-analyses/7-generate-eclsk11-schl-effectiveness-est.txt")

cat("===========================================\n")
cat("Table F.6: School Effectiveness = school-year learning rate - summer learning rate, averaged over 1st and 2nd grades in ECLS-K 2011\n")
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
cat("Table F.7: School Effectiveness = school-year learning rate - 0.5*summer learning rate, averagaed over 1st and 2nd grades in ECLS-K 2011\n")
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

sink()
