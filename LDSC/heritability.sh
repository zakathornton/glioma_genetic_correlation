module load languages/python/ldsc-2.0.1            #load modules
ldsc.py \                                          #run the python script
--h2 oropharyngeal_rashkin.sumstats.gz \           #provide the summary stats for heritability analysis
--ref-ld-chr eur_w_ld_chr/ \                       #
--w-ld-chr eur_w_ld_chr/ \                         #
--out oropharyngeal_rashkin_h2                     #Specify the outcome name
