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
#zcat /gpfs01/home/mbzlld/data/hagfish/basecalls/native-testis-gDNA-runs.tar_ds.65d54afc517d42748734e471d8b06e54/native-testis-gDNA-runs/20250521_1920_P2S-02815-A_PBE42448_d1085348/pod5/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/native-testis-gDNA-runs.tar_ds.65d54afc517d42748734e471d8b06e54/native-testis-gDNA-runs/20250521_1920_P2S-02815-B_PBE69200_d65a7237/pod5/SUPlatest_calls.fastq.gz | gzip > /gpfs01/home/mbzlld/data/hagfish/basecalls/native_calls.fastq.gz

# concatenate the four pcr sequencing runs
#zcat /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs/Testis-Aside/20250603_2041_P2S-02815-A_PBE35590_d20049ae/pod5_pass/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs/Testis-Aside/20250603_2041_P2S-02815-A_PBE35590_d20049ae/pod5_fail/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs/Testis-Bside/20250603_2041_P2S-02815-B_PBE67209_1922ab87/pod5_pass/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs/Testis-Bside/20250603_2041_P2S-02815-B_PBE67209_1922ab87/pod5_fail/SUPlatest_calls.fastq.gz | gzip > /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr_calls.fastq.gz

# concatenate the two files from native and pcr sequencing runs

zcat /gpfs01/home/mbzlld/data/hagfish/basecalls/native-testis-gDNA-runs.tar_ds.65d54afc517d42748734e471d8b06e54/native-testis-gDNA-runs/20250521_1920_P2S-02815-A_PBE42448_d1085348/pod5/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/native-testis-gDNA-runs.tar_ds.65d54afc517d42748734e471d8b06e54/native-testis-gDNA-runs/20250521_1920_P2S-02815-B_PBE69200_d65a7237/pod5/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs/Testis-Aside/20250603_2041_P2S-02815-A_PBE35590_d20049ae/pod5_pass/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs/Testis-Aside/20250603_2041_P2S-02815-A_PBE35590_d20049ae/pod5_fail/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs/Testis-Bside/20250603_2041_P2S-02815-B_PBE67209_1922ab87/pod5_pass/SUPlatest_calls.fastq.gz /gpfs01/home/mbzlld/data/hagfish/basecalls/pcr-testis-gDNA-runs.tar_ds.ab6ab2b3be014723b4fc1c8a4b48b9e8/pcr-testis-gDNA-runs/Testis-Bside/20250603_2041_P2S-02815-B_PBE67209_1922ab87/pod5_fail/SUPlatest_calls.fastq.gz | gzip > /gpfs01/home/mbzlld/data/hagfish/basecalls/native_and_pcr_calls.fastq.gz

