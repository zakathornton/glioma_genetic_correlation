## load the gene output from FUMA (for a given exposure or outcome)

dat<-read.delim("genes.txt")

## Set the locus parameters

CHR<-1
start<-204092538
end<-205009623
range<-start:end

## Subset the data to the locus parameters

dat<-dat[dat$chr==CHR,]
dat<-dat[dat$start%in%range|dat$end%in%range,]

# Filter and re-order the data

dat<-dat[c(3,4,5,2,12,14,15,16,17)]

## Save the table

write.table(dat, "all_glioma_FUMA_genes_157.txt", quote = F, row.names = F)
