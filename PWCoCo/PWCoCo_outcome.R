## Load the outcome data

dat<-read.delim("all_glioma_data.txt", sep="\t")

## Set the locus parameters

chr<-1
start<-204092538
end<-205009623

## Subset the data to the locus parameters, filter the data and add the case and total sample sizes

dat<-dat[dat$CHR==chr,]
dat<-dat[dat$POS>start & dat$POS<end,]
dat<-dat[c(1,4,5,6,7,8,9)]
dat$N<-30686
dat$case<-12496

## Save the table

write.table(dat, "all_glioma_pwcoco_157.txt", quote=F, row.names = F, sep=" ")
