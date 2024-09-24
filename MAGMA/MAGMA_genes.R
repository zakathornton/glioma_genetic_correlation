## load the gene output from MAGMA (for a given exposure or outcome)

dat<-read.delim("magma.genes.out")

## Set the locus parameters

CHR<-22
start<-29457602
end<-30962255

## Subset the data to the locus parameters

dat<-dat[dat$CHR==CHR,]
dat<-dat[dat$START>start&dat$STOP<end,]

# Filter and re-order the data

dat<-dat[c(10,2,3,4,5,9)]

## Save the table

write.table(dat, "all_glioma_MAGMA_genes_2474.txt", quote=F, row.names=F)
