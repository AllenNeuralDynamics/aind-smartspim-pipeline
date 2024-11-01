#!/usr/bin/env nextflow
"""
Nextflow script to execute the SmartSPIM pipeline. This script executes
the following steps:
- Retrospective flatfield correction
- Image horizontal destriping
- Flatfield correction
- Image stitching
- Image fusion
- Image atlas registration to the CCF Allen v3 atlas
- Image cell detection
- Image cell quantification

Parameters
----------

DATA_PATH: str
    Path where the dataset is located.

RESULTS_PATH: str
    Path where the results folder is located.

PARAMS: dict
    Parameters provided to the smartspim pipeline.
"""
nextflow.enable.dsl = 1

params.lightsheet_dataset = DATA_PATH

println "DATA_PATH: ${DATA_PATH}"
println "RESULTS_PATH: ${RESULTS_PATH}"
println "PARAMS: ${params}"

params_keys = params.keySet()

// set cloud copy
if ("cloud" in params_keys) {
	cloud = params.cloud
}
else
{
	cloud = "false"
}
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

// Channels from dataset to registration
dataset_to_registration_manifest = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
dataset_to_registration_acquisition = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')

// Channels from preprocessing to dispatcher
preprocessing_to_dispatch_1 = channel.create()
preprocessing_to_dispatch_2 = channel.create()

// Channels from registration to dispatcher
registration_to_dispatcher = channel.create()

// Channels from fusion to dispatcher
fuse_to_dispatch = channel.create()

// Channels from dataset to dispatcher
dataset_to_dispatch_metadata = channel.fromPath(params.lightsheet_dataset + "/*.json", type: 'any')
dataset_to_dispatch_manifest = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')

// Channels from stitching to dispatcher
stitch_to_dispatch = channel.create()

// Channels from fusion to cell detection
fuse_to_cell_detect = channel.create()

// channels from fusion to quantification
fuse_to_quantification = channel.create()

// Channels from dispatcher to cell detection
dispatch_to_cell_detect_1 = channel.create()
dispatch_to_cell_detect_2 = channel.create()


// Channels from classification to quantification
classification_to_quantification = channel.create()

// Channels from dispatch to cell quantification
dispatcher_to_quantification_manifests = channel.create()
dispatcher_to_quantification_data_description = channel.create()
dispatcher_to_quantification_acquisition = channel.create()

// Channels from registration to quantification
registration_to_quantification = channel.create()

// Dispatch outputs
dispatch_to_dispatch_processing_json_output = channel.create()
dispatch_to_dispatch_mod_manifest_output = channel.create()
dispatch_to_dispatch_data_description_output = channel.create()

// Channels from cell classification to dispatcher
classification_to_dispatch = channel.create()

// Channels from quantification to dispatcher
quantification_to_dispatcher = channel.create()

// Channels from cell detection to cell classification
cell_detect_to_classification = channel.create()

// Channels from usion to classification
fusion_to_classification = channel.create()

// Channels from dispatcher to classification
dispatch_to_classification = channel.create()

// capsule - aind-smartspim-validation
process capsule_aind_smartspim_validation_1 {
	tag 'capsule-7794579'
	container "$REGISTRY_HOST/published/9aab765d-b4b5-4e11-84fa-27557bc3c043:v4"

	cpus 8
	memory '64 GB'

	input:
	path 'capsule/data' from dataset_to_validation.collect()

	output:
	path 'capsule/results/*' into validation_to_preprocessing

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9aab765d-b4b5-4e11-84fa-27557bc3c043
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7794579.git" capsule-repo
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
process capsule_aind_destripe_shadow_correction_2 {
	tag 'capsule-3325535'
	container "$REGISTRY_HOST/capsule/fcca3922-bc11-430e-9c63-faa7575af52d"

	cpus 32
	memory '128 GB'

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

	export CO_CAPSULE_ID=fcca3922-bc11-430e-9c63-faa7575af52d
	export CO_CPUS=32
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3325535.git" capsule-repo
	git -C capsule-repo checkout e3b30f1f86c289220b38424719345386cc7f7b80 --quiet
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
process capsule_aind_smartspim_stitch_3 {
	tag 'capsule-4153248'
	container "$REGISTRY_HOST/capsule/1c4065c1-93e6-4bfc-af9d-7c6f4eea7e63"

	cpus 32
	memory '256 GB'

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

	export CO_CAPSULE_ID=1c4065c1-93e6-4bfc-af9d-7c6f4eea7e63
	export CO_CPUS=32
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4153248.git" capsule-repo
	git -C capsule-repo checkout b7a2944938248e53653e81d47fa99657b71bfc02 --quiet
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
process capsule_aind_smartspim_fuse_4 {
	tag 'capsule-2013512'
	container "$REGISTRY_HOST/capsule/96191619-86f4-4f28-85c7-4f992fc4b30c"

	cpus 32
	memory '256 GB'

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

	export CO_CAPSULE_ID=96191619-86f4-4f28-85c7-4f992fc4b30c
	export CO_CPUS=32
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2013512.git" capsule-repo
	git -C capsule-repo checkout 52afeaa036a9a788f9e048e88d29742ae845bb4b --quiet
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
process capsule_aind_smartspim_ccf_registration_5 {
	tag 'capsule-6045222'
	container "$REGISTRY_HOST/capsule/30b4f986-4d55-452f-aae7-463e19dba67d"

	cpus 16
	memory '128 GB'

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

	export CO_CAPSULE_ID=30b4f986-4d55-452f-aae7-463e19dba67d
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/lightsheet_template_ccf_registration" "capsule/data/lightsheet_template_ccf_registration" # id: 9be4e3ac-adfb-4335-824c-bd99364a2c0f

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6045222.git" capsule-repo
	git -C capsule-repo checkout 80d5bcc6de5703070a9fbf3ddd069bb4c68464c8 --quiet
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
process capsule_aind_smartspim_pipeline_dispatcher_6 {
	tag 'capsule-2991712'
	container "$REGISTRY_HOST/capsule/18f160f3-be42-49c7-87a3-0ed0938bfa28"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/' from preprocessing_to_dispatch_1.collect()
	path 'capsule/data/' from preprocessing_to_dispatch_2.collect()
	path 'capsule/data/ccf_registration_results/' from registration_to_dispatcher.collect()
	path 'capsule/data/fused/' from fuse_to_dispatch.collect()
	path 'capsule/data/input_aind_metadata/' from dataset_to_dispatch_metadata.collect()
	path 'capsule/data/' from dataset_to_dispatch_manifest.collect()
	path 'capsule/data/stitched/' from stitch_to_dispatch.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into dispatch_to_cell_detect_1
	path 'capsule/results/output_aind_metadata/data_description.json' into dispatch_to_cell_detect_2
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

	export CO_CAPSULE_ID=18f160f3-be42-49c7-87a3-0ed0938bfa28
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2991712.git" capsule-repo
	git -C capsule-repo checkout 87de7d3536b57a3999ca399cda304431a7688ac4 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run dispatch

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-segmentation
process capsule_aind_smartspim_cell_segmentation_7 {
	tag 'capsule-9761832'
	container "$REGISTRY_HOST/capsule/e2be5aab-618f-4a9e-9d50-b5b649e169b1"

	cpus 16
	memory '256 GB'

	input:
	path 'capsule/data/fused/' from fuse_to_cell_detect.collect()
	path 'capsule/data/' from dispatch_to_cell_detect_1.flatten()
	path 'capsule/data/' from dispatch_to_cell_detect_2.collect()

	output:
	path 'capsule/results/*' into cell_detect_to_classification

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e2be5aab-618f-4a9e-9d50-b5b649e169b1
	export CO_CPUS=16
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9761832.git" capsule-repo
	git -C capsule-repo checkout 9405f3febdeba71a38f4105c451f6d1a01f8d744 --quiet
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
process capsule_aind_smartspim_cell_quantification_8 {
	tag 'capsule-8884276'
	container "$REGISTRY_HOST/capsule/2486f4d2-79b2-4862-946b-e3a14e780f1d"

	cpus 16
	memory '128 GB'

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

	export CO_CAPSULE_ID=2486f4d2-79b2-4862-946b-e3a14e780f1d
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/lightsheet_template_ccf_registration" "capsule/data/lightsheet_template_ccf_registration" # id: 9be4e3ac-adfb-4335-824c-bd99364a2c0f

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8884276.git" capsule-repo
	git -C capsule-repo checkout b3644385004fc4def505b8a0bb1d633361f0fdb1 --quiet
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
process capsule_aind_smartspim_pipeline_dispatcher_9 {
	tag 'capsule-2991712'
	container "$REGISTRY_HOST/capsule/18f160f3-be42-49c7-87a3-0ed0938bfa28"

	cpus 16
	memory '128 GB'

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

	export CO_CAPSULE_ID=18f160f3-be42-49c7-87a3-0ed0938bfa28
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2991712.git" capsule-repo
	git -C capsule-repo checkout 87de7d3536b57a3999ca399cda304431a7688ac4 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-classification
process capsule_aind_smartspim_cell_classification_gpu_10 {
	tag 'capsule-0963828'
	container "$REGISTRY_HOST/capsule/6fa72b6b-7b12-466e-94da-6cc5699b68f3"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

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

	export CO_CAPSULE_ID=6fa72b6b-7b12-466e-94da-6cc5699b68f3
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/smartspim_18_model" "capsule/data/smartspim_18_model" # id: 459560f0-c7bb-406a-8a67-73ba8450bbd0

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0963828.git" capsule-repo
	git -C capsule-repo checkout 338c64934a1e54758be4ed3acd03ff8422fcada8 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
