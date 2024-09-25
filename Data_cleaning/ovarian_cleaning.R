## Load modules

library(tidyr)
library(data.table)
library(dplyr)

## Load the raw data

data<-read.delim("ovarian_raw.txt", header = F, sep=" ")

## Appropriately rename columns

colnames(data)[1]<-"CHR"
colnames(data)[2]<-"POS"
colnames(data)[3]<-"A1"
colnames(data)[4]<-"A2"
colnames(data)[5]<-"FREQA1"
colnames(data)[6]<-"BETA"
colnames(data)[7]<-"SE"
colnames(data)[8]<-"P"

## Remove any SNPs with P-values out of bounds

data<-data[data$P>0&data$P<1,]

# Add sample size

data$N<-63347

## Remove any SNPs with MAF<0.01

data<-data[data$FREQA1>0.01&data$FREQA1<0.99,]

## Only keep autosomal chromosomes

data<-data[data$CHR%between%c(1,22),]

## Create a variable composed of chr and pos

chrbp<-paste0(data$CHR," ",data$POS)
data$chrbp<-paste0(data$CHR," ",data$POS)
 
## Remove duplicated SNPs

data<-unique(data$chrbp)

## Save the list of variants (chr:pos) for retrieving rsIDs

write.table(chrbp, "~/OneDrive - University of Bristol/GenCorr/Data/Exposure/ovarian/phelan_new/ovarian_chrbp.txt", quote=F, row.names = F)

## Once rsIDs have been retrieved, load the list

rsid<-read.delim("~/OneDrive - University of Bristol/GenCorr/Data/Exposure/ovarian/phelan/ovarian_rsid.txt", header=F)
colnames(rsid)[1]<-"SNP"
colnames(rsid)[2]<-"chrbp"

## Keep only unique rsIDs 

rsid$uniq<-!duplicated(rsid$chrbp)
rsid<-rsid[rsid$uniq==T,]
rsid<-rsid[-3]

## Merge the rsIDs and exposure dataset

data<-merge(data, rsid, by="chrbp")
data<-data[c(11,2:10)]

## Save the table

write.table(data, "ovarian_data.txt", quote=F, row.names = F)
