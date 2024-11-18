# aind-smartspim-pipeline

Base code of the SmartSPIM pipeline in Code Ocean. This pipeline has the following steps:

- [aind-smartspim-validation](https://github.com/AllenNeuralDynamics/aind-smartspim-validation): Code ocean capsule that checks the integrity of the transferred datasets.
- [aind-smartspim-destripe](https://github.com/AllenNeuralDynamics/aind-smartspim-destripe): Code ocean capsule removes horizontal streaks from individual 2D tiles using a filtering algorithm based on wavelet decomposition. Additionally, it performs flat field correction using the provided flats in the dataset. If these are not provided, these are estimated and then applied on the fly.
- [aind-smartspim-stitch](https://github.com/AllenNeuralDynamics/aind-smartspim-stitch): Capsule that estimates the stitching transformations for pairs of stacks for the whole dataset to allow the reconstruction.
- [aind-smartspim-fuse](https://github.com/AllenNeuralDynamics/aind-smartspim-fuse): Capsule that reconstructs the dataset using the stitching transformations. The reconstructed dataset has the OMEZarr format.
- [aind-ccf-registration](https://github.com/AllenNeuralDynamics/aind-ccf-registration): This capsule registers the new datasets to the Allen CCFv3 atlas using the third multiscale.
- [aind-smartspim-pipeline-dispatcher](https://github.com/AllenNeuralDynamics/aind-smartspim-pipeline-dispatcher): This capsule copies the fused dataset to the destination bucket, creates the necessary metadata using the schemas defined here: [aind-data-schema](https://github.com/AllenNeuralDynamics/aind-data-schema) and creates the neuroglancer link to visualize the fused dataset.
- [aind-smartspim-segmentation](https://github.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation): Capsule that performs chunked cell segmentation using [cellfinder](https://github.com/brainglobe/cellfinder). It generates a neuroglancer link that allows the its visualization.
- [aind-smartspim-quantification](https://github.com/AllenNeuralDynamics/aind-smartspim-quantification): This capsule takes the identified cell locations and maps them into the space domain of the CCFv3 registered brain. It generates a neuroglancer link that allows the its visualization.

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
- SmartSPIM: Folder that contains the dataset channels. The folders must include the exaltation wavelength and emission wavelength.
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

# Deployments
## SLURM
To deploy on a SLURM cluster, you need to have access to a SLURM cluster and have the Nextflow and Singularity/Apptainer installed. To create the environment suitable to execute the pipeline, you can use the following bash script: `environment/create_slurm_env.sh`.
```bash
bash environment/create_slurm_env.sh /path/to/environment
```
After execution, the script will create the environment in the provided location.

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

Finally, depending your SLURM configuration, the containers for the image processing steps won't be downloaded from the cloud. In this scenario, you will need to download them prior execution and change the `pipeline/main_slurm.nf` nextflow script to use the paths where the containers are stored.

Script example to execute pipeline:
```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4GB
#SBATCH --time=2:00:00
#SBATCH --partition=YOUR_PARTITION

# Export the credentials for GHCR - Might be needed to download the containers
export SINGULARITY_DOCKER_USERNAME=your_github_username
export SINGULARITY_DOCKER_PASSWORD=your_personal_access_token

PIPELINE_PATH="/your/path/to/aind-smartspim-pipeline"
DATA_PATH="/your/path/to/smartspim_data"
RESULTS_PATH="/your/path/to/results"
WORKDIR="/your/path/to/workdir"

# Change this output path to a S3 path if AWS cloud compatibility is needed
OUTPUT_PATH="/your/path/to/processed/dataset"

# Template path
TEMPLATE_PATH="your/path/to/lightsheet_to_template_to_ccf_registration"

# Cell detection path
CELL_DETECTION_PATH="/your/path/to/cell_detection_model"

# Setting cloud parameter - Useful if you want to store the results in a bucket
CLOUD="false"

NXF_VER=22.10.8 DATA_PATH=$DATA_PATH RESULTS_PATH=$RESULTS_PATH nextflow \
  -C $PIPELINE_PATH/pipeline/nextflow_slurm.config \
  -log $RESULTS_PATH/nextflow/nextflow.log \
  run $PIPELINE_PATH/pipeline/main_slurm.nf \
  -work-dir $WORKDIR \
  --output_path $OUTPUT_PATH \
  --template_path $TEMPLATE_PATH \
  --cell_detection_model $CELL_DETECTION_PATH \
  --cloud $CLOUD
  # additional parameters here
```

> [!IMPORTANT]
> You should change the `--partition` parameter to match the partition you want to use on your cluster. 
> The same partition should be also indicated as the `queue` argument in the `pipeline/nextflow_slurm_custom.config` file!

In Nextflow, you can also use the `-resume` flag to restart a previous execution:
```bash
NXF_VER=22.10.8 DATA_PATH=$DATA_PATH RESULTS_PATH=$RESULTS_PATH nextflow \
  -C $PIPELINE_PATH/pipeline/nextflow_slurm.config \
  -log $RESULTS_PATH/nextflow/nextflow.log \
  run $PIPELINE_PATH/pipeline/main_slurm.nf \
  -resume \
  -work-dir $WORKDIR \
  --output_path $OUTPUT_PATH \
  --template_path $TEMPLATE_PATH \
  --cell_detection_model $CELL_DETECTION_PATH \
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

to use on your cluster. 
> The same partition should be also indicated as the `queue` argument in the `pipeline/nextflow_slurm_custom.config` file!

---
**NOTE**

> The following pipeline parameters are used for Nextflow: PIPELINE_PATH, DATA_PATH, RESULTS_PATH, WORKDIR. The rest of the parameters are used for each of the image processing steps in the pipeline.
---
