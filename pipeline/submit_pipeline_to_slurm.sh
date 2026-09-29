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
    -resume
