# Create a token to deploy images to the GitHub Container Registry
# export CR_PAT=ghp_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# before running this script
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=versions.env
source "${SCRIPT_DIR}/versions.env"

ORG="ghcr.io/allenneuraldynamics"

docker tag "${ORG}/aind-smartspim-flatfield-estimation:${FLATFIELD_EST_VERSION}" "${ORG}/aind-smartspim-flatfield-estimation:latest"
docker tag "${ORG}/aind-smartspim-preprocessing:${PREPROCESSING_VERSION}" "${ORG}/aind-smartspim-preprocessing:latest"
docker tag "${ORG}/aind-smartspim-stitch:${STITCH_VERSION}" "${ORG}/aind-smartspim-stitch:latest"
docker tag "${ORG}/aind-smartspim-registration:${REGISTRATION_VERSION}" "${ORG}/aind-smartspim-registration:latest"
docker tag "${ORG}/aind-smartspim-fuse:${FUSE_VERSION}" "${ORG}/aind-smartspim-fuse:latest"
docker tag "${ORG}/aind-smartspim-dispatch:${DISPATCH_VERSION}" "${ORG}/aind-smartspim-dispatch:latest"
docker tag "${ORG}/aind-smartspim-cell-detection:${CELL_DETECTION_VERSION}" "${ORG}/aind-smartspim-cell-detection:latest"
docker tag "${ORG}/aind-smartspim-cell-classification:${CELL_CLASSIFICATION_VERSION}" "${ORG}/aind-smartspim-cell-classification:latest"
docker tag "${ORG}/aind-smartspim-cell-quantification:${CELL_QUANTIFICATION_VERSION}" "${ORG}/aind-smartspim-cell-quantification:latest"

docker push --all-tags "${ORG}/aind-smartspim-flatfield-estimation"
docker push --all-tags "${ORG}/aind-smartspim-preprocessing"
docker push --all-tags "${ORG}/aind-smartspim-stitch"
docker push --all-tags "${ORG}/aind-smartspim-registration"
docker push --all-tags "${ORG}/aind-smartspim-fuse"
docker push --all-tags "${ORG}/aind-smartspim-dispatch"
docker push --all-tags "${ORG}/aind-smartspim-cell-detection"
docker push --all-tags "${ORG}/aind-smartspim-cell-classification"
docker push --all-tags "${ORG}/aind-smartspim-cell-quantification"
