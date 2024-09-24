module load languages/python/ldsc-2.0.1      #load module
munge_sumstats.py \                          #run the python script
--sumstats oropharyngeal_data.txt \          #select the summary stats to be munged
--out oropharyngeal_rashkin \                #define the outcome name
--merge-alleles w_hm3.snplist \              #provide the SNP list
--chunksize 500000                           #define the chunksize i.e., the number of SNPs to be ran at a time.
