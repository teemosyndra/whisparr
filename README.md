# Automated Whisparr Patch & Docker Builder

This repository automatically:
- Forks whisparr/whisparr
- Applies patches from [teemosyndra/whisparr-patch](https://github.com/teemosyndra/whisparr-patch)
- Builds and packages as a Docker image
- Pushes the image to Docker Hub and GHCR

## Usage

- Modify `.github/workflows/patch-build-push.yml` as needed.
- Add your secrets (`DOCKERHUB_USERNAME`, `DOCKERHUB_PASSWORD`) to repository secrets.
- Patches should be placed in the patch repository as `.patch` files.

The resulting images will be available at:
- `docker.io/<DOCKERHUB_USERNAME>/whisparr-custom:latest`
- `ghcr.io/<your-github-username>/whisparr-custom:latest`
