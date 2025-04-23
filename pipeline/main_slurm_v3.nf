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
Date: Nov 1st, 2024.
"""

nextflow.enable.dsl = 1

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

// Ensure cell_detection_model is provided
if (!params_keys.contains('cell_detection_model')) {
    exit 1, "Error: Missing SmartSPIM cell detection model"
}
cell_detection_model = params.cell_detection_model

println "Output path: ${output_path}"
println "Cell detection model: ${cell_detection_model}"
println "Using cloud: ${cloud}"

params.lightsheet_dataset = 's3://aind-scratch-data/smartspim_dataset'
params.smartspim_production_models_url = 's3://aind-benchmark-data/mesoscale-anatomy-cell-detection/models/smartspim_production_models'

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
ch_models_to_classification = channel.fromPath(params.smartspim_production_models_url + "/", type: 'any')

// Inter-process channels (organized by source → target)
// Flatfield → Destripe
ch_flatfield_to_destripe = channel.create()

// Destripe → Stitch
ch_destripe_to_stitch = channel.create()

// Destripe → Fuse
ch_destripe_to_fuse = channel.create()

// Destripe → Dispatcher
ch_destripe_to_dispatcher = channel.create()

// Stitch → Fuse
ch_stitch_to_fuse = channel.create()

// Stitch → Dispatcher
ch_stitch_to_dispatcher = channel.create()

// Fuse → Dispatcher
ch_fuse_to_dispatcher = channel.create()

// Fuse → Quantification
ch_fuse_to_quantification = channel.create()

// Fuse → Registration
ch_fuse_to_registration = channel.create()

// Fuse → Segmentation
ch_fuse_to_segmentation = channel.create()

// Fuse → Classification
ch_fuse_to_classification = channel.create()

// Flatfield → Dispatcher
ch_flatfield_to_dispatcher = channel.create()

// Registration → Dispatcher
ch_registration_to_dispatcher = channel.create()

// Registration → Quantification
ch_registration_to_quantification = channel.create()

// Dispatcher → Quantification (multiple files)
ch_dispatcher_to_quantification_manifest = channel.create()
ch_dispatcher_to_quantification_description = channel.create()
ch_dispatcher_to_quantification_acquisition = channel.create()

// Dispatcher → Segmentation
ch_dispatcher_to_segmentation_description = channel.create()
ch_dispatcher_to_segmentation_manifest = channel.create()

// Dispatcher → Classification
ch_dispatcher_to_classification_description = channel.create()
ch_dispatcher_to_classification_acquisition = channel.create()

// Dispatcher → Final Dispatcher
ch_dispatcher_to_final_processing = channel.create()
ch_dispatcher_to_final_manifest = channel.create()
ch_dispatcher_to_final_description = channel.create()

// Classification → Quantification
ch_classification_to_quantification = channel.create()

// Classification → Final Dispatcher
ch_classification_to_final = channel.create()

// Segmentation → Classification
ch_segmentation_to_classification = channel.create()

// Quantification → Final Dispatcher
ch_quantification_to_final = channel.create()

// Process 1: Destripe and Shadow Correction (v0.0.4)
process preprocessing {
    tag 'capsule-4725614'
    container "ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:si-0.0.4"

    cpus 32
    memory '128 GB'

    input:
    path 'capsule/data/' from ch_dataset_to_destripe_derivatives.collect()
    path 'capsule/data/' from ch_dataset_to_destripe_acquisition.collect()
    path 'capsule/data/' from ch_dataset_to_destripe_images
    path 'capsule/data/' from ch_flatfield_to_destripe.collect()

    output:
    path 'capsule/results/destriped_data/Ex_*_Em_*' into ch_destripe_to_stitch
    path 'capsule/results/destriped_data*' into ch_destripe_to_fuse
    path 'capsule/results/image_destriping_*.json' into ch_destripe_to_dispatcher

    script:
    """
    #!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

    echo "[${task.tag}] cloning git repo..."
    git clone "https://github.com/AllenNeuralDynamics/aind-smartspim-destripe.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Process 2: Image Stitching (v1.2.6)
process stitching {
    tag 'capsule-2124819'
    container "$REGISTRY_HOST/published/4c04ae91-ff3e-453b-b95f-e26970fc1350:v2"

    cpus 16
    memory '128 GB'

    input:
    path 'capsule/data/' from ch_dataset_to_stitch_acquisition.collect()
    path 'capsule/data/' from ch_dataset_to_stitch_data_description.collect()
    path 'capsule/data/' from ch_dataset_to_stitch_manifest.collect()
    path 'capsule/data/preprocessed_data/' from ch_destripe_to_stitch.collect()

    output:
    path 'capsule/results/*' into ch_stitch_to_fuse
    path 'capsule/results/*' into ch_stitch_to_dispatcher

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=4c04ae91-ff3e-453b-b95f-e26970fc1350
    export CO_CPUS=16
    export CO_MEMORY=137438953472

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2124819.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Process 3: Image Fusion (v0.0.2)
process process_fuse_v002 {
    tag 'capsule-0248143'
    container "$REGISTRY_HOST/published/10d08e17-f8a0-4c33-8610-40f8eeaef236:v1"

    cpus 16
    memory '128 GB'
    accelerator 1
    label 'gpu'

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

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=10d08e17-f8a0-4c33-8610-40f8eeaef236
    export CO_CPUS=16
    export CO_MEMORY=137438953472

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0248143.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Process 4: Flatfield Estimation
process process_flatfield {
    tag 'capsule-2734547'
    container "$REGISTRY_HOST/published/94d2cbcc-55b3-41fb-9686-9ccc1d3601b1:v1"

    cpus 16
    memory '128 GB'

    input:
    path 'capsule/data/' from ch_dataset_to_flatfield_metadata.collect()
    path 'capsule/data/' from ch_dataset_to_flatfield_images.collect()
    path 'capsule/data/' from ch_dataset_to_flatfield_data_description.collect()

    output:
    path 'capsule/results/*' into ch_flatfield_to_destripe
    path 'capsule/results/*' into ch_flatfield_to_dispatcher

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=94d2cbcc-55b3-41fb-9686-9ccc1d3601b1
    export CO_CPUS=16
    export CO_MEMORY=137438953472

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2734547.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Process 5: Pipeline Dispatcher (v1.0.1)
process process_dispatcher_v101 {
    tag 'capsule-9560554'
    container "$REGISTRY_HOST/published/aaf91c8f-c0a2-413d-8e1e-f9e263df1b32:v3"

    cpus 16
    memory '128 GB'

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
    path 'capsule/results/segmentation_processing_manifest_*.json' into ch_dispatcher_to_segmentation_manifest
    path 'capsule/results/output_aind_metadata/data_description.json' into ch_dispatcher_to_classification_description
    path 'capsule/results/output_aind_metadata/acquisition.json' into ch_dispatcher_to_classification_acquisition
    path 'capsule/results/output_aind_metadata/processing.json' into ch_dispatcher_to_final_processing
    path 'capsule/results/modified_processing_manifest.json' into ch_dispatcher_to_final_manifest
    path 'capsule/results/output_aind_metadata/data_description.json' into ch_dispatcher_to_final_description

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=aaf91c8f-c0a2-413d-8e1e-f9e263df1b32
    export CO_CPUS=16
    export CO_MEMORY=137438953472

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9560554.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run dispatch

    echo "[${task.tag}] completed!"
    """
}

// Process 6: Cell Quantification (v1.6.1)
process process_cell_quantification_v161 {
    tag 'capsule-2107437'
    container "$REGISTRY_HOST/published/b895947f-db4f-4025-adb4-a1a04b7f1587:v3"

    cpus 16
    memory '128 GB'

    input:
    path 'capsule/data/fused/' from ch_fuse_to_quantification.collect()
    path 'capsule/data/' from ch_classification_to_quantification.collect()
    path 'capsule/data/' from ch_dispatcher_to_quantification_manifest.flatten()
    path 'capsule/data/' from ch_dispatcher_to_quantification_description.collect()
    path 'capsule/data/' from ch_dispatcher_to_quantification_acquisition.collect()
    path 'capsule/data/' from ch_registration_to_quantification.collect()

    output:
    path 'capsule/results/*' into ch_quantification_to_final

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=b895947f-db4f-4025-adb4-a1a04b7f1587
    export CO_CPUS=16
    export CO_MEMORY=137438953472

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    ln -s "/tmp/data/lightsheet_template_ccf_registration" "capsule/data/lightsheet_template_ccf_registration" # id: 9be4e3ac-adfb-4335-824c-bd99364a2c0f

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2107437.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run detect

    echo "[${task.tag}] completed!"
    """
}

// Process 7: CCF Registration (v0.0.30)
process process_ccf_registration_v030 {
    tag 'capsule-8584302'
    container "$REGISTRY_HOST/published/d61333f3-fd41-464e-9dac-dbdad02aec54:v6"

    cpus 16
    memory '128 GB'

    input:
    path 'capsule/data/' from ch_dataset_to_registration_manifest.collect()
    path 'capsule/data/' from ch_dataset_to_registration_acquisition.collect()
    path 'capsule/data/fused/' from ch_fuse_to_registration.collect()

    output:
    path 'capsule/results/*' into ch_registration_to_dispatcher
    path 'capsule/results/*' into ch_registration_to_quantification

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=d61333f3-fd41-464e-9dac-dbdad02aec54
    export CO_CPUS=16
    export CO_MEMORY=137438953472

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    ln -s "/tmp/data/lightsheet_template_ccf_registration" "capsule/data/lightsheet_template_ccf_registration" # id: 9be4e3ac-adfb-4335-824c-bd99364a2c0f

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v6.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8584302.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Process 8: Cell Segmentation (v0.0.9)
process process_cell_segmentation_v009 {
    tag 'capsule-5009831'
    container "$REGISTRY_HOST/published/0d01bdb8-e530-40b8-8311-883814bde142:v5"

    cpus 16
    memory '256 GB'

    input:
    path 'capsule/data/fused/' from ch_fuse_to_segmentation.collect()
    path 'capsule/data/' from ch_dispatcher_to_segmentation_description.collect()
    path 'capsule/data/' from ch_dispatcher_to_segmentation_manifest.flatten()

    output:
    path 'capsule/results/*' into ch_segmentation_to_classification

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=0d01bdb8-e530-40b8-8311-883814bde142
    export CO_CPUS=16
    export CO_MEMORY=274877906944

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5009831.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Process 9: Cell Classification (v0.0.6)
process process_classification_v006 {
    tag 'capsule-4355840'
    container "$REGISTRY_HOST/published/eab3673c-2c7f-488b-82b9-75dbfdddcb53:v4"

    cpus 16
    memory '128 GB'
    accelerator 1
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

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=eab3673c-2c7f-488b-82b9-75dbfdddcb53
    export CO_CPUS=16
    export CO_MEMORY=137438953472

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4355840.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run

    echo "[${task.tag}] completed!"
    """
}

// Process 10: Final Pipeline Dispatcher (v1.0.1)
process process_final_dispatcher_v101 {
    tag 'capsule-9560554'
    container "$REGISTRY_HOST/published/aaf91c8f-c0a2-413d-8e1e-f9e263df1b32:v3"

    cpus 16
    memory '64 GB'

    publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

    input:
    path 'capsule/data/input_aind_metadata/' from ch_dispatcher_to_final_processing.collect()
    path 'capsule/data/' from ch_dispatcher_to_final_manifest.collect()
    path 'capsule/data/input_aind_metadata/' from ch_dispatcher_to_final_description.collect()
    path 'capsule/data/' from ch_classification_to_final.collect()
    path 'capsule/data/' from ch_quantification_to_final.collect()

    output:
    path 'capsule/results/*'

    script:
    """
    #!/usr/bin/env bash
    set -e

    export CO_CAPSULE_ID=aaf91c8f-c0a2-413d-8e1e-f9e263df1b32
    export CO_CPUS=16
    export CO_MEMORY=68719476736

    mkdir -p capsule
    mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
    mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
    mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

    echo "[${task.tag}] cloning git repo..."
    git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9560554.git" capsule-repo
    mv capsule-repo/code capsule/code
    rm -rf capsule-repo

    echo "[${task.tag}] running capsule..."
    cd capsule/code
    chmod +x run
    ./run clean

    echo "[${task.tag}] completed!"
    """
}