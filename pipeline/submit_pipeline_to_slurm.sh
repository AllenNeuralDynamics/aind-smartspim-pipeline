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

# Change this output path to a S3 path if AWS cloud compatibility is needed
OUTPUT_PATH="/your/path/to/processed/dataset"

# Template path
TEMPLATE_PATH="your/path/to/lightsheet_to_template_to_ccf_registration"

# Cell detection path
CELL_DETECTION_PATH="/your/path/to/cell_detection_model"

# Setting cloud parameter - Useful if you want to store the results in a bucket
CLOUD="false"

NXF_VER=22.10.8 DATA_PATH=$DATA_PATH RESULTS_PATH=$RESULTS_PATH nextflow \
  -C $PIPELINE_PATH/pipeline/nextflow_slurm.config \
  -log $RESULTS_PATH/nextflow/nextflow.log \
  run $PIPELINE_PATH/pipeline/main_slurm.nf \
  -work-dir $WORKDIR \
  --output_path $OUTPUT_PATH \
  --template_path $TEMPLATE_PATH \
  --cell_detection_model $CELL_DETECTION_PATH \
  --cloud $CLOUD
  # additional parameters here
