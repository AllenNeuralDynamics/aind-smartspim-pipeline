# aind-smartspim-pipeline

Nextflow pipeline for processing SmartSPIM light-sheet microscopy datasets on SLURM clusters and AWS Batch / Code Ocean. This pipeline has the following steps:

- [aind-smartspim-destripe](https://github.com/AllenNeuralDynamics/aind-smartspim-destripe): Removes horizontal streaks from individual 2D tiles using a wavelet-based filtering algorithm and applies flat field correction (estimated retrospectively if not provided).
- [aind-smartspim-stitch](https://github.com/AllenNeuralDynamics/aind-smartspim-stitch): Estimates tile stitching transformations for the whole dataset to allow reconstruction.
- [aind-smartspim-fuse](https://github.com/AllenNeuralDynamics/aind-smartspim-fuse): Reconstructs the dataset from stitching transformations. Output is OMEZarr format.
- [aind-smartspim-ccf-registration](https://github.com/AllenNeuralDynamics/aind-smartspim-ccf-registration): Registers datasets to the Allen CCFv3 atlas using the third multiscale.
- [aind-smartspim-pipeline-dispatcher](https://github.com/AllenNeuralDynamics/aind-smartspim-pipeline-dispatcher): Copies fused data to the destination, creates processing metadata ([aind-data-schema](https://github.com/AllenNeuralDynamics/aind-data-schema)), and generates Neuroglancer visualization links.
- [aind-smartspim-segmentation](https://github.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation): Chunked cell proposals using an optimized DoG. Generates Neuroglancer links for visualization.
- [aind-smartspim-classification](https://github.com/AllenNeuralDynamics/aind-smartspim-classification): Cell classification of cell proposals using a fine-tuned [cellfinder](https://github.com/brainglobe/cellfinder) model.
- [aind-smartspim-quantification](https://github.com/AllenNeuralDynamics/aind-smartspim-quantification): Maps detected cell locations into CCFv3 atlas space and generates regional cell count CSVs.

# Input
The SmartSPIM pipeline input is a dataset that must have the following data convention:
- SmartSPIM_ID_YYYY-MM-DD_HH-mm-ss
    - SmartSPIM
        - Ex_xxx_Em_xxx
        - Ex_xxx_Em_xxx
        - Ex_xxx_Em_xxx
    - derivatives:
        - metadata.json
        - processing_manifest.json
        - DarkMaster_cropped.tif
        - Other files coming from the microscope
    - acquisition.json
    - data_description.json
    - instrument.json
    - subject.json

## Input details
- SmartSPIM: Folder that contains the dataset channels. The folders must include the excitation wavelength and emission wavelength.
- Derivatives: This folder needs to have the `metadata.json` that comes from the microscope, `processing_manifest.json` contains the parameters to process the dataset and the `DarkMaster_cropped.tif` is the darkfield of the microscope.
- jsons: They need to be created prior sending the dataset through the pipeline. Please, follow the [aind-data-schema](https://github.com/AllenNeuralDynamics/aind-data-schema/tree/dev/examples) examples to learn how to create them.

### Processing manifest
Example of a processing manifest for pipeline execution.
```python
{
    "pipeline_processing": {
        "stitching": {
            "channel": "Ex_561_Em_593",
            "resolution": [
                {
                    "axis_name": "X",
                    "unit": "micrometer",
                    "resolution": 1.8
                },
                {
                    "axis_name": "Y",
                    "unit": "micrometer",
                    "resolution": 1.8
                },
                {
                    "axis_name": "Z",
                    "unit": "micrometer",
                    "resolution": 2.0
                }
            ],
            "cpus": 32
        },
        "registration": {
            "channels": [
                "Ex_639_Em_660"
            ],
            "input_scale": 3
        },
        "segmentation": {
            "channels": [
                "Ex_488_Em_525",
                "Ex_561_Em_593"
            ],
            "input_scale": "0",
            "chunksize": "128",
            "signal_start": "0",
            "signal_end": "-1"
        }
    }
}
```
    
# Output
The output is a folder with the following structure:
- SmartSPIM_ID_YYYY-MM-DD_HH-mm-ss_stitched_YYYY-MM-DD_HH-mm-ss
    - acquisition.json
    - data_description.json
    - instrument.json
    - subject.json
    - processing.json
    - neuroglancer_config.json
    - image_atlas_alignment/
    - image_cell_quantification/
    - image_cell_segmentation/
    - image_tile_fusing/

## Output details
All the .jsons are copied from the raw dataset except from `processing.json`.

- processing.json: This file contains all the image processing steps performed to transform the raw dataset into the processed one. This file also contains the parameters, code versions, software versions and locations of the input data for each algorithm for easy reproducibility.
- neuroglancer_config.json: Neuroglancer link that could be used to visualize the data. If the pipeline is deployed in the SLURM cluster, you will have to instantiate a local deploy of neuroglancer to visualize your data.
- image_atlas_alignment: Folder that contains all the results for CCF registration. It will include the transforms and registered images, as well as metadata for each of the steps and intermediate results for debugging.
- image_cell_quantification: Folder that contains the quantified cells. We provide visualization links for neuroglancer where you could visualize the cell counts per brain region in CCF space and a CSV with the counts.
- image_cell_segmentation: Folder that contains the results for the identified cells. It also includes visualization links and XML with the cell locations.
- image_tile_fusing: Folder that contains the stitched channels in OMEZarr format.

# Prerequisites

Before deployment, ensure the following tools are installed and accessible on the submission host:

| Tool | Minimum version | Purpose |
|---|---|---|
| [Nextflow](https://www.nextflow.io/docs/latest/install.html) | 22.10.8 | Pipeline orchestration (pinned via `NXF_VER=22.10.8`) |
| [Singularity](https://docs.sylabs.io/guides/3.0/user-guide/installation.html) / [Apptainer](https://apptainer.org/docs/user/main/quick_start.html) | any recent | Container runtime on HPC compute nodes |
| [conda](https://docs.conda.io/projects/conda/en/stable/user-guide/install/) or [mamba](https://mamba.readthedocs.io/) | any recent | Required by `environment/create_slurm_env.sh` |

**Pipeline script to use:** `pipeline/main_slurm_v3.nf` (current production version). `main_slurm_v2.nf` is deprecated, untested and kept only for historical reference.

# Approximate runtimes

These are rough wall-clock estimates on a 16-core / 128 GB node for a typical single-channel dataset. Actual times vary with dataset size.

| Stage | Typical time | Notes |
|---|---|---|
| Flatfield estimation | ~1 h | Scales with number of tiles |
| Preprocessing (destripe) | ~4–8 h | Parallel across channels |
| Stitching | ~2–3 h | Memory-intensive |
| Fusion | ~3-5 h | Largest single step |
| CCF registration | ~1 h | — |
| Cell detection | ~3-4 h | Requires GPU |
| Cell classification | ~1-2 h | Requires GPU |
| Cell quantification | ~1 h | — |
| Dispatcher (×2) | ~30 min each | Metadata + file copy |

# Deployments
## SLURM
To deploy on a SLURM cluster, you need to have access to a SLURM cluster and have Nextflow and Singularity/Apptainer installed. To create the environment suitable to execute the pipeline, you can use the following bash script: `environment/create_slurm_env.sh`.
```bash
bash environment/create_slurm_env.sh /path/to/environment
```
After execution, the script will create the environment in the provided location. We recommend using the script `create_singularity_containers.sh` to avoid having the submission job creating the SIFs as these could fail depending the resources the node has. Please, place these SIFs in the nextflow work directory in a folder called 'singularity'.

Before submission, you need to configure the `nextflow_slurm.config` file to use your the partition you want in your SLURM to execute the pipeline.

### Configuration

All deployment-specific settings live in a single file: `pipeline/deployment.env`. This file is **not** committed (it is in `.gitignore`) so each user maintains their own copy per cluster. Copy the example and fill in your paths:

```bash
cp pipeline/deployment.env.example pipeline/deployment.env
# Edit pipeline/deployment.env with your paths and settings
```

Key variables in `pipeline/deployment.env`:

| Variable | Description |
|---|---|
| `PIPELINE_PATH` | Absolute path to the root of this repository |
| `DATA_PATH` | Path to the raw SmartSPIM dataset |
| `RESULTS_PATH` | Path for Nextflow logs and reports |
| `WORKDIR` | Nextflow work directory (intermediate files; use scratch storage) |
| `OUTPUT_PATH` | Where processed results are written (use `s3://…` when `CLOUD=true`) |
| `TEMPLATE_PATH` | Path to the CCF / SmartSPIM template volume |
| `CELL_MODELS_PATH` | Path to the cell-detection model weights directory |
| `CLOUD` | `"true"` to upload results to S3; `"false"` for local output only |

Optional settings (commented out in the example; leave unset to use the defaults):

| Variable | Description |
|---|---|
| `INPUT_PATH` | Raw-data root for channel splitting. The dispatcher looks for channels under `<INPUT_PATH>/<data_description.name>/SPIM`. It defaults to the parent folder of `DATA_PATH`, so set it if your dataset folder name differs from `data_description.json`'s `name`. |
| `NG_BASE_URL`, `CCF_ANNOTATION_S3`, `CO_DOMAIN` | Neuroglancer base URL, CCF annotation volume and CodeOcean org URL used in result links |
| `DATA_FOLDER`, `RESULTS_FOLDER` | Override the dispatcher's data/results folders |
| `ALERT_BOT_LINK`, `API_SECRET`, `SES_TOKEN_PATH`, `SMARTSHEET_ID`, `SOURCE_EMAIL` | Teams alerts, CodeOcean token and email alerts. Exported into the dispatcher containers only when set. |

The submit script passes the optional settings to the pipeline only when they are set. `make check-deploy` verifies that every variable in the example reaches the pipeline.

Capsule versions are managed separately in `environment/versions.env` — do not set them in `deployment.env`.

### Submitting the pipeline

Once `deployment.env` is configured, submit with:

```bash
sbatch pipeline/submit_pipeline_to_slurm.sh
```

The script reads your settings, auto-generates `pipeline/versions.config` from `environment/versions.env`, and launches Nextflow. You never need to edit `submit_pipeline_to_slurm.sh` itself.

> [!IMPORTANT]
> Set the `queue` in `pipeline/nextflow_slurm.config` to the SLURM partition that should run the **compute jobs** (not the submission job). The `#SBATCH --partition` in `submit_pipeline_to_slurm.sh` only controls where Nextflow itself runs. Override it at submission time without editing the file:
> ```bash
> sbatch --partition=cpu_light pipeline/submit_pipeline_to_slurm.sh
> ```

To resume a previous execution, simply re-submit — `-resume` is already included in the script and Nextflow automatically continues from the last checkpoint.

> [!IMPORTANT]
> If at some point, you are getting a 140 code error, most likely the dataset is large and you need to increase the time of that process.
> After trying to resume a previous job that failed due to a 140 code error, you could get an error saying *"Unable to acquire lock on session"* which means that there is already a job running for that execution. In that case, you could:
- Use the lsof command with the process path to get the PID of the running job and kill it.
```batch
lsof /path/to/process/workdir/db/LOCK
```
- If the lsof command does not show any job, you could delete the LOCK file in the working directory of that process and restart the job.
```batch
rm /path/to/process/workdir/db/LOCK
```
- Update the nextflow_slurm.config to align with the configuration of your SLURM cluster. Please, check the `envWhitelist` to make sure you are able to access `SLURM_JOBID`, `SLURM_JOB_CPUS_PER_NODE` and `SLURM_JOB_GPUS`. Many of the processes are using this information to dynamically assign the workload based on available resources.
- Make sure the container option in the processes contain --nv in the GPU processes to be able to load the GPUs and drivers.

## Additional troubleshooting

**Out-of-memory (OOM) errors**
Increase the `memory` directive for the failing process in `pipeline/main_slurm_v3.nf`, or pass more memory to the SLURM job via `clusterOptions = '--mem=512G'` for that process label.

**Network error during `git clone` inside a process**
Each process clones the capsule code from GitHub at runtime. If the compute nodes have no outbound internet access, either:
1. Pre-clone the repos to a shared filesystem and mount them via `--bind` in the Singularity run options, or
2. Configure an HTTP proxy via `HTTPS_PROXY` in `envWhitelist` of `nextflow_slurm.config`.

**CUDA not available in GPU processes**
- Confirm `--nv` is present in `containerOptions` for processes labeled `gpu`.
- Confirm `SLURM_JOB_GPUS` is in the `envWhitelist` and that your partition exposes it.
- Run `nvidia-smi` on the compute node directly to check driver availability.

**Singularity image pull failures**
Pre-build all images with `environment/create_singularity_containers.sh` and place the resulting `.sif` files in `$WORKDIR/singularity/`. Then change each `container` directive to point to the local path instead of the `ghcr.io/` URL.

---
**NOTE**

> The following pipeline parameters are used for Nextflow: PIPELINE_PATH, DATA_PATH, RESULTS_PATH, WORKDIR. The rest of the parameters are used for each of the image processing steps in the pipeline.

This pipeline is currently using Nextflow DSL1. Currently, this version is not supported by Nextflow and we will be migrating the nextflow script to DSL2 in a future release. Please, follow this [issue](https://github.com/AllenNeuralDynamics/aind-smartspim-pipeline/issues/7) for more information.
---

# Development and testing

The repo has two pipelines that must stay in sync:
- **`pipeline/main.nf`**: runs on CodeOcean / AWS Batch. CodeOcean generates it from `.codeocean/nextflow.json`; never edit or lint it by hand.
- **`pipeline/main_slurm_v3.nf`**: runs on SLURM and is maintained by hand. Every check below targets it.

`pipeline/main_slurm_v2.nf` is deprecated and untested.

All checks run through `make`, and CI runs the same targets, so a local run matches CI.

## Prerequisites

| Tool | Version | Needed for |
|---|---|---|
| Python | 3.9+ (standard library only) | every check |
| [shellcheck](https://www.shellcheck.net/) | any recent | `make lint` |
| [Nextflow](https://www.nextflow.io/docs/latest/install.html) | 22.10.8 (the Makefile pins `NXF_VER`) | `make stub`, `make stub-direct` |
| Java | 17 for nf-test; 11+ for `stub-direct` | stub runs |
| [nf-test](https://www.nf-test.com/) | 0.9.5 | `make stub` |
| Docker | any recent | `make smoke` only |

Install nf-test into the current directory with `curl -fsSL https://code.askimed.com/install/nf-test | bash -s 0.9.5`. No GPU, HPC or data is needed for anything except the smoke tests.

## Commands

```bash
make                    # list targets
make test               # every fast check (Tiers 0-2); run before every push
make test STUB=stub-direct   # same, on a machine without Java 17 / nf-test
```

| Target | Tier | What it checks |
|---|---|---|
| `make lint` | 0 | shellcheck on `environment/*.sh` and the submit script |
| `make check-versions` | 0 | `pipeline/versions.config` matches `environment/versions.env` |
| `make check-deploy` | 0 | every `deployment.env.example` setting reaches Nextflow; passed `--params` exist in `main_slurm_v3.nf`; exported variables are in `envWhitelist` |
| `make versions` | — | regenerates `pipeline/versions.config` (then commit both files) |
| `make parity` | 1 | CodeOcean wiring, capsule arguments and versions match `main_slurm_v3.nf`, apart from documented differences |
| `make stub` | 1 | nf-test stub run of `main_slurm_v3.nf` on a 2-channel stub dataset: task count per process, published results |
| `make stub-direct` | 1 | the same stub run with plain Nextflow (no nf-test) |
| `make check-refs` | 2 | for every process: image tag on GHCR, `linux/amd64` build, git tag, GitHub Release, entrypoint at that tag |
| `make smoke [CAPSULE="stitching fusion"]` | 3 | pulls each image, clones the pinned code inside it and imports its entrypoint (catches new code on an old image) |

Set `GITHUB_TOKEN` to avoid GitHub API rate limits in `make check-refs`.

## Test tiers

| Tier | Catches | Runs in CI |
|---|---|---|
| 0 Static | shell errors, stale `versions.config`, `deployment.env` settings that never reach the pipeline | every PR (`ci.yml`) |
| 1 Wiring | broken channel wiring or fan-out in `main_slurm_v3.nf`; drift from the CodeOcean pipeline | every PR (`ci.yml`) |
| 2 Artifacts | missing or unpublished image, tag, release or entrypoint | every PR (`ci.yml`) and nightly (`smoke.yml`) |
| 3 Container smoke | code that doesn't import in its image; missing git or Java jars | PRs touching versions, pipelines or `.codeocean/`, plus nightly (`smoke.yml`) |
| 4 Synthetic data *(planned)* | end-to-end failures of the real capsules on a small generated dataset | manual / weekly on a GPU runner or SLURM (`integration.yml`, disabled) |
| 5 Real data *(planned)* | scientific regressions on TB-scale benchmark brains | manual, before pipeline releases; never in PR CI |

The stub run does **not** check scientific correctness, container contents or network access; Tiers 2-3 cover artifacts and containers, and Tiers 4-5 will cover real data (see [docs/testing_roadmap.md](docs/testing_roadmap.md)).

## Bumping a capsule

1. Cut a GitHub Release in the capsule repo.
2. Build and push the image with `environment/build_envs.sh` and `environment/push_envs.sh`.
3. In `environment/versions.env`, set the image tag (`*_VERSION`) and the code release (`*_REF`). They can differ: stitch uses image `si-1.2.9` with code `v1.2.9`. The repository each capsule is cloned from is also set there (`*_REPO`); change it to move a capsule to another repo or point it at a mirror. `main_slurm_v3.nf` and `build_envs.sh` both read these values, so nothing else needs editing.
4. Run `make versions test`, and `make smoke CAPSULE=<process>` if docker is available.
5. If CodeOcean isn't bumped at the same time, `make parity` reports the version drift. Add it to `tests/parity_allowlist.json` with a reason, and remove the entry once CodeOcean catches up.
6. Open a PR. The smoke tests run automatically because `versions.env` changed.

## Keeping SLURM in sync with CodeOcean

After CodeOcean re-exports `main.nf` and `.codeocean/nextflow.json`, run `make parity`. Each reported difference either needs a fix in `main_slurm_v3.nf`, or an entry in `tests/parity_allowlist.json` explaining why SLURM differs, for example local data staging or bucket arguments. Allowlist entries that no longer match anything also fail, so the list stays current.

# Datasets for pipeline processing

- [SmartSPIM template v1.0](https://open.quiltdata.com/b/aind-open-data/tree/SmartSPIM-template_2024-05-16_11-26-14/): Please, download this dataset.
- [SmartSPIM cell detection models](https://open.quiltdata.com/b/aind-benchmark-data/tree/mesoscale-anatomy-cell-detection/models/smartspim_production_models/): Please, download one of the cell detection models suitable for your image processing task.

Once the datasets are downloaded, you need to point the pipeline to them.