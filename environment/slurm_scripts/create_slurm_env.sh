#!/bin/bash

# Check if the path is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/environment"
  exit 1
fi

# Set the path for the conda environment
ENV_PATH="$1"

# Create the conda environment at the specified path with Python
conda create --prefix "$ENV_PATH" python=3.8 -y

# Activate the environment
source activate "$ENV_PATH"

# Install Nextflow
conda install -c bioconda nextflow -y

echo "Conda environment at '$ENV_PATH' created and Nextflow installed."