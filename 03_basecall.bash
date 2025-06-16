#!/bin/bash
# Laura Dean
# 13/6/25
# script written for running on the UoN HPC Ada

#SBATCH --job-name=basecall_hagfish
#SBATCH --partition=ampereq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:1
#SBATCH --mem=256g
#SBATCH --time=167:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out
#SBATCH --array=1-6


# generate array config file
# # generate list of file paths for the array config
# cd /gpfs01/home/mbzlld/data/hagfish/raw_data
# # list all directories containing fast5 files & write to config file
# find . -type f -name '*pod5*' | sed -r 's|/[^/]+$||' |sort -u > ~/code_and_scripts/config_files/hagfish_basecalling_array_config_tmp.txt
# # add the start of the filepath to the config file (bc we cd'd to only get hagfish, it only prints from there)
# sed -i 's/[.]/\/gpfs01\/home\/mbzlld\/data\/hagfish\/raw_data/' ~/code_and_scripts/config_files/hagfish_basecalling_array_config_tmp.txt
# # add array numbers to config file
# awk '{print NR,$0}' ~/code_and_scripts/config_files/hagfish_basecalling_array_config_tmp.txt > ~/code_and_scripts/config_files/hagfish_basecalling_array_config.txt
# rm ~/code_and_scripts/config_files/hagfish_basecalling_array_config_tmp.txt # remove the temp file
# then I went through and deleted the path endings to simplify and make 6 directories to be searched recursively by dorado
# then I added a third colunm that was the cut statement for fields to define the output dirs manually


# load cuda module
module load cuda-12.2.2

# set the config file
config=/gpfs01/home/mbzlld/code_and_scripts/config_files/hagfish_basecalling_array_config.txt

# extract the pod5 directory paths from the config file
pod5_path=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

# extract the fields to cut from the path for output from the config file
cut_fields=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)

# extract the working directory from the pod5 filepath
wkdir=$(echo $pod5_path | cut -f1,2,3,4,5,6 -d '/')

# get the name of the directory the pod5 files are in and part of the path to it to use in the output
out_path=$(echo $pod5_path | cut $cut_fields -d '/')

# then make a directory with this path (only if one does not already exist with the same name)
mkdir -p $wkdir/basecalls/$out_path

# print some information about what this run is doing
echo "Starting basecalling for the pod5 files in $wkdir/basecalls/$out_path..."


# basecall the simplex reads
dorado basecaller \
--recursive \
--verbose \
sup@latest \
$pod5_path/ > $wkdir/basecalls/$out_path/SUPlatest_calls.bam


echo "Finished running Dorado"

