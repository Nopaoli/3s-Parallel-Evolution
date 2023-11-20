#!/bin/bash

# author: Carla
#SBATCH --account=project_2003317
#SBATCH --output=/scratch/project_2003317/3s/9_Genotype_GVCFs/Genotype_GVCFs.ou
#SBATCH --error=/scratch/project_2003317/3s/9_Genotype_GVCFs/Genotype_GVCFs.err
#SBATCH --partition=longrun
#SBATCH -n 1
#SBATCH --cpus-per-task=16
#SBATCH --time=14-00:00:00
#SBATCH --mem-per-cpu=5000

module load gatk

gatk GenotypeGVCFs -R /scratch/project_2003317/3s/1_Reference/Gasterosteus_aculeatus.BROADS1.dna.toplevel.fa -V /scratch/project_2003317/3s/8_Combine_GVCFs/join_gvcf.gvcf -O /scratch/project_2003317/3s/9_Genotype_GVCFs/genotypes.vcf
