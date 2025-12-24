#!/usr/bin/env nextflow
// hash:sha256:00ef14123a7c9ca0ef21e9dc6cf7aea2592581a67e8708a77c49f32381c36d8b

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
smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_15 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/metadata.json", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_16 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_17 = channel.create()
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_18 = channel.fromPath(params.smartspim_dataset_url + "/*.json", type: 'any')
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_19 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_20 = channel.create()
capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_21 = channel.create()
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_22 = channel.create()
capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_23 = channel.create()
smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_cell_quantification_1_6_3_24 = channel.fromPath(params.smartspim_template_2024_05_16_11_26_14_url + "/", type: 'any')
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
smartspim_production_models_to_aind_smartspim_classification_0_0_9_41 = channel.fromPath(params.smartspim_production_models_url + "/", type: 'any')
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
	tag 'capsule-6067584'
	container "$REGISTRY_HOST/capsule/e989fbed-af2e-4552-b931-e7bd48e4b8cf:16c8c83a4bef2332e717c6b047643741"

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

	export CO_CAPSULE_ID=e989fbed-af2e-4552-b931-e7bd48e4b8cf
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6067584.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6067584.git" capsule-repo
	fi
	git -C capsule-repo checkout e4a1a792a67e33e9223fe245c630481d52b073ef --quiet
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
	tag 'capsule-8765450'
	container "$REGISTRY_HOST/capsule/7bba4392-d98e-48ef-9b33-242908c455cb:c79ef3a39fb92f03d51b62e60729cd5f"

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

	export CO_CAPSULE_ID=7bba4392-d98e-48ef-9b33-242908c455cb
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8765450.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8765450.git" capsule-repo
	fi
	git -C capsule-repo checkout 98f4783b18743f5747950c556445f704bfbeda11 --quiet
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
	tag 'capsule-1972908'
	container "$REGISTRY_HOST/capsule/664683c7-6ac9-4968-91e3-08d5e2f430e7:432bb3de2fa8293b7c207063ddb90860"

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

	export CO_CAPSULE_ID=664683c7-6ac9-4968-91e3-08d5e2f430e7
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1972908.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1972908.git" capsule-repo
	fi
	git -C capsule-repo checkout 156125233ed9b3f890217576e0f2586e43f564bc --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-flatfield-estimation-0.0.2
process capsule_aind_smartspim_flatfield_estimation_5 {
	tag 'capsule-1467402'
	container "$REGISTRY_HOST/capsule/37c0404c-111e-4f43-8744-39616bae91f1:44d68d43fa30b3578ed3e50b6efef069"

	cpus 4
	memory '30 GB'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_13_to_capsule_aind_smartspim_flatfield_estimation_5_14.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_15.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_16.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_5
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_22

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=37c0404c-111e-4f43-8744-39616bae91f1
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1467402.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1467402.git" capsule-repo
	fi
	git -C capsule-repo checkout 2cb18dbb01eceb123d456e359a30eef637c7804e --quiet
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
	tag 'capsule-7923375'
	container "$REGISTRY_HOST/capsule/61ffdab7-797a-4022-9b9e-8792ad843cd3:ec226c73a74d73ebf24b1404ddd9d2d5"

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

	export CO_CAPSULE_ID=61ffdab7-797a-4022-9b9e-8792ad843cd3
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	fi
	git -C capsule-repo checkout 9a09511a514a0fd95c7f587668f23d0f56fcf1b8 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run dispatch

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-quantification-1.6.3
process capsule_aind_smartspim_cell_quantification_163_7 {
	tag 'capsule-5932556'
	container "$REGISTRY_HOST/capsule/ada793d3-bfa3-45fb-bdf5-3b2eb2c6df2f:8c1f39fd1ad896b13786afded13b8bc3"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/lightsheet_template_ccf_registration' from smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_cell_quantification_1_6_3_24.collect()
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

	export CO_CAPSULE_ID=ada793d3-bfa3-45fb-bdf5-3b2eb2c6df2f
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5932556.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5932556.git" capsule-repo
	fi
	git -C capsule-repo checkout 4076c70a030108b77adf38103f2a3ba8de886452 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-ccf-registration-0.0.34
process capsule_aind_smartspim_ccf_registration_0034_8 {
	tag 'capsule-2505115'
	container "$REGISTRY_HOST/capsule/4e9ff62e-76b9-48eb-9b62-bd79e398fae6:aa821180261fd8ab48eb869adb0380b0"

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

	export CO_CAPSULE_ID=4e9ff62e-76b9-48eb-9b62-bd79e398fae6
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2505115.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2505115.git" capsule-repo
	fi
	git -C capsule-repo checkout b3464cd5435d752bcb53d8c1e4b78596d36b6f2e --quiet
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
	tag 'capsule-5129020'
	container "$REGISTRY_HOST/capsule/e4e4cf4a-7295-4006-bab1-4e2b1a3247c1:785c45be70c150b00cddf40e3bc49751"

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

	export CO_CAPSULE_ID=e4e4cf4a-7295-4006-bab1-4e2b1a3247c1
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5129020.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5129020.git" capsule-repo
	fi
	git -C capsule-repo checkout a0389e92faa7fc5916aa10ac78fc0ceee574d970 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-classification-0.0.9
process capsule_aind_smartspim_classification_009_10 {
	tag 'capsule-5543118'
	container "$REGISTRY_HOST/capsule/1f5844df-dbb3-4efc-8eb9-fda57bc43735:19f86d15499f7abe6e9a4269ef01df2e"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_39.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_40.collect()
	path 'capsule/data/smartspim_production_models' from smartspim_production_models_to_aind_smartspim_classification_0_0_9_41.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_classification_009_10_42.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_102_9_to_capsule_aind_smartspim_classification_009_10_43

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_cell_quantification_163_7_26
	path 'capsule/results/*' into capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_46

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1f5844df-dbb3-4efc-8eb9-fda57bc43735
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5543118.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5543118.git" capsule-repo
	fi
	git -C capsule-repo checkout 83b1ddc57e835d60c2cf1ae3f18c5fbc79ea9922 --quiet
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
	tag 'capsule-7923375'
	container "$REGISTRY_HOST/capsule/61ffdab7-797a-4022-9b9e-8792ad843cd3:ec226c73a74d73ebf24b1404ddd9d2d5"

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

	export CO_CAPSULE_ID=61ffdab7-797a-4022-9b9e-8792ad843cd3
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	fi
	git -C capsule-repo checkout 9a09511a514a0fd95c7f587668f23d0f56fcf1b8 --quiet
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
	tag 'capsule-7923375'
	container "$REGISTRY_HOST/capsule/61ffdab7-797a-4022-9b9e-8792ad843cd3:ec226c73a74d73ebf24b1404ddd9d2d5"

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

	export CO_CAPSULE_ID=61ffdab7-797a-4022-9b9e-8792ad843cd3
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	fi
	git -C capsule-repo checkout 9a09511a514a0fd95c7f587668f23d0f56fcf1b8 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run split_channels

	echo "[${task.tag}] completed!"
	"""
}
