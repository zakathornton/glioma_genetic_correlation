## Load modules

library(LAVA)
library(parallel)

## Read in data

loci <- read.loci(loc.file)
n.loc <- nrow(loci)
sample.overlap.file <- NULL
input <- process.input(info.file, sample.overlap.file, ref.dat, phenos)

## Set target for non-pairwise analysis.

target <- "oropharyngeal"

## Set univariate pvalue threshold

univ.thresh <- 0.05

## Analyse
print(paste("Starting LAVA analysis for",n.loc,"loci"))
progress=ceiling(quantile(1:n.loc, seq(.05,1,.05)))
u=b=NULL

out = mclapply(1:n.loc, mc.cores=1, function(i) {
	if(i %in% progress) {
		 print(paste("...",names(progress[which(progress==i)])))
        }
	locus = process.locus(loci[i,], input)
	if(!target%in%locus$phenos) {
		return(NULL)
	}
	if(!is.null(locus)) {
                # extract some general locus info for the output
                loc.info = data.frame(locus = locus$id, chr = locus$chr, start = locus$start, stop = locus$stop, n.snps = locus$n.snps, n.pcs = locus$K)
                
                # run the univariate and bivariate tests
                ub = run.univ.bivar(locus, univ.thresh = univ.thresh, target = target)
                u = cbind(loc.info, ub$univ)
                if(!is.null(ub$bivar)) {
			b = cbind(loc.info, ub$bivar)
		}
	}
	return(list(univ=u, bivar=b))
})

## Save the output
write.table(do.call(rbind, lapply(out,"[[","univ")), paste0(outname,".univ"), row.names=F, quote=F)
write.table(do.call(rbind, lapply(out, "[[", "bivar")), paste0(outname,".bivar"), row.names=F, quote=F)
