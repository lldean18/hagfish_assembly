#!/bin/bash
# Laura Dean
# 10/6/25
# script written for running on the UoN HPC Ada

#SBATCH --job-name=hagfish_download
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10g
#SBATCH --time=10:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# set variables
wkdir=/gpfs01/home/mbzlld/data/hagfish

# move to working directory
cd $wkdir

# Download data from basespace with wget



