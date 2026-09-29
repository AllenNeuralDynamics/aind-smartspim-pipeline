#!/usr/bin/env nextflow
"""
Nextflow Script: SmartSPIM Pipeline

Note: This pipeline works with ome.zarr files.

This script executes the SmartSPIM pipeline, performing the following operations:
0. Channel splitting (dispatcher split_channels)
1. Retrospective flatfield correction
2. Image horizontal destriping
3. Flatfield correction
4. Image stitching
5. Image fusion
6. Image atlas registration to the Allen CCF v3 atlas
7. Image cell detection
8. Image cell quantification

Parameters
----------
DATA_PATH : str
    Path to the dataset.
RESULTS_PATH : str
    Path to the results folder.
PARAMS : dict
    Configuration parameters for the SmartSPIM pipeline.

Author: Camilo Laiton
Date: April, 2025.
"""

nextflow.enable.dsl = 1

// Capsule image tags (params.ver_*), code release refs (params.ref_*) and code
// repositories (params.repo_*) are injected via pipeline/versions.config, which is
// auto-generated from environment/versions.env by submit_pipeline_to_slurm.sh.

// Optional dispatcher flags — all default to null.
// The dispatcher falls back to its own env var defaults when not provided.
// Pass at submission time with e.g. --ng_base_url https://neuroglancer.example.org
params.data_folder        = null   // --data-folder        (overrides DATA_FOLDER env var in dispatcher)
params.results_folder     = null   // --results-folder     (overrides RESULTS_FOLDER env var in dispatcher)
params.ng_base_url        = null   // --ng-base-url        (Neuroglancer base URL)
params.ccf_annotation_s3  = null   // --ccf-annotation-s3  (S3 path to CCF annotations)
params.co_domain          = null   // --co-domain          (CodeOcean domain)

// Raw data root handed to the dispatcher's split_channels mode. The dispatcher
// looks for channels under <input_path>/<data_description.name>/SPIM, so this
// defaults to the parent folder of DATA_PATH. In cloud mode pass the bucket name.
params.input_path         = null

// Dataset and results locations: --lightsheet_dataset / --results_path,
// falling back to the DATA_PATH / RESULTS_PATH env vars set by submit_pipeline_to_slurm.sh
params.lightsheet_dataset = System.getenv('DATA_PATH')
params.results_path       = System.getenv('RESULTS_PATH')

if (!params.lightsheet_dataset) {
    exit 1, "Error: Missing dataset path. Set DATA_PATH or pass --lightsheet_dataset."
}
if (!params.results_path) {
    exit 1, "Error: Missing results path. Set RESULTS_PATH or pass --results_path."
}

println "DATA_PATH: ${params.lightsheet_dataset}"
println "RESULTS_PATH: ${params.results_path}"
println "PARAMS: ${params}"

// Retrieve keys from params
params_keys = params.keySet()

// Set cloud copy, defaulting to "false" if not specified
cloud = params_keys.contains("cloud") ? params.cloud : "false"

// Ensure output_path is provided
if (!params_keys.contains('output_path')) {
    exit 1, "Error: Missing required parameter 'output_path'."
}
output_path = params.output_path

// Ensure template_path is provided
if (!params_keys.contains('template_path')) {
    exit 1, "Error: Missing SmartSPIM template"
}
template_path = params.template_path

// Ensure cell_models_path is provided
if (!params_keys.contains('cell_models_path')) {
    exit 1, "Error: Missing SmartSPIM template"
}

cell_models_path = params.cell_models_path

println "Output path: ${output_path}"
println "Path for deep learning production models: ${cell_models_path}"
println "Using cloud: ${cloud}"

split_input_path = params.input_path ?: file(params.lightsheet_dataset).parent.toString()
println "Raw data root for channel splitting: ${split_input_path}"

// Build optional CLI flags for the dispatcher and clean_up processes.
// Only appends a flag when the param was explicitly provided (non-null, non-empty).
def _opt(flag, val) { val ? " ${flag} ${val}" : "" }
dispatcher_extra_args  = _opt("--data-folder",        params.data_folder)
dispatcher_extra_args += _opt("--results-folder",     params.results_folder)
dispatcher_extra_args += _opt("--ng-base-url",        params.ng_base_url)
dispatcher_extra_args += _opt("--ccf-annotation-s3",  params.ccf_annotation_s3)
dispatcher_extra_args += _opt("--co-domain",          params.co_domain)

// Input Channels - Organized by data source and target process
// Dataset to Channel Splitting (dispatcher split_channels)
ch_dataset_to_split_metadata = channel.fromPath(params.lightsheet_dataset + "/*.json", type: 'any')
ch_dataset_to_split_manifest = channel.fromPath(params.lightsheet_dataset + "/SPIM/derivatives/processing_manifest.json", type: 'any')

// Dataset to Destripe process
ch_dataset_to_destripe_derivatives = channel.fromPath(params.lightsheet_dataset + "/SPIM/derivatives", type: 'any')
ch_dataset_to_destripe_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')
ch_dataset_to_destripe_data_description = channel.fromPath(params.lightsheet_dataset + "/data_description.json", type: 'any')
ch_dataset_to_destripe_images = channel.fromPath(params.lightsheet_dataset + "/SPIM/Ex_*_Em_*", type: 'any')

// Dataset to Stitching process
ch_dataset_to_stitch_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')
ch_dataset_to_stitch_data_description = channel.fromPath(params.lightsheet_dataset + "/data_description.json", type: 'any')
ch_dataset_to_stitch_manifest = channel.fromPath(params.lightsheet_dataset + "/SPIM/derivatives/processing_manifest.json", type: 'any')

// Dataset to Fusion process
ch_dataset_to_fuse_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')

// Dataset to Flatfield Estimation process
ch_dataset_to_flatfield_metadata = channel.fromPath(params.lightsheet_dataset + "/SPIM/derivatives/metadata.json", type: 'any')
ch_dataset_to_flatfield_images = channel.fromPath(params.lightsheet_dataset + "/SPIM/Ex_*_Em_*", type: 'any')
ch_dataset_to_flatfield_data_description = channel.fromPath(params.lightsheet_dataset + "/data_description.json", type: 'any')

// Dataset to Pipeline Dispatcher
ch_dataset_to_dispatcher_metadata = channel.fromPath(params.lightsheet_dataset + "/*.json", type: 'any')
ch_dataset_to_dispatcher_manifest = channel.fromPath(params.lightsheet_dataset + "/SPIM/derivatives/processing_manifest.json", type: 'any')

// Dataset to CCF Registration
ch_dataset_to_registration_manifest = channel.fromPath(params.lightsheet_dataset + "/SPIM/derivatives/processing_manifest.json", type: 'any')
ch_dataset_to_registration_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')

// Production models to Classification
ch_models_to_classification = channel.fromPath(cell_models_path + "/", type: 'any')

// Inter-process channels (organized by source -> target)
// Channel Splitting -> Destripe
ch_split_to_preprocessing = channel.create()

// Channel Splitting -> Flatfield
ch_split_to_flatfield = channel.create()

// Flatfield -> Destripe
ch_flatfield_to_destripe = channel.create()

// Destripe -> Stitch
ch_destripe_to_stitch = channel.create()

// Destripe -> Fuse
ch_destripe_to_fuse = channel.create()

// Destripe -> Dispatcher
ch_destripe_to_dispatcher = channel.create()

// Stitch -> Fuse
ch_stitch_to_fuse = channel.create()

// Stitch -> Dispatcher
ch_stitch_to_dispatcher = channel.create()

// Fuse -> Dispatcher
ch_fuse_to_dispatcher = channel.create()

// Fuse -> Quantification
ch_fuse_to_quantification = channel.create()

// Fuse -> Registration
ch_fuse_to_registration = channel.create()

// Fuse -> Segmentation
ch_fuse_to_segmentation = channel.create()

// Fuse -> Classification
ch_fuse_to_classification = channel.create()

// Flatfield -> Dispatcher
ch_flatfield_to_dispatcher = channel.create()

// Registration -> Dispatcher
ch_registration_to_dispatcher = channel.create()

// Registration -> Quantification
ch_registration_to_quantification = channel.create()

// Dispatcher -> Quantification (multiple files)
ch_dispatcher_to_quantification_manifest = channel.create()
ch_dispatcher_to_quantification_description = channel.create()
ch_dispatcher_to_quantification_acquisition = channel.create()

// Dispatcher -> Segmentation
ch_dispatcher_to_segmentation_description = channel.create()
ch_dispatcher_to_segmentation_acquisition = channel.create()
ch_dispatcher_to_segmentation_manifest = channel.create()

// Dispatcher -> Classification
ch_dispatcher_to_classification_description = channel.create()
ch_dispatcher_to_classification_acquisition = channel.create()

// Dispatcher -> Final Dispatcher
ch_dispatcher_to_final_manifest = channel.create()
ch_dispatcher_to_final_metadata = channel.create()

// Classification -> Quantification
ch_classification_to_quantification = channel.create()

// Classification -> Final Dispatcher
ch_classification_to_final = channel.create()

// Segmentation -> Classification
ch_segmentation_to_classification = channel.create()

// Quantification -> Final Dispatcher
ch_quantification_to_final = channel.create()

// Splits the dataset into per-channel preprocess_<channel>.json configs
process split_channels {
    tag 'split-channels'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:${params.ver_dispatch}"

    cpus 2
    memory '16 GB'
    time '1h'

    input:
    path 'capsule/data/input_aind_metadata/' from ch_dataset_to_split_metadata.collect()
    path 'capsule/data/' from ch_dataset_to_split_manifest.collect()

    output:
    path 'capsule/results/preprocess_*.json' into ch_split_to_preprocessing
    path 'capsule/results/*' into ch_split_to_flatfield

    stub:
    """
    mkdir -p capsule/results
    for channel in ${params.lightsheet_dataset}/SPIM/Ex_*_Em_*; do
        touch "capsule/results/preprocess_\$(basename "\$channel").json"
    done
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_dispatch} \
        "${params.repo_dispatch}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run split_channels ${cloud} ${split_input_path}${dispatcher_extra_args}

    echo "[${task.tag}] completed!"
    """
}

// Retrospective flatfield correction
process flatfield_estimation {
    tag 'flatfield-estimation'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:${params.ver_flatfield}"

    cpus 16
    memory '128 GB'
    time '8h'

    input:
    path 'capsule/data/' from ch_dataset_to_flatfield_metadata.collect()
    path 'capsule/data/' from ch_dataset_to_flatfield_images.collect()
    path 'capsule/data/' from ch_dataset_to_flatfield_data_description.collect()
    path 'capsule/data/' from ch_split_to_flatfield.collect()

    output:
    path 'capsule/results/*' into ch_flatfield_to_destripe
    path 'capsule/results/*' into ch_flatfield_to_dispatcher

    stub:
    """
    mkdir -p capsule/results
    touch capsule/results/flatfield_results.json
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_flatfield} \
        "${params.repo_flatfield}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Applying flats and correcting stripes
process preprocessing {
    tag 'preprocessing'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:${params.ver_preprocessing}"

    cpus 32
    memory '128 GB'
    time '12h'

    input:
    path 'capsule/data/' from ch_dataset_to_destripe_derivatives.collect()
    path 'capsule/data/' from ch_dataset_to_destripe_acquisition.collect()
    path 'capsule/data/' from ch_dataset_to_destripe_data_description.collect()
    path 'capsule/data/' from ch_dataset_to_destripe_images
    path 'capsule/data/' from ch_flatfield_to_destripe.collect()
    path 'capsule/data/' from ch_split_to_preprocessing.collect()

    output:
    path 'capsule/results/destriped_data/Ex_*_Em_*' into ch_destripe_to_stitch
    path 'capsule/results/destriped_data*' into ch_destripe_to_fuse
    path 'capsule/results/image_destriping_*.json' into ch_destripe_to_dispatcher

    stub:
    """
    mkdir -p capsule/results
    for channel in capsule/data/Ex_*_Em_*; do
        name=\$(basename "\$channel")
        mkdir -p "capsule/results/destriped_data/\$name"
        touch "capsule/results/image_destriping_\$name.json"
    done
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_preprocessing} \
        "${params.repo_preprocessing}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Image Stitching
process stitching {
    tag 'stitching'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-stitch:${params.ver_stitch}"

    env = [
        'CLASSPATH': '/home/BigStitcher-Spark/target/*:/home/n5-aws-s3/target/*'
    ]

    cpus 16
    memory '256 GB'
    time '6h'

    input:
    path 'capsule/data/' from ch_dataset_to_stitch_acquisition.collect()
    path 'capsule/data/' from ch_dataset_to_stitch_data_description.collect()
    path 'capsule/data/' from ch_dataset_to_stitch_manifest.collect()
    path 'capsule/data/preprocessed_data/' from ch_destripe_to_stitch.collect()

    output:
    path 'capsule/results/*' into ch_stitch_to_fuse
    path 'capsule/results/*' into ch_stitch_to_dispatcher

    stub:
    """
    mkdir -p capsule/results
    touch capsule/results/stitch_transforms.json
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    export HOME=/root

    # Mirrors the create_individual_zgroup capsule in the CodeOcean pipeline
    echo '{"zarr_format": 2}' > capsule/data/preprocessed_data/.zgroup

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_stitch} \
        "${params.repo_stitch}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Image Fusion
process fusion {
    tag 'fusion'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-fuse:${params.ver_fuse}"

    env = [
        'CLASSPATH': '/home/BigStitcher-Spark/target/*:/home/n5-aws-s3/target/*'
    ]

    cpus 16
    memory '128 GB'
    time '18h'

    input:
    path 'capsule/data/preprocessed_data' from ch_destripe_to_fuse.flatten()
    path 'capsule/data/' from ch_dataset_to_fuse_acquisition.collect()
    path 'capsule/data/' from ch_stitch_to_fuse.collect()

    output:
    path 'capsule/results/*' into ch_fuse_to_dispatcher
    path 'capsule/results/Ex_*_Em_*.zarr' into ch_fuse_to_quantification
    path 'capsule/results/Ex_*_Em_*.zarr' into ch_fuse_to_registration
    path 'capsule/results/Ex_*_Em_*.zarr' into ch_fuse_to_segmentation
    path 'capsule/results/Ex_*_Em_*.zarr' into ch_fuse_to_classification

    stub:
    """
    mkdir -p capsule/results
    for channel in capsule/data/preprocessed_data/Ex_*_Em_*; do
        name=\$(basename "\$channel")
        mkdir -p "capsule/results/\$name.zarr"
        touch "capsule/results/fusion_metadata_\$name.json"
    done
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    export HOME=/root

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_fuse} \
        "${params.repo_fuse}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Atlas CCF Registration
process atlas_registration {
    tag 'atlas-registration'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-registration:${params.ver_registration}"

    cpus 16
    memory '128 GB'
    time '4h'

    input:
    path 'capsule/data/' from ch_dataset_to_registration_manifest.collect()
    path 'capsule/data/' from ch_dataset_to_registration_acquisition.collect()
    path 'capsule/data/fused/' from ch_fuse_to_registration.collect()

    output:
    path 'capsule/results/*' into ch_registration_to_dispatcher
    path 'capsule/results/*' into ch_registration_to_quantification

    stub:
    """
    mkdir -p capsule/results
    touch capsule/results/ccf_registration_metadata.json
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    ln -s "${template_path}" "capsule/data/lightsheet_template_ccf_registration"

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_registration} \
        "${params.repo_registration}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Pipeline Dispatcher
process dispatcher {
    tag 'dispatcher'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:${params.ver_dispatch}"

    cpus 16
    memory '128 GB'
    time '12h'

    input:
    path 'capsule/data/input_aind_metadata/' from ch_dataset_to_dispatcher_metadata.collect()
    path 'capsule/data/' from ch_dataset_to_dispatcher_manifest.collect()
    path 'capsule/data/fused/' from ch_fuse_to_dispatcher.collect()
    path 'capsule/data/ccf_registration_results/' from ch_registration_to_dispatcher.collect()
    path 'capsule/data/' from ch_destripe_to_dispatcher.collect()
    path 'capsule/data/flatfield_estimation/' from ch_flatfield_to_dispatcher.collect()
    path 'capsule/data/stitched/' from ch_stitch_to_dispatcher.collect()

    output:
    path 'capsule/results/segmentation_processing_manifest_*.json' into ch_dispatcher_to_quantification_manifest
    path 'capsule/results/output_aind_metadata/data_description.json' into ch_dispatcher_to_quantification_description
    path 'capsule/results/output_aind_metadata/acquisition.json' into ch_dispatcher_to_quantification_acquisition
    path 'capsule/results/output_aind_metadata/data_description.json' into ch_dispatcher_to_segmentation_description
    path 'capsule/results/output_aind_metadata/acquisition.json' into ch_dispatcher_to_segmentation_acquisition
    path 'capsule/results/segmentation_processing_manifest_*.json' into ch_dispatcher_to_segmentation_manifest
    path 'capsule/results/output_aind_metadata/data_description.json' into ch_dispatcher_to_classification_description
    path 'capsule/results/output_aind_metadata/acquisition.json' into ch_dispatcher_to_classification_acquisition
    path 'capsule/results/modified_processing_manifest.json' into ch_dispatcher_to_final_manifest
    path 'capsule/results/output_aind_metadata/*.json' into ch_dispatcher_to_final_metadata

    stub:
    """
    mkdir -p capsule/results/output_aind_metadata
    for fused in capsule/data/fused/Ex_*_Em_*.zarr; do
        touch "capsule/results/segmentation_processing_manifest_\$(basename "\$fused" .zarr).json"
    done
    touch capsule/results/output_aind_metadata/data_description.json
    touch capsule/results/output_aind_metadata/acquisition.json
    touch capsule/results/output_aind_metadata/processing.json
    touch capsule/results/modified_processing_manifest.json
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_dispatch} \
        "${params.repo_dispatch}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run dispatch ${cloud} ${output_path}${dispatcher_extra_args}

    echo "[${task.tag}] completed!"
    """
}

// Cell proposal generation
process cell_proposals {
    tag 'cell-proposals'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:${params.ver_detection}"

    cpus 16
    memory '256 GB'
    time '12h'

    // To request gpu in slurm
    label 'gpu'

    input:
    path 'capsule/data/fused/' from ch_fuse_to_segmentation.collect()
    path 'capsule/data/' from ch_dispatcher_to_segmentation_description.collect()
    path 'capsule/data/' from ch_dispatcher_to_segmentation_manifest.flatten()
    path 'capsule/data/' from ch_dispatcher_to_segmentation_acquisition.collect()

    output:
    path 'capsule/results/*' into ch_segmentation_to_classification

    stub:
    """
    manifest=\$(basename capsule/data/segmentation_processing_manifest_*.json .json)
    mkdir -p "capsule/results/proposals_\${manifest#segmentation_processing_manifest_}"
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    echo "[${task.tag}] System info:"
    echo "Executor: ${task.executor}"
    echo "Container: ${task.container}"
    echo "Container options: ${task.containerOptions}"

    echo "[${task.tag}] GPU check:"
    which nvidia-smi && nvidia-smi || echo "nvidia-smi not found"

    echo "[${task.tag}] CUDA check:"
    python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')" || echo "PyTorch not available"

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_detection} \
        "${params.repo_detection}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run_slurm
    ./run_slurm

    echo "[${task.tag}] completed!"
    """
}

// Cell classification from proposals
process cell_classification {
    tag 'cell-classification'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:${params.ver_classification}"

    cpus 16
    memory '128 GB'
    time '24h'

    // To request gpu in slurm
    label 'gpu'

    input:
    path 'capsule/data/' from ch_dispatcher_to_classification_description.collect()
    path 'capsule/data/' from ch_dispatcher_to_classification_acquisition.collect()
    path 'capsule/data/smartspim_production_models' from ch_models_to_classification.collect()
    path 'capsule/data/fused/' from ch_fuse_to_classification.collect()
    path 'capsule/data/' from ch_segmentation_to_classification

    output:
    path 'capsule/results/*' into ch_classification_to_quantification
    path 'capsule/results/*' into ch_classification_to_final

    stub:
    """
    mkdir -p capsule/results
    for proposals in capsule/data/proposals_*; do
        mkdir -p "capsule/results/cell_\${proposals##*/proposals_}"
    done
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_classification} \
        "${params.repo_classification}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run_slurm
    ./run_slurm

    echo "[${task.tag}] completed!"
    """
}

// Cell quantification -> mapping cells to CCF
process cell_quantification {
    tag 'cell-quantification'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:${params.ver_quantification}"

    cpus 16
    memory '128 GB'
    time '18h'

    input:
    path 'capsule/data/fused/' from ch_fuse_to_quantification.collect()
    path 'capsule/data/' from ch_classification_to_quantification.collect()
    path 'capsule/data/' from ch_dispatcher_to_quantification_manifest.flatten()
    path 'capsule/data/' from ch_dispatcher_to_quantification_description.collect()
    path 'capsule/data/' from ch_dispatcher_to_quantification_acquisition.collect()
    path 'capsule/data/' from ch_registration_to_quantification.collect()

    output:
    path 'capsule/results/*' into ch_quantification_to_final

    stub:
    """
    manifest=\$(basename capsule/data/segmentation_processing_manifest_*.json .json)
    mkdir -p "capsule/results/quant_\${manifest#segmentation_processing_manifest_}"
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    ln -s "${template_path}" "capsule/data/lightsheet_template_ccf_registration"

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_quantification} \
        "${params.repo_quantification}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run detect ${output_path}

    echo "[${task.tag}] completed!"
    """
}

// Cleaning up
process clean_up {
    tag 'clean-up'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:${params.ver_dispatch}"

    cpus 16
    memory '64 GB'
    time '24h'

    publishDir "${params.results_path}", saveAs: { filename -> new File(filename).getName() }

    input:
    path 'capsule/data/' from ch_dispatcher_to_final_manifest.collect()
    path 'capsule/data/input_aind_metadata/' from ch_dispatcher_to_final_metadata.collect()
    path 'capsule/data/' from ch_classification_to_final.collect()
    path 'capsule/data/' from ch_quantification_to_final.collect()

    output:
    path 'capsule/results/*'

    stub:
    """
    mkdir -p capsule/results
    touch capsule/results/processing.json
    """

    script:
    """
    #!/usr/bin/env bash
    set -e

    mkdir -p capsule
    mkdir -p capsule/data
    mkdir -p capsule/results
    mkdir -p capsule/scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ref_dispatch} \
        "${params.repo_dispatch}" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run clean ${cloud} ${output_path}${dispatcher_extra_args}

    echo "[${task.tag}] completed!"
    """
}
