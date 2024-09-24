## Load modules

library(tidyr)

## Load the meta-analysed data (using METAL)

data1<-read.table("~/Documents/University/PhD Population Health Sciences/GenCorr/Exposure/kidney/laskar/kidney_data_META1.tbl", header = T)

## Load the kidney (female) data to extract rsids from

data2<-read.delim("~/Documents/University/PhD Population Health Sciences/GenCorr/Exposure/kidney/laskar/kidney_data_F.txt", sep = " ")

## Rename column for merging

colnames(data1)[1]<-"SNP"

## Merge the data

data3<-merge(data1, data2, by="SNP")

## Extract the variables needed (CHR, POS, SNP, A1, A2, FREQA1, BETA, SE, P, N)

data<-data3[c(8,9,1,10,11,12,4,5,6)]

## Add sample size

data$N<-13230

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

data<-data[data$FREQA1>0.01&data$FREQA1<0.99,]

## Only keep autosomal chromosomes

data<-data[data$CHR%between%c(1,22),]

## Keep unique SNPs only (remove duplicates)

data<-data[!duplicated(data$SNP),]

## Save the new data

write.table(data, "~/Documents/University/PhD Population Health Sciences/GenCorr/Exposure/kidney/laskar/kidney_data.txt", quote = F, row.names = F)
