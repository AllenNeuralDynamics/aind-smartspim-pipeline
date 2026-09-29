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

# ── Load deployment settings (paths, cloud flag, optional dispatcher overrides).
# DEPLOYMENT_ENV points at a different file (used by tests/check_submit_script.py).
# shellcheck source=/dev/null
source "${DEPLOYMENT_ENV:-${SCRIPT_DIR}/deployment.env}"

# ── Optional pipeline parameters: passed only when set in deployment.env
OPTIONAL_PARAMS=()
add_param() { if [ -n "$2" ]; then OPTIONAL_PARAMS+=("$1" "$2"); fi; }
add_param --input_path        "${INPUT_PATH:-}"
add_param --ng_base_url       "${NG_BASE_URL:-}"
add_param --ccf_annotation_s3 "${CCF_ANNOTATION_S3:-}"
add_param --co_domain         "${CO_DOMAIN:-}"
add_param --data_folder       "${DATA_FOLDER:-}"
add_param --results_folder    "${RESULTS_FOLDER:-}"

# ── Optional dispatcher credentials and alert settings: exported only when set,
# then forwarded into the containers by envWhitelist in nextflow_slurm.config
for var in ALERT_BOT_LINK API_SECRET SES_TOKEN_PATH SMARTSHEET_ID SOURCE_EMAIL; do
    if [ -n "${!var:-}" ]; then export "${var?}"; fi
done

# ── Generate the Nextflow versions config from environment/versions.env
# (fast — runs on every submission so the pinned capsule versions are always current)
"${PIPELINE_PATH}/environment/render_versions_config.sh" "${PIPELINE_PATH}/pipeline/versions.config"

# ── Run the pipeline (DATA_PATH / RESULTS_PATH come from deployment.env)
export DATA_PATH RESULTS_PATH
NXF_VER=22.10.8 nextflow \
    -C "${PIPELINE_PATH}/pipeline/nextflow_slurm.config" \
    -c "${PIPELINE_PATH}/pipeline/versions.config" \
    -log "${RESULTS_PATH}/nextflow/nextflow.log" \
    run "${PIPELINE_PATH}/pipeline/main_slurm_v3.nf" \
    -work-dir "$WORKDIR" \
    --output_path "$OUTPUT_PATH" \
    --template_path "$TEMPLATE_PATH" \
    --cell_models_path "$CELL_MODELS_PATH" \
    --cloud "$CLOUD" \
    ${OPTIONAL_PARAMS[@]+"${OPTIONAL_PARAMS[@]}"} \
    -resume
