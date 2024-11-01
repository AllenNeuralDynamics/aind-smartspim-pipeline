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

smartspim_test_dataset_to_aind_smartspim_stitch_7 = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_stitch_8 = channel.fromPath(params.lightsheet_dataset + "/data_description.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_stitch_9 = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_10 = channel.create()
smartspim_test_dataset_to_aind_smartspim_fuse_11 = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_fuse_12 = channel.fromPath(params.lightsheet_dataset + "/data_description.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_fuse_13 = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_14 = channel.create()
capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_15 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_16 = channel.create()
smartspim_test_dataset_to_aind_smartspim_ccf_registration_17 = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_ccf_registration_18 = channel.fromPath(params.lightsheet_dataset + "/acquisition.json", type: 'any')
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_19 = channel.create()
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_20 = channel.create()
capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_21 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_22 = channel.create()
smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_23 = channel.fromPath(params.lightsheet_dataset + "/*.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_24 = channel.fromPath(params.lightsheet_dataset + "/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_25 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_26 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_27 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_28 = channel.create()
capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_cell_quantification_8_29 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_31 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_32 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_33 = channel.create()
capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_34 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_35 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_36 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_37 = channel.create()
capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_pipeline_dispatcher_9_38 = channel.create()
capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_39 = channel.create()
capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_classification_gpu_10_40 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_classification_gpu_10_41 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_classification_gpu_10_42 = channel.create()

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
	path 'capsule/results/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_10
	path 'capsule/results/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_14
	path 'capsule/results/image_destriping_*_processing.json' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_19
	path 'capsule/results/flatfield_correction_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_20

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
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_7.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_8.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_9.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_10.collect()

	output:
	path 'capsule/results/volume_alignments.xml' into capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_15
	path 'capsule/results/stitch_*' into capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_25

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
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_11.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_12.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_13.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_14.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_15.collect()

	output:
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_16
	path 'capsule/results/fusion_*' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_22
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_26
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_33
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_classification_gpu_10_41

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
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_16.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_ccf_registration_17.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_ccf_registration_18.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_21
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_34

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
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_19.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_20.collect()
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_21.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_22.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_23.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_24.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_25.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_27
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_28
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_31
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_32
	path 'capsule/results/output_aind_metadata/processing.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_35
	path 'capsule/results/modified_processing_manifest.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_36
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_37
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_classification_gpu_10_42

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
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_26.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_27.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_28.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_classification_gpu_10_40

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
	path 'capsule/data/' from capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_cell_quantification_8_29.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_31.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_32.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_33.collect()
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_34.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_39

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
	path 'capsule/data/output_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_35.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_36.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_37.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_pipeline_dispatcher_9_38.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_39.collect()

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
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_classification_gpu_10_40
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_classification_gpu_10_41.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_classification_gpu_10_42.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_cell_quantification_8_29
	path 'capsule/results/*' into capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_pipeline_dispatcher_9_38

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
