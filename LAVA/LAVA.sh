# This script submits separate jobs for each phenotype pair
source settings.sh

# iterate over all unique phenotype pairs
N_PAIRS=$(wc -l pheno.pairs.txt | awk '{print $1}')

for I in $(seq 1 $N_PAIRS); do
        # extract phenotype IDs
        P1=$(awk 'NR=='$I' {print $1}' pheno.pairs.txt)
        P2=$(awk 'NR=='$I' {print $2}' pheno.pairs.txt)

        echo "$P1 $P2"

        # check if output files for these phenotypes already exist
        if [[ -f $OUT/$P1.$P2.univ ]]; then
                echo "*  output files already exist"
        else
	        # if not, SUBMIT JOB! (note: this is written for slurm, adapt the line below as necessary)
                sbatch -t 7-00:00:00 -p mrcieu,hmem,cpu -N 1 --mem=64G -A sscm013903 -J $P1.$P2.lava -o slurm.$P1-$P2.%A.out lava.job $SCRIPTS/settings.sh $P1 $P2
        fi
done
