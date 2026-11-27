#!/bin/bash
# Laura Dean
# 21/11/26

# code use to concatenate fastqs

cd ~/data/hagfish/basecalls

cat Hagfish-10_SUP.fastq.gz Hagfish-25_SUP.fastq.gz native_and_pcr_calls.fastq.gz > all_hagfish.fastq.gz


