#!/usr/bin/env nextflow
// hash:sha256:af826e8597a50e4ee11c67085e82243a1204d7538bb48a661a03e78bf063bb06

nextflow.enable.dsl = 1

params.smartspim_test_dataset_url = 's3://aind-msma-morphology-data/test_data/SmartSPIM/unstitched_test_smartspim_format'

smartspim_test_dataset_to_aind_smartspim_validation_1 = channel.fromPath(params.smartspim_test_dataset_url + "/*", type: 'any')
smartspim_test_dataset_to_aind_destripe_shadow_correction_2 = channel.fromPath(params.smartspim_test_dataset_url + "/SmartSPIM/Ex_*_Em_*", type: 'any')
smartspim_test_dataset_to_aind_destripe_shadow_correction_3 = channel.fromPath(params.smartspim_test_dataset_url + "/data_description.json", type: 'any')
smartspim_test_dataset_to_aind_destripe_shadow_correction_4 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_2_5 = channel.create()
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_6 = channel.create()
smartspim_test_dataset_to_aind_smartspim_stitch_7 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_stitch_8 = channel.fromPath(params.smartspim_test_dataset_url + "/data_description.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_fuse_9 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_fuse_10 = channel.fromPath(params.smartspim_test_dataset_url + "/data_description.json", type: 'any')
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_11 = channel.create()
capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_12 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_13 = channel.create()
smartspim_test_dataset_to_aind_smartspim_ccf_registration_14 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_ccf_registration_15 = channel.fromPath(params.smartspim_test_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_16 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_17 = channel.create()
smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_18 = channel.fromPath(params.smartspim_test_dataset_url + "/*.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_19 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_20 = channel.create()
capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_21 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_22 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_23 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_24 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_25 = channel.create()
capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_quantification_8_26 = channel.create()
capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_27 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_28 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_30 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_31 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_32 = channel.create()
capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_33 = channel.create()
capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_pipeline_dispatcher_9_34 = channel.create()

// capsule - aind-smartspim-validation
process capsule_aind_smartspim_validation_1 {
	tag 'capsule-2501646'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/67445dcc-6871-4567-bef0-58a488c996bc'

	cpus 8
	memory '64 GB'

	input:
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_validation_1.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_2_5

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
process capsule_aind_destripe_shadow_correction_2 {
	tag 'capsule-3325535'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/fcca3922-bc11-430e-9c63-faa7575af52d'

	cpus 32
	memory '128 GB'

	input:
	path 'capsule/data/' from smartspim_test_dataset_to_aind_destripe_shadow_correction_2
	path 'capsule/data/' from smartspim_test_dataset_to_aind_destripe_shadow_correction_3.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_destripe_shadow_correction_4.collect()
	path 'capsule/data/' from capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_2_5.collect()

	output:
	path 'capsule/results/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_6
	path 'capsule/results/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_11
	path 'capsule/results/image_destriping_*_processing.json' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_20

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
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-3325535.git" capsule-repo
	git -C capsule-repo checkout cb4e4311ae5ef7bf6532166b81eeb3ec11c2e3db --quiet
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
	container 'registry.codeocean.allenneuraldynamics.org/capsule/1c4065c1-93e6-4bfc-af9d-7c6f4eea7e63'

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_6.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_7.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_8.collect()

	output:
	path 'capsule/results/volume_alignments.xml' into capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_12
	path 'capsule/results/stitch_*' into capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_21

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
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-4153248.git" capsule-repo
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
	container 'registry.codeocean.allenneuraldynamics.org/capsule/96191619-86f4-4f28-85c7-4f992fc4b30c'

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_9.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_10.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_11.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_12.collect()

	output:
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_13
	path 'capsule/results/fusion_*' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_17
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_22
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_25

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
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-2013512.git" capsule-repo
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
	container 'registry.codeocean.allenneuraldynamics.org/capsule/30b4f986-4d55-452f-aae7-463e19dba67d'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_13.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_ccf_registration_14.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_ccf_registration_15.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_16
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_27

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

	ln -s "/tmp/data/ccf_atlas_image" "capsule/data/ccf_atlas_image" # id: 165a797d-cfca-420b-becc-0c89295ecf3f
	
	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-6045222.git" capsule-repo
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
	container 'registry.codeocean.allenneuraldynamics.org/capsule/18f160f3-be42-49c7-87a3-0ed0938bfa28'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_16.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_17.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_18.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_19.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_20.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_21.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_23
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_24
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_28
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29
	path 'capsule/results/output_aind_metadata/processing.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_30
	path 'capsule/results/modified_processing_manifest.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_31
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_32

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
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-2991712.git" capsule-repo
	git -C capsule-repo checkout eb1353be287e3e854deb86627ffe93da01528b6a --quiet
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
	container 'registry.codeocean.allenneuraldynamics.org/capsule/e2be5aab-618f-4a9e-9d50-b5b649e169b1'

	cpus 16
	memory '256 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_22.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_23.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_24.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_quantification_8_26
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_pipeline_dispatcher_9_34

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
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-9761832.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-smartspim-cell-quantification
process capsule_aind_smartspim_cell_quantification_8 {
	tag 'capsule-8884276'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/2486f4d2-79b2-4862-946b-e3a14e780f1d'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_25.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_quantification_8_26.collect()
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_27.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_28.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_33

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

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-8884276.git" capsule-repo
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
process capsule_aind_smartspim_pipeline_dispatcher_9 {
	tag 'capsule-2991712'
	container 'registry.codeocean.allenneuraldynamics.org/capsule/18f160f3-be42-49c7-87a3-0ed0938bfa28'

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/output_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_30.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_31.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_32.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_33.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_pipeline_dispatcher_9_34.collect()

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
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-2991712.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean

	echo "[${task.tag}] completed!"
	"""
}
