# 🚢 Project: Shipyard

Shipyard is a monorepo for managing and building Docker images, primarily published to `ghcr.io`. It uses a centralized GitHub Actions pipeline to automate the build and push process for all images within the `images/` directory.

## 🛠️ Key Technologies
- **🐳 Docker**: For containerization.
- **🚀 GitHub Actions**: For CI/CD.
- **🛡️ Distroless**: Preferred base images for security (e.g., `gcr.io/distroless/cc-debian13`).
- **📦 Multi-Image Support**: Designed to host various containerized tools and services.

## 📂 Directory Structure
- `.github/workflows/`: Contains the CI/CD pipeline.
  - `main-build.yaml`: Detects changes in `images/` and triggers builds.
  - `_base.yaml`: Reusable workflow for building and pushing images.
- `images/`: Contains subdirectories for each Docker image.
  - `<image-name>/`: Directory containing the Docker context for a specific image.

## ⚙️ Building and Running

### 🤖 Automated Builds
Images are automatically built and pushed to `ghcr.io` when changes are detected in `images/**` on the `main` branch.

### 💻 Local Development
To build an image locally:
```bash
docker build -t <image-name> -f images/<image-name>/Dockerfile images/<image-name>
```

To run a container:
```bash
docker run --rm ghcr.io/<owner>/<image-name>:latest [args]
```

## 📏 Development Conventions

### 📋 Image Requirements
Each subdirectory in `images/` MUST contain:
1.  **🐳 Dockerfile**: The instructions to build the image.
2.  **🏷️ VERSION**: A plain text file containing the version number (e.g., `1.0.0`). This is used for the Docker tag and passed as a `VERSION` build argument.
3.  **🏷️ LABELS**: A file containing OCI-compliant labels (key=value pairs) that will be applied to the image metadata.

### 🔄 CI/CD Workflow
- The `main-build.yaml` workflow uses `tj-actions/changed-files` to identify which image directories have changed.
- It extracts the `VERSION` and `LABELS` from the changed directory and passes them to the reusable `_base.yaml` workflow.
- All images are tagged with both the specific version and `latest`.
