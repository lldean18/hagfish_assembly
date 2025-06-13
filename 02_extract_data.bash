#!/bin/bash
# Laura Dean
# 13/6/25
# script written for running on the UoN HPC Ada

#SBATCH --job-name=extract_tar
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30g
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# extract the downloaded tar archives
tar -xf /gpfs01/home/mbzlld/data/hagfish/raw_data/native-testis-gDNA-runs.tar_ds.65d54afc517d42748734e471d8b06e54/native-testis-gDNA-runs.tar

tar -xf /gpfs01/home/mbzlld/data/hagfish/raw_data/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs.tar


