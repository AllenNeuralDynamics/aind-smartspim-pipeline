#!/usr/bin/env nextflow
"""
Nextflow Script: SmartSPIM Pipeline

Note: This pipeline works with ome.zarr files.

This script executes the SmartSPIM pipeline, performing the following operations:
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

// ---------------------------------------------------------------------------
// Capsule release versions — keep these in sync with environment/versions.env.
// Update both files together when releasing a new pipeline version.
// ---------------------------------------------------------------------------
params.ver_flatfield      = "si-0.0.4"
params.ver_preprocessing  = "si-0.0.4"
params.ver_stitch         = "si-1.2.9"
params.ver_fuse           = "si-0.0.4"
params.ver_registration   = "si-0.0.31"
params.ver_dispatch       = "si-1.0.1"
params.ver_detection      = "si-1.0.0"
params.ver_classification = "si-0.0.6"
params.ver_quantification = "si-1.6.1"

params.lightsheet_dataset = DATA_PATH

println "DATA_PATH: ${DATA_PATH}"
println "RESULTS_PATH: ${RESULTS_PATH}"
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

// Input Channels - Organized by data source and target process
// Dataset to Destripe process
ch_dataset_to_destripe_derivatives = channel.fromPath(params.lightsheet_dataset + "/SPIM/derivatives", type: 'any')
ch_dataset_to_destripe_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')
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
ch_dispatcher_to_final_processing = channel.create()
ch_dispatcher_to_final_manifest = channel.create()
ch_dispatcher_to_final_description = channel.create()

// Classification -> Quantification
ch_classification_to_quantification = channel.create()

// Classification -> Final Dispatcher
ch_classification_to_final = channel.create()

// Segmentation -> Classification
ch_segmentation_to_classification = channel.create()

// Quantification -> Final Dispatcher
ch_quantification_to_final = channel.create()

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
    git clone --depth 1 --branch ${params.ver_flatfield} \
        "https://github.com/AllenNeuralDynamics/aind-smartspim-flatfield-estimation.git" capsule-repo
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
    path 'capsule/data/' from ch_dataset_to_destripe_images
    path 'capsule/data/' from ch_flatfield_to_destripe.collect()

    output:
    path 'capsule/results/destriped_data/Ex_*_Em_*' into ch_destripe_to_stitch
    path 'capsule/results/destriped_data*' into ch_destripe_to_fuse
    path 'capsule/results/image_destriping_*.json' into ch_destripe_to_dispatcher

    stub:
    """
    mkdir -p capsule/results/destriped_data/Ex_488_Em_525
    touch capsule/results/image_destriping_stub.json
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
    git clone --depth 1 --branch ${params.ver_preprocessing} \
        "https://github.com/AllenNeuralDynamics/aind-smartspim-destripe.git" capsule-repo
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

    echo "[${task.tag}] cloning git repo..."
    git clone --depth 1 --branch ${params.ver_stitch} \
        "https://github.com/AllenNeuralDynamics/aind-smartspim-stitch.git" capsule-repo
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
    mkdir -p capsule/results/Ex_488_Em_525.zarr
    touch capsule/results/fusion_metadata.json
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
    git clone --depth 1 --branch ${params.ver_fuse} \
        "https://github.com/AllenNeuralDynamics/aind-smartspim-fuse.git" capsule-repo
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
    git clone --depth 1 --branch ${params.ver_registration} \
        "https://github.com/AllenNeuralDynamics/aind-ccf-registration.git" capsule-repo
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
    path 'capsule/results/output_aind_metadata/processing.json' into ch_dispatcher_to_final_processing
    path 'capsule/results/modified_processing_manifest.json' into ch_dispatcher_to_final_manifest
    path 'capsule/results/output_aind_metadata/data_description.json' into ch_dispatcher_to_final_description

    stub:
    """
    mkdir -p capsule/results/output_aind_metadata
    touch capsule/results/segmentation_processing_manifest_stub.json
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
    git clone --depth 1 --branch ${params.ver_dispatch} \
        "https://github.com/AllenNeuralDynamics/aind-smartspim-external-dispatcher.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run dispatch ${cloud} ${output_path}

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
    mkdir -p capsule/results
    touch capsule/results/cell_proposals_stub.xml
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
    git clone --depth 1 --branch ${params.ver_detection} \
        "https://github.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation.git" capsule-repo
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
    touch capsule/results/classified_cells_stub.csv
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
    git clone --depth 1 --branch ${params.ver_classification} \
        "https://github.com/AllenNeuralDynamics/aind-smartspim-classification.git" capsule-repo
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
    mkdir -p capsule/results
    touch capsule/results/cell_quantification_stub.csv
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
    git clone --depth 1 --branch ${params.ver_quantification} \
        "https://github.com/AllenNeuralDynamics/aind-smartspim-quantification.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run detect

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

    publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

    input:
    path 'capsule/data/input_aind_metadata/' from ch_dispatcher_to_final_processing.collect()
    path 'capsule/data/' from ch_dispatcher_to_final_manifest.collect()
    path 'capsule/data/input_aind_metadata/' from ch_dispatcher_to_final_description.collect()
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
    git clone --depth 1 --branch ${params.ver_dispatch} \
        "https://github.com/AllenNeuralDynamics/aind-smartspim-external-dispatcher.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run clean ${cloud} ${output_path}

    echo "[${task.tag}] completed!"
    """
}
