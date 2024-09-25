## Load modules

library(data.table)

## Load the raw data

data<-read.delim("scc_raw.tsv")

## Extract the variables needed (CHR, POS, SNP, A1, A2, FREQA1, BETA, SE, P, N)

data<-data[c(2,3,1,4,5,6,10,11,12)]

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

## Ensure all numeric values are numeric

data$FREQA1<-as.numeric(data$FREQA1)
data$BETA<-as.numeric(data$BETA)
data$SE<-as.numeric(data$SE)
data$P<-as.numeric(data$P)

## Remove any SNPs with MAF<0.01

data<-data[data$FREQA1>0.01&data$FREQA1<0.99,]

## Only keep autosomal chromosomes

data<-data[data$CHR%between%c(1,22),]

## Keep unique SNPs only (remove duplicates)

data<-data[!duplicated(data$SNP),]

## Save the new data

write.table(data, "scc_data.txt", quote = F, row.names = F)
