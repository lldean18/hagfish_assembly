#!/bin/bash
# Laura Dean
# 20/6/25
# for running on Ada

#SBATCH --partition=hmemq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=96
#SBATCH --mem=1495g
#SBATCH --time=168:00:00
#SBATCH --job-name=hagfish_assembly_hifiasm_no_pcr
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

source $HOME/.bash_profile

####### PREPARE ENVIRONMENT #######
# create conda environment
#conda create --name hifiasm_0.25.0 hifiasm -y
conda activate hifiasm_0.25.0


# set environment variables
wkdir=/gpfs01/home/mbzlld/data/hagfish # set the working directory
attempt=2
reads=$wkdir/basecalls/pcr_calls.fastq.gz

# print a line to the slurm output that says exactly what was done on this run
echo "This is hifiasm version 0.25.0 running on the file $reads with the new --ONT flag and saving the output to the directory $wkdir/hifiasm_$attempt"

# make directory for the assembly & move to it
mkdir -p $wkdir/hifiasm_$attempt
cd $wkdir/hifiasm_$attempt

# run hifiasm on the simplex reads withOUT the new --ont flag to generate the assembly
hifiasm \
-t 96 \
--ont \
-o ONTasm \
$reads

# convert the final assembly to fasta format
awk '/^S/{print ">"$2;print $3}' ONTasm.bp.p_ctg.gfa > ONTasm.bp.p_ctg.fasta

# deactivate conda
conda deactivate

