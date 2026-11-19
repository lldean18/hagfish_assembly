#!/bin/bash
# Laura Dean
# 27/10/26

#SBATCH --job-name=blast
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=48:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env
source $HOME/.bash_profile
conda activate blast

# move to working dir
cd /gpfs01/home/mbzlld/data/hagfish/serotonin_receptors


##  # create a blast database for the assembly
##  makeblastdb \
##      -in assembly.fasta \
##      -dbtype nucl \
##      -out assembly_db


# search for each of the two genes
genes=( DN7537_i DN24979_ii )
for gene in "${genes[@]}"
do
blastn \
    -query $gene.fasta \
    -db assembly_db \
    -out ${gene}_hits.tsv \
    -outfmt 6 \
    -evalue 1e-10 \
    -word_size 11 \
    -num_threads 8
done

