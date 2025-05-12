# Download the Dockerfiles
wget -O Dockerfile_flat_est https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-flatfield-estimation/refs/heads/feat-slurm-deployment/environment/Dockerfile_local
wget -O Dockerfile_preprocessing https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-destripe/refs/heads/feat-slurm-pipeline-v3/environment/Dockerfile_local
wget -O Dockerfile_stitch https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/heads/feat-slurm-deployment/environment/Dockerfile_local
wget -O Dockerfile_registration https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-ccf-registration/refs/heads/feat-slurm-deployment/environment/Dockerfile_local
wget -O Dockerfile_fuse https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/heads/fix-multiscale-fusion/environment/Dockerfile_local
wget -O postInstall https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/heads/fix-multiscale-fusion/environment/postInstall
wget -O Dockerfile_dispatcher https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-external-dispatcher/refs/heads/feat-v3-deployment/environment/Dockerfile_local
wget -O Dockerfile_cell_detection https://raw.githubusercontent.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation/refs/heads/feat-fast-detection/environment/Dockerfile_local
wget -O Dockerfile_cell_classification https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-classification/refs/heads/feat-slurm-deployment/environment/Dockerfile_local
wget -O Dockerfile_cell_quantification https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-quantification/refs/heads/feat-slurm-deployment/environment/Dockerfile_local

docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:si-0.0.1 -f Dockerfile_flat_est .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:si-0.0.4 -f Dockerfile_preprocessing .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-stitch:si-1.2.6 -f Dockerfile_stitch .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-registration:si-0.0.31 -f Dockerfile_registration .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-fuse:si-0.0.4 -f Dockerfile_fuse .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:si-1.0.1 -f Dockerfile_dispatcher .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:si-1.0.0 -f Dockerfile_cell_detection .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:si-0.0.6 -f Dockerfile_cell_classification .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:si-1.6.1 -f Dockerfile_cell_quantification .

rm Dockerfile_*
rm postInstall