#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4GB
#SBATCH --time=24:00:00
#SBATCH --partition=your_partition
#
# Override any SBATCH directive at submission time without editing this file:
#   sbatch --partition=gpu --mem=8GB pipeline/submit_pipeline_to_slurm.sh
#
# This script is a fixed wrapper — edit pipeline/deployment.env instead.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Load deployment settings (paths, cloud flag, optional dispatcher overrides)
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/deployment.env"

# ── Load capsule release tags (single source of truth)
# shellcheck source=../environment/versions.env
source "${PIPELINE_PATH}/environment/versions.env"

# ── Generate the Nextflow versions config (fast — runs on every submission)
cat > "${PIPELINE_PATH}/pipeline/versions.config" <<EOF
// AUTO-GENERATED on every submission from environment/versions.env — do not edit by hand.
// To update versions: edit environment/versions.env, then re-submit (or commit versions.config).
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
}
EOF

# ── Run the pipeline
NXF_VER=22.10.8 DATA_PATH=$DATA_PATH RESULTS_PATH=$RESULTS_PATH nextflow \
    -C "${PIPELINE_PATH}/pipeline/nextflow_slurm.config" \
    -c "${PIPELINE_PATH}/pipeline/versions.config" \
    -log "${RESULTS_PATH}/nextflow/nextflow.log" \
    run "${PIPELINE_PATH}/pipeline/main_slurm_v3.nf" \
    -work-dir "$WORKDIR" \
    --output_path "$OUTPUT_PATH" \
    --template_path "$TEMPLATE_PATH" \
    --cell_models_path "$CELL_MODELS_PATH" \
    --cloud "$CLOUD" \
    -resume
