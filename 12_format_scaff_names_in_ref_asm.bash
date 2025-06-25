#!/bin/bash
# Laura Dean


# set variables
reference=/gpfs01/home/mbzlld/data/hagfish/Eptatretus_burgeri_ref/FYBX03.fasta.gz
reference=/gpfs01/home/mbzlld/data/hagfish/Eptatretus_atami_ref/JAXMNL01.fasta.gz


# source bash profile for conda
source $HOME/.bash_profile


# have a look at the current format of scaffold names in the downloaded fasta file
zgrep ">" $reference

# fix the scaffold names in the downloaded reference assembly
zcat $reference | sed 's/^.*Eptatretus atami isolate PATA_SCHIZ_1 />/;s/, whole genome shotgun sequence.//' | gzip > ${reference}.tmp && mv ${reference}.tmp $reference

# remove the unplaced contigs from the reference
conda activate seqkit
seqkit grep -r -n -p 'chromosome.*' $reference | gzip > ${reference%.*.*}_scaffs_only.fasta.gz
conda deactivate

# check that this worked as you intended
zgrep ">" ${reference%.*.*}_scaffs_only.fasta.gz


