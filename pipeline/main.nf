#!/usr/bin/env nextflow
// hash:sha256:27421be47deb6dd5f3e4ab76476ea4cf106a052aa3e14ba7a12b480ed4e536a4

nextflow.enable.dsl = 1

params.smartspim_dataset_url = 's3://aind-scratch-data/smartspim_dataset'
params.smartspim_template_2024_05_16_11_26_14_url = 's3://aind-open-data/SmartSPIM-template_2024-05-16_11-26-14'
params.smartspim_production_models_url = 's3://aind-benchmark-data/mesoscale-anatomy-cell-detection/models/smartspim_production_models'

capsule_aind_smartspim_pipeline_dispatcher_102_16_to_capsule_aind_smartspim_flatfield_estimation_5_1 = channel.create()
smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_2 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/metadata.json", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_3 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_4 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_5 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_6 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
capsule_aind_smartspim_pipeline_dispatcher_102_16_to_capsule_aind_destripe_shadow_correction_005_6_7 = channel.create()
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_005_6_8 = channel.create()
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_9 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_10 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_11 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_create_individual_zgroup_9_to_capsule_aind_smartspim_stitch_127_7_12 = channel.create()
capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_stitch_127_7_13 = channel.create()
smartspim_dataset_to_aind_smartspim_fuse_0_0_5_bigstitcher_14 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_15 = channel.create()
capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_16 = channel.create()
smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_33_17 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_33_18 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_ccf_registration_0_0_33_19 = channel.fromPath(params.smartspim_template_2024_05_16_11_26_14_url + "/", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_ccf_registration_0033_10_20 = channel.create()
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_21 = channel.create()
capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_22 = channel.create()
capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_23 = channel.create()
capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_24 = channel.create()
capsule_aind_smartspim_ccf_registration_0033_10_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_25 = channel.create()
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_2_26 = channel.fromPath(params.smartspim_dataset_url + "/*.json", type: 'any')
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_2_27 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_28 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_29 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_30 = channel.create()
capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_cell_segmentation_101_12_31 = channel.create()
capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_classification_007_13_32 = channel.create()
capsule_aind_smartspim_cell_segmentation_101_12_to_capsule_aind_smartspim_classification_007_13_33 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_classification_007_13_34 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_classification_007_13_35 = channel.create()
smartspim_production_models_to_aind_smartspim_classification_0_0_7_36 = channel.fromPath(params.smartspim_production_models_url + "/*", type: 'any')
capsule_aind_smartspim_ccf_registration_0033_10_to_capsule_aind_smartspim_cell_quantification_161_14_37 = channel.create()
capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_cell_quantification_161_14_38 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_39 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_40 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_41 = channel.create()
capsule_aind_smartspim_classification_007_13_to_capsule_aind_smartspim_cell_quantification_161_14_42 = channel.create()
smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_cell_quantification_1_6_1_43 = channel.fromPath(params.smartspim_template_2024_05_16_11_26_14_url + "/", type: 'any')
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_44 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_45 = channel.create()
capsule_aind_smartspim_cell_quantification_161_14_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_46 = channel.create()
capsule_aind_smartspim_classification_007_13_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_47 = channel.create()
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_2_48 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_2_49 = channel.fromPath(params.smartspim_dataset_url + "/*.json", type: 'any')

// capsule - aind-smartspim-flatfield-estimation-0.0.2
process capsule_aind_smartspim_flatfield_estimation_5 {
	tag 'capsule-1467402'
	container "$REGISTRY_HOST/capsule/37c0404c-111e-4f43-8744-39616bae91f1:44d68d43fa30b3578ed3e50b6efef069"

	cpus 4
	memory '30 GB'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_16_to_capsule_aind_smartspim_flatfield_estimation_5_1.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_2.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_3.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_005_6_8
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_21

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1467402.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1467402.git" capsule-repo
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

// capsule - aind-smartspim-destripe-shadow-correction-0.0.5
process capsule_aind_destripe_shadow_correction_005_6 {
	tag 'capsule-6067584'
	container "$REGISTRY_HOST/capsule/e989fbed-af2e-4552-b931-e7bd48e4b8cf:16c8c83a4bef2332e717c6b047643741"

	cpus 32
	memory '120 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_4.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_5.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_6.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_16_to_capsule_aind_destripe_shadow_correction_005_6_7.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_005_6_8.collect()

	output:
	path 'capsule/results/destriped_data/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_stitch_127_7_13
	path 'capsule/results/destriped_data*' into capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_15
	path 'capsule/results/image_destriping_*.json' into capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_22

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e989fbed-af2e-4552-b931-e7bd48e4b8cf
	export CO_CPUS=32
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6067584.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6067584.git" capsule-repo
	fi
	git -C capsule-repo checkout f91778fb71aed181cf6ca438e1bbc9da588c5ccc --quiet
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
process capsule_aind_smartspim_stitch_127_7 {
	tag 'capsule-8765450'
	container "$REGISTRY_HOST/capsule/7bba4392-d98e-48ef-9b33-242908c455cb:c79ef3a39fb92f03d51b62e60729cd5f"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_9.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_10.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_11.collect()
	path 'capsule/data/preprocessed_data/' from capsule_create_individual_zgroup_9_to_capsule_aind_smartspim_stitch_127_7_12.collect()
	path 'capsule/data/preprocessed_data/' from capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_stitch_127_7_13.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_16
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_23

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8765450.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8765450.git" capsule-repo
	fi
	git -C capsule-repo checkout a35b9bcfef78f0233bc4e909224b22b6eb71547f --quiet
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
process capsule_aind_smartspim_fuse_005_bigstitcher_8 {
	tag 'capsule-1972908'
	container "$REGISTRY_HOST/capsule/664683c7-6ac9-4968-91e3-08d5e2f430e7:432bb3de2fa8293b7c207063ddb90860"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_fuse_0_0_5_bigstitcher_14.collect()
	path 'capsule/data/preprocessed_data' from capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_15.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_16.collect()

	output:
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_ccf_registration_0033_10_20
	path 'capsule/results/*' into capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_24
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_cell_segmentation_101_12_31
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_classification_007_13_32
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_cell_quantification_161_14_38

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1972908.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1972908.git" capsule-repo
	fi
	git -C capsule-repo checkout 88cab75ec24aaddc14dc436456fb522d4c313bd9 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Create individual .zgroup
process capsule_create_individual_zgroup_9 {
	tag 'capsule-5587181'
	container "$REGISTRY_HOST/capsule/2ae3bb33-55ac-48f4-ae22-93d148b0f5ab:cbb76805f9b77fda6ae280a5bbda2296"

	cpus 2
	memory '15 GB'

	output:
	path 'capsule/results/zgroup_folder/.zgroup' into capsule_create_individual_zgroup_9_to_capsule_aind_smartspim_stitch_127_7_12

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=2ae3bb33-55ac-48f4-ae22-93d148b0f5ab
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5587181.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5587181.git" capsule-repo
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

// capsule - aind-smartspim-ccf-registration-0.0.33
process capsule_aind_smartspim_ccf_registration_0033_10 {
	tag 'capsule-2505115'
	container "$REGISTRY_HOST/capsule/4e9ff62e-76b9-48eb-9b62-bd79e398fae6:c6847cc5d50809741a1559cac06fc8c0"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_33_17.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_33_18.collect()
	path 'capsule/data/lightsheet_template_ccf_registration' from smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_ccf_registration_0_0_33_19.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_ccf_registration_0033_10_20.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_0033_10_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_25
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_0033_10_to_capsule_aind_smartspim_cell_quantification_161_14_37

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2505115.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2505115.git" capsule-repo
	fi
	git -C capsule-repo checkout c21b5b9a876ce01e7580c605c3395039e4144d54 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher-1.0.2
process capsule_aind_smartspim_pipeline_dispatcher_102_11 {
	tag 'capsule-7923375'
	container "$REGISTRY_HOST/capsule/61ffdab7-797a-4022-9b9e-8792ad843cd3:ec226c73a74d73ebf24b1404ddd9d2d5"

	cpus 2
	memory '15 GB'

	input:
	path 'capsule/data/flatfield_estimation/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_21.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_22.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_23.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_24.collect()
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_0033_10_to_capsule_aind_smartspim_pipeline_dispatcher_102_11_25.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_2_26.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_2_27.collect()

	output:
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_28
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_29
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_30
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_classification_007_13_34
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_classification_007_13_35
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_39
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_40
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_41
	path 'capsule/results/modified_processing_manifest.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_44
	path 'capsule/results/output_aind_metadata/*.json' into capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_45

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	fi
	git -C capsule-repo checkout cf1fc3e3ab20a7d3bf708f7e0b3828816d341482 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run dispatch

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-segmentation-1.0.1
process capsule_aind_smartspim_cell_segmentation_101_12 {
	tag 'capsule-5129020'
	container "$REGISTRY_HOST/capsule/e4e4cf4a-7295-4006-bab1-4e2b1a3247c1:785c45be70c150b00cddf40e3bc49751"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_28.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_29.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_segmentation_101_12_30.flatten()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_cell_segmentation_101_12_31.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_101_12_to_capsule_aind_smartspim_classification_007_13_33

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5129020.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5129020.git" capsule-repo
	fi
	git -C capsule-repo checkout c1910238049aba38077337c140e6157b4fb444da --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-classification-0.0.7
process capsule_aind_smartspim_classification_007_13 {
	tag 'capsule-5543118'
	container "$REGISTRY_HOST/capsule/1f5844df-dbb3-4efc-8eb9-fda57bc43735:038e11af849398ac8e0db3b0f10e5ba7"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_classification_007_13_32.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_101_12_to_capsule_aind_smartspim_classification_007_13_33
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_classification_007_13_34.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_classification_007_13_35.collect()
	path 'capsule/data/' from smartspim_production_models_to_aind_smartspim_classification_0_0_7_36

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_classification_007_13_to_capsule_aind_smartspim_cell_quantification_161_14_42
	path 'capsule/results/*' into capsule_aind_smartspim_classification_007_13_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_47

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5543118.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5543118.git" capsule-repo
	fi
	git -C capsule-repo checkout faebb6666455bbbe6f5790e54e1aa4941a6e192b --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-quantification-1.6.1
process capsule_aind_smartspim_cell_quantification_161_14 {
	tag 'capsule-5932556'
	container "$REGISTRY_HOST/capsule/ada793d3-bfa3-45fb-bdf5-3b2eb2c6df2f:f153e972b8ef0752aa612736972ac1d5"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_0033_10_to_capsule_aind_smartspim_cell_quantification_161_14_37.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_8_to_capsule_aind_smartspim_cell_quantification_161_14_38.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_39.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_40.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_cell_quantification_161_14_41.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_007_13_to_capsule_aind_smartspim_cell_quantification_161_14_42.collect()
	path 'capsule/data/lightsheet_template_ccf_registration' from smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_cell_quantification_1_6_1_43.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_161_14_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_46

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5932556.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5932556.git" capsule-repo
	fi
	git -C capsule-repo checkout 6ee8e1411f02b152ca1792b4a8b77744c0d0194e --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher-1.0.2
process capsule_aind_smartspim_pipeline_dispatcher_102_15 {
	tag 'capsule-7923375'
	container "$REGISTRY_HOST/capsule/61ffdab7-797a-4022-9b9e-8792ad843cd3:ec226c73a74d73ebf24b1404ddd9d2d5"

	cpus 2
	memory '15 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_44.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_102_11_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_45.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_161_14_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_46.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_007_13_to_capsule_aind_smartspim_pipeline_dispatcher_102_15_47.collect()

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	fi
	git -C capsule-repo checkout cf1fc3e3ab20a7d3bf708f7e0b3828816d341482 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher-1.0.2
process capsule_aind_smartspim_pipeline_dispatcher_102_16 {
	tag 'capsule-7923375'
	container "$REGISTRY_HOST/capsule/61ffdab7-797a-4022-9b9e-8792ad843cd3:ec226c73a74d73ebf24b1404ddd9d2d5"

	cpus 2
	memory '15 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_2_48.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_2_49.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_pipeline_dispatcher_102_16_to_capsule_aind_smartspim_flatfield_estimation_5_1
	path 'capsule/results/preprocess_*.json' into capsule_aind_smartspim_pipeline_dispatcher_102_16_to_capsule_aind_destripe_shadow_correction_005_6_7

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7923375.git" capsule-repo
	fi
	git -C capsule-repo checkout cf1fc3e3ab20a7d3bf708f7e0b3828816d341482 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run split_channels

	echo "[${task.tag}] completed!"
	"""
}
