## Load modules

library(ggplot2)
library(tidyverse)
library(TwoSampleMR)

# Read in exposure dataset

data1<-read.delim(file = "scc_data.txt", sep=" ")

## Format the data

data1<-format_data(dat=data1, type = "outcome", header=T, snp_col="SNP", effect_allele_col="A1", other_allele_col="A2", eaf_col = "FREQA1", beta_col="BETA", se_col="SE", pval_col="P", samplesize_col = "N")

## Read in glioma dataset

data2<-read.delim(file = "gbm_glioma_data_signif.txt", sep="")

## Format the data

data2<-format_data(dat=data2, type = "exposure", header=T, snp_col="SNP", effect_allele_col="A1", other_allele_col="A2", eaf_col = "FREQA1", beta_col="BETA", se_col="SE", pval_col="P", samplesize_col = "N", phenotype_col = "GENE")

## Clump the glioma dataset

data2<-clump_data(data2, clump_r2=0.001)

## Filter datasets to only contain the clumped outcome SNPs

data1<-data1[data1$SNP%in%data2$SNP,]
data2<-data2[data2$SNP%in%data1$SNP,]

## Order the datasets by rsID

data1<-arrange(data1, SNP)
data2<-arrange(data2, SNP)

## Make new dataframe by harmonising the data

data3<-harmonise_data(exposure_dat = data2, outcome_dat = data1)
data3<-data3[data3$ambiguous==FALSE,]

## Reorder the variables

data3<-data3[c(1,22,4,5,9,7,14,15,2,3,8,6,20,21)]

## Rename columns

colnames(data3)[1]<-"SNP"
colnames(data3)[2]<-"GENE"
colnames(data3)[3]<-"exp_eff_allele"
colnames(data3)[4]<-"exp_ref_allele"
colnames(data3)[5]<-"exp_maf"
colnames(data3)[6]<-"exp_beta"
colnames(data3)[7]<-"exp_se"
colnames(data3)[8]<-"exp_P"
colnames(data3)[9]<-"out_eff_allele"
colnames(data3)[10]<-"out_ref_allele"
colnames(data3)[11]<-"out_maf"
colnames(data3)[12]<-"out_beta"
colnames(data3)[13]<-"out_se"
colnames(data3)[14]<-"out_P"

## Index the SNPs for looping

idxSNP<-data3$SNP

## Check that reference (A1) alleles are the same - if not, then flip.

for (i in idxSNP){
  if(data3$exp_eff_allele[data3$SNP==i]==data3$out_ref_allele[data3$SNP==i]){
      data3$exp_eff_allele[data3$SNP==i]<-data3$out_eff_allele[data3$SNP==i]
      data3$exp_ref_allele[data3$SNP==i]<-data3$out_ref_allele[data3$SNP==i]
      data3$exp_beta[data3$SNP==i]<-data3$exp_beta[data3$SNP==i]*-1
  }
}

## Check that the outcome beta is positive - if not, then flip.

for (i in idxSNP){
  if (data3$out_beta[data3$SNP==i]<0){
        data3$exp_beta[data3$SNP==i]<-data3$exp_beta[data3$SNP==i]*-1
        data3$out_beta[data3$SNP==i]<-data3$out_beta[data3$SNP==i]*-1
        data3$exp_eff_allele[data3$SNP==i]<-ifelse(data3$exp_eff_allele[data3$SNP==i]=="A","T", 
          ifelse(data3$exp_eff_allele[data3$SNP==i]=="T","A", 
            ifelse(data3$exp_eff_allele[data3$SNP==i]=="C","G","C")))
        data3$exp_ref_allele[data3$SNP==i]<-ifelse(data3$exp_ref_allele[data3$SNP==i]=="A","T", 
          ifelse(data3$exp_ref_allele[data3$SNP==i]=="T","A",
            ifelse(data3$exp_ref_allele[data3$SNP==i]=="C","G","C")))
        data3$out_eff_allele[data3$SNP==i]<-ifelse(data3$out_eff_allele[data3$SNP==i]=="A","T",
          ifelse(data3$out_eff_allele[data3$SNP==i]=="T","A",
            ifelse(data3$out_eff_allele[data3$SNP==i]=="C","G","C")))
        data3$out_ref_allele[data3$SNP==i]<-ifelse(data3$out_ref_allele[data3$SNP==i]=="A","T",
          ifelse(data3$out_ref_allele[data3$SNP==i]=="T","A",
            ifelse(data3$out_ref_allele[data3$SNP==i]=="C","G","C")))
        }
}

## Create the minimum and maximum betas

data3$exp_max<-(data3$exp_beta)+(data3$exp_se)
data3$exp_min<-(data3$exp_beta)-(data3$exp_se)
data3$out_max<-(data3$out_beta)+(data3$out_se)
data3$out_min<-(data3$out_beta)-(data3$out_se)

## Create the plot

plot<-ggplot(data = data3, aes(x=out_beta, y=exp_beta, color=exp_P)) +
  xlab("Glioma Beta (GB)") +
  ylab("Squamous Cell Carcinoma Beta") +
  geom_point(cex=0.75) +
  geom_errorbarh(aes(xmin=out_min, xmax=out_max)) +
  geom_errorbar(aes(ymin=exp_min, ymax=exp_max)) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  scale_color_gradient(low="blue", high="red") +
  geom_smooth(method = "lm", col = "black", lty=2, lwd = 0.75) +
  labs(color = "P value")
plot

## Save the table

write.table(data3,"scc_gbm_SNP.txt", quote=F, row.names = F)

## Save the plot

ggsave("scc_gbm.png", height = 8, width = 12, units = "in")

## Calculate Pearson's correlation coefficient

cor(x=data3$out_beta, y=data3$exp_beta, method = "pearson")
