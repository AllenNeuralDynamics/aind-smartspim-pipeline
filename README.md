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

In Nextflow, you can also use the `-resume` flag to restart a previous execution. Depending your SLURM configuration, you might also want to change the header of the SBATCH to use your partition since sometimes it might not be recognized from the `nextflow_slurm.config`.

Finally, depending your SLURM configuration, the containers for the image processing steps won't be downloaded from the cloud. In this scenario, you will need to download them prior execution and change the `pipeline/main_slurm.nf` nextflow script to use the paths where the containers are stored.
