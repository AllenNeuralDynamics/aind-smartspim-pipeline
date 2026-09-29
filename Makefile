# Development and test entry points. CI runs these same targets.
# See "Development and testing" in README.md.

export NXF_VER := 22.10.8

PYTHON     ?= python3
SHELLCHECK ?= shellcheck
NF_TEST    ?= nf-test
# Use STUB=stub-direct on machines without Java 17 / nf-test
STUB       ?= stub
STUB_OUT   := .nf-test/stub-direct
# Space-separated process names for `make smoke`, e.g. CAPSULE="stitching fusion"
CAPSULE    ?=

.DEFAULT_GOAL := help
.PHONY: help test lint versions check-versions parity stub stub-direct check-refs smoke

help: ## List targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-15s %s\n", $$1, $$2}'

test: lint check-versions parity $(STUB) check-refs ## Run every fast check (Tiers 0-2) before pushing

lint: ## Tier 0: shellcheck all shell scripts
	$(SHELLCHECK) -x --source-path=SCRIPTDIR environment/*.sh pipeline/submit_pipeline_to_slurm.sh

versions: ## Regenerate pipeline/versions.config from environment/versions.env
	environment/render_versions_config.sh

check-versions: ## Tier 0: fail if pipeline/versions.config is stale
	$(PYTHON) tests/check_versions.py

parity: ## Tier 1: compare CodeOcean wiring/args/versions with main_slurm_v3.nf
	$(PYTHON) tests/check_parity.py

stub: ## Tier 1: nf-test stub run of main_slurm_v3.nf (needs Java 17)
	$(NF_TEST) test tests/stub/ --profile ci

stub-direct: ## Tier 1: same stub run with plain Nextflow (Java 11+ is enough)
	rm -rf $(STUB_OUT) && mkdir -p $(STUB_OUT)
	cd $(STUB_OUT) && nextflow -q \
		-c $(CURDIR)/tests/ci.config -c $(CURDIR)/pipeline/versions.config \
		run $(CURDIR)/pipeline/main_slurm_v3.nf -stub-run -profile ci \
		--lightsheet_dataset $(CURDIR)/tests/stub_data/dataset \
		--results_path $(CURDIR)/$(STUB_OUT)/nextflow \
		--output_path $(CURDIR)/$(STUB_OUT)/processed \
		--template_path $(CURDIR)/tests/stub_data/template \
		--cell_models_path $(CURDIR)/tests/stub_data/models \
		--cloud false \
		-with-trace $(CURDIR)/$(STUB_OUT)/trace.txt
	$(PYTHON) tests/check_stub_trace.py $(STUB_OUT)/trace.txt $(STUB_OUT)/nextflow

check-refs: ## Tier 2: images, platforms, git tags, releases and entrypoints exist
	$(PYTHON) tests/check_capsule_refs.py

smoke: ## Tier 3: pull images and import pinned code inside them (needs docker)
	$(PYTHON) tests/smoke_capsule.py $(CAPSULE)
