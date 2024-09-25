## Load modules

library(data.table)

## Load the raw data

data<-read.delim("oropharyngeal_raw.tsv")

## Calculate the beta and se from the OR

data$beta<-log(data$odds_ratio)
data$se<-abs(data$beta/qnorm(data$p_value/2))

## Extract the variables needed (CHR, POS, SNP, A1, A2, FREQA1, BETA, SE, P, N)

data<-data[c(1,2,13,5,4,15,16,7,14)]

## Appropriately rename columns

colnames(data)[1]<-"CHR"
colnames(data)[2]<-"POS"
colnames(data)[3]<-"SNP"
colnames(data)[4]<-"A1"
colnames(data)[5]<-"A2"
colnames(data)[6]<-"BETA"
colnames(data)[7]<-"SE"
colnames(data)[8]<-"P"
colnames(data)[9]<-"N"

## Ensure all numeric values are numeric

data$BETA<-as.numeric(data$BETA)
data$SE<-as.numeric(data$SE)
data$P<-as.numeric(data$P)

## Only keep autosomal chromosomes

data<-data[data$CHR%between%c(1,22),]

## Keep unique SNPs only (remove duplicates)

data<-data[!duplicated(data$SNP),]

## Save the new data

write.table(data, "oropharyngeal_data.txt", quote = F, row.names = F)
