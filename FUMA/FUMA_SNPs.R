## load the SNP output from FUMA (for a given exposure or outcome)

dat<-read.delim("snps.txt")

## Set the locus parameters

CHR<-17
start<-69245591
end<-70495119

## Subset the data to the locus parameters

dat<-dat[dat$chr==CHR,]
dat<-dat[dat$pos>start&dat$pos<end,]

# Filter and re-order the data

dat<-dat[c(3,4,2,6,5,7,9,10,8,12,11,14,15,16)]

## Save the table

write.table(dat, "all_glioma_FUMA_SNPs_157.txt", quote = F, row.names = F)
