#!/bin/bash -l

# author: Carla
#SBATCH --account=project_2003317
#SBATCH -o /scratch/project_2003317/3s/tmp/GATK_HC_%A_%a.ou
#SBATCH -e /scratch/project_2003317/3s/tmp/GATK_HC_%A_%a.err
#SBATCH -p small
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -t 2-00:00:00
#SBATCH --mem-per-cpu=8000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=carla.collcosta@helsinki.fi
#SBATCH --array=1-257

# we have an array job for every file
SAMPLE=$(sed -n ${SLURM_ARRAY_TASK_ID}p /scratch/project_2003317/3s/Pipelines/4_Map_List)

module load biokit
# make a temporary file containing the X line of the sample list, defined by SLURM array job number
#to work, the number of array jobs must be indetical to the length of the sample list
$SAMPLE
