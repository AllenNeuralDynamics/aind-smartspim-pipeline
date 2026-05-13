# aind-smartspim-pipeline

Nextflow pipeline for processing SmartSPIM light-sheet microscopy datasets on SLURM clusters and AWS Batch / Code Ocean. This pipeline has the following steps:

- [aind-smartspim-destripe](https://github.com/AllenNeuralDynamics/aind-smartspim-destripe): Removes horizontal streaks from individual 2D tiles using a wavelet-based filtering algorithm and applies flat field correction (estimated retrospectively if not provided).
- [aind-smartspim-stitch](https://github.com/AllenNeuralDynamics/aind-smartspim-stitch): Estimates tile stitching transformations for the whole dataset to allow reconstruction.
- [aind-smartspim-fuse](https://github.com/AllenNeuralDynamics/aind-smartspim-fuse): Reconstructs the dataset from stitching transformations. Output is OMEZarr format.
- [aind-ccf-registration](https://github.com/AllenNeuralDynamics/aind-ccf-registration): Registers datasets to the Allen CCFv3 atlas using the third multiscale.
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

**Pipeline script to use:** `pipeline/main_slurm_v3.nf` (current production version). `main_slurm_v2.nf` is retained for historical reference.

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

For submission, you can use the `pipeline/submit_pipeline_to_slurm.sh` script as a template for your script. In this script you will need to provide:
- PIPELINE_PATH: Path where the repository with the pipeline is located.
- DATA_PATH: Path where your dataset is located.
- RESULTS_PATH: Path where you want to store results by default.
- WORKDIR: Working directory for each of the processes in the pipeline.
- OUTPUT_PATH: Path where you want to save the processed dataset.
- TEMPLATE_PATH: Path for the SmartSPIM template. This is necessary for CCF registration.
- CELL_DETECTION_PATH: Path for the Cell Detection model. This is necessary to identify cells.
- CLOUD: "true" if you want to store the results in a cloud bucket (only AWS supported at the moment), "false" if you want to store the results locally.

Finally, depending your SLURM configuration, the containers for the image processing steps won't be downloaded from the cloud. In this scenario, you will need to download them prior execution and change the `pipeline/main_slurm_v3.nf` nextflow script to use the paths where the containers are stored.

Script example to execute pipeline:
```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4GB
#SBATCH --time=24:00:00
#SBATCH --partition=YOUR_PARTITION

PIPELINE_PATH="/your/repo-pipeline/path"
DATA_PATH="/path/to/your/data"
RESULTS_PATH="/path/to/your/outputs"
WORKDIR="/path/to/workdir"

# Change this output path to a S3 path if AWS cloud compatibility is needed
OUTPUT_PATH="/path/to/your/outputdir"

# Template path
TEMPLATE_PATH="/path/to/templatev2"

# Cell detection path
CELL_MODELS_PATH="/path/to/production-models"

# Setting cloud parameter - Useful if you want to store the results in a bucket
CLOUD="false"

NXF_VER=22.10.8 DATA_PATH=$DATA_PATH RESULTS_PATH=$RESULTS_PATH nextflow \
  -C $PIPELINE_PATH/pipeline/nextflow_slurm.config \
  -log $RESULTS_PATH/nextflow/nextflow.log \
  run $PIPELINE_PATH/pipeline/main_slurm_v3.nf \
  -work-dir $WORKDIR \
  --output_path $OUTPUT_PATH \
  --template_path $TEMPLATE_PATH \
  --cell_models_path $CELL_MODELS_PATH \
  --cloud $CLOUD \
  -resume
```

> [!IMPORTANT]
> You should change the `--partition` parameter to match the partition you want to use on your cluster for the submission job.
> You need to change the queue in the nextflow slurm config to allocate nodes in that queue.
> The same partition should be also indicated as the `queue` argument in the `pipeline/nextflow_slurm_custom.config` file for simplicity.

In Nextflow, you can also use the `-resume` flag to restart a previous execution:
```bash
NXF_VER=22.10.8 DATA_PATH=$DATA_PATH RESULTS_PATH=$RESULTS_PATH nextflow \
  -C $PIPELINE_PATH/pipeline/nextflow_slurm.config \
  -log $RESULTS_PATH/nextflow/nextflow.log \
  run $PIPELINE_PATH/pipeline/main_slurm_v3.nf \
  -resume \
  -work-dir $WORKDIR \
  --output_path $OUTPUT_PATH \
  --template_path $TEMPLATE_PATH \
  --cell_models_path $CELL_MODELS_PATH \
  --cloud $CLOUD
```

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

# Datasets for pipeline processing

- [SmartSPIM template v1.0](https://open.quiltdata.com/b/aind-open-data/tree/SmartSPIM-template_2024-05-16_11-26-14/): Please, download this dataset.
- [SmartSPIM cell detection models](https://open.quiltdata.com/b/aind-benchmark-data/tree/mesoscale-anatomy-cell-detection/models/smartspim_production_models/): Please, download one of the cell detection models suitable for your image processing task.

Once the datasets are downloaded, you need to point the pipeline to them.