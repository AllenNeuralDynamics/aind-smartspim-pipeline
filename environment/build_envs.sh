# Download the Dockerfiles
wget -O Dockerfile_flat_est https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-flatfield-estimation/refs/heads/main/environment/Dockerfile_local
wget -O Dockerfile_preprocessing https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-destripe/refs/heads/main/environment/Dockerfile_local
wget -O Dockerfile_stitch https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-stitch/refs/heads/main/environment/Dockerfile_local
wget -O Dockerfile_registration https://raw.githubusercontent.com/AllenNeuralDynamics/aind-ccf-registration/refs/heads/main/environment/Dockerfile_local
wget -O Dockerfile_fuse https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-fuse/refs/heads/main/environment/Dockerfile_local
wget -O Dockerfile_dispatcher https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-external-dispatcher/refs/heads/main/environment/Dockerfile_local
wget -O Dockerfile_cell_detection https://raw.githubusercontent.com/AllenNeuralDynamics/aind-SmartSPIM-segmentation/refs/heads/main/environment/Dockerfile_local
wget -O Dockerfile_cell_classification https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-classification/refs/heads/main/environment/Dockerfile_local
wget -O Dockerfile_cell_quantification https://raw.githubusercontent.com/AllenNeuralDynamics/aind-smartspim-quantification/refs/heads/main/environment/Dockerfile_local

docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:si-0.0.1 -f Dockerfile_validation .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:si-0.0.4 -f Dockerfile_preprocessing .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-stitch:si-1.2.5 -f Dockerfile_stitch .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-registration:si-0.0.27 -f Dockerfile_registration .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-fuse:si-0.0.2 -f Dockerfile_fuse .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:si-0.0.1 -f Dockerfile_dispatcher .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:si-0.0.7 -f Dockerfile_cell_detection .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:si-0.0.3 -f Dockerfile_cell_classification .
docker build -t ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:si-1.5.1 -f Dockerfile_cell_quantification .

rm Dockerfile_*
