#!/bin/bash

#author: collcost
#SBATCH --account=project_2003317
#SBATCH --output=/scratch/project_2003317/3s/4_Clone_Filter/0_outputs/RUS-SLI-GA_clone_filter.out
#SBATCH --error=/scratch/project_2003317/3s/4_Clone_Filter/0_errors/RUS-SLI-GA_clone_filter.err
#SBATCH --partition=small
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --mem-per-cpu=50000

module load stacks

while read -r unique_id sample population path; do
    mkdir -p /scratch/project_2003317/3s/4_Clone_Filter/${population}/${sample}/
    output_directory="/scratch/project_2003317/3s/4_Clone_Filter/${population}/${sample}/"
    echo $unique_id >> /scratch/project_2003317/3s/4_Clone_Filter/0_outputs/RUS-SLI-GA_clone_filter.out
    echo $unique_id >> /scratch/project_2003317/3s/4_Clone_Filter/0_errors/RUS-SLI-GA_clone_filter.err
    clone_filter -1 /scratch/project_2003317/3s/2_FASTQ/${population}/${unique_id}_1.fq.gz -2 /scratch/project_2003317/3s/2_FASTQ/${population}/${unique_id}_2.fq.gz -i gzfastq -o $output_directory
done <  /scratch/project_2003317/3s/3_Paths_IDs/RUS-SLI-GA_Paths_and_IDs_ID_SAMPLE_POP_PATH

## Change the input file for each population.
## Change the name of the error and input files to match the population name.