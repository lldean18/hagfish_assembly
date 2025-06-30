#!/bin/bash
# Laura Dean
# 30/6/25
# script written for running on the UoN HPC Ada

#SBATCH --job-name=hagfish_backup
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30g
#SBATCH --time=48:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# possible sharepoint sites set up are"
# OrgOne
# OrgOne2
# MacCollLab1
# MacCollLab2
# Laura



# load software
module load rclone-uon/1.65.2


# back up the raw data to sharepoint
rclone --transfers 1 --checkers 1 --bwlimit 100M --checksum copy ~/data/hagfish/raw_data OrgOne:hagfish/raw_data

# and check that the two folders are identical
rclone check --one-way ~/data/hagfish/raw_data OrgOne:hagfish/raw_data



# unload software
module unload rclone-uon/1.65.2


