# this 'settings' file contains relevant directories and file names used for the analyses
# you need to at least adapt the MAIN path 

# key directories
MAIN=$HOME/../../work/bp20214/GenCorr/scripts/lava 				# base directory
SCRIPTS=$MAIN									# scripts dir
OUT=$MAIN									# results dir 
EXP_DATA=$HOME/../../work/bp20214/GenCorr/exposure/oropharyngeal/phelan_new		# exposure data dir
OUT_DATA=$HOME/../../work/bp20214/GenCorr/outcome				# outcome data dir

# names of key input files
LOCFILE=blocks_s2500_m25_f1_w200.GRCh37_hg19.locfile
INFOFILE=input.info.txt
OVERLAP=sample.overlap.txt

# reference data dir & prefix
REFDIR=$HOME/../../work/bp20214/1000Genomes	 # (usually this is not in the main data dir since I only keep a single copy of these files)
REFDAT=GRCh37_EUR_dupvar
