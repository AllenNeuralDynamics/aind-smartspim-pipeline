# Testing roadmap

Tiers 0–3 are in place; see "Development and testing" in the [README](../README.md) for how to run them. This page plans the data-driven tiers, which are not built yet because real SmartSPIM datasets are terabytes.

## Where we are

| Tier | Status | Entry point |
|---|---|---|
| 0 Static | done | `make lint check-versions` |
| 1 Wiring | done | `make parity stub` |
| 2 Artifacts | done | `make check-refs` |
| 3 Container smoke | done | `make smoke` |
| 4 Synthetic mini-dataset | planned | `integration.yml` (disabled), `tests/integration/pipeline.nf.test` |
| 4b CodeOcean run | planned | — |
| 5 Real data | planned | — |

Tiers 0–3 prove that the pipeline is wired correctly and that every pinned image and piece of code can be fetched and imported. They don't run any capsule on data.

## Tier 4: synthetic mini-dataset

**Goal:** run the real capsules end to end in minutes, on a dataset small enough to generate or keep on S3.

- **Dataset generator:** `tests/synthetic/make_dataset.py` writes a SmartSPIM-shaped dataset:
  - 2×2 tiles, 2 channels (`Ex_488_Em_525`, `Ex_561_Em_600`), with small OME-Zarr tiles and overlap so stitching has something to register;
  - bright blobs for cell detection and classification to find;
  - valid `acquisition.json`, `data_description.json`, `SPIM/derivatives/processing_manifest.json`, `metadata.json` and dark/flat images.

  The target size is 100 MB–1 GB. Generating the data from a seed keeps it reproducible and out of git.
- **Run:** `main_slurm_v3.nf` with real containers, using the existing `slurm_ci` profile in `tests/ci.config`. Cell proposals and classification need a GPU, so this runs on a self-hosted runner (labelled `gpu`, with Singularity) or through SLURM submission.
- **Assertions:**
  - every process completes;
  - the expected output folders exist (`image_tile_fusing`, `image_atlas_alignment`, `image_cell_segmentation`, `image_cell_quantification`);
  - the metadata files validate against aind-data-schema;
  - cell and quantification outputs are non-empty;
  - fused-volume shape and dtype are as expected.
- **Trigger:** `workflow_dispatch` and weekly. Too slow and GPU-bound for every PR.
- **Activation:** rework `.github/workflows/integration.yml` and `tests/integration/pipeline.nf.test` (currently disabled) to use the generated dataset instead of the S3 path it references today, which doesn't exist.

## Tier 4b: CodeOcean run

Upload the same mini-dataset as a CodeOcean data asset, and trigger `main.nf` through the CodeOcean API with a repo secret token. This validates the cloud path (AWS Batch, S3 buckets, capsule versions in CodeOcean), which Tier 4 can't reach. It runs on the same schedule as Tier 4.

## Tier 5: real data

**Goal:** catch scientific regressions before a pipeline release.

- **Benchmarks:** curate one or two benchmark brains (for example, one standard and one iDISCO, which have previously caused out-of-memory failures in stitching). Store reference outputs from a known-good release.
- **Run:** on SLURM, started manually or by a release workflow, never from PR CI. Results go to S3.
- **Regression report** against the reference outputs:
  - cell counts per CCF region, within a tolerance;
  - registration quality metrics;
  - stitching and fusion QC;
  - runtime and peak memory per process from `trace.txt`, which catches resource regressions such as the recent memory bumps.
- **Gate:** a pipeline release (a tag of this repo) requires a passing Tier 5 report.

## Order of work

1. Tier 4 dataset generator and assertions, run locally with docker on CPU; skip the GPU stages at first.
2. Self-hosted GPU runner, then enable `integration.yml` weekly.
3. Tier 4b CodeOcean trigger.
4. Tier 5 benchmark selection and reference outputs, then the regression report.
