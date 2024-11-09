#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4GB
#SBATCH --time=2:00:00
#SBATCH --partition=your_partition

# Export the credentials for GHCR
export SINGULARITY_DOCKER_USERNAME=your_github_username
export SINGULARITY_DOCKER_PASSWORD=your_personal_access_token

PIPELINE_PATH="/your/path/to/aind-smartspim-pipeline"
DATA_PATH="/your/path/to/smartspim_data"
RESULTS_PATH="/your/path/to/results"
WORKDIR="/your/path/to/workdir"

NXF_VER=22.10.8 DATA_PATH=$DATA_PATH RESULTS_PATH=$RESULTS_PATH nextflow \
  -C $PIPELINE_PATH/pipeline/nextflow_slurm.config \
  -log $RESULTS_PATH/nextflow/nextflow.log \
  run $PIPELINE_PATH/pipeline/main_slurm.nf \
  -work-dir $WORKDIR
  # additional parameters here