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
#SBATCH --time=100:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# set variables
wkdir=/gpfs01/home/mbzlld/data/hagfish
# move to working directory
cd $wkdir


# install and load software
source $HOME/.bash_profile
#conda create --name basespace hcc::basespace-cli
conda activate basespace
# authenticate my basespace account
#bs authenticate
# then follow the link it gives you to log in
# get the list of what's in my project
#bs  content project --name S-25-0583_ONT
#+-------------+-----------------------------+
#|     Id      |          FilePath           |
#+-------------+-----------------------------+
#| 40757060038 | pcr-testis-gDNA-runs.tar    |
#| 40750692865 | native-testis-gDNA-runs.tar |
#+-------------+-----------------------------+

# download the data
bs download project --name S-25-0583_ONT --output raw_data




# deactivate software
conda deactivate


