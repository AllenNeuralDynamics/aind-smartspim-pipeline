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

# Deploying to a SLURM cluster

To deploy the SmartSPIM pipeline to a slurm cluster, you must install Nextflow and have Singularity/Docker installed in your cluster. We provide a script that will create a conda environment where Nextflow will be installed.

This conda environment must be activated before running the pipeline.