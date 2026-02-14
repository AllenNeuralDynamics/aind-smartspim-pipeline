#!/usr/bin/env nextflow
// hash:sha256:7b1d9f4577cd1823c389b81c185b23c55ec56e745c9a0f6f98b39ed81e9c07b7

nextflow.enable.dsl = 1

params.smartspim_dataset_url = 's3://aind-scratch-data/smartspim_dataset'
params.smartspim_template_2024_05_16_11_26_14_url = 's3://aind-open-data/SmartSPIM-template_2024-05-16_11-26-14'
params.smartspim_production_models_url = 's3://aind-benchmark-data/mesoscale-anatomy-cell-detection/models/smartspim_production_models'

capsule_aind_smartspim_pipeline_dispatcher_103_13_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_1 = channel.create()
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_2 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_3 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_4 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_5 = channel.create()
capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_stitch_128_2_6 = channel.create()
capsule_create_individual_zgroup_12_to_capsule_aind_smartspim_stitch_128_2_7 = channel.create()
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_8 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_9 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_10 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_11 = channel.create()
smartspim_dataset_to_aind_smartspim_fuse_0_0_5_bigstitcher_12 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_13 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_13_to_capsule_aind_smartspim_flatfield_estimation_5_14 = channel.create()
smartspim_dataset_to_aind_smartspim_flatfield_estimation_15 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/metadata.json", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_16 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_17 = channel.create()
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_18 = channel.fromPath(params.smartspim_dataset_url + "/*.json", type: 'any')
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_19 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_20 = channel.create()
capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_21 = channel.create()
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_22 = channel.create()
capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_23 = channel.create()
smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_cell_quantification_1_7_0_24 = channel.fromPath(params.smartspim_template_2024_05_16_11_26_14_url + "/", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_quantification_163_7_25 = channel.create()
capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_cell_quantification_163_7_26 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_27 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_28 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_29 = channel.create()
capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_cell_quantification_163_7_30 = channel.create()
smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_ccf_registration_0_0_34_31 = channel.fromPath(params.smartspim_template_2024_05_16_11_26_14_url + "/", type: 'any')
smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_34_32 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_34_33 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_ccf_registration_0034_8_34 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_35 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_36 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_37 = channel.create()
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_segmentation_102_9_38 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_39 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_40 = channel.create()
smartspim_production_models_to_aind_smartspim_classification_0_1_0_41 = channel.fromPath(params.smartspim_production_models_url + "/", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_classification_009_10_42 = channel.create()
capsule_aind_smartspim_cell_segmentation_102_9_to_capsule_aind_smartspim_classification_009_10_43 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_44 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_45 = channel.create()
capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_46 = channel.create()
capsule_aind_smartspim_cell_quantification_163_7_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_47 = channel.create()
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_48 = channel.fromPath(params.smartspim_dataset_url + "/*.json", type: 'any')
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_49 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')

// capsule - aind-smartspim-destripe-shadow-correction-0.0.5
process capsule_aind_smartspim_destripe_shadow_correction_005_1 {
	tag 'capsule-5224764'
	container "$REGISTRY_HOST/published/f7f1d820-253d-4ec4-b8d8-be288d62596f:v1"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_13_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_1.flatten()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_2.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_3.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_4.collect()
	path 'capsule/data/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_5.collect()

	output:
	path 'capsule/results/destriped_data/Ex_*_Em_*' into capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_stitch_128_2_6
	path 'capsule/results/destriped_data*' into capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_11
	path 'capsule/results/image_destriping_*.json' into capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_21

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=f7f1d820-253d-4ec4-b8d8-be288d62596f
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5224764.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5224764.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-stitch-1.2.8
process capsule_aind_smartspim_stitch_128_2 {
	tag 'capsule-6599682'
	container "$REGISTRY_HOST/published/9fd01a17-58d1-48f5-9a7e-beeccb8c90f5:v1"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/preprocessed_data/' from capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_stitch_128_2_6.collect()
	path 'capsule/data/preprocessed_data/' from capsule_create_individual_zgroup_12_to_capsule_aind_smartspim_stitch_128_2_7.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_8.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_9.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_10.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_13
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_23

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9fd01a17-58d1-48f5-9a7e-beeccb8c90f5
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6599682.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6599682.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-fuse-0.0.5-bigstitcher
process capsule_aind_smartspim_fuse_005_bigstitcher_3 {
	tag 'capsule-8580265'
	container "$REGISTRY_HOST/published/04cf5fe6-caa7-47dd-a95e-1706ab4aa32c:v1"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/preprocessed_data' from capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_11.flatten()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_fuse_0_0_5_bigstitcher_12.collect()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_13.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_17
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_quantification_163_7_25
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_ccf_registration_0034_8_34
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_segmentation_102_9_38
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_classification_009_10_42

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=04cf5fe6-caa7-47dd-a95e-1706ab4aa32c
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8580265.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8580265.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-flatfield-estimation
process capsule_aind_smartspim_flatfield_estimation_5 {
	tag 'capsule-2734547'
	container "$REGISTRY_HOST/published/94d2cbcc-55b3-41fb-9686-9ccc1d3601b1:v1"

	cpus 4
	memory '30 GB'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_13_to_capsule_aind_smartspim_flatfield_estimation_5_14.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_15.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_16.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_5
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_22

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=94d2cbcc-55b3-41fb-9686-9ccc1d3601b1
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2734547.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2734547.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher-1.0.3
process capsule_aind_smartspim_pipeline_dispatcher_103_6 {
	tag 'capsule-6615385'
	container "$REGISTRY_HOST/published/de997ea8-f900-4eef-8432-7d6726a579ae:v1"

	cpus 2
	memory '15 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_17.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_18.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_19.collect()
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_20.collect()
	path 'capsule/data/' from capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_21.collect()
	path 'capsule/data/flatfield_estimation/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_22.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_23.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_27
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_28
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_29
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_35
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_36
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_37
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_39
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_40
	path 'capsule/results/modified_processing_manifest.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_44
	path 'capsule/results/output_aind_metadata/*.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_45

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=de997ea8-f900-4eef-8432-7d6726a579ae
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6615385.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6615385.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run dispatch

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-quantification-1.7.0
process capsule_aind_smartspim_cell_quantification_163_7 {
	tag 'capsule-9139738'
	container "$REGISTRY_HOST/published/035a9a9d-a755-4050-9724-b7b2decff0e9:v1"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/lightsheet_template_ccf_registration' from smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_cell_quantification_1_7_0_24.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_quantification_163_7_25.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_cell_quantification_163_7_26.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_27.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_28.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_29.collect()
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_cell_quantification_163_7_30.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_163_7_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_47

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=035a9a9d-a755-4050-9724-b7b2decff0e9
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9139738.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9139738.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run detect

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-ccf-registration-0.0.34
process capsule_aind_smartspim_ccf_registration_0034_8 {
	tag 'capsule-8189339'
	container "$REGISTRY_HOST/published/1d42f62b-68e4-40b7-ab32-32225960c6a3:v1"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/lightsheet_template_ccf_registration' from smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_ccf_registration_0_0_34_31.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_34_32.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_34_33.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_ccf_registration_0034_8_34.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_20
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_cell_quantification_163_7_30

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1d42f62b-68e4-40b7-ab32-32225960c6a3
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8189339.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8189339.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-segmentation-1.0.2
process capsule_aind_smartspim_cell_segmentation_102_9 {
	tag 'capsule-3362114'
	container "$REGISTRY_HOST/published/1937c92b-b912-4e40-adc9-5b241dd80125:v1"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_35.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_36.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_37.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_segmentation_102_9_38.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_102_9_to_capsule_aind_smartspim_classification_009_10_43

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1937c92b-b912-4e40-adc9-5b241dd80125
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3362114.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3362114.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-classification-0.1.0
process capsule_aind_smartspim_classification_009_10 {
	tag 'capsule-7049712'
	container "$REGISTRY_HOST/published/e9054c0b-c45c-42c4-a8da-c8e1ddd9e61d:v1"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_39.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_40.collect()
	path 'capsule/data/smartspim_production_models' from smartspim_production_models_to_aind_smartspim_classification_0_1_0_41.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_classification_009_10_42.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_102_9_to_capsule_aind_smartspim_classification_009_10_43

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_cell_quantification_163_7_26
	path 'capsule/results/*' into capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_46

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e9054c0b-c45c-42c4-a8da-c8e1ddd9e61d
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7049712.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7049712.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher-1.0.3
process capsule_aind_smartspim_pipeline_dispatcher_103_11 {
	tag 'capsule-6615385'
	container "$REGISTRY_HOST/published/de997ea8-f900-4eef-8432-7d6726a579ae:v1"

	cpus 2
	memory '15 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_44.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_45.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_46.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_163_7_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_47.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=de997ea8-f900-4eef-8432-7d6726a579ae
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6615385.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6615385.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Create individual .zgroup
process capsule_create_individual_zgroup_12 {
	tag 'capsule-5587181'
	container "$REGISTRY_HOST/capsule/2ae3bb33-55ac-48f4-ae22-93d148b0f5ab:cbb76805f9b77fda6ae280a5bbda2296"

	cpus 1
	memory '7.5 GB'

	output:
	path 'capsule/results/zgroup_folder/.zgroup' into capsule_create_individual_zgroup_12_to_capsule_aind_smartspim_stitch_128_2_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=2ae3bb33-55ac-48f4-ae22-93d148b0f5ab
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5587181.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5587181.git" capsule-repo
	fi
	git -C capsule-repo checkout f7397ee59e2f7a91677d19d0b29fffc2ba16306c --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher-1.0.3
process capsule_aind_smartspim_pipeline_dispatcher_103_13 {
	tag 'capsule-6615385'
	container "$REGISTRY_HOST/published/de997ea8-f900-4eef-8432-7d6726a579ae:v1"

	cpus 2
	memory '15 GB'

	input:
	path 'capsule/data/input_aind_metadata/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_48.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_49.collect()

	output:
	path 'capsule/results/preprocess_*.json' into capsule_aind_smartspim_pipeline_dispatcher_103_13_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_1
	path 'capsule/results/*' into capsule_aind_smartspim_pipeline_dispatcher_103_13_to_capsule_aind_smartspim_flatfield_estimation_5_14

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=de997ea8-f900-4eef-8432-7d6726a579ae
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6615385.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6615385.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run split_channels

	echo "[${task.tag}] completed!"
	"""
}
