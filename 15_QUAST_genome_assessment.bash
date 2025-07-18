#!/bin/bash
# Laura Dean
# 18/7/25
# script designed for running on the UoN HPC Ada

#SBATCH --job-name=quast
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=360g
#SBATCH --time=60:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


#############################
# setup working environment #
#############################

# set variables
wkdir=/gpfs01/home/mbzlld/data/hagfish
reference=/gpfs01/home/mbzlld/data/hagfish/Eptatretus_burgeri_ref/FYBX03.fasta

# load software
source $HOME/.bash_profile
conda activate quast

# move to working dir
cd $wkdir


###################################################
#### run quast on assemblies to assess quality ####
###################################################

python /gpfs01/home/mbzlld/software_bin/miniconda3/envs/quast/bin/quast \
	--threads 64 \
	--eukaryote \
	-r $reference \
	-o $wkdir/quast1 \
	$wkdir/flye1/assembly.fasta \
	$wkdir/flye1/assembly_ragtag/ragtag.scaffold.fasta \
	$wkdir/Eptatretus_atami_ref/JAXMNL01.fasta


# deactivate software
conda deactivate

