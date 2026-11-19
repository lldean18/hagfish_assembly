#!/bin/bash
# Laura Dean
# 16/6/25
# script written for running on the UoN HPC Ada

#SBATCH --job-name=bam2fq
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=20g
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out
#SBATCH --array=1-6

source $HOME/.bash_profile

# make the config file
#cd /gpfs01/home/mbzlld/data/hagfish/basecalls
#find . -type f -name '*.bam' | sort -u > ~/code_and_scripts/config_files/hagfish_bam_config_tmp.txt
#sed -i "s/[.]/\/gpfs01\/home\/mbzlld\/data\/hagfish\/basecalls/" ~/code_and_scripts/config_files/hagfish_bam_config_tmp.txt
#awk '{print NR,$0}' ~/code_and_scripts/config_files/hagfish_bam_config_tmp.txt > ~/code_and_scripts/config_files/hagfish_bam_config.txt
#rm ~/code_and_scripts/config_files/hagfish_bam_config_tmp.txt


config=~/code_and_scripts/config_files/hagfish_bam_config.txt


# extract the bam file paths and names from the config file
bam=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

# load modules
module load samtools-uoneasy/1.18-GCC-12.3.0

# write the name of the file being converted
echo "converting reads from $bam"

# check how many reads are in the bam file or files you want to convert
samtools flagstat $bam

# convert the bam files to fastq format
# -O output qulaity tags if they exist
# -t output RG, BC and QT tags to the FASTQ header line
# then pipe to gzip so that the file is properly compressed
samtools bam2fq \
-O \
-t \
--threads 23 \
$bam | gzip > ${bam%.*}.fastq.gz

# unload modules
module unload samtools-uoneasy/1.18-GCC-12.3.0


