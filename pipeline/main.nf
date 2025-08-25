#!/usr/bin/env nextflow
// hash:sha256:c81e076c627a3e9612f6c46bf113d62e37f9771371db37ce31c9b1f3dfedf645

nextflow.enable.dsl = 1

params.smartspim_dataset_url = 's3://aind-scratch-data/smartspim_dataset'

smartspim_dataset_to_aind_smartspim_flatfield_estimation_1 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/metadata.json", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_2 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/Ex_*_Em_*", type: 'any')
smartspim_dataset_to_aind_smartspim_flatfield_estimation_3 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_005_6_4 = channel.create()
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_5 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_6 = channel.fromPath(params.smartspim_dataset_url + "/acquisiton.json", type: 'any')
smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_7 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/Ex_*_Em_*.zarr", type: 'any')
capsule_create_individual_zgroup_9_to_capsule_aind_smartspim_stitch_127_7_8 = channel.create()
capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_stitch_127_7_9 = channel.create()
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_10 = channel.fromPath(params.smartspim_dataset_url + "/acquisiton.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_11 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')
smartspim_dataset_to_aind_smartspim_stitch_1_2_8_12 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/processing_manifest.json", type: 'any')
capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_13 = channel.create()
smartspim_dataset_to_aind_smartspim_fuse_0_0_5_bigstitcher_14 = channel.fromPath(params.smartspim_dataset_url + "/acquisiton.json", type: 'any')
capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_15 = channel.create()

// capsule - aind-smartspim-flatfield-estimation
process capsule_aind_smartspim_flatfield_estimation_5 {
	tag 'capsule-1467402'
	container "$REGISTRY_HOST/capsule/37c0404c-111e-4f43-8744-39616bae91f1"

	cpus 4
	memory '30 GB'

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_1.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_2.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_flatfield_estimation_3.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_005_6_4

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
	container "$REGISTRY_HOST/capsule/e989fbed-af2e-4552-b931-e7bd48e4b8cf"

	cpus 32
	memory '120 GB'

	input:
	path 'capsule/data/' from capsule_aind_smartspim_flatfield_estimation_5_to_capsule_aind_destripe_shadow_correction_005_6_4.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_5.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_6.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_destripe_shadow_correction_0_0_5_7.collect()

	output:
	path 'capsule/results/destriped_data/Ex_*_Em_*' into capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_stitch_127_7_9
	path 'capsule/results/destriped_data*' into capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_15

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
	container "$REGISTRY_HOST/capsule/7bba4392-d98e-48ef-9b33-242908c455cb"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/preprocessed_data/' from capsule_create_individual_zgroup_9_to_capsule_aind_smartspim_stitch_127_7_8.collect()
	path 'capsule/data/preprocessed_data/' from capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_stitch_127_7_9.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_10.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_11.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_stitch_1_2_8_12.collect()

	output:
	path 'capsule/results/*' into capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_13

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
	container "$REGISTRY_HOST/capsule/664683c7-6ac9-4968-91e3-08d5e2f430e7"

	cpus 16
	memory '120 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_smartspim_stitch_127_7_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_13.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_smartspim_fuse_0_0_5_bigstitcher_14.collect()
	path 'capsule/data/preprocessed_data/' from capsule_aind_destripe_shadow_correction_005_6_to_capsule_aind_smartspim_fuse_005_bigstitcher_8_15.collect()

	output:
	path 'capsule/results/*'

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
	container "$REGISTRY_HOST/capsule/2ae3bb33-55ac-48f4-ae22-93d148b0f5ab"

	cpus 1
	memory '7.5 GB'

	output:
	path 'capsule/results/zgroup_folder/.zgroup' into capsule_create_individual_zgroup_9_to_capsule_aind_smartspim_stitch_127_7_8

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
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5587181.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5587181.git" capsule-repo
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
