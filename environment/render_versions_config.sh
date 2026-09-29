#!/usr/bin/env bash
# Renders pipeline/versions.config from environment/versions.env.
# Called by submit_pipeline_to_slurm.sh on every submission and by `make versions`.
#
# Usage: environment/render_versions_config.sh [output_path]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="${1:-${SCRIPT_DIR}/../pipeline/versions.config}"

# shellcheck source=versions.env
source "${SCRIPT_DIR}/versions.env"

cat > "${OUTPUT}" <<EOF
// AUTO-GENERATED from environment/versions.env — do not edit by hand.
// To update: edit environment/versions.env, then run \`make versions\`
// (submit_pipeline_to_slurm.sh also regenerates it). Commit both files together.
params {
    ver_flatfield      = "${FLATFIELD_EST_VERSION}"
    ver_preprocessing  = "${PREPROCESSING_VERSION}"
    ver_stitch         = "${STITCH_VERSION}"
    ver_fuse           = "${FUSE_VERSION}"
    ver_registration   = "${REGISTRATION_VERSION}"
    ver_dispatch       = "${DISPATCHER_VERSION}"
    ver_detection      = "${CELL_DETECTION_VERSION}"
    ver_classification = "${CELL_CLASSIFICATION_VERSION}"
    ver_quantification = "${CELL_QUANTIFICATION_VERSION}"
    ref_flatfield      = "${FLATFIELD_EST_REF}"
    ref_preprocessing  = "${PREPROCESSING_REF}"
    ref_stitch         = "${STITCH_REF}"
    ref_fuse           = "${FUSE_REF}"
    ref_registration   = "${REGISTRATION_REF}"
    ref_dispatch       = "${DISPATCHER_REF}"
    ref_detection      = "${CELL_DETECTION_REF}"
    ref_classification = "${CELL_CLASSIFICATION_REF}"
    ref_quantification = "${CELL_QUANTIFICATION_REF}"
    repo_flatfield      = "${FLATFIELD_EST_REPO}"
    repo_preprocessing  = "${PREPROCESSING_REPO}"
    repo_stitch         = "${STITCH_REPO}"
    repo_fuse           = "${FUSE_REPO}"
    repo_registration   = "${REGISTRATION_REPO}"
    repo_dispatch       = "${DISPATCHER_REPO}"
    repo_detection      = "${CELL_DETECTION_REPO}"
    repo_classification = "${CELL_CLASSIFICATION_REPO}"
    repo_quantification = "${CELL_QUANTIFICATION_REPO}"
}
EOF
