#!/usr/bin/env nextflow
// hash:sha256:4df5e25d6013aed6183e3800dfb42c1a1c0a4586a08dd72dddc70174dd5f043e

nextflow.enable.dsl = 1

params.smartspim_dataset_url = 's3://aind-scratch-data/smartspim_dataset'

smartspim_dataset_to_aind_destripe_shadow_correction_0_0_5_1 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/derivatives/metadata.json", type: 'any')
smartspim_dataset_to_aind_destripe_shadow_correction_0_0_5_2 = channel.fromPath(params.smartspim_dataset_url + "/SPIM/Ex_*_Em_*", type: 'any')
smartspim_dataset_to_aind_destripe_shadow_correction_0_0_5_3 = channel.fromPath(params.smartspim_dataset_url + "/data_description.json", type: 'any')

// capsule - aind-destripe-shadow-correction-0.0.5
process capsule_aind_destripe_shadow_correction_005_5 {
	tag 'capsule-6067584'
	container "$REGISTRY_HOST/capsule/e989fbed-af2e-4552-b931-e7bd48e4b8cf"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_5_1.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_5_2.collect()
	path 'capsule/data/' from smartspim_dataset_to_aind_destripe_shadow_correction_0_0_5_3.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e989fbed-af2e-4552-b931-e7bd48e4b8cf
	export CO_CPUS=1
	export CO_MEMORY=8053063680

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
