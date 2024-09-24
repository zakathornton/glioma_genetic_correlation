module load languages/python/ldsc-2.0.1                      #load modules
ldsc.py \                                                    #run the python script
--rg oropharyngeal_rashkin.sumstats.gz, all_glioma.sumstats.gz, gbm_glioma.sumstats.gz, nongbm_glioma.sumstats.gz \            #provide the zipped summary stats for genetic correlation
--ref-ld-chr eur_w_ld_chr/ \                                 # provide the LD scores for LDSC
--w-ld-chr eur_w_ld_chr/ \                                   # provide the LD scores for regression weights
--out oropharyngeal_rashkin_gc                               #provide the 
