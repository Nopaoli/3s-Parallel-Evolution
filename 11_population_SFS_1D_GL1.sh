#!/bin/bash -l

# author: Carla
#SBATCH --account=project_2003317
#SBATCH --output=/scratch/project_2003317/3s/11_Population_SFS_GL1/0_PopSFS_%A_%a.ou
#SBATCH --error=/scratch/project_2003317/3s/11_Population_SFS_GL1/0_PopSFS_%A_%a.err
#SBATCH --partition=small
#SBATCH -n 1
#SBATCH --cpus-per-task=16
#SBATCH --time=3-00:00:00
#SBATCH --mem-per-cpu=4000
#SBATCH --array=1-33

GENOME=/scratch/project_2003317/3s/1_Reference/Gasterosteus_aculeatus.BROADS1.dna.toplevel.fa 
FILTERS="-uniqueOnly 1 -remove_bads 1 -minMapQ 20 -minQ 20 -C 50"
    # GENERAL FOR ANGSD.
    # -uniqueOnly 1 : Remove reads that have multiple best hits.
    # -remove_bads 1: Removes reads with a flag above 255, this is, the secondary alignments of some reads.
    # -minMapQ 20: Minimum MapQ quality.
    # -minQ 20: Minimum base quality score.
    # -C 50: Adjust mapQ for excessive mismatches (50).
TODO="-dosaf 1 -GL 1"
    # CONCRETE FOR SFS.
    # -dosaf 1: Calculate the Site allele frequency likelihood based on individual genotype likelihoods assuming HWE.
    # -GL 1: Genotype likelihood model.

# -P: Number of threads. 
# -fold 1: If you don't have the ancestral state, you can instead estimate the folded SFS. This is done by supplying the -anc with the reference genome and applying -fold 1 to realSFS.

conda activate angsd0921

sed -n ${SLURM_ARRAY_TASK_ID}p /scratch/project_2003317/3s/11_Population_SFS_GL1/0_Pops_Paths > /scratch/project_2003317/3s/11_Population_SFS_GL1/tmp_${SLURM_ARRAY_TASK_ID}

# ANGSD: SFS BASED ON GENOTYPE LIKELIHOODS
while read population bamfiles; do
    angsd  $FILTERS $TODO -ref $GENOME -anc $GENOME -bam $bamfiles  -out /scratch/project_2003317/3s/11_Population_SFS_GL1/${population};
    done < /scratch/project_2003317/3s/11_Population_SFS_GL1/tmp_${SLURM_ARRAY_TASK_ID}
# Output: 1) angsdput.saf.idx 2) angsdput.saf.pos.gz 3) angsdput.saf.gz

# realSFS: Get ML estimates. This program will estimate the (multi) SFS based on a .saf file generated from the ./angsd [options] -doSaf .
while read population bamfiles; do
    realSFS /scratch/project_2003317/3s/11_Population_SFS_GL1/${population}.saf.idx > /scratch/project_2003317/3s/11_Population_SFS_GL1/${population}.sfs;
    done < /scratch/project_2003317/3s/11_Population_SFS_GL1/tmp_${SLURM_ARRAY_TASK_ID}

rm /scratch/project_2003317/3s/11_Population_SFS_GL1/tmp_${SLURM_ARRAY_TASK_ID}
