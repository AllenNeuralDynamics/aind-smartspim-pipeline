# Create a token to deploy images to the GitHub Container Registry
# export CR_PAT=ghp_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# before running this script
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

docker tag ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:si-0.0.1 ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:latest
docker tag ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:si-0.0.4 ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:latest
docker tag ghcr.io/allenneuraldynamics/aind-smartspim-stitch:si-1.2.6 ghcr.io/allenneuraldynamics/aind-smartspim-stitch:latest
docker tag ghcr.io/allenneuraldynamics/aind-smartspim-registration:si-0.0.31 ghcr.io/allenneuraldynamics/aind-smartspim-registration:latest
docker tag ghcr.io/allenneuraldynamics/aind-smartspim-fuse:si-0.0.4 ghcr.io/allenneuraldynamics/aind-smartspim-fuse:latest
docker tag ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:si-1.0.1 ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:latest
docker tag ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:si-1.0.0 ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:latest
docker tag ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:si-0.0.6 ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:latest
docker tag ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:si-1.6.1 ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:latest

docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation
docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing
docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-stitch
docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-registration
docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-fuse
docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-dispatch
docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection
docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification
docker push --all-tags ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification
