#!/bin/bash
export PROJECT_PATH=/project/kaliappa_550/amin/p1_inferCNV

snakemake \
--snakefile $PROJECT_PATH/Snakefile \
--configfile $PROJECT_PATH/config/config.yaml \
--printshellcmds \
--keep-going \
--rerun-incomplete \
--cluster-config $PROJECT_PATH/config/cluster.yaml \
--cores 1 \
--cluster 'sbatch --ntasks={cluster.tasks} --cpus-per-task={cluster.cores} 
--mem={cluster.mem} --time={cluster.time} --account={cluster.acc} 
--output {cluster.logout} --error {cluster.logerror}' \
$@
