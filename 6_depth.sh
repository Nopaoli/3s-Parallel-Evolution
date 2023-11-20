#!/bin/bash

# author: Carla
#SBATCH --account=project_2003317
#SBATCH --output=/scratch/project_2003317/3s/6_Depth/IndDepth.ou
#SBATCH --error=/scratch/project_2003317/3s/6_Depth/IndDepth.err
#SBATCH --partition=small
#SBATCH -n 1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --mem-per-cpu=50000
#SBATCH --mail-user=carla.collcosta@helsinki.fi

module load biokit
LIST=/scratch/project_2003317/3s/6_Depth/All_BAM_files

while read sample path; do
    samtools depth $path |  awk '{sum+=$3} END {print sum/NR}' >> /scratch/project_2003317/3s/6_Depth/Sample_Depth;
    done < $LIST

paste $LIST /scratch/project_2003317/3s/6_Depth/Sample_Depth >> /scratch/project_2003317/3s/6_Depth/temporary.tab 
awk '{print $1"\t"$3}' /scratch/project_2003317/3s/6_Depth/temporary.tab >> /scratch/project_2003317/3s/6_Depth/Individual_Mean_Depths.tab
rm /scratch/project_2003317/3s/6_Depth/Sample_Depth
rm /scratch/project_2003317/3s/6_Depth/temporary.tab