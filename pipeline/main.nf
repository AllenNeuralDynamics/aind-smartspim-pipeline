#!/usr/bin/env nextflow
// hash:sha256:fd2c705d868cfdabf0b91fcd50d177b50ca4ffc8547f8d728bc3e82794a49c61

nextflow.enable.dsl = 1

params.smartspim_dataset_url = 's3://aind-scratch-data/smartspim_dataset'
params.smartspim_template_2024_05_16_11_26_14_url = 's3://aind-open-data/SmartSPIM-template_2024-05-16_11-26-14'
params.smartspim_production_models_url = 's3://aind-benchmark-data/mesoscale-anatomy-cell-detection/models/smartspim_production_models'

smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_1 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_2 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_3 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_4 = channel.create()
capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_stitch_128_2_5 = channel.create()
capsule_create_individual_zgroup_12_to_capsule_aind_smartspim_stitch_128_2_6 = channel.create()
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_7 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_8 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_9 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_10 = channel.create()
smartspim_dataset_to_aind_smartspim_fuse_0_0_5_bigstitcher_11 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_12 = channel.create()
smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_13 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/metadata.json", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_14 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_15 = channel.create()
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_16 = channel.fromPath(params.smartspim_dataset_url + "/*.json", type: 'any')
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_17 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_18 = channel.create()
capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_19 = channel.create()
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_20 = channel.create()
capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_21 = channel.create()
smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_cell_quantification_1_6_3_22 = channel.fromPath(params.smartspim_template_2024_05_16_11_26_14_url + "/", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_quantification_163_7_23 = channel.create()
capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_cell_quantification_163_7_24 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_25 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_26 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_27 = channel.create()
capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_cell_quantification_163_7_28 = channel.create()
smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_ccf_registration_0_0_34_29 = channel.fromPath(params.smartspim_template_2024_05_16_11_26_14_url + "/", type: 'any')
smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_34_30 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_34_31 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_ccf_registration_0034_8_32 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_33 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_34 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_35 = channel.create()
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_segmentation_102_9_36 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_37 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_38 = channel.create()
smartspim_production_models_to_aind_smartspim_classification_0_0_9_39 = channel.fromPath(params.smartspim_production_models_url + "/", type: 'any')
capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_classification_009_10_40 = channel.create()
capsule_aind_smartspim_cell_segmentation_102_9_to_capsule_aind_smartspim_classification_009_10_41 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_42 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_43 = channel.create()
capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_44 = channel.create()
capsule_aind_smartspim_cell_quantification_163_7_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_45 = channel.create()

// capsule - aind-smartspim-destripe-shadow-correction-0.0.5
process capsule_aind_smartspim_destripe_shadow_correction_005_1 {
	tag 'capsule-6067584'
	container "$REGISTRY_HOST/capsule/e989fbed-af2e-4552-b931-e7bd48e4b8cf"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_1.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_2.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_3.collect()
	path 'capsule/data/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_4.collect()

	output:
	path 'capsule/results/destriped_data/Ex_*_Em_*' into capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_stitch_128_2_5
	path 'capsule/results/destriped_data*' into capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_10
	path 'capsule/results/image_destriping_*.json' into capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_19

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
	container "$REGISTRY_HOST/capsule/7bba4392-d98e-48ef-9b33-242908c455cb"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/preprocessed_data/' from capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_stitch_128_2_5.collect()
	path 'capsule/data/preprocessed_data/' from capsule_create_individual_zgroup_12_to_capsule_aind_smartspim_stitch_128_2_6.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_7.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_8.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_9.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_12
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_21

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
	container "$REGISTRY_HOST/capsule/664683c7-6ac9-4968-91e3-08d5e2f430e7"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/preprocessed_data' from capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_10.flatten()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_fuse_0_0_5_bigstitcher_11.collect()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_fuse_005_bigstitcher_3_12.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_15
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_quantification_163_7_23
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_ccf_registration_0034_8_32
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_segmentation_102_9_36
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_classification_009_10_40

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
	container "$REGISTRY_HOST/capsule/37c0404c-111e-4f43-8744-39616bae91f1"

	cpus 4
	memory '30 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_13.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_0_0_2_14.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_destripe_shadow_correction_005_1_4
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_20

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
	container "$REGISTRY_HOST/capsule/61ffdab7-797a-4022-9b9e-8792ad843cd3"

	cpus 2
	memory '15 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_15.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_16.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_3_17.collect()
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_18.collect()
	path 'capsule/data/' from capsule_aind_smartspim_destripe_shadow_correction_005_1_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_19.collect()
	path 'capsule/data/flatfield_estimation/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_20.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_128_2_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_21.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_25
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_26
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_27
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_33
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_34
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_35
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_37
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_38
	path 'capsule/results/modified_processing_manifest.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_42
	path 'capsule/results/output_aind_metadata/*.json' into capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_43

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
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-quantification-1.6.3
process capsule_aind_smartspim_cell_quantification_163_7 {
	tag 'capsule-5932556'
	container "$REGISTRY_HOST/capsule/ada793d3-bfa3-45fb-bdf5-3b2eb2c6df2f"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/lightsheet_template_ccf_registration' from smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_cell_quantification_1_6_3_22.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_quantification_163_7_23.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_cell_quantification_163_7_24.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_25.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_26.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_quantification_163_7_27.collect()
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_cell_quantification_163_7_28.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_163_7_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_45

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
	container "$REGISTRY_HOST/capsule/4e9ff62e-76b9-48eb-9b62-bd79e398fae6"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/lightsheet_template_ccf_registration' from smartspim_template_2024_05_16_11_26_14_to_aind_smartspim_ccf_registration_0_0_34_29.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_34_30.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_34_31.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_ccf_registration_0034_8_32.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_pipeline_dispatcher_103_6_18
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_0034_8_to_capsule_aind_smartspim_cell_quantification_163_7_28

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
	container "$REGISTRY_HOST/capsule/e4e4cf4a-7295-4006-bab1-4e2b1a3247c1"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_33.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_34.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_cell_segmentation_102_9_35.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_cell_segmentation_102_9_36.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_102_9_to_capsule_aind_smartspim_classification_009_10_41

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
	container "$REGISTRY_HOST/capsule/1f5844df-dbb3-4efc-8eb9-fda57bc43735"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_37.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_classification_009_10_38.collect()
	path 'capsule/data/smartspim_production_models' from smartspim_production_models_to_aind_smartspim_classification_0_0_9_39.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_005_bigstitcher_3_to_capsule_aind_smartspim_classification_009_10_40.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_102_9_to_capsule_aind_smartspim_classification_009_10_41

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_cell_quantification_163_7_24
	path 'capsule/results/*' into capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_44

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
	container "$REGISTRY_HOST/capsule/61ffdab7-797a-4022-9b9e-8792ad843cd3"

	cpus 2
	memory '15 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_42.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_103_6_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_43.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_009_10_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_44.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_163_7_to_capsule_aind_smartspim_pipeline_dispatcher_103_11_45.collect()

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
process capsule_create_individual_zgroup_12 {
	tag 'capsule-5587181'
	container "$REGISTRY_HOST/capsule/2ae3bb33-55ac-48f4-ae22-93d148b0f5ab"

	cpus 1
	memory '7.5 GB'

	output:
	path 'capsule/results/zgroup_folder/.zgroup' into capsule_create_individual_zgroup_12_to_capsule_aind_smartspim_stitch_128_2_6

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
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
