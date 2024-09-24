# Load modules

library(readxl)
library(dplyr)

## Load the genetic correlation results

dat<-read_excel("Genetic Correlation Results.xlsx", sheet=3, skip = 3)

## Seperate the data by outcome

all<-dat[dat$`Phenotype 2`=="All Glioma",]
gb<-dat[dat$`Phenotype 2`=="GB",]
nongb<-dat[dat$`Phenotype 2`=="Non-GB",]

## Calculate the difference in effect estimates between ECC and all glioma for every SNP.

grouped_all_ECC<-all%>%
  group_by(SNP) %>%
  summarise(mean(BETA...8))
grouped_all_glioma<-all%>%
  group_by(SNP) %>%
  summarise(mean(BETA...16))
all_merge<-merge(grouped_all_ECC, grouped_all_glioma)
all_merge$diff<-all_merge$`mean(BETA...8)`-all_merge$`mean(BETA...16)`
all_merge$Tissue<-"All Glioma"
all_merge<-all_merge[c(5,1,3,2,4)]

## Calculate the difference in effect estimates between ECC and gbm for every SNP.

grouped_gb_ECC<-gb%>%
  group_by(SNP) %>%
  summarise(mean(BETA...8))
grouped_gb_glioma<-gb%>%
  group_by(SNP) %>%
  summarise(mean(BETA...16))
gb_merge<-merge(grouped_gb_ECC, grouped_gb_glioma)
gb_merge$diff<-gb_merge$`mean(BETA...8)`-gb_merge$`mean(BETA...16)`
gb_merge$Tissue<-"GB"
gb_merge<-gb_merge[c(5,1,3,2,4)]

## Calculate the difference in effect estimates between ECC and non-gbm for every SNP.

grouped_nongb_ECC<-nongb%>%
  group_by(SNP) %>%
  summarise(mean(BETA...8))
grouped_nongb_glioma<-nongb%>%
  group_by(SNP) %>%
  summarise(mean(BETA...16))
nongb_merge<-merge(grouped_nongb_ECC, grouped_nongb_glioma)
nongb_merge$diff<-nongb_merge$`mean(BETA...8)`-nongb_merge$`mean(BETA...16)`
nongb_merge$Tissue<-"Non-GB"
nongb_merge<-nongb_merge[c(5,1,3,2,4)]

## Merge the results back into one table

res<-rbind(all_merge, gb_merge, nongb_merge)

## Save the table

write.table(res,"SNP Beta Deltas", row.names = F, quote = F, sep = "\t")
