#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4GB
#SBATCH --partition={your-partition}
#SBATCH --time=2:00:00

# Check if the path is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/environment"
  exit 1
fi

# modify this section to make the nextflow command available to your environment
# e.g., using a conda environment with nextflow installed
ENV_PATH="$1"
conda activate "$ENV_PATH"

PIPELINE_PATH="path-to-your-cloned-repo"
DATA_PATH="path-to-data-folder"
RESULTS_PATH="path-to-results-folder"
WORKDIR="path-to-workdir-folder"

NXF_VER=24.10.0.5928 DATA_PATH=$DATA_PATH RESULTS_PATH=$RESULTS_PATH nextflow \
    -C $PIPELINE_PATH/pipeline/nextflow_slurm.config \
    -log $RESULTS_PATH/nextflow/nextflow.log \
    run $PIPELINE_PATH/pipeline/main_slurm.nf \
    -work-dir $WORKDIR
    # additional parameters here