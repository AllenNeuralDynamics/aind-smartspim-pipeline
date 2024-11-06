#!/bin/bash

# Set environment name
ENV_NAME="env_nf"

# Create the conda environment with a specific name and install Python
conda create --name "$ENV_NAME" python=3.8 -y

# Activate the environment
source activate "$ENV_NAME"

# Install Nextflow
conda install -c bioconda nextflow -y

echo "Conda environment '$ENV_NAME' created and Nextflow installed."