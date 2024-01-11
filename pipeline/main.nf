#!/usr/bin/env nextflow
// hash:sha256:e9d0c1af225496e4854022fc4a0e5ba674319ccb28323f78a26ee97a4c28772a

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
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_16 = channel.create()
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_17 = channel.create()
capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_18 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_19 = channel.create()
smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_20 = channel.fromPath(params.smartspim_test_dataset_url + "/*.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_21 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_22 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_23 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_24 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_25 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_26 = channel.create()
capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_quantification_8_27 = channel.create()
capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_28 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_31 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_32 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_33 = channel.create()
capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_34 = channel.create()
capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_pipeline_dispatcher_9_35 = channel.create()

// capsule - aind-smartspim-validation
process capsule_aind_smartspim_validation_1 {
	tag 'capsule-7794579'
	container 'registry.codeocean.allenneuraldynamics.org/published/9aab765d-b4b5-4e11-84fa-27557bc3c043:v1'

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

	export CO_CAPSULE_ID=9aab765d-b4b5-4e11-84fa-27557bc3c043
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-7794579.git" capsule-repo
	git -C capsule-repo checkout v1.0
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
	tag 'capsule-2988281'
	container 'registry.codeocean.allenneuraldynamics.org/published/c055a106-47c8-4975-8606-b8125c1e8da8:v2'

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
	path 'capsule/results/image_destriping_*_processing.json' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_16
	path 'capsule/results/flatfield_correction_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_17

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c055a106-47c8-4975-8606-b8125c1e8da8
	export CO_CPUS=32
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-2988281.git" capsule-repo
	git -C capsule-repo checkout v2.0
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
	tag 'capsule-3347076'
	container 'registry.codeocean.allenneuraldynamics.org/published/9b17439a-7538-4340-962f-cd756a4461ef:v1'

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_6.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_7.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_8.collect()

	output:
	path 'capsule/results/volume_alignments.xml' into capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_12
	path 'capsule/results/stitch_*' into capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_22

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9b17439a-7538-4340-962f-cd756a4461ef
	export CO_CPUS=32
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-3347076.git" capsule-repo
	git -C capsule-repo checkout v1.0
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
	tag 'capsule-0587185'
	container 'registry.codeocean.allenneuraldynamics.org/published/eb6d2a76-afa8-4cbf-9282-5bd0604b38eb:v1'

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_9.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_10.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_11.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_12.collect()

	output:
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_13
	path 'capsule/results/fusion_*' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_19
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_23
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_26

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=eb6d2a76-afa8-4cbf-9282-5bd0604b38eb
	export CO_CPUS=32
	export CO_MEMORY=274877906944

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-0587185.git" capsule-repo
	git -C capsule-repo checkout v1.0
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
	tag 'capsule-8584302'
	container 'registry.codeocean.allenneuraldynamics.org/published/d61333f3-fd41-464e-9dac-dbdad02aec54:v1'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_13.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_ccf_registration_14.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_ccf_registration_15.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_18
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_28

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

	ln -s "/tmp/data/ccf_atlas_image" "capsule/data/ccf_atlas_image" # id: 165a797d-cfca-420b-becc-0c89295ecf3f
	
	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-8584302.git" capsule-repo
	git -C capsule-repo checkout v1.0
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
	tag 'capsule-6466712'
	container 'registry.codeocean.allenneuraldynamics.org/published/b020c3b5-693e-418b-ad6a-f204a681ad89:v4'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_16.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_17.collect()
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_18.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_19.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_20.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_21.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_22.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_24
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_25
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30
	path 'capsule/results/output_aind_metadata/processing.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_31
	path 'capsule/results/modified_processing_manifest.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_32
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_33

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b020c3b5-693e-418b-ad6a-f204a681ad89
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-6466712.git" capsule-repo
	git -C capsule-repo checkout v4.0
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
	tag 'capsule-5009831'
	container 'registry.codeocean.allenneuraldynamics.org/published/0d01bdb8-e530-40b8-8311-883814bde142:v1'

	cpus 16
	memory '256 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_23.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_24.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_25.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_quantification_8_27
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_pipeline_dispatcher_9_35

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
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-5009831.git" capsule-repo
	git -C capsule-repo checkout v1.0
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
	tag 'capsule-3254921'
	container 'registry.codeocean.allenneuraldynamics.org/published/73da6d60-4501-40cd-b258-1672d6a1773e:v1'

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_26.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_quantification_8_27.collect()
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_28.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_34

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=73da6d60-4501-40cd-b258-1672d6a1773e
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-3254921.git" capsule-repo
	git -C capsule-repo checkout v1.0
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
	tag 'capsule-6466712'
	container 'registry.codeocean.allenneuraldynamics.org/published/b020c3b5-693e-418b-ad6a-f204a681ad89:v4'

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/output_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_31.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_32.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_33.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_34.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_pipeline_dispatcher_9_35.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b020c3b5-693e-418b-ad6a-f204a681ad89
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@codeocean.allenneuraldynamics.org/capsule-6466712.git" capsule-repo
	git -C capsule-repo checkout v4.0
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run clean

	echo "[${task.tag}] completed!"
	"""
}
