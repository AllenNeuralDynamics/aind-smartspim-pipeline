#!/usr/bin/env nextflow
// hash:sha256:53fe9d9e8608fe18cb38cdf06aa32e0ff0f3dd9dbe2997edda833bbd260ecb80

nextflow.enable.dsl = 1

params.smartspim_test_dataset_url = 's3://aind-msma-morphology-data/test_data/SmartSPIM/unstitched_test_smartspim_format'

smartspim_test_dataset_to_aind_smartspim_validation_1 = channel.fromPath(params.smartspim_test_dataset_url + "/", type: 'any')
smartspim_test_dataset_to_aind_destripe_shadow_correction_2 = channel.fromPath(params.smartspim_test_dataset_url + "/SmartSPIM/Ex_*_Em_*", type: 'any')
smartspim_test_dataset_to_aind_destripe_shadow_correction_3 = channel.fromPath(params.smartspim_test_dataset_url + "/data_description.json", type: 'any')
smartspim_test_dataset_to_aind_destripe_shadow_correction_4 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_destripe_shadow_correction_5 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives", type: 'any')
capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_2_6 = channel.create()
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_7 = channel.create()
smartspim_test_dataset_to_aind_smartspim_stitch_8 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_stitch_9 = channel.fromPath(params.smartspim_test_dataset_url + "/data_description.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_fuse_10 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_fuse_11 = channel.fromPath(params.smartspim_test_dataset_url + "/data_description.json", type: 'any')
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_12 = channel.create()
capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_13 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_14 = channel.create()
smartspim_test_dataset_to_aind_smartspim_ccf_registration_15 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_ccf_registration_16 = channel.fromPath(params.smartspim_test_dataset_url + "/acquisition.json", type: 'any')
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_17 = channel.create()
capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_18 = channel.create()
capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_19 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_20 = channel.create()
smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_21 = channel.fromPath(params.smartspim_test_dataset_url + "/*.json", type: 'any')
smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_22 = channel.fromPath(params.smartspim_test_dataset_url + "/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_23 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_24 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_25 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_26 = channel.create()
capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_cell_quantification_8_27 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_28 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_31 = channel.create()
capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_32 = channel.create()
capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_pipeline_dispatcher_9_33 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_34 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_35 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_36 = channel.create()
capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_37 = channel.create()
capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_classification_gpu_10_38 = channel.create()
capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_classification_gpu_10_39 = channel.create()
capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_classification_gpu_10_40 = channel.create()

// capsule - aind-smartspim-validation
process capsule_aind_smartspim_validation_1 {
	tag 'capsule-7794579'
	container "$REGISTRY_HOST/published/9aab765d-b4b5-4e11-84fa-27557bc3c043:v4"

	cpus 8
	memory '64 GB'

	input:
	path 'capsule/data' from smartspim_test_dataset_to_aind_smartspim_validation_1.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_2_6

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
	tag 'capsule-2988281'
	container "$REGISTRY_HOST/published/c055a106-47c8-4975-8606-b8125c1e8da8:v4"

	cpus 32
	memory '128 GB'

	input:
	path 'capsule/data/' from smartspim_test_dataset_to_aind_destripe_shadow_correction_2
	path 'capsule/data/' from smartspim_test_dataset_to_aind_destripe_shadow_correction_3.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_destripe_shadow_correction_4.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_destripe_shadow_correction_5.collect()
	path 'capsule/data/' from capsule_aind_smartspim_validation_1_to_capsule_aind_destripe_shadow_correction_2_6.collect()

	output:
	path 'capsule/results/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_7
	path 'capsule/results/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_12
	path 'capsule/results/image_destriping_*_processing.json' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_17
	path 'capsule/results/flatfield_correction_*' into capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_18

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
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2988281.git" capsule-repo
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
	container "$REGISTRY_HOST/published/9b17439a-7538-4340-962f-cd756a4461ef:v1"

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_stitch_3_7.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_8.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_stitch_9.collect()

	output:
	path 'capsule/results/volume_alignments.xml' into capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_13
	path 'capsule/results/stitch_*' into capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_23

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
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3347076.git" capsule-repo
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
	container "$REGISTRY_HOST/published/eb6d2a76-afa8-4cbf-9282-5bd0604b38eb:v1"

	cpus 32
	memory '256 GB'

	input:
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_10.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_fuse_11.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_fuse_4_12.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_fuse_4_13.collect()

	output:
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_14
	path 'capsule/results/fusion_*' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_20
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_24
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_31
	path 'capsule/results/fusion_*/OMEZarr/Ex_*_Em_*.zarr' into capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_classification_gpu_10_38

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
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0587185.git" capsule-repo
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
	container "$REGISTRY_HOST/published/d61333f3-fd41-464e-9dac-dbdad02aec54:v1"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_ccf_registration_5_14.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_ccf_registration_15.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_ccf_registration_16.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_19
	path 'capsule/results/*' into capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_32

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
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8584302.git" capsule-repo
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
	container "$REGISTRY_HOST/published/b020c3b5-693e-418b-ad6a-f204a681ad89:v10"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_17.collect()
	path 'capsule/data/' from capsule_aind_destripe_shadow_correction_2_to_capsule_aind_smartspim_pipeline_dispatcher_6_18.collect()
	path 'capsule/data/ccf_registration_results/' from capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_pipeline_dispatcher_6_19.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_pipeline_dispatcher_6_20.collect()
	path 'capsule/data/input_aind_metadata/' from smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_21.collect()
	path 'capsule/data/' from smartspim_test_dataset_to_aind_smartspim_pipeline_dispatcher_22.collect()
	path 'capsule/data/stitched/' from capsule_aind_smartspim_stitch_3_to_capsule_aind_smartspim_pipeline_dispatcher_6_23.collect()

	output:
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_25
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_26
	path 'capsule/results/segmentation_processing_manifest_*.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_28
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29
	path 'capsule/results/output_aind_metadata/acquisition.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30
	path 'capsule/results/output_aind_metadata/processing.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_34
	path 'capsule/results/modified_processing_manifest.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_35
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_36
	path 'capsule/results/output_aind_metadata/data_description.json' into capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_classification_gpu_10_39

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
	git clone --branch v10.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6466712.git" capsule-repo
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
	container "$REGISTRY_HOST/published/0d01bdb8-e530-40b8-8311-883814bde142:v2"

	cpus 16
	memory '256 GB'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_segmentation_7_24.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_25.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_segmentation_7_26.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_classification_gpu_10_40

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
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5009831.git" capsule-repo
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
	container "$REGISTRY_HOST/published/73da6d60-4501-40cd-b258-1672d6a1773e:v6"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_cell_quantification_8_27.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_28.flatten()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_29.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_quantification_8_30.collect()
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_quantification_8_31.collect()
	path 'capsule/data/' from capsule_aind_smartspim_ccf_registration_5_to_capsule_aind_smartspim_cell_quantification_8_32.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_37

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
	git clone --branch v6.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3254921.git" capsule-repo
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
	container "$REGISTRY_HOST/published/b020c3b5-693e-418b-ad6a-f204a681ad89:v10"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_pipeline_dispatcher_9_33.collect()
	path 'capsule/data/output_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_34.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_35.collect()
	path 'capsule/data/input_aind_metadata/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_pipeline_dispatcher_9_36.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_quantification_8_to_capsule_aind_smartspim_pipeline_dispatcher_9_37.collect()

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
	git clone --branch v10.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6466712.git" capsule-repo
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
	tag 'capsule-8095075'
	container "$REGISTRY_HOST/published/5f824a9c-2d51-400a-833b-29335e47f144:v1"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/fused/' from capsule_aind_smartspim_fuse_4_to_capsule_aind_smartspim_cell_classification_gpu_10_38.collect()
	path 'capsule/data/' from capsule_aind_smartspim_pipeline_dispatcher_6_to_capsule_aind_smartspim_cell_classification_gpu_10_39.collect()
	path 'capsule/data/' from capsule_aind_smartspim_cell_segmentation_7_to_capsule_aind_smartspim_cell_classification_gpu_10_40

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_cell_quantification_8_27
	path 'capsule/results/*' into capsule_aind_smartspim_cell_classification_gpu_10_to_capsule_aind_smartspim_pipeline_dispatcher_9_33

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=5f824a9c-2d51-400a-833b-29335e47f144
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/smartspim_18_model" "capsule/data/smartspim_18_model" # id: 459560f0-c7bb-406a-8a67-73ba8450bbd0

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8095075.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
