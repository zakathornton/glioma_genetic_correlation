module load languages/python/ldsc-2.0.1
munge_sumstats.py \
--sumstats oropharyngeal_data.txt \
--out oropharyngeal_rashkin \
--merge-alleles w_hm3.snplist \
--chunksize 500000
