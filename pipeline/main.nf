#!/usr/bin/env nextflow
// hash:sha256:fc80260abc672836d96c5d8dc684a5e32752fd8b15db6cc05b8039d42fcae1c6

nextflow.enable.dsl = 1

params.smartspim_dataset_url = 's3://aind-scratch-data/smartspim_dataset'

smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_1 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives", type: 'any')
smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_2 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_3 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/Ex_*_Em_*", type: 'any')
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_004_1_4 = channel.create()
smartspim_dataset_to_aind_smartspim_stitch_1_2_5_5 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_5_6 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_5_7 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_8 = channel.create()
capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_fuse_002_3_9 = channel.create()
smartspim_dataset_to_aind_smartspim_fuse_0_0_2_10 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_fuse_002_3_11 = channel.create()
smartspim_dataset_to_aind_smartspim_flatfield_estimation_12 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/metadata.json", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_13 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/Ex_*_Em_*", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_14 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_zarr_pipeline_aind_smartspim_pipeline_dispatcher_15 = channel.fromPath(params.smartspim_dataset_url + "/*.json", type: 'any')
smartspim_dataset_to_zarr_pipeline_aind_smartspim_pipeline_dispatcher_16 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_fuse_002_3_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_17 = channel.create()
capsule_aind_smartspim_ccf_registration_8_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_18 = channel.create()
capsule_aind_destripe_shadow_correction_004_1_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_19 = channel.create()
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_20 = channel.create()
capsule_aind_smartspim_stitch_125_2_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_21 = channel.create()
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_quantification_151_7_22 = channel.create()
capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_cell_quantification_151_7_23 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_24 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_25 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_26 = channel.create()
capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_cell_quantification_151_7_27 = channel.create()
smartspim_dataset_to_aind_smartspim_ccf_registration_28 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
smartspim_dataset_to_aind_smartspim_ccf_registration_29 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_ccf_registration_8_30 = channel.create()
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_segmentation_007_9_31 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_007_9_32 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_007_9_33 = channel.create()
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_classification_003_10_34 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_classification_003_10_35 = channel.create()
capsule_aind_smartspim_cell_segmentation_007_9_to_capsule_aind_smartspim_classification_003_10_36 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_37 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_38 = channel.create()
capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_39 = channel.create()
capsule_aind_smartspim_classification_003_10_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_40 = channel.create()
capsule_aind_smartspim_cell_quantification_151_7_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_41 = channel.create()

// capsule - aind-destripe-shadow-correction-0.0.4
process capsule_aind_destripe_shadow_correction_004_1 {
	tag 'capsule-4725614'
	container "$REGISTRY_HOST/published/73319e3c-625e-4153-b5d1-29fd755d1bf8:v1"

	cpus 32
	memory '128 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_1.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_2.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_3
	path 'capsule/data/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_004_1_4.collect()

	output:
	path 'capsule/results/destriped_data/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_8
	path 'capsule/results/destriped_data*' into capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_fuse_002_3_9
	path 'capsule/results/image_destriping_*.json' into capsule_aind_destripe_shadow_correction_004_1_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_19

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=73319e3c-625e-4153-b5d1-29fd755d1bf8
	export CO_CPUS=32
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4725614.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-stitch-1.2.5
process capsule_aind_smartspim_stitch_125_2 {
	tag 'capsule-2124819'
	container "$REGISTRY_HOST/published/4c04ae91-ff3e-453b-b95f-e26970fc1350:v1"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_5_5.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_5_6.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_5_7.collect()
	path 'capsule/data/preprocessed_data/' from capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_8.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_fuse_002_3_11
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_125_2_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_21

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
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2124819.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-fuse-0.0.2
process capsule_aind_smartspim_fuse_002_3 {
	tag 'capsule-0248143'
	container "$REGISTRY_HOST/published/10d08e17-f8a0-4c33-8610-40f8eeaef236:v1"

	cpus 16
	memory '128 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/preprocessed_data' from capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_fuse_002_3_9.flatten()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_fuse_0_0_2_10.collect()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_fuse_002_3_11.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_fuse_002_3_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_17
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_quantification_151_7_22
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_ccf_registration_8_30
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_segmentation_007_9_31
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_classification_003_10_34

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

// capsule - aind-smartspim-flatfield-estimation
process capsule_aind_smartspim_flatfield_estimation_5 {
	tag 'capsule-2734547'
	container "$REGISTRY_HOST/published/94d2cbcc-55b3-41fb-9686-9ccc1d3601b1:v1"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_12.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_13.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_14.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_004_1_4
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_20

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

// capsule - zarr pipeline aind-smartspim-pipeline-dispatcher
process capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6 {
	tag 'capsule-0991347'
	container "$REGISTRY_HOST/capsule/251a89cb-d614-4629-93d6-77929f18623b"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/input_aind_metadata/' from smartspim_dataset_to_zarr_pipeline_aind_smartspim_pipeline_dispatcher_15.collect()
	path 'capsule/data/' from smartspim_dataset_to_zarr_pipeline_aind_smartspim_pipeline_dispatcher_16.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_17.collect()
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_8_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_18.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_004_1_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_19.collect()
	path 'capsule/data/flatfield_estimation/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_20.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_125_2_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_21.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_24
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_25
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_26
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_007_9_32
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_007_9_33
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_classification_003_10_35
	path 'capsule/results/output_aind_metadata/processing.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_37
	path 'capsule/results/modified_processing_manifest.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_38
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_39

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=251a89cb-d614-4629-93d6-77929f18623b
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0991347.git" capsule-repo
	git -C capsule-repo checkout 13a6b06bdc5bce565cfbdae876975281c3102694 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run dispatch

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-quantification-1.5.1
process capsule_aind_smartspim_cell_quantification_151_7 {
	tag 'capsule-2107437'
	container "$REGISTRY_HOST/published/b895947f-db4f-4025-adb4-a1a04b7f1587:v1"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_quantification_151_7_22.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_cell_quantification_151_7_23.collect()
	path 'capsule/data/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_24.flatten()
	path 'capsule/data/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_25.collect()
	path 'capsule/data/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_151_7_26.collect()
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_cell_quantification_151_7_27.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_151_7_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_41

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
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2107437.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run detect

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-ccf-registration
process capsule_aind_smartspim_ccf_registration_8 {
	tag 'capsule-8584302'
	container "$REGISTRY_HOST/published/d61333f3-fd41-464e-9dac-dbdad02aec54:v4"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_28.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_29.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_ccf_registration_8_30.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_8_to_capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_18
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_cell_quantification_151_7_27

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
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8584302.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-segmentation-0.0.7
process capsule_aind_smartspim_cell_segmentation_007_9 {
	tag 'capsule-5009831'
	container "$REGISTRY_HOST/published/0d01bdb8-e530-40b8-8311-883814bde142:v3"

	cpus 16
	memory '256 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_segmentation_007_9_31.collect()
	path 'capsule/data/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_007_9_32.collect()
	path 'capsule/data/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_007_9_33.flatten()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_007_9_to_capsule_aind_smartspim_classification_003_10_36

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
	git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5009831.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-classification-0.0.3
process capsule_aind_smartspim_classification_003_10 {
	tag 'capsule-4355840'
	container "$REGISTRY_HOST/published/eab3673c-2c7f-488b-82b9-75dbfdddcb53:v1"

	cpus 16
	memory '128 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_classification_003_10_34.collect()
	path 'capsule/data/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_classification_003_10_35.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_007_9_to_capsule_aind_smartspim_classification_003_10_36

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_cell_quantification_151_7_23
	path 'capsule/results/*' into capsule_aind_smartspim_classification_003_10_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_40

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

	ln -s "/tmp/data/smartspim_18_model" "capsule/data/smartspim_18_model" # id: 459560f0-c7bb-406a-8a67-73ba8450bbd0

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4355840.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - zarr pipeline aind-smartspim-pipeline-dispatcher
process capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11 {
	tag 'capsule-0991347'
	container "$REGISTRY_HOST/capsule/251a89cb-d614-4629-93d6-77929f18623b"

	cpus 16
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/input_aind_metadata/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_37.collect()
	path 'capsule/data/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_38.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_zarrpipelineaind_smartspim_pipeline_dispatcher_6_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_39.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_003_10_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_40.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_151_7_to_capsule_zarr_pipeline_aind_smartspim_pipeline_dispatcher_11_41.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=251a89cb-d614-4629-93d6-77929f18623b
	export CO_CPUS=16
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0991347.git" capsule-repo
	git -C capsule-repo checkout 13a6b06bdc5bce565cfbdae876975281c3102694 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean

	echo "[${task.tag}] completed!"
	"""
}
