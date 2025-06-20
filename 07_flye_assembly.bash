#!/bin/bash
# Laura Dean
# 20/6/25
# for running on Ada

#SBATCH --partition=hmemq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=96
#SBATCH --mem=1495g
#SBATCH --time=168:00:00
#SBATCH --job-name=hagfish_flye_assembly
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# load your bash environment for using conda
source $HOME/.bash_profile

# set variables
wkdir=/gpfs01/home/mbzlld/data/hagfish # set the working directory
try=1

## create a conda environment and install the software you want
#conda create --name flye2.9.6 bioconda::flye -y
conda activate flye2.9.6

# assemble your genome from fastq files (using all pass and fail reads)
flye \
--threads 96 \
--iterations 5 \
-o $wkdir/flye_${try} \
--nano-hq $wkdir/basecalls/native_and_pcr_calls.fastq.gz

# deactivate the conda environment
conda deactivate

