#######################################################
### DENSITY PLOT OF SCHOOL QUALITY BY NHOOD TERTILE ###
#######################################################

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
  "re_impact_math", 
  "re_impact_read", 
  "school_resources", 
  "school_disorder", 
  "trct_disadv_index2", 
  "c1r4rtht_r_mean", 
  "c1r4mtht_r_mean", 
  "_mi_m", 
  "S3_ID")

analytic_sample_post_mi <- analytic_sample_post_mi[which(analytic_sample_post_mi$"_mi_m" != 0), vars]

### Standardize variables ###
analytic_sample_post_mi$re_impact_math <- 
  ((analytic_sample_post_mi$re_impact_math - mean(analytic_sample_post_mi$re_impact_math)) / 
     sd(analytic_sample_post_mi$re_impact_math))
analytic_sample_post_mi$re_impact_math <- residuals(lm(re_impact_math~c1r4mtht_r_mean,data=analytic_sample_post_mi))

analytic_sample_post_mi$re_impact_read <- 
  ((analytic_sample_post_mi$re_impact_read - mean(analytic_sample_post_mi$re_impact_read)) / 
     sd(analytic_sample_post_mi$re_impact_read))
analytic_sample_post_mi$re_impact_read <- residuals(lm(re_impact_read~c1r4rtht_r_mean,data=analytic_sample_post_mi))

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

### Create nhood dadvg tertiles ###
cut1<-quantile(analytic_sample_post_mi$trct_disadv_index2,probs=0.33)
cut2<-quantile(analytic_sample_post_mi$trct_disadv_index2,probs=0.66)

analytic_sample_post_mi$dadvgTertile<-NA
analytic_sample_post_mi$dadvgTertile[analytic_sample_post_mi$trct_disadv_index2<=cut1]<-1
analytic_sample_post_mi$dadvgTertile[analytic_sample_post_mi$trct_disadv_index2>cut1 & analytic_sample_post_mi$trct_disadv_index2<=cut2]<-2
analytic_sample_post_mi$dadvgTertile[analytic_sample_post_mi$trct_disadv_index2>cut2]<-3

### Calculate density estimates pooling across imputations ###
dTertile1ImpactMath<-density(analytic_sample_post_mi$re_impact_math[analytic_sample_post_mi$dadvgTertile==1], from=-5, to=5, adjust=3)
dTertile2ImpactMath<-density(analytic_sample_post_mi$re_impact_math[analytic_sample_post_mi$dadvgTertile==2], from=-5, to=5, adjust=3)
dTertile3ImpactMath<-density(analytic_sample_post_mi$re_impact_math[analytic_sample_post_mi$dadvgTertile==3], from=-5, to=5, adjust=3)

dTertile1ImpactRead<-density(analytic_sample_post_mi$re_impact_read[analytic_sample_post_mi$dadvgTertile==1], from=-5, to=5, adjust=3)
dTertile2ImpactRead<-density(analytic_sample_post_mi$re_impact_read[analytic_sample_post_mi$dadvgTertile==2], from=-5, to=5, adjust=3)
dTertile3ImpactRead<-density(analytic_sample_post_mi$re_impact_read[analytic_sample_post_mi$dadvgTertile==3], from=-5, to=5, adjust=3)

dTertile1SchlResources<-density(analytic_sample_post_mi$school_resources[analytic_sample_post_mi$dadvgTertile==1], from=-5, to=5, adjust=3)
dTertile2SchlResources<-density(analytic_sample_post_mi$school_resources[analytic_sample_post_mi$dadvgTertile==2], from=-5, to=5, adjust=3)
dTertile3SchlResources<-density(analytic_sample_post_mi$school_resources[analytic_sample_post_mi$dadvgTertile==3], from=-5, to=5, adjust=3)

dTertile1SchlDisorder<-density(analytic_sample_post_mi$school_disorder[analytic_sample_post_mi$dadvgTertile==1], from=-5, to=5, adjust=3.25)
dTertile2SchlDisorder<-density(analytic_sample_post_mi$school_disorder[analytic_sample_post_mi$dadvgTertile==2], from=-5, to=5, adjust=3.25)
dTertile3SchlDisorder<-density(analytic_sample_post_mi$school_disorder[analytic_sample_post_mi$dadvgTertile==3], from=-5, to=5, adjust=3.25)

### Create density plots ###
tiff("C:/Users/wodtke/Desktop/projects/nhood_mediation_schl_qual/replication/figures-replicate-study/3-analyze-data/figure-densPlot.tiff",
	width=9, 
	height=9, 
	units='in',
	res = 600)

par(mfrow=c(2,2))

# Math Effectiveness
plot(dTertile1ImpactMath,
	main="", 
	xlab="Math Effectiveness (Standardized)", 
	ylab="Density",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	lty="solid", 
	lwd=1.25)
par(new=T)
plot(dTertile2ImpactMath,
	main="",
	xlab="",
	ylab="",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	axes=FALSE,
	lty="dashed",
	lwd=1.25)
par(new=T)
plot(dTertile3ImpactMath,
	main="",
	xlab="",
	ylab="",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	axes=FALSE,
	lty="dotted",
	lwd=1.25)
title("Math Effectiveness",line=0.3,adj=0,cex.main=1)
legend("topright",
	inset=0.025,
	c("1st Tertile", "2nd Tertile", "3rd Tertile"),
	lty=c("solid", "dashed", "dotted"),
	lwd=1.25,
	seg.len=3,
	title="Neighborhood Disadvantage",
	cex=0.8)

# Reading Effectiveness
par(new=F)
plot(dTertile1ImpactRead,
	main="", 
	xlab="Reading Effectiveness (Standardized)", 
	ylab="Density",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	lty="solid", 
	lwd=1.25)
par(new=T)
plot(dTertile2ImpactRead,
	main="",
	xlab="",
	ylab="",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	axes=FALSE,
	lty="dashed",
	lwd=1.25)
par(new=T)
plot(dTertile3ImpactRead,
	main="",
	xlab="",
	ylab="",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	axes=FALSE,
	lty="dotted",
	lwd=1.25)
title("Reading Effectiveness",line=0.3,adj=0,cex.main=1)

# School Resources
par(new=F)
plot(dTertile1SchlResources,
	main="", 
	xlab="School Resources (Standardized)", 
	ylab="Density",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	lty="solid", 
	lwd=1.25)
par(new=T)
plot(dTertile2SchlResources,
	main="",
	xlab="",
	ylab="",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	axes=FALSE,
	lty="dashed",
	lwd=1.25)
par(new=T)
plot(dTertile3SchlResources,
	main="",
	xlab="",
	ylab="",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	axes=FALSE,
	lty="dotted",
	lwd=1.25)
title("School Resources",line=0.3,adj=0,cex.main=1)

# School Disorder
par(new=F)
plot(dTertile1SchlDisorder,
	main="", 
	xlab="School Disorder (Standardized)", 
	ylab="Density",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	lty="solid", 
	lwd=1.25)
par(new=T)
plot(dTertile2SchlDisorder,
	main="",
	xlab="",
	ylab="",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	axes=FALSE,
	lty="dashed",
	lwd=1.25)
par(new=T)
plot(dTertile3SchlDisorder,
	main="",
	xlab="",
	ylab="",
	xlim=c(-5,5),
	ylim=c(0,0.6),
	axes=FALSE,
	lty="dotted",
	lwd=1.25)
title("School Disorder",line=0.3,adj=0,cex.main=1)

dev.off()
