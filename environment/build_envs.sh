#!/usr/bin/env bash
# Build Docker images for all pipeline capsules.
# Versions are defined in versions.env — edit that file to bump a capsule.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=versions.env
source "${SCRIPT_DIR}/versions.env"

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-flatfield-estimation/refs/tags/${FLATFIELD_EST_VERSION}/environment/Dockerfile_local"

wget -O Dockerfile_flat_est \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/heads/dev/environment/Dockerfile_local"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:${FLATFIELD_EST_VERSION}" -f Dockerfile_flat_est .

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-destripe/refs/tags/${PREPROCESSING_VERSION}/environment/Dockerfile_local"

wget -O Dockerfile_preprocessing \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-destripe/refs/heads/dev/environment/Dockerfile_local"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:${PREPROCESSING_VERSION}" -f Dockerfile_preprocessing .

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/tags/${STITCH_VERSION}/environment/Dockerfile_local"
# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/tags/${STITCH_VERSION}/environment/postInstall"

wget -O Dockerfile_stitch \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/heads/dev/environment/Dockerfile_local"
wget -O postInstall \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/heads/dev/environment/postInstall"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-stitch:${STITCH_VERSION}" -f Dockerfile_stitch .

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-ccf-registration/refs/tags/${REGISTRATION_VERSION}/environment/Dockerfile_local"

wget -O Dockerfile_registration \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-ccf-registration/refs/heads/dev/environment/Dockerfile_local"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-registration:${REGISTRATION_VERSION}" -f Dockerfile_registration .

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/tags/${FUSE_VERSION}/environment/Dockerfile_local"
# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/tags/${FUSE_VERSION}/environment/postInstall"

wget -O Dockerfile_fuse \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/heads/dev/environment/Dockerfile_local"
wget -O postInstall \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/heads/dev/environment/postInstall"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-fuse:${FUSE_VERSION}" -f Dockerfile_fuse .

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-external-dispatcher/refs/tags/${DISPATCHER_VERSION}/environment/Dockerfile_local"

wget -O Dockerfile_dispatcher \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-pipeline-dispatcher/refs/heads/refactor-package-for-publication/environment/Dockerfile_local"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:${DISPATCHER_VERSION}" -f Dockerfile_dispatcher .

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation/refs/tags/${CELL_DETECTION_VERSION}/environment/Dockerfile_local"

wget -O Dockerfile_cell_detection \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation/refs/heads/dev/environment/Dockerfile_local"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:${CELL_DETECTION_VERSION}" -f Dockerfile_cell_detection .

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-classification/refs/tags/${CELL_CLASSIFICATION_VERSION}/environment/Dockerfile_local"

wget -O Dockerfile_cell_classification \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-classification/refs/heads/dev/environment/Dockerfile_local"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:${CELL_CLASSIFICATION_VERSION}" -f Dockerfile_cell_classification .

# "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-quantification/refs/tags/${CELL_QUANTIFICATION_VERSION}/environment/Dockerfile_local"

wget -O Dockerfile_cell_quantification \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-quantification/refs/heads/dev/environment/Dockerfile_local"
docker build -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:${CELL_QUANTIFICATION_VERSION}" -f Dockerfile_cell_quantification .

rm Dockerfile_*
rm postInstall
