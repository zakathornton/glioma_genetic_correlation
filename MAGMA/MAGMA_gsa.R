## load the gene output from MAGMA gene-set analysis (for a given exposure or outcome)

dat<-read.delim("magma.gsa.out", skip=4, sep = "")

## Set the Bonferroni-corrected p-value and subset the data

nrow<-nrow(dat)
dat<-dat[dat$P<0.05/nrow,]

## Filter and re-order the data

dat<-dat[c(8,3,4,5,6,7)]

## Save the table

write.table(dat, "all_glioma_MAGMA_gsa.txt", quote=F, row.names=F)
