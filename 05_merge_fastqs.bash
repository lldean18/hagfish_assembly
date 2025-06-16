#!/bin/bash
# Laura Dean
# 16/6/25
# script written for running on the UoN HPC Ada

#SBATCH --job-name=cat_fastqs
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40g
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# concatenate the two native sequencing runs
zcat /gpfs01/home/mbzlld/data/hagfish/basecalls/native-testis-gDNA-runs.tar_ds.65d54afc517d42748734e471d8b06e54/native-testis-gDNA-runs/20250521_1920_P2S-02815-A_PBE42448_d1085348/pod5/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/native-testis-gDNA-runs.tar_ds.65d54afc517d42748734e471d8b06e54/native-testis-gDNA-runs/20250521_1920_P2S-02815-B_PBE69200_d65a7237/pod5/SUPlatest_calls.fastq.gz | gzip > /gpfs01/home/mbzlld/data/hagfish/basecalls/native_calls.fastq.gz

# concatenate the four pcr sequencing runs

