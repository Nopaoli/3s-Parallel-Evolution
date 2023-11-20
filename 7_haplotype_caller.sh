#!/bin/bash -l

# author: Carla
#SBATCH --account=project_2003317
#SBATCH --output=/scratch/project_2003317/3s/7_Haplotype_Caller/0_errors_outputs/GATK_HC_%A_%a.ou
#SBATCH --error=/scratch/project_2003317/3s/7_Haplotype_Caller/0_errors_outputs/GATK_HC_%A_%a.err
#SBATCH --partition=small
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --mem-per-cpu=32000
#SBATCH --mail-user=carla.collcosta@helsinki.fi
#SBATCH --array=1-257

# We have an array job for every BAM file in 5_BAM 
reference=/scratch/project_2003317/3s/1_Reference/Gasterosteus_aculeatus.BROADS1.dna.toplevel.fa 
SAMPLES="/scratch/project_2003317/3s/7_Haplotype_Caller/All_BAM_files"
threespine="/scratch/project_2003317/3s/7_Haplotype_Caller/"

# make a temporary file containing the X line of the sample list, defined by SLURM array job number 
# to work, the number of array jobs must be identical to the lenght of the sample list
sed -n ${SLURM_ARRAY_TASK_ID}p $SAMPLES > $threespine/bla_${SLURM_ARRAY_TASK_ID}_tmp
time=`date +%F-%T`

module load biokit 
module load gatk
echo -e \#\!\/\bin\/\bash > $threespine/combineGVCFscript.sh
echo reference=$reference >> $threespine/combineGVCFscript.sh
echo -e gatk4 CombineGVCFs \\ >> $threespine/combineGVCFscript.sh
echo -e -R $reference \\ >> $threespine/combineGVCFscript.sh


while read sample_name path; do \
   gatk --java-options "-Xmx32G"  HaplotypeCaller \
        -R $reference \
        -I $path \
        -O $threespine/${sample_name}.gvcf \
        -ERC GVCF \
        --native-pair-hmm-threads 16 \
        -ploidy 2
        
        echo -e $sample_name"\t"$gvcf >> $threespine/gvcf.sample_map
        echo -e --variant $sample_name.gvcf \\ >> $threespine/combineGVCFscript.sh
        
done < $threespine/bla_${SLURM_ARRAY_TASK_ID}_tmp

rm -f $threespine/bla_${SLURM_ARRAY_TASK_ID}_tmp

