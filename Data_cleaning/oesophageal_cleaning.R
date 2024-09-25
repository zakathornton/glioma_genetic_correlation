## Load modules

library(data.table)

## Load the raw data

data<-read.delim("oesophageal_raw.tsv", sep="")

## Extract the variables needed (CHR, POS, SNP, A1, A2, FREQA1, BETA, SE, P, N)

data<-data[c(2,3,1,4,5,6,7,8)]

## Extract the variables needed (CHR, POS, SNP, A1, A2, FREQA1, BETA, SE, P, N)

colnames(data)[1]<-"CHR"
colnames(data)[2]<-"POS"
colnames(data)[3]<-"SNP"
colnames(data)[4]<-"A1"
colnames(data)[5]<-"A2"
colnames(data)[6]<-"BETA"
colnames(data)[7]<-"SE"
colnames(data)[8]<-"P"

## Ensure all numeric values are numeric

data$BETA<-as.numeric(data$BETA)
data$SE<-as.numeric(data$SE)
data$P<-as.numeric(data$P)

## Only keep autosomal chromosomes

data<-data[data$CHR%between%c(1,22),]

## Keep unique SNPs only (remove duplicates)

data<-data[!duplicated(data$SNP),]

## Save the new data

write.table(data, "oesophageal_data.txt", quote = F, row.names = F)
