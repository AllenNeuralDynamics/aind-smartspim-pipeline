#!/usr/bin/env bash
# Build Docker images for all pipeline capsules.
# Versions are defined in versions.env — edit that file to bump a capsule.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRANCH="dev"
DOCKER_BUILD_PARAMS="--no-cache"
# shellcheck source=versions.env
source "${SCRIPT_DIR}/versions.env"

wget -O Dockerfile_flat_est \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-flatfield-estimation/refs/heads/${BRANCH}/environment/Dockerfile_local"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:${FLATFIELD_EST_VERSION}" -f Dockerfile_flat_est .

wget -O Dockerfile_preprocessing \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-destripe/refs/heads/${BRANCH}/environment/Dockerfile_local"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:${PREPROCESSING_VERSION}" -f Dockerfile_preprocessing .

wget -O Dockerfile_stitch \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/heads/${BRANCH}/environment/Dockerfile_local"
wget -O postInstall \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/heads/${BRANCH}/environment/postInstall"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-stitch:${STITCH_VERSION}" -f Dockerfile_stitch .

wget -O Dockerfile_registration \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-ccf-registration/refs/heads/${BRANCH}/environment/Dockerfile_local"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-registration:${REGISTRATION_VERSION}" -f Dockerfile_registration .

wget -O Dockerfile_fuse \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/heads/${BRANCH}/environment/Dockerfile_local"
wget -O postInstall \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/heads/${BRANCH}/environment/postInstall"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-fuse:${FUSE_VERSION}" -f Dockerfile_fuse .

wget -O Dockerfile_dispatcher \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-pipeline-dispatcher/refs/heads/${BRANCH}/environment/Dockerfile_local"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:${DISPATCHER_VERSION}" -f Dockerfile_dispatcher .

wget -O Dockerfile_cell_detection \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation/refs/heads/${BRANCH}/environment/Dockerfile_local"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:${CELL_DETECTION_VERSION}" -f Dockerfile_cell_detection .

wget -O Dockerfile_cell_classification \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-classification/refs/heads/${BRANCH}/environment/Dockerfile_local"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:${CELL_CLASSIFICATION_VERSION}" -f Dockerfile_cell_classification .

wget -O Dockerfile_cell_quantification \
    "https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-quantification/refs/heads/${BRANCH}/environment/Dockerfile_local"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:${CELL_QUANTIFICATION_VERSION}" -f Dockerfile_cell_quantification .

rm Dockerfile_*
rm postInstall
