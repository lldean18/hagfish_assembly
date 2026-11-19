#!/bin/bash
# Laura Dean
# 1/7/25
# script designed for running on the UoN HPC Ada

#SBATCH --job-name=plotsr
#SBATCH --partition=hmemq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1495g
#SBATCH --time=168:00:00
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# set variables
wkdir=/gpfs01/home/mbzlld/data/hagfish/plotsr
reference=/gpfs01/home/mbzlld/data/hagfish/Eptatretus_burgeri_ref/FYBX03_scaffs_only.fasta
asm1=/gpfs01/home/mbzlld/data/hagfish/flye_1/assembly_ragtag/ragtag.scaffold_chrs_only.fasta

# load software
source $HOME/.bash_profile
module load samtools-uoneasy/1.18-GCC-12.3.0


cd $wkdir

###########################################
#### map our assembly to the reference ####
###########################################

echo "Mapping our assembly to the reference..."


#conda activate minimap2
# for reference asm5/asm10/asm20 = 0.1%/1%/5% sequence divergence
#minimap2 \
#-ax asm5 \
#-t 1 \
#--eqx $asm1 $reference \
#-o $wkdir/$(basename ${asm1%.*}).sam
#conda deactivate
#module unload samtools-uoneasy/1.18-GCC-12.3.0


# Trying with MuMmer instead because syri won't work with the sam or bam output by minimap2
#conda create --name mummer bioconda::mummer -y
conda activate mummer
nucmer --maxmatch -c 100 -b 500 -l 50 $reference $asm1
delta-filter -m -i 90 -l 100 out.delta > out.filtered.delta
show-coords -THrd out.filtered.delta > out.filtered.coords
conda deactivate

conda activate syri
syri -c out.filtered.coords -d out.filtered.delta -r $reference -q $asm1
conda deactivate



## write the names of the assemblies to a file for use by plotsr
#echo -e ""$asm1"\tEptatretus_stoutii
#"$reference"\tEptatretus_burgeri" > $wkdir/$(basename ${asm1%.*})_plotsr_assemblies_list.txt
#
#echo -e "Done\n\n"


################################################################
##### Identify structural rearrangements between assemblies ####
################################################################
#
#echo "identifying structural rearrangements between assemblies with syri..."
## create your syri environment
##conda create -y --name syri -c bioconda -c conda-forge -c anaconda python=3.8 syri
#conda activate syri
#
## Run syri to find structural rearrangements between your assemblies
#syri \
#-c $wkdir/$(basename ${asm1%.*}).sam \
#-r $reference \
#-q $asm1 \
#-F S \
#-k \
#--dir $wkdir \
#--prefix $(basename ${asm1%.*})_syri
#
#conda deactivate
#echo -e "Done\n\n"

############################
#### create plotsr plot ####
############################

#echo "plotting structural rearrangements with plotsr..."
#conda activate plotsr
#
#plotsr \
#--sr $(basename ${asm1%.*})_${asm}_syri.out \
#--genomes $wkdir/$(basename ${asm1%.*})_plotsr_assemblies_list.txt \
#-o $wkdir/$(basename ${asm1%.*})_${asm}_plot.png
#
#conda deactivate
#echo "Done"



