#!/usr/bin/env nextflow
// hash:sha256:c184e39bd023c4ddd145d5a9f008af354c9c42c424e49c56e33236128a8b5295

nextflow.enable.dsl = 1

params.smartspim_dataset_url = 's3://aind-scratch-data/smartspim_dataset'
params.smartspim_production_models_url = 's3://aind-benchmark-data/mesoscale-anatomy-cell-detection/models/smartspim_production_models'

smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_1 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives", type: 'any')
smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_2 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_3 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/Ex_*_Em_*", type: 'any')
smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_4 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_004_1_5 = channel.create()
capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_6 = channel.create()
capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_7 = channel.create()
smartspim_dataset_to_aind_smartspim_stitch_1_2_6_8 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_6_9 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_6_10 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_fuse_002_3_11 = channel.create()
smartspim_dataset_to_aind_smartspim_fuse_0_0_4_bigstitcher_12 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_fuse_002_3_13 = channel.create()
smartspim_dataset_to_aind_smartspim_flatfield_estimation_14 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/metadata.json", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_15 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/Ex_*_Em_*", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_16 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_1_17 = channel.fromPath(params.smartspim_dataset_url + "/*.json", type: 'any')
smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_1_18 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_19 = channel.create()
capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_20 = channel.create()
capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_21 = channel.create()
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_22 = channel.create()
capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_23 = channel.create()
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_quantification_151_7_24 = channel.create()
capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_cell_quantification_151_7_25 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_26 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_27 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_28 = channel.create()
capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_cell_quantification_151_7_29 = channel.create()
smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_32_30 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_32_31 = channel.fromPath(params.smartspim_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_ccf_registration_8_32 = channel.create()
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_segmentation_007_9_33 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_segmentation_007_9_34 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_segmentation_007_9_35 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_classification_003_10_36 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_classification_003_10_37 = channel.create()
smartspim_production_models_to_aind_smartspim_classification_0_0_6_38 = channel.fromPath(params.smartspim_production_models_url + "/", type: 'any')
capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_classification_003_10_39 = channel.create()
capsule_aind_smartspim_cell_segmentation_007_9_to_capsule_aind_smartspim_classification_003_10_40 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_41 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_42 = channel.create()
capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_43 = channel.create()
capsule_aind_smartspim_cell_quantification_151_7_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_44 = channel.create()

// capsule - aind-destripe-shadow-correction-0.0.4
process capsule_aind_destripe_shadow_correction_004_1 {
	tag 'capsule-2729769'
	container "$REGISTRY_HOST/capsule/9297b361-aefa-419f-8897-0466e6b2ba0e:73c76f839031ef10c3df1b562e426d06"

	cpus 32
	memory '120 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_1.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_2.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_3
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_4_4.collect()
	path 'capsule/data/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_004_1_5.collect()

	output:
	path 'capsule/results/destriped_data/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_6
	path 'capsule/results/path_to_cloud_*' into capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_7
	path 'capsule/results/destriped_data*' into capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_fuse_002_3_11
	path 'capsule/results/image_destriping_*.json' into capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_21

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9297b361-aefa-419f-8897-0466e6b2ba0e
	export CO_CPUS=32
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2729769.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2729769.git" capsule-repo
	fi
	git -C capsule-repo checkout 6215e8a5d804029903a6429e25af9f6be48abdce --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-stitch-1.2.6
process capsule_aind_smartspim_stitch_125_2 {
	tag 'capsule-2825072'
	container "$REGISTRY_HOST/capsule/53ecb114-e201-48b5-8d5e-5277d26cbb2b:69351eee84c1baa80ef68483579bbf75"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/preprocessed_data/' from capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_6.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_stitch_125_2_7.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_6_8.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_6_9.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_6_10.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_fuse_002_3_13
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_23

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=53ecb114-e201-48b5-8d5e-5277d26cbb2b
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2825072.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2825072.git" capsule-repo
	fi
	git -C capsule-repo checkout c33c53d0e047ba9078277eb333b006aa4bf1ae2e --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-fuse-0.0.4-bigstitcher
process capsule_aind_smartspim_fuse_002_3 {
	tag 'capsule-5768558'
	container "$REGISTRY_HOST/capsule/e28fec7f-8253-46ba-8502-10ac3711e3f2:f5b2f2a9754d5690f3080e6f94332df6"

	cpus 16
	memory '120 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/preprocessed_data' from capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_fuse_002_3_11.flatten()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_fuse_0_0_4_bigstitcher_12.collect()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_fuse_002_3_13.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_19
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_quantification_151_7_24
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_ccf_registration_8_32
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_segmentation_007_9_33
	path 'capsule/results/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_classification_003_10_39

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e28fec7f-8253-46ba-8502-10ac3711e3f2
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5768558.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5768558.git" capsule-repo
	fi
	git -C capsule-repo checkout dc789c6c63dffd7aa1aa0a6616e48d606fa14737 --quiet
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
	memory '120 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_14.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_15.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_16.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_004_1_5
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_22

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=94d2cbcc-55b3-41fb-9686-9ccc1d3601b1
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2734547.git" capsule-repo
	else
		git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2734547.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher-1.0.1
process capsule_aind_smartspim_pipeline_dispatcher_100_6 {
	tag 'capsule-3294345'
	container "$REGISTRY_HOST/capsule/7adb694b-b8cd-42ef-ba37-4639508b7ee0:3d43415e5e57512b3d1a406b222b7a58"

	cpus 2
	memory '15 GB'

	input:
	path 'capsule/data/input_aind_metadata/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_1_17.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_pipeline_dispatcher_1_0_1_18.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_19.collect()
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_20.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_004_1_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_21.collect()
	path 'capsule/data/flatfield_estimation/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_22.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_125_2_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_23.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_26
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_27
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_28
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_segmentation_007_9_34
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_segmentation_007_9_35
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_classification_003_10_36
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_classification_003_10_37
	path 'capsule/results/modified_processing_manifest.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_41
	path 'capsule/results/output_aind_metadata/*.json' into capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_42

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=7adb694b-b8cd-42ef-ba37-4639508b7ee0
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3294345.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3294345.git" capsule-repo
	fi
	git -C capsule-repo checkout 8cb0cf277c47680908e318fd0bf7998bec31778d --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run dispatch

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-quantification-1.6.2
process capsule_aind_smartspim_cell_quantification_151_7 {
	tag 'capsule-2404927'
	container "$REGISTRY_HOST/capsule/a240d629-4d4b-430d-a040-0ab11d48a2a0:8f7109c38bfddadb527256bc9d6e2672"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_quantification_151_7_24.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_cell_quantification_151_7_25.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_26.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_27.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_quantification_151_7_28.collect()
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_cell_quantification_151_7_29.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_151_7_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_44

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a240d629-4d4b-430d-a040-0ab11d48a2a0
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/lightsheet_template_ccf_registration" "capsule/data/lightsheet_template_ccf_registration" # id: 9be4e3ac-adfb-4335-824c-bd99364a2c0f

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2404927.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2404927.git" capsule-repo
	fi
	git -C capsule-repo checkout 90356f4763cbc93a59d373b6ff586c033e56c4e7 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run detect

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-ccf-registration-0.0.32
process capsule_aind_smartspim_ccf_registration_8 {
	tag 'capsule-6045222'
	container "$REGISTRY_HOST/capsule/30b4f986-4d55-452f-aae7-463e19dba67d:4039507616948f9280eb6f782920d0a5"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_32_30.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_ccf_registration_0_0_32_31.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_ccf_registration_8_32.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_pipeline_dispatcher_100_6_20
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_8_to_capsule_aind_smartspim_cell_quantification_151_7_29

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=30b4f986-4d55-452f-aae7-463e19dba67d
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/lightsheet_template_ccf_registration" "capsule/data/lightsheet_template_ccf_registration" # id: 9be4e3ac-adfb-4335-824c-bd99364a2c0f

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6045222.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6045222.git" capsule-repo
	fi
	git -C capsule-repo checkout b1a1c8d3fbc2b5876f87a50b14e738a4fc78603b --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-segmentation-0.0.9
process capsule_aind_smartspim_cell_segmentation_007_9 {
	tag 'capsule-5009831'
	container "$REGISTRY_HOST/published/0d01bdb8-e530-40b8-8311-883814bde142:v5"

	cpus 16
	memory '240 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_cell_segmentation_007_9_33.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_segmentation_007_9_34.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_cell_segmentation_007_9_35.flatten()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_007_9_to_capsule_aind_smartspim_classification_003_10_40

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=0d01bdb8-e530-40b8-8311-883814bde142
	export CO_CPUS=16
	export CO_MEMORY=257698037760

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5009831.git" capsule-repo
	else
		git clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5009831.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-classification-0.0.6
process capsule_aind_smartspim_classification_003_10 {
	tag 'capsule-4355840'
	container "$REGISTRY_HOST/published/eab3673c-2c7f-488b-82b9-75dbfdddcb53:v4"

	cpus 16
	memory '120 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_classification_003_10_36.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_classification_003_10_37.collect()
	path 'capsule/data/smartspim_production_models' from smartspim_production_models_to_aind_smartspim_classification_0_0_6_38.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_002_3_to_capsule_aind_smartspim_classification_003_10_39.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_007_9_to_capsule_aind_smartspim_classification_003_10_40

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_cell_quantification_151_7_25
	path 'capsule/results/*' into capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_43

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=eab3673c-2c7f-488b-82b9-75dbfdddcb53
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4355840.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4355840.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-pipeline-dispatcher-1.0.1
process capsule_aind_smartspim_pipeline_dispatcher_100_11 {
	tag 'capsule-3294345'
	container "$REGISTRY_HOST/capsule/7adb694b-b8cd-42ef-ba37-4639508b7ee0:3d43415e5e57512b3d1a406b222b7a58"

	cpus 2
	memory '15 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_41.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_100_6_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_42.collect()
	path 'capsule/data/' from capsule_aind_smartspim_classification_003_10_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_43.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_151_7_to_capsule_aind_smartspim_pipeline_dispatcher_100_11_44.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=7adb694b-b8cd-42ef-ba37-4639508b7ee0
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3294345.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3294345.git" capsule-repo
	fi
	git -C capsule-repo checkout 8cb0cf277c47680908e318fd0bf7998bec31778d --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean

	echo "[${task.tag}] completed!"
	"""
}
