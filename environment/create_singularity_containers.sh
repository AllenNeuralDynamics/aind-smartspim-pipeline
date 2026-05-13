#!/usr/bin/env bash
# Build Singularity SIF images for all pipeline capsules.
# Versions are defined in versions.env — edit that file to bump a capsule.
# Run this from a node that has Singularity installed, then place the .img
# files in $WORKDIR/singularity/ before submitting the pipeline.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=versions.env
source "${SCRIPT_DIR}/versions.env"

ORG="ghcr.io/allenneuraldynamics"

echo "Building flat-field estimation SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-flatfield-estimation-${FLATFIELD_EST_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-flatfield-estimation:${FLATFIELD_EST_VERSION}" > /dev/null

echo "Building preprocessing SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-preprocessing-${PREPROCESSING_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-preprocessing:${PREPROCESSING_VERSION}" > /dev/null

echo "Building stitch SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-stitch-${STITCH_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-stitch:${STITCH_VERSION}" > /dev/null

echo "Building registration SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-registration-${REGISTRATION_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-registration:${REGISTRATION_VERSION}" > /dev/null

echo "Building fusion SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-fuse-${FUSE_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-fuse:${FUSE_VERSION}" > /dev/null

echo "Building dispatch SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-dispatch-${DISPATCHER_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-dispatch:${DISPATCHER_VERSION}" > /dev/null

echo "Building cell detection SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-cell-detection-${CELL_DETECTION_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-cell-detection:${CELL_DETECTION_VERSION}" > /dev/null

echo "Building cell classification SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-cell-classification-${CELL_CLASSIFICATION_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-cell-classification:${CELL_CLASSIFICATION_VERSION}" > /dev/null

echo "Building cell quantification SIF"
singularity build --force \
    "${ORG//\//-}-aind-smartspim-cell-quantification-${CELL_QUANTIFICATION_VERSION}.img" \
    "docker://${ORG}/aind-smartspim-cell-quantification:${CELL_QUANTIFICATION_VERSION}" > /dev/null
