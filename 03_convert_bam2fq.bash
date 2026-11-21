#!/bin/bash
# Laura Dean
# 21/11/26

# script to convert bam files to fastq format

#SBATCH --job-name=bam2fq
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=20g
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out
#SBATCH --array=1-2

# setup env
module load samtools-uoneasy/1.18-GCC-12.3.0
INDIVIDUAL=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ~/code_and_scripts/config_files/hagfish_basecalling_array_config_2.txt)

# print info
echo "converting reads from bam to fastq.gz for $INDIVIDUAL"


# convert the bam files to fastq format
# -O output qulaity tags if they exist
# -t output RG, BC and QT tags to the FASTQ header line
# then pipe to gzip so that the file is properly compressed
samtools bam2fq \
-O \
-t \
--threads 23 \
~/data/hagfish/basecalls/$INDIVIDUAL.bam | gzip > ~/data/hagfish/basecalls/$INDIVIDUAL.fastq.gz

# cleanup env
module unload samtools-uoneasy/1.18-GCC-12.3.0


