#!/bin/bash
# Laura Dean
# 21/11/26

# script to basecall raw pod5 files

#SBATCH --job-name=basecall_hagfish
#SBATCH --partition=ampereq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:A100-full:1
#SBATCH --mem=256g
#SBATCH --time=167:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out
#SBATCH --array=1-2


# setup env
mkdir -p ~/data/hagfish/basecalls
module load cuda-12.2.2

# set variables
INDIVIDUAL=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ~/code_and_scripts/config_files/hagfish_basecalling_array_config_2.txt)

# print info
echo "SUP basecalling for $INDIVIDUAL..."


# basecall the simplex reads
dorado basecaller \
--recursive \
--models-directory /gpfs01/home/mbzlld/data/dorado_models/dorado_models \
--verbose \
sup@latest \
~/data/hagfish/box_data/second_try/RawData/$INDIVIDUAL/pod5 > ~/data/hagfish/basecalls/${INDIVIDUAL}_SUP.bam


# print info
echo "Finished running Dorado for $INDIVIDUAL"

# cleanup env
module unload cuda-12.2.2

