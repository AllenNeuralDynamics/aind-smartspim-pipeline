#!/usr/bin/env bash
# Build Docker images for all pipeline capsules.
# Versions and repositories are defined in versions.env — edit that file to bump a capsule.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRANCH="main"
DOCKER_BUILD_PARAMS="--no-cache"
# shellcheck source=versions.env
source "${SCRIPT_DIR}/versions.env"

# Raw-file URL for environment/<file> on ${BRANCH} of a capsule repo (the *_REPO clone URLs in versions.env)
raw_url() {
    local slug="${1#https://github.com/}"
    echo "https://raw.githubusercontent.com/${slug%.git}/refs/heads/${BRANCH}/environment/$2"
}

wget -O Dockerfile_flat_est \
    "$(raw_url "${FLATFIELD_EST_REPO}" Dockerfile_local)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:${FLATFIELD_EST_VERSION}" -f Dockerfile_flat_est .

wget -O Dockerfile_preprocessing \
    "$(raw_url "${PREPROCESSING_REPO}" Dockerfile_local)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:${PREPROCESSING_VERSION}" -f Dockerfile_preprocessing .

wget -O Dockerfile_stitch \
    "$(raw_url "${STITCH_REPO}" Dockerfile_local)"
wget -O postInstall \
    "$(raw_url "${STITCH_REPO}" postInstall)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-stitch:${STITCH_VERSION}" -f Dockerfile_stitch .

wget -O Dockerfile_registration \
    "$(raw_url "${REGISTRATION_REPO}" Dockerfile_local)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-registration:${REGISTRATION_VERSION}" -f Dockerfile_registration .

wget -O Dockerfile_fuse \
    "$(raw_url "${FUSE_REPO}" Dockerfile_local)"
wget -O postInstall \
    "$(raw_url "${FUSE_REPO}" postInstall)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-fuse:${FUSE_VERSION}" -f Dockerfile_fuse .

wget -O Dockerfile_dispatcher \
    "$(raw_url "${DISPATCHER_REPO}" Dockerfile_local)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:${DISPATCHER_VERSION}" -f Dockerfile_dispatcher .

wget -O Dockerfile_cell_detection \
    "$(raw_url "${CELL_DETECTION_REPO}" Dockerfile_local)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:${CELL_DETECTION_VERSION}" -f Dockerfile_cell_detection .

wget -O Dockerfile_cell_classification \
    "$(raw_url "${CELL_CLASSIFICATION_REPO}" Dockerfile_local)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:${CELL_CLASSIFICATION_VERSION}" -f Dockerfile_cell_classification .

wget -O Dockerfile_cell_quantification \
    "$(raw_url "${CELL_QUANTIFICATION_REPO}" Dockerfile_local)"
docker build ${DOCKER_BUILD_PARAMS} -t "ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:${CELL_QUANTIFICATION_VERSION}" -f Dockerfile_cell_quantification .

rm Dockerfile_*
rm postInstall
