module load languages/python/ldsc-2.0.1
ldsc.py \
--rg oropharyngeal_rashkin.sumstats.gz, all_glioma.sumstats.gz, gbm_glioma.sumstats.gz, nongbm_glioma.sumstats.gz \
--ref-ld-chr eur_w_ld_chr/ \
--w-ld-chr eur_w_ld_chr/ \
--out oropharyngeal_rashkin_gc
