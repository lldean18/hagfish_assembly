#!/bin/bash
# Laura Dean
# 19/11/26

# script to download second batch of hagfish sequencing data from box

#SBATCH --job-name=hagfish_download
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10g
#SBATCH --time=100:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# setup env
srun --partition defq --cpus-per-task 2 --mem 25g --time 72:00:00 --pty bash
source $HOME/.bash_profile
#conda create --name nodejs conda-forge::nodejs
conda activate nodejs
#npm install --global @box/cli


mkdir -p /gpfs01/home/mbzlld/data/hagfish/box_data
cd /gpfs01/home/mbzlld/data/hagfish/box_data


# authenticate my box account
# this needs to open a web browser so needs to be done in OOD
#box login -d

# list what is in the folder to check its right
box folders:items 438920135943

# download the data
box folders:download 438920135943 --destination ./


# cleanup env
conda deactivate


