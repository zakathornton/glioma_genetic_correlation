awk 'NR==FNR{a[$1]=$0;next} ($2) in a{print $0a[($2)]; next}' ll_SNPs_2181.txt plink.frq > tmp         # Retrieve the AFs for the list of SNPs
awk '{print $2,$5}' tmp > ll_AF_2181.txt                                                               # Make this into a new file
rm tmp                                                                                                 # remove the tmp file
