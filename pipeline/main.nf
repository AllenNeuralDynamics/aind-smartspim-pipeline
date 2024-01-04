#!/usr/bin/env nextflow
// hash:sha256:49f7e932bf183f38a4aeac364d15d4bc0f2a24903f0aedbd84782daeac8d3500

nextflow.enable.dsl = 1

params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url = 's3://aind-msma-morphology-data/test_data/SmartSPIM/SmartSPIM_695464_2023-10-18_20-30-30'

smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_validation_1 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/*", type: 'any')
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_destripe_shadow_correction_2 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/SmartSPIM/Ex_*_Em_*", type: 'any')
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_destripe_shadow_correction_3 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/data_description.json", type: 'any')
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_destripe_shadow_correction_4 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_11_5 = channel.create()
capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_stitch_4_6 = channel.create()
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_stitch_7 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_stitch_8 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/data_description.json", type: 'any')
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_fuse_9 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_fuse_10 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/data_description.json", type: 'any')
capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_fuse_5_11 = channel.create()
capsule_aind_smartspim_stitch_4_to_capsule_aind_smartspim_fuse_5_12 = channel.create()
capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_to_capsule_aind_smartspim_dispatcher_cleanup_6_13 = channel.create()
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_dispatcher_cleanup_14 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/*.json", type: 'any')
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_dispatcher_cleanup_15 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_stitch_4_to_capsule_aind_smartspim_dispatcher_cleanup_6_16 = channel.create()
capsule_aind_smartspim_fuse_5_to_capsule_aind_smartspim_dispatcher_cleanup_6_17 = channel.create()
capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_dispatcher_cleanup_6_18 = channel.create()
capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_19 = channel.create()
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_pipeline_version_v1_5_smartspim_ccf_registration_capsule_20 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_pipeline_version_v1_5_smartspim_ccf_registration_capsule_21 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_aind_smartspim_dispatcher_cleanup_10_22 = channel.create()
capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_to_capsule_aind_smartspim_dispatcher_cleanup_10_23 = channel.create()
capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_to_capsule_aind_smartspim_dispatcher_cleanup_10_24 = channel.create()
smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_dispatcher_cleanup_25 = channel.fromPath(params.smartspim_695464_2023_10_18_20_30_30_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_26 = channel.create()
capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_27 = channel.create()
capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_28 = channel.create()
capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_29 = channel.create()
capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_30 = channel.create()
capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_31 = channel.create()
capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_32 = channel.create()

// capsule - aind-smartspim-validation
process capsule_aind_smartspim_validation_1 {
	tag 'capsule-2501646'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/67445dcc-6871-4567-bef0-58a488c996bc'

	cpus 8
	memory '64 GB'

	input:
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_validation_1.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_11_5

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=67445dcc-6871-4567-bef0-58a488c996bc
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-2501646.git" capsule-repo
	git -C capsule-repo checkout 23e37eb208e1261930f73db77557d1c4204216de --quiet
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
process capsule_aind_destripe_shadow_correction_11 {
	tag 'capsule-9408040'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/dcb5d8ec-80ee-4819-a916-2abbb12f6d6b'

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_destripe_shadow_correction_2.flatten()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_destripe_shadow_correction_3.collect()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_destripe_shadow_correction_4.collect()
	path 'capsule/data/' from capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_11_5.collect()

	output:
	path 'capsule/results/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_stitch_4_6
	path 'capsule/results/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_fuse_5_11
	path 'capsule/results/image_destriping_*_processing.json' into capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_dispatcher_cleanup_6_18

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=dcb5d8ec-80ee-4819-a916-2abbb12f6d6b
	export CO_CPUS=32
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-9408040.git" capsule-repo
	git -C capsule-repo checkout a16042248367617d8125a6e2d1759daa2e85ceb1 --quiet
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
process capsule_aind_smartspim_stitch_4 {
	tag 'capsule-7722045'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/e347889b-7798-4fbb-ab1c-29666245a61c'

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_stitch_4_6.collect()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_stitch_7.collect()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_stitch_8.collect()

	output:
	path 'capsule/results/volume_alignments.xml' into capsule_aind_smartspim_stitch_4_to_capsule_aind_smartspim_fuse_5_12
	path 'capsule/results/stitch_*' into capsule_aind_smartspim_stitch_4_to_capsule_aind_smartspim_dispatcher_cleanup_6_16

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e347889b-7798-4fbb-ab1c-29666245a61c
	export CO_CPUS=32
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-7722045.git" capsule-repo
	git -C capsule-repo checkout aad70f7f7601f52ff69a9ffffee66e9943280ffc --quiet
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
process capsule_aind_smartspim_fuse_5 {
	tag 'capsule-1204778'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/2a1c6668-7e21-474c-8e1e-6dbea015bbbc'

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_fuse_9.collect()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_fuse_10.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_fuse_5_11.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_4_to_capsule_aind_smartspim_fuse_5_12.collect()

	output:
	path 'capsule/results/fusion_*' into capsule_aind_smartspim_fuse_5_to_capsule_aind_smartspim_dispatcher_cleanup_6_17
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_19
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_26
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_30

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=2a1c6668-7e21-474c-8e1e-6dbea015bbbc
	export CO_CPUS=32
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-1204778.git" capsule-repo
	git -C capsule-repo checkout 41e556bb0484707532da836c332204b6734a7c1e --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-dispatcher-cleanup
process capsule_aind_smartspim_dispatcher_cleanup_6 {
	tag 'capsule-7523293'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/4fcb37cf-c589-43fa-87c3-e247b5a76d74'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/ccf_registration_results/' from capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_to_capsule_aind_smartspim_dispatcher_cleanup_6_13.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_dispatcher_cleanup_14.collect()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_dispatcher_cleanup_15.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_4_to_capsule_aind_smartspim_dispatcher_cleanup_6_16.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_5_to_capsule_aind_smartspim_dispatcher_cleanup_6_17.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_11_to_capsule_aind_smartspim_dispatcher_cleanup_6_18.collect()

	output:
	path 'capsule/results/output_aind_metadata/processing.json' into capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_aind_smartspim_dispatcher_cleanup_10_22
	path 'capsule/results/segmentation_processing_manifest*.json' into capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_27
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_31
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_32

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=4fcb37cf-c589-43fa-87c3-e247b5a76d74
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-7523293.git" capsule-repo
	git -C capsule-repo checkout 9c04713bfa93e183d405637c918ec78ef2832b81 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run dispatch

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Pipeline Version V1.5 - SmartSPIM CCF Registration Capsule
process capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7 {
	tag 'capsule-2638890'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/9d43c728-08b9-4c38-bbb2-2c24c5d85232'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_19.collect()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_pipeline_version_v1_5_smartspim_ccf_registration_capsule_20.collect()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_pipeline_version_v1_5_smartspim_ccf_registration_capsule_21.collect()

	output:
	path 'capsule/results/*' into capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_to_capsule_aind_smartspim_dispatcher_cleanup_6_13
	path 'capsule/results/*' into capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_28

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9d43c728-08b9-4c38-bbb2-2c24c5d85232
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/ccf_atlas_image" "capsule/data/ccf_atlas_image" # id: 165a797d-cfca-420b-becc-0c89295ecf3f
	
	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-2638890.git" capsule-repo
	git -C capsule-repo checkout 0690bf2c7a64f7bf6f12c6efeb19f1ef5321f93c --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-dispatcher-cleanup
process capsule_aind_smartspim_dispatcher_cleanup_10 {
	tag 'capsule-7523293'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/4fcb37cf-c589-43fa-87c3-e247b5a76d74'

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/output_aind_metadata/processing.json/' from capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_aind_smartspim_dispatcher_cleanup_10_22.collect()
	path 'capsule/data/' from capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_to_capsule_aind_smartspim_dispatcher_cleanup_10_23.collect()
	path 'capsule/data/' from capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_to_capsule_aind_smartspim_dispatcher_cleanup_10_24.collect()
	path 'capsule/data/' from smartspim_695464_2023_10_18_20_30_30_test_dataset_to_aind_smartspim_dispatcher_cleanup_25.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=4fcb37cf-c589-43fa-87c3-e247b5a76d74
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-7523293.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Pipeline Version V1.5 - SmartSPIM Quantification Capsule
process capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12 {
	tag 'capsule-0384741'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/b80b7066-fe16-4ad8-8ae8-670ca85f9927'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_26.collect()
	path 'capsule/data/' from capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_27.flatten()
	path 'capsule/data/' from capsule_pipeline_version_v_1_5_smart_spim_ccf_registration_capsule_7_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_28.collect()
	path 'capsule/data/' from capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_29.collect()

	output:
	path 'capsule/results/*' into capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_to_capsule_aind_smartspim_dispatcher_cleanup_10_23

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b80b7066-fe16-4ad8-8ae8-670ca85f9927
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-0384741.git" capsule-repo
	git -C capsule-repo checkout f1b5672229c70e05561cf5908b9a70f501385f98 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Pipeline Version V1.5 - SmartSPIM Cell Segmentation Capsule
process capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13 {
	tag 'capsule-1559032'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/c8d79a9d-f818-43b4-b7e1-cb86de410585'

	cpus 16
	memory '256 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_5_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_30.collect()
	path 'capsule/data/' from capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_31.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_dispatcher_cleanup_6_to_capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_32.collect()

	output:
	path 'capsule/results/*' into capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_to_capsule_aind_smartspim_dispatcher_cleanup_10_24
	path 'capsule/results/*' into capsule_pipeline_version_v_1_5_smart_spim_cell_segmentation_capsule_13_to_capsule_pipeline_version_v_1_5_smart_spim_quantification_capsule_12_29

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c8d79a9d-f818-43b4-b7e1-cb86de410585
	export CO_CPUS=16
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-1559032.git" capsule-repo
	git -C capsule-repo checkout 5c7ff180c027570685e15d042df49f90d3640d95 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
