## Load the exposure data

dat<-read.delim("prostate_data.txt", sep=" ")

## Set the locus parameters

chr<-1
start<-204092538
end<-205009623

## Subset the data to the locus parameters

dat<-dat[dat$CHR==chr,]
dat<-dat[dat$POS>start & dat$POS<end,]

## If the data doesn't contain the AF, create a list of SNPs for which to obtain the AFs.
## Then run the script for gathering AF from the reference genome.

SNP<-dat$SNP
write.table(SNP, "~/OneDrive - University of Bristol/GenCorr/Data/Exposure/ll/seviiri/ll_SNPs_2181.txt", quote=F, row.names = F, col.names = F)

## If the data doesn't contain the AF, load the AF for the SNPs, then merge with the dataset.

AF<-read.delim("~/OneDrive - University of Bristol/GenCorr/Data/Exposure/ll/seviiri/ll_AF_2181.txt", sep="", header=F)
colnames(AF)[1]<-"SNP"
colnames(AF)[2]<-"FREQA1"
dat<-merge(dat,AF, all=T)

## Reformat data for PWCoCo and add case number

dat<-dat[c(3,4,5,6,7,8,9,10)] #AF already available OR
dat<-dat[c(1,4,5,10,6,7,8,9)] #AF added
dat$case<-79148

## Save the table

write.table(dat, "prostate_pwcoco_157.txt", quote=F, row.names = F, sep=" ")
