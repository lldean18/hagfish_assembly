#!/bin/bash
# Laura Dean
# 1/7/25
# script designed for running on the UoN HPC Ada

#SBATCH --job-name=plotsr
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=4:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# set variables
wkdir=/gpfs01/home/mbzlld/data/hagfish/plotsr
reference=/gpfs01/home/mbzlld/data/hagfish/Eptatretus_burgeri_ref/FYBX03_scaffs_only.fasta
asm1=/gpfs01/home/mbzlld/data/hagfish/flye_1/assembly_ragtag/ragtag.scaffold_chrs_only.fasta
# set mapping variable (select level based on estimated sequence divergence)
# for reference asm5/asm10/asm20 = 0.1%/1%/5% sequence divergence
#asm=asm5 # 0.1% sequence divergence
asm=asm10 # 1% sequence divergence
#asm=asm20 # 5% sequence divergence

# load software
source $HOME/.bash_profile
module load samtools-uoneasy/1.18-GCC-12.3.0


###########################################
#### map our assembly to the reference ####
###########################################

echo "Mapping our assembly to the reference..."
conda activate minimap2

# align the genomes

# for reference asm5/asm10/asm20 = 0.1%/1%/5% sequence divergence
minimap2 \
-ax $asm \
-t 16 \
--eqx $asm1 $reference \
-o $wkdir/tmp.sam
samtools sort $wkdir/tmp.sam \
-o $wkdir/$(basename ${asm1%.*})_$asm.bam
rm $wkdir/tmp.sam
conda deactivate

# index the bam file
samtools index -bc $wkdir/$(basename ${asm1%.*})_$asm.bam

# write the names of the assemblies to a file for use by plotsr
echo -e ""$asm1"\tEptatretus_stoutii
"$reference"\tEptatretus_burgeri" > $wkdir/$(basename ${asm1%.*})_plotsr_assemblies_list.txt

module unload samtools-uoneasy/1.18-GCC-12.3.0
echo -e "Done\n\n"


###############################################################
#### Identify structural rearrangements between assemblies ####
###############################################################

echo "identifying structural rearrangements between assemblies with syri..."
# create your syri environment
#conda create -y --name syri -c bioconda -c conda-forge -c anaconda python=3.8 syri
conda activate syri

# Run syri to find structural rearrangements between your assemblies
syri \
-c $wkdir/$(basename ${asm1%.*})_$asm.bam \
-r $reference \
-q $asm1 \
-F B \
--dir $wkdir \
--prefix $(basename ${asm1%.*})_${asm}_syri

conda deactivate
echo -e "Done\n\n"

############################
#### create plotsr plot ####
############################

echo "plotting structural rearrangements with plotsr..."
conda activate plotsr

plotsr \
--sr $(basename ${asm1%.*})_${asm}_syri.out \
--genomes $wkdir/$(basename ${asm1%.*})_plotsr_assemblies_list.txt \
-o $wkdir/$(basename ${asm1%.*})_${asm}_plot.png

conda deactivate
echo "Done"



