## FASTA DICTIONARY ##
samtools dict /scratch/project_2003317/3s/1_Reference/Gasterosteus_aculeatus.BROADS1.dna.toplevel.fa > /scratch/project_2003317/3s/1_Reference/Gasterosteus_aculeatus.BROADS1.dna.toplevel.dict
#output: .dict

## FASTA INDEX ##
samtools faidx /scratch/project_2003317/3s/1_Reference/Gasterosteus_aculeatus.BROADS1.dna.toplevel.fa
#output: .fai

## MAPPING INDEX ##
bwa index /scratch/project_2003317/3s/1_Reference/Gasterosteus_aculeatus.BROADS1.dna.toplevel.fa
#output: Nothing?