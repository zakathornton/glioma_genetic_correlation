## Load modules

library(data.table)

## Load the raw data

data<-read.table("melanoma_raw.txt", header = T, sep="")

## Extract the variables needed (CHR, POS, SNP, A1, A2, FREQA1, BETA, SE, P, N)

data<-data[c(1,2,4,5,6,8,16,17,18,9)]

## Appropriately rename columns

colnames(data)[1]<-"CHR"
colnames(data)[2]<-"POS"
colnames(data)[3]<-"SNP"
colnames(data)[4]<-"A1"
colnames(data)[5]<-"A2"
colnames(data)[6]<-"FREQA1"
colnames(data)[7]<-"BETA"
colnames(data)[8]<-"SE"
colnames(data)[9]<-"P"
colnames(data)[10]<-"N"

## Ensure all numeric values are numeric

data$FREQA1<-as.numeric(data$FREQA1)
data$BETA<-as.numeric(data$BETA)
data$SE<-as.numeric(data$SE)
data$P<-as.numeric(data$P)

## Remove any SNPs with MAF<0.01

data<-data[data$FREQA1>0.01&FREQA1<0.99,]

## Only keep autosomal chromosomes

data<-data[data$CHR%in%c(1:22),]

## Keep unique SNPs only (remove duplicates)

data<-data[!duplicated(data$SNP),]

## Save the new data

write.table(data, "melanoma_data.txt", row.names = F, quote = F)
