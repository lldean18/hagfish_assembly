#!/bin/bash
# Laura Dean
# 4/11/26

# code used to extract serotonin receptor sequences
# coordinates were obtained using a blast search
# this was super quick so just ran on a login node

# setup env
cd /gpfs01/home/mbzlld/data/hagfish/serotonin_receptors
conda activate samtools1.24

#index assembly
samtools faidx assembly.fasta


# extract the DN7537_i region from the assembly
echo "contig_127434:99947-138942" > DN7537_i_region.txt
samtools faidx --region-file DN7537_i_region.txt assembly.fasta > DN7537_i.fasta


# extract the DN24979_ii region from the assembly
echo "contig_71936:73109-92085" > DN24979_ii_region.txt
samtools faidx --region-file DN24979_ii_region.txt assembly.fasta > DN24979_ii_main_match.fasta


# extract the secondary match on a different chromosome for DN24979_ii
echo "contig_92899:3326-3528" > DN24979_ii_secondary_region.txt
samtools faidx --region-file DN24979_ii_secondary_region.txt assembly.fasta > DN24979_ii_secondary_match.fasta


# cleanup env
conda deactivate

