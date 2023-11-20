###########################
## LIST FOR CLONE_FILTER ##
###########################

while read pops_paths_id; do
    ## 1st column: Unique ID ##
    cut -f2 ${pops_paths_id} | sed "/_2.fq.gz/d" > ${pops_paths_id}_1_Sample
    sed "s/_1.fq.gz//g" ${pops_paths_id}_1_Sample > ${pops_paths_id}_1_Column

    ## 2nd column: Sample ##
    awk 'BEGIN{FS=OFS=" "} {$1 = $1 OFS $1} 1' ${pops_paths_id}_1_Column | cut -f2 | sed "s/.*_//g" > ${pops_paths_id}_2nd_Column
    awk 'FNR==NR{a[NR]=$1;next}{$2=a[FNR]}1' ${pops_paths_id}_2nd_Column ${pops_paths_id}_1_Column > ${pops_paths_id}_2_Columns

    ## 3rd column: Population ##
    awk 'BEGIN{FS=OFS=" "} {$2 = $2 OFS $2} 1' ${pops_paths_id}_2_Columns | cut -f3 | sed 's/\(.*\)-[0-9]*/\1 /' > ${pops_paths_id}_3_Columns

    ## 4th column: Path to file ##
    cut -f1 ${pops_paths_id} | sed 's/\(.*\)\/.*/\1 /' > ${pops_paths_id}_4th_Column
    awk 'FNR==NR{a[NR]=$1;next}{$4=a[FNR]}1' ${pops_paths_id}_4th_Column ${pops_paths_id}_3_Columns > ${pops_paths_id}_4_Columns

    ## \t between columns ##
    sed "s/ /\t/g" ${pops_paths_id}_4_Columns > ${pops_paths_id}_ID_SAMPLE_POP_PATH

    ## Remove all temporary files ##
    rm ${pops_paths_id}_1_Sample
    rm ${pops_paths_id}_1_Column
    rm ${pops_paths_id}_2nd_Column
    rm ${pops_paths_id}_2_Columns
    rm ${pops_paths_id}_3_Columns
    rm ${pops_paths_id}_4th_Column
    rm ${pops_paths_id}_4_Columns

done < 0_Populations_Paths_IDs