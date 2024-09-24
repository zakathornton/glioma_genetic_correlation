## Load the univariate analysis (for a given exposure)

univ<-read.delim("~/OneDrive - University of Bristol/GenCorr/Data/Exposure/prostate/schumacher/prostate.nongbm.univ", sep = " ")

## Seperate the data into exposure and outcome (glioma)

phen1<-univ[!univ$phen%in%c("all_glioma","gbm","nongbm"),]
phen2<-univ[univ$phen%in%c("all_glioma","gbm","nongbm"),]

## Load the bivariate analysis (for a given exposure)

bivar<-read.delim("~/OneDrive - University of Bristol/GenCorr/Data/Exposure/prostate/schumacher/prostate.nongbm.bivar", sep = "")
bivar<-bivar[!is.na(bivar$p),]

## Set the bivariate analysis Bonferroni-corrected p-value and filter (for all univariate results i.e., no adjusted p-values)

bivar_p<-0.05/nrow(bivar)
bivar_bc<-bivar[bivar$p<bivar_p,]

## Set the univariate analysis Bonferroni-corrected p-value and filter

phen1<-phen1[phen1$p<(0.05/2495),]
phen2<-phen2[phen2$p<(0.05/2495),]

## Filter the bivariate results to only those that passed the univariate analysis threshold in both exposure and outcome.

bivar<-bivar[bivar$locus%in%phen1$locus&bivar$locus%in%phen2$locus,]

## Set the new bivariate analysis Bonferroni-corrected p-value and filter, then print the significant loci.

bivar_p<-0.05/nrow(bivar)
bivar_bc<-bivar[bivar$p<bivar_p,]
bivar_bc$locus

## Calculate the average genetic correlation

mean<-mean(bivar$rho)
mean
