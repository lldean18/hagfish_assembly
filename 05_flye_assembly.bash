#!/bin/bash
# Laura Dean
# 27/11/26

# script for assembling a genome with flye

#SBATCH --partition=hmemq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=96
#SBATCH --mem=1495g
#SBATCH --time=168:00:00
#SBATCH --job-name=hagfish_flye_assembly
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# setup env
source $HOME/.bash_profile
#conda create --name flye2.9.6 bioconda::flye -y
conda activate flye2.9.6

ATTEMPT=2
READS=/gpfs01/home/mbzlld/data/hagfish/basecalls/all_hagfish.fastq.gz
OUTDIR=~/data/hagfish/flye_$ATTEMPT


mkdir -p $OUTDIR
cd $OUTDIR


# assemble your genome from fastq files (using all pass and fail reads)
flye \
--threads 96 \
--iterations 5 \
-o $OUTDIR \
--nano-hq $READS

# deactivate the conda environment
conda deactivate

