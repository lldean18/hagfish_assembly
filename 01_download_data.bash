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
# once you have done it once it works on that machine even on a compute node
#box login -d

# list what is in the folder to check its right
box folders:items 438920135943 # STALLED

# download the data
# downloading the whole folder (438920135943) at once stalled so I did each thing within it separately
box folders:download 438920135943 --destination ./ # COMPLETED 55Gb Hagfish-25
box folders:download 438921088504 --destination ./ # COMPLETED 42Gb Hagfish-10
box folders:download 438935262027 --destination ./ # COMPLETED 2.6Mb Reports
box folders:download 438937640547 --destination ./ # COMPLETED 9.1Gb Basecalled
box folders:download 438939512567 --destination ./ # COMPLETED S-26-0583_nativetestisgdna1_other_reports
box folders:download 438937417957 --destination ./ # COMPLETED S-26-0927-Pool21_other_reports
box files:download 2600494278399 --destination ./ # COMPLETED analyzePoreScanData.R
box files:download 2600499143450 --destination ./ # COMPLETED ActivePoreCountXTime_Rplot.pdf

# cleanup env
conda deactivate


