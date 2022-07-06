################
### FIGURE 3 ###
################

rm(list=ls())



### Load in required libraries ###

library(dplyr)
library(foreign)
library(ggplot2)
library(gridExtra)
library(survey)



### Input data ###

analytic_sample_post_mi <- read.dta("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/data-replicate-study/data-replicate-study/Merge/analytic-sample-post-mi-R.dta")


### Remove original non-imputed dataset ###

vars <- c(
  "re_impact_math", "re_impact_read", 
  "school_resources", "school_disorder", 
  "trct_disadv_index2", 
  "c1r4rtht_r_mean", "c1r4mtht_r_mean", 
  "_mi_m", 
  "S3_ID"
)

analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" != 0), vars]



### Standardize variables ###

analytic_sample_post_mi$re_impact_math <- 
  ((analytic_sample_post_mi$re_impact_math - mean(analytic_sample_post_mi$re_impact_math)) / 
     sd(analytic_sample_post_mi$re_impact_math))

analytic_sample_post_mi$re_impact_read <- 
  ((analytic_sample_post_mi$re_impact_read - mean(analytic_sample_post_mi$re_impact_read)) / 
     sd(analytic_sample_post_mi$re_impact_read))

analytic_sample_post_mi$school_resources <- 
  ((analytic_sample_post_mi$school_resources - mean(analytic_sample_post_mi$school_resources)) / 
     sd(analytic_sample_post_mi$school_resources))

analytic_sample_post_mi$school_disorder <- 
  ((analytic_sample_post_mi$school_disorder - mean(analytic_sample_post_mi$school_disorder)) / 
     sd(analytic_sample_post_mi$school_disorder))

analytic_sample_post_mi$trct_disadv_index2 <- 
  ((analytic_sample_post_mi$trct_disadv_index2 - mean(analytic_sample_post_mi$trct_disadv_index2)) / 
     sd(analytic_sample_post_mi$trct_disadv_index2))

analytic_sample_post_mi$c1r4rtht_r_mean <- 
  ((analytic_sample_post_mi$c1r4rtht_r_mean - mean(analytic_sample_post_mi$c1r4rtht_r_mean)) / 
     sd(analytic_sample_post_mi$c1r4rtht_r_mean))

analytic_sample_post_mi$c1r4mtht_r_mean <- 
  ((analytic_sample_post_mi$c1r4mtht_r_mean - mean(analytic_sample_post_mi$c1r4mtht_r_mean)) / 
     sd(analytic_sample_post_mi$c1r4mtht_r_mean))



### Calculate estimates across imputations ###

nmi <- 50

obs_range <- range(analytic_sample_post_mi$trct_disadv_index2)
granularity <- 50
treat_vals <- seq(from = obs_range[1], to = obs_range[2], length = granularity)

base_mean_math <- mean(analytic_sample_post_mi$c1r4mtht_r_mean)
base_mean_read <- mean(analytic_sample_post_mi$c1r4rtht_r_mean)

math_adj_pe_m <- matrix(data = NA, nrow = nmi, ncol = granularity)
read_adj_pe_m <- matrix(data = NA, nrow = nmi, ncol = granularity)
schl_res_pe_m <- matrix(data = NA, nrow = nmi, ncol = granularity)
schl_dis_pe_m <- matrix(data = NA, nrow = nmi, ncol = granularity)

math_adj_se_m <- matrix(data = NA, nrow = nmi, ncol = granularity)
read_adj_se_m <- matrix(data = NA, nrow = nmi, ncol = granularity)
schl_res_se_m <- matrix(data = NA, nrow = nmi, ncol = granularity)
schl_dis_se_m <- matrix(data = NA, nrow = nmi, ncol = granularity)

for (i in 1:nmi) {
  
  # Select imputed dataset
  analytic_sample <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" == i), ]
  
  # Generate design object
  design <- svydesign(ids = ~S3_ID, data = analytic_sample, weights = NULL)
  
  # Generate newdata object
  new_data_math_adj <- data.frame(trct_disadv_index2 = treat_vals, c1r4mtht_r_mean = base_mean_math)
  new_data_read_adj <- data.frame(trct_disadv_index2 = treat_vals, c1r4rtht_r_mean = base_mean_read)
  new_data_unadj    <- data.frame(trct_disadv_index2 = treat_vals)
  
  # Fit models
  math_adj <- svyglm(formula = re_impact_math   ~ trct_disadv_index2 + c1r4mtht_r_mean, design = design)
  read_adj <- svyglm(formula = re_impact_read   ~ trct_disadv_index2 + c1r4rtht_r_mean, design = design)
  schl_res <- svyglm(formula = school_resources ~ trct_disadv_index2, design = design)
  schl_dis <- svyglm(formula = school_disorder  ~ trct_disadv_index2, design = design)
  
  # Generate prediction datasets
  math_adj_ds <- data.frame(predict(math_adj, new_data_math_adj))
  read_adj_ds <- data.frame(predict(read_adj, new_data_read_adj))
  schl_res_ds <- data.frame(predict(schl_res, new_data_unadj))
  schl_dis_ds <- data.frame(predict(schl_dis, new_data_unadj))
  
  
  # Store point estimates
  math_adj_pe <- math_adj_ds$link
  read_adj_pe <- read_adj_ds$link
  schl_res_pe <- schl_res_ds$link
  schl_dis_pe <- schl_dis_ds$link
  
  
  # Store standard errors
  math_adj_se <- math_adj_ds$SE
  read_adj_se <- read_adj_ds$SE
  schl_res_se <- schl_res_ds$SE
  schl_dis_se <- schl_dis_ds$SE
  
  
  # Add estimates to matrices
  math_adj_pe_m[i, ] <- math_adj_pe
  read_adj_pe_m[i, ] <- read_adj_pe
  schl_res_pe_m[i, ] <- schl_res_pe
  schl_dis_pe_m[i, ] <- schl_dis_pe
  
  math_adj_se_m[i, ] <- math_adj_se
  read_adj_se_m[i, ] <- read_adj_se
  schl_res_se_m[i, ] <- schl_res_se
  schl_dis_se_m[i, ] <- schl_dis_se
  
  
}



### Combine estimates across imputations ###

# Point estimates
math_adj_pe_combined <- math_adj_pe_m %>% colSums() / nmi
read_adj_pe_combined <- read_adj_pe_m %>% colSums() / nmi
schl_res_pe_combined <- schl_res_pe_m %>% colSums() / nmi
schl_dis_pe_combined <- schl_dis_pe_m %>% colSums() / nmi

# Standard errors
math_adj_se_combined_part1 <- math_adj_se_m^2 %>% colSums() / nmi
read_adj_se_combined_part1 <- read_adj_se_m^2 %>% colSums() / nmi
schl_res_se_combined_part1 <- schl_res_se_m^2 %>% colSums() / nmi
schl_dis_se_combined_part1 <- schl_dis_se_m^2 %>% colSums() / nmi

math_adj_se_combined_part2 <- apply(math_adj_pe_m, 2, var)
read_adj_se_combined_part2 <- apply(read_adj_pe_m, 2, var)
schl_res_se_combined_part2 <- apply(schl_res_pe_m, 2, var)
schl_dis_se_combined_part2 <- apply(schl_dis_pe_m, 2, var)

math_adj_se_combined       <- sqrt(math_adj_se_combined_part1 + math_adj_se_combined_part2)
read_adj_se_combined       <- sqrt(read_adj_se_combined_part1 + read_adj_se_combined_part2)
schl_res_se_combined       <- sqrt(schl_res_se_combined_part1 + schl_res_se_combined_part2)
schl_dis_se_combined       <- sqrt(schl_dis_se_combined_part1 + schl_dis_se_combined_part2)

# Lower and upper bounds
math_adj_lower <- math_adj_pe_combined - 1.96 * math_adj_se_combined
read_adj_lower <- read_adj_pe_combined - 1.96 * read_adj_se_combined
schl_res_lower <- schl_res_pe_combined - 1.96 * schl_res_se_combined
schl_dis_lower <- schl_dis_pe_combined - 1.96 * schl_dis_se_combined

math_adj_upper <- math_adj_pe_combined + 1.96 * math_adj_se_combined
read_adj_upper <- read_adj_pe_combined + 1.96 * read_adj_se_combined
schl_res_upper <- schl_res_pe_combined + 1.96 * schl_res_se_combined
schl_dis_upper <- schl_dis_pe_combined + 1.96 * schl_dis_se_combined



### Generate figure ###

# Figure 3
tiff("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/figures-replicate-study/3-analyze-data/figure-3.tiff", width = 9, height = 9, units = 'in', res = 600)

dat3 <- data.frame(math_adj_pe_combined = math_adj_pe_combined, math_adj_lower = math_adj_lower, math_adj_upper = math_adj_upper,
                   read_adj_pe_combined = read_adj_pe_combined, read_adj_lower = read_adj_lower, read_adj_upper = read_adj_upper,
                   schl_res_pe_combined = schl_res_pe_combined, schl_res_lower = schl_res_lower, schl_res_upper = schl_res_upper,
                   schl_dis_pe_combined = schl_dis_pe_combined, schl_dis_lower = schl_dis_lower, schl_dis_upper = schl_dis_upper)

figure3_math <- ggplot(data = dat3, aes(x = treat_vals, y = math_adj_pe_combined)) +
  geom_line() + 
  geom_ribbon(aes(ymin = math_adj_lower, ymax = math_adj_upper), alpha = 0.25) +
  xlab("Neighborhood Disadvantage (Standardized)") +
  ylab("Math Effectiveness (Standardized)") + 
  labs(title = "Math Effectiveness") + 
  scale_y_continuous(breaks=c(-0.5, 0.0, 0.5, 1.0, 1.5), limits=c(-0.80, 1.65)) +
  geom_hline(yintercept = 0, linetype = "dashed")

figure3_read <- ggplot(data = dat3, aes(x = treat_vals, y = read_adj_pe_combined)) +
  geom_line() + 
  geom_ribbon(aes(ymin = read_adj_lower, ymax = read_adj_upper), alpha = 0.25) +
  xlab("Neighborhood Disadvantage (Standardized)") +
  ylab("Reading Effectiveness (Standardized)") + 
  labs(title = "Reading Effectiveness") + 
  scale_y_continuous(breaks=c(-0.5, 0.0, 0.5, 1.0, 1.5), limits=c(-0.80, 1.65)) +
  geom_hline(yintercept = 0, linetype = "dashed")

figure3_res <- ggplot(data = dat3, aes(x = treat_vals, y = schl_res_pe_combined)) +
  geom_line() + 
  geom_ribbon(aes(ymin = schl_res_lower, ymax = schl_res_upper), alpha = 0.25) +
  xlab("Neighborhood Disadvantage (Standardized)") +
  ylab("School Resources (Standardized)") + 
  labs(title = "School Resources") + 
  scale_y_continuous(breaks=c(-0.5, 0.0, 0.5, 1.0, 1.5), limits=c(-0.80, 1.65)) +
  geom_hline(yintercept = 0, linetype = "dashed")

figure3_dis <- ggplot(data = dat3, aes(x = treat_vals, y = schl_dis_pe_combined)) +
  geom_line() + 
  geom_ribbon(aes(ymin = schl_dis_lower, ymax = schl_dis_upper), alpha = 0.25) +
  xlab("Neighborhood Disadvantage (Standardized)") +
  ylab("School Disorder (Standardized)") + 
  labs(title = "School Disorder") + 
  scale_y_continuous(breaks=c(-0.5, 0.0, 0.5, 1.0, 1.5), limits=c(-0.80, 1.65)) +
  geom_hline(yintercept = 0, linetype = "dashed")

grid.arrange(figure3_math, figure3_read, 
             figure3_res, figure3_dis, 
             nrow = 2, ncol = 2, top = "Figure 3: Estimates for school quality on treatment")

dev.off()
