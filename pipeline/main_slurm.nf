#!/usr/bin/env nextflow
"""
Nextflow Script: SmartSPIM Pipeline

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

// Channels from dataset to validation capsule -> PNG validation
dataset_to_validation = channel.fromPath(params.lightsheet_dataset + "/", type: 'any')

// Channels from dataset to preprocessing capsule
dataset_to_preprocessing_imgs = channel.fromPath(params.lightsheet_dataset + "/SmartSPIM/Ex_*_Em_*", type: 'any')
dataset_to_preprocessing_data_description = channel.fromPath(params.lightsheet_dataset + "/data_description.json", type: 'any')
dataset_to_preprocessing_manifest = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
dataset_to_preprocessing_derivatives = channel.fromPath(params.lightsheet_dataset + "/derivatives", type: 'any')

// Channels from validation to preprocessing capsule
validation_to_preprocessing = channel.create()

// Channels from dataset to stitching
dataset_to_stitch_manifest = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
dataset_to_stitch_data_description = channel.fromPath(params.lightsheet_dataset + "/data_description.json", type: 'any')
dataset_to_stitch_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')

// Channels from preprocessing to stitching
preprocessing_to_stitch = channel.create()

// Channels from dataset to fusion
dataset_to_fuse_manifest = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
dataset_to_fuse_data_description = channel.fromPath(params.lightsheet_dataset + "/data_description.json", type: 'any')
dataset_to_fuse_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')

// Channels from preprocessing to fusion
preprocessing_to_fuse = channel.create()

// Channels from stiching to fusion
stitch_to_fuse = channel.create()

// Channels from fusion to CCF registration
fuse_to_registration = channel.create()

// Channels from fusion to cell detection
fuse_to_cell_detect = channel.create()

// channels from fusion to quantification
fuse_to_quantification = channel.create()

// Channels from dataset to registration
dataset_to_registration_manifest = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
dataset_to_registration_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')

// Channels from preprocessing to dispatcher
preprocessing_to_dispatch_1 = channel.create()
preprocessing_to_dispatch_2 = channel.create()

// Channels from stitching to dispatcher
stitch_to_dispatch = channel.create()

// Channels from fusion to dispatcher
fuse_to_dispatch = channel.create()

// Channels from registration to dispatcher
registration_to_dispatcher = channel.create()

// Channels from dataset to dispatcher
dataset_to_dispatch_metadata = channel.fromPath(params.lightsheet_dataset + "/*.json", type: 'any')
dataset_to_dispatch_manifest = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')

// Channels from dispatcher to cell detection
dispatch_to_cell_detect_manifests = channel.create()
dispatch_to_cell_detect_data_description = channel.create()

// Channels from dispatch to cell quantification
dispatcher_to_quantification_manifests = channel.create()
dispatcher_to_quantification_data_description = channel.create()
dispatcher_to_quantification_acquisition = channel.create()

// Channels from fusion to classification
fusion_to_classification = channel.create()

// Channels from registration to quantification
registration_to_quantification = channel.create()

// Channels from cell detection to cell classification
cell_detect_to_classification = channel.create()

// Channels from classification to quantification
classification_to_quantification = channel.create()

// Dispatch outputs
dispatch_to_dispatch_processing_json_output = channel.create()
dispatch_to_dispatch_mod_manifest_output = channel.create()
dispatch_to_dispatch_data_description_output = channel.create()

// Channels from cell classification to dispatcher
classification_to_dispatch = channel.create()

// Channels from quantification to dispatcher
quantification_to_dispatcher = channel.create()

// Channels from dispatcher to classification
dispatch_to_classification = channel.create()

// capsule - aind-smartspim-validation -> Only for PNGs
process data_validation {
	tag 'data-validation'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-validation:si-0.0.1"

	cpus 8
	memory '64 GB'
	time '1h'

	input:
	path 'capsule/data' from dataset_to_validation.collect()

	output:
	path 'capsule/results/*' into validation_to_preprocessing

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://github.com/AllenNeuralDynamics/aind-smartspim-validation.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-destripe-shadow-correction
process preprocessing {
	tag 'preprocessing'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:si-0.0.3"

	cpus 32
	memory '128 GB'
	time '12h'

	input:
	path 'capsule/data/' from dataset_to_preprocessing_imgs
	path 'capsule/data/' from dataset_to_preprocessing_data_description.collect()
	path 'capsule/data/' from dataset_to_preprocessing_manifest.collect()
	path 'capsule/data/' from dataset_to_preprocessing_derivatives.collect()
	path 'capsule/data/' from validation_to_preprocessing.collect()

	output:
	path 'capsule/results/Ex_*_Em_*' into preprocessing_to_stitch
	path 'capsule/results/Ex_*_Em_*' into preprocessing_to_fuse
	path 'capsule/results/image_destriping_*_processing.json' into preprocessing_to_dispatch_1
	path 'capsule/results/flatfield_correction_*' into preprocessing_to_dispatch_2

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

// capsule - aind-smartspim-stitch
process stitching {
	tag 'stitching'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-stitch:si-1.2.4"

	cpus 32
	memory '256 GB'
	time '6h'

	input:
	path 'capsule/data/' from dataset_to_stitch_manifest.collect()
	path 'capsule/data/' from dataset_to_stitch_data_description.collect()
	path 'capsule/data/' from dataset_to_stitch_acquisition.collect()
	path 'capsule/data/' from preprocessing_to_stitch.collect()

	output:
	path 'capsule/results/volume_alignments.xml' into stitch_to_fuse
	path 'capsule/results/stitch_*' into stitch_to_dispatch

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://github.com/AllenNeuralDynamics/aind-smartspim-stitch.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-fuse
process fusion {
	tag 'fusion'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-fuse:si-0.0.1"

	cpus 32
	memory '256 GB'
	time '18h'

	input:
	path 'capsule/data/' from dataset_to_fuse_manifest.collect()
	path 'capsule/data/' from dataset_to_fuse_data_description.collect()
	path 'capsule/data/' from dataset_to_fuse_acquisition.collect()
	path 'capsule/data/' from preprocessing_to_fuse.flatten()
	path 'capsule/data/' from stitch_to_fuse.collect()

	output:
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into fuse_to_registration
	path 'capsule/results/fusion_*' into fuse_to_dispatch
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into fuse_to_cell_detect
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into fuse_to_quantification
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into fusion_to_classification

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://github.com/AllenNeuralDynamics/aind-smartspim-fuse.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-ccf-registration
process atlas_registration {
	tag 'atlas-registration'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-registration:si-0.0.24"

	cpus 16
	memory '128 GB'
	time '3h'

	input:
	path 'capsule/data/fused/' from fuse_to_registration.collect()
	path 'capsule/data/' from dataset_to_registration_manifest.collect()
	path 'capsule/data/' from dataset_to_registration_acquisition.collect()

	output:
	path 'capsule/results/*' into registration_to_dispatcher
	path 'capsule/results/*' into registration_to_quantification

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
	git clone "https://github.com/AllenNeuralDynamics/aind-ccf-registration.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher
process dispatcher {
	tag 'dispatcher'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:si-0.0.1"

	cpus 16
	memory '128 GB'
	time '12h'

	input:
	path 'capsule/data/' from preprocessing_to_dispatch_1.collect()
	path 'capsule/data/' from preprocessing_to_dispatch_2.collect()
	path 'capsule/data/ccf_registration_results/' from registration_to_dispatcher.collect()
	path 'capsule/data/fused/' from fuse_to_dispatch.collect()
	path 'capsule/data/input_aind_metadata/' from dataset_to_dispatch_metadata.collect()
	path 'capsule/data/' from dataset_to_dispatch_manifest.collect()
	path 'capsule/data/stitched/' from stitch_to_dispatch.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into dispatch_to_cell_detect_manifests
	path 'capsule/results/output_aind_metadata/data_description.json' into dispatch_to_cell_detect_data_description
	path 'capsule/results/segmentation_processing_manifest_*.json' into dispatcher_to_quantification_manifests
	path 'capsule/results/output_aind_metadata/data_description.json' into dispatcher_to_quantification_data_description
	path 'capsule/results/output_aind_metadata/acquisition.json' into dispatcher_to_quantification_acquisition
	path 'capsule/results/output_aind_metadata/processing.json' into dispatch_to_dispatch_processing_json_output
	path 'capsule/results/modified_processing_manifest.json' into dispatch_to_dispatch_mod_manifest_output
	path 'capsule/results/output_aind_metadata/data_description.json' into dispatch_to_dispatch_data_description_output
	path 'capsule/results/output_aind_metadata/data_description.json' into dispatch_to_classification

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://github.com/AllenNeuralDynamics/aind-smartspim-external-dispatcher.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run dispatch ${cloud} ${output_path}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-segmentation
process cell_detection {
	tag 'cell-detection'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:si-0.0.6"

	cpus 16
	memory '256 GB'
	time '12h'

	input:
	path 'capsule/data/fused/' from fuse_to_cell_detect.collect()
	path 'capsule/data/' from dispatch_to_cell_detect_manifests.flatten()
	path 'capsule/data/' from dispatch_to_cell_detect_data_description.collect()

	output:
	path 'capsule/results/*' into cell_detect_to_classification

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://github.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-classification
process cell_classification {
	tag 'cell-classification'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:si-0.0.2"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'
	time '24h'

	input:
	path 'capsule/data/' from cell_detect_to_classification
	path 'capsule/data/fused/' from fusion_to_classification.collect()
	path 'capsule/data/' from dispatch_to_classification.collect()

	output:
	path 'capsule/results/*' into classification_to_quantification
	path 'capsule/results/*' into classification_to_dispatch

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	ln -s "${cell_detection_model}" "capsule/data/smartspim_18_model"

	echo "[${task.tag}] cloning git repo..."
	git clone "https://github.com/AllenNeuralDynamics/aind-smartspim-classification.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - reprocess-aind-smartspim-cell-quantification
process cell_quantification {
	tag 'cell-quantification'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:si-0.0.2"

	cpus 16
	memory '128 GB'
	time '18h'

	input:
	path 'capsule/data/' from classification_to_quantification.collect()
	path 'capsule/data/' from dispatcher_to_quantification_manifests.flatten()
	path 'capsule/data/' from dispatcher_to_quantification_data_description.collect()
	path 'capsule/data/' from dispatcher_to_quantification_acquisition.collect()
	path 'capsule/data/fused/' from fuse_to_quantification.collect()
	path 'capsule/data/' from registration_to_quantification.collect()

	output:
	path 'capsule/results/*' into quantification_to_dispatcher

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
	git clone "https://github.com/AllenNeuralDynamics/aind-smartspim-quantification.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run detect

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher
process clean_up {
	tag 'clean-up'
	container "ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:si-0.0.1"

	cpus 16
	memory '128 GB'
	time '24h'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/output_aind_metadata/' from dispatch_to_dispatch_processing_json_output.collect()
	path 'capsule/data/' from dispatch_to_dispatch_mod_manifest_output.collect()
	path 'capsule/data/input_aind_metadata/' from dispatch_to_dispatch_data_description_output.collect()
	path 'capsule/data/' from classification_to_dispatch.collect()
	path 'capsule/data/' from quantification_to_dispatcher.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	mkdir -p capsule
	mkdir -p capsule/data
	mkdir -p capsule/results
	mkdir -p capsule/scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://github.com/AllenNeuralDynamics/aind-smartspim-external-dispatcher.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean ${cloud} ${output_path}

	echo "[${task.tag}] completed!"
	"""
}
