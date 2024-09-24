## Load modules

library(devtools)
library(miamiplot)
library(dplyr)
library(ggplot2)
library(readxl)
library(tidyverse)

## Set the locus parameters

chr<-5
start<-1206610
end<-2106885

## Load the exposure dataset, and subset by the locus parameters

dat1<-read.delim("~/OneDrive - University of Bristol/GenCorr/Data/Exposure/nsclc/mckay/nsclc_data.txt", sep=" ")
dat1<-dat1[dat1$CHR==chr,]
dat1<-dat1[dat1$POS>start & dat1$POS<end,]
dat1<-dat1[-10]
dat1$study<-"NSCLC"

## Load the outcome dataset, and subset by the locus parameters

dat2<-read.delim("~/OneDrive - University of Bristol/GenCorr/Data/Outcome/all_glioma_data.txt")
colnames(dat2)[2]<-"CHR"
colnames(dat2)[3]<-"POS"
dat2<-dat2[dat2$CHR==5,]
dat2<-dat2[dat2$POS>start & dat2$POS<end,]
dat2<-dat2[c(2,3,1,4:9)]
dat2$study<-"All Glioma"

## Load the rsIDs and nearest genes


labels<-read_excel("~/OneDrive - University of Bristol/GenCorr/Tables/Genetic Correlation Results.xlsx", sheet = "FUMA - SNPs")
labels<-labels[c(8,17)]
colnames(labels)[1]<-"SNP"
labels<-labels[!duplicated(labels$SNP),]

## Merge the exposure and outcome datasets together

dat1<-join(dat1,labels, by = "SNP", type = "left")
dat2<-join(dat2,labels, by = "SNP", type = "left")
dat<-rbind(dat1,dat2)

## Prepare the data for plotting

miami<-prep_miami_data(data=dat, split_by = "study",
        chr = "CHR",
        pos = "POS",
        split_at = dat1$study[1],
        p = "P")

## Transform the labels of the Miami plot

studyA_labels<-miami$upper %>%
  group_by(chr) %>%
  arrange(desc(logged_p)) %>%
  slice(1:5) %>%
  ungroup() %>%
  mutate(label = paste0(SNP, "\n", `Nearest Gene`)) %>%
  select(rel_pos, logged_p, label) %>%
  arrange(desc(logged_p)) %>%
  slice(1:5)
studyB_labels<-miami$lower %>%
  group_by(chr) %>%
  arrange(desc(logged_p)) %>%
  slice(1:5) %>%
  ungroup() %>%
  mutate(label = paste0(SNP, "\n", `Nearest Gene`)) %>%
  select(rel_pos, logged_p, label) %>%
  arrange(desc(logged_p)) %>%
  slice(1:5)

## Create the Miami plot

miami<-ggmiami(data=dat, split_by = "study",
        chr = "CHR",
        pos = "POS",
        split_at = dat1$study[1],
        p = "P",
        upper_ylab = dat1$study[1],
        lower_ylab = dat2$study[1],
        suggestive_line = 1E-05,
        upper_labels_df = studyA_labels,
        lower_labels_df = studyB_labels)
ggsave(plot = miami,"~/OneDrive - University of Bristol/GenCorr/Figures/nsclc/mckay/nsclc_all_miami.png")

## Save the plot.

ggsave("~/OneDrive - University of Bristol/GenCorr/Figures/nsclc/mckay/nsclc_all_miami.png")
