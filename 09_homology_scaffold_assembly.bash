#!/bin/bash
# Laura Dean
# 23/6/25
# script written for running on the UoN HPC Ada

#SBATCH --job-name=ragtag_scaffold
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=30g
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# set variables
reference=/gpfs01/home/mbzlld/data/hagfish/Eptatretus_burgeri_ref/FYBX03.fasta.gz
assembly=/gpfs01/home/mbzlld/data/hagfish/flye_1/assembly.fasta

source $HOME/.bash_profile


## fix the scaffold names in the downloaded reference assembly
#zcat $reference | sed 's/^.*: />/' | gzip > ${reference}.tmp && mv ${reference}.tmp $reference
## remove the unplaced contigs from the reference
#conda activate seqkit
#seqkit grep -r -n -p '.*cluster.*' $reference | gzip > ${reference%.*.*}_scaffs_only.fasta.gz
#conda deactivate



# scaffold assembly with ragtag
conda activate ragtag
ragtag.py scaffold -t 16 -o ${assembly%.*}_ragtag ${reference%.*.*}_scaffs_only.fasta.gz $assembly
conda deactivate


# get rid of the ragtag suffixes
sed -i 's/_RagTag//' ${assembly%.*}_ragtag/ragtag.scaffold.fasta

## set the file containing chromosome names to keep
#keep=/gpfs01/home/mbzlld/data/OrgOne/sumatran_tiger/liger_reference/tiger_chrs.txt
## rename scaffolds and remove unplaced contigs
#conda activate seqtk
#seqtk subseq ${assembly%.*}_ragtag/ragtag.scaffold.fasta $keep > ${assembly%.*}_ragtag/ragtag.scaffolds_only.fasta
#conda deactivate



