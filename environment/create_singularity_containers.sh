# For SLURM deployment, you need singularity installed to do this
# You can login into one of the nodes with singularity

# Navegate to the work directory where you want to store your SIFs

echo "Building flat-field estimation SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-flatfield-estimation-si-0.0.1.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-flatfield-estimation:si-0.0.1 > /dev/null

echo "Building preprocessing SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-preprocessing-si-0.0.4.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-preprocessing:si-0.0.4 > /dev/null

echo "Building stitch SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-stitch-si-1.2.6.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-stitch:si-1.2.6 > /dev/null

echo "Building registration SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-registration-si-0.0.31.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-registration:si-0.0.31 > /dev/null

echo "Building fusion SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-fuse-si-0.0.4.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-fuse:si-0.0.4 > /dev/null

echo "Building dispatch SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-dispatch-si-1.0.1.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-dispatch:si-1.0.1 > /dev/null

echo "Building cell detection SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-cell-detection-si-1.0.0.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-cell-detection:si-1.0.0 > /dev/null

echo "Building cell classification SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-cell-classification-si-0.0.6.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-cell-classification:si-0.0.6 > /dev/null

echo "Building cell quantification SIF"
singularity build --force ghcr.io-allenneuraldynamics-aind-smartspim-cell-quantification-si-1.6.1.img docker://ghcr.io/allenneuraldynamics/aind-smartspim-cell-quantification:si-1.6.1 > /dev/null