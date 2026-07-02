# 🚢 Project: Shipyard

Shipyard is a monorepo for managing and building Docker images, published to `ghcr.io`. It uses a centralized GitHub Actions pipeline to automate the build and push process for all images within the `images/` directory, and Renovate to keep the packaged application versions up to date — there is no manual release step.

## 🛠️ Key Technologies
- **🐳 Docker**: For containerization.
- **🚀 GitHub Actions**: For CI/CD.
- **🤖 Renovate**: Automated version bumps for the packaged applications.
- **🛡️ Distroless**: Preferred base images for security (e.g., `gcr.io/distroless/cc-debian13`).
- **📦 Multi-Image Support**: Designed to host various containerized tools and services.

## 📂 Directory Structure
- `.github/workflows/`: Contains the CI/CD pipeline.
  - `main-build.yaml`: Detects changes in `images/` and triggers builds.
  - `_base.yaml`: Reusable workflow for building, pushing and attesting images.
- `images/`: Contains subdirectories for each Docker image.
  - `<image-name>/`: Directory containing the Docker context for a specific image.
- `renovate.json`: Automated dependency/version updates.

## ⚙️ Building and Running

### 🤖 Automated Builds
Images are automatically built and pushed to `ghcr.io` when changes are detected in `images/**` on the `main` branch.

### 💻 Local Development
To build an image locally:
```bash
docker build -t <image-name> --build-arg VERSION="$(grep -v '^\s*#' images/<image-name>/VERSION)" -f images/<image-name>/Dockerfile images/<image-name>
```
> [!IMPORTANT]
> `--build-arg VERSION=...` is required. Dockerfiles download the upstream release from a URL containing the version; without it the build fails with a curl 404.

To run a container:
```bash
docker run --rm ghcr.io/kaerbr/shipyard/<image-name>:latest [args]
```

## 📏 Development Conventions

### 📋 Image Requirements
Each subdirectory in `images/` MUST contain:
1.  **🐳 Dockerfile**: The instructions to build the image. It MUST declare `ARG VERSION` and use it to fetch/pin the application — CI always passes it.
2.  **🏷️ VERSION**: A plain text file containing the version number (e.g., `1.0.0`). This is used for the Docker tag and passed as a `VERSION` build argument. It MUST carry a Renovate marker comment, otherwise the image never receives automatic updates:
    ```
    # renovate: datasource=github-releases depName=<upstream-owner>/<upstream-repo>
    1.0.0
    ```
3.  **🏷️ LABELS**: A file containing OCI-compliant labels (key=value pairs) that will be applied to the image metadata.

`#`-prefixed lines in `VERSION` and `LABELS` are treated as comments and stripped by CI. A per-image `README.md` and `LICENSE` are conventional but not enforced.

### 🍦 Flavours
Besides the default `Dockerfile`, any `<flavour>.Dockerfile` in the image directory is built as an additional variant, with the flavour as tag prefix:

| Dockerfile | Tags pushed |
|------------|-------------|
| `Dockerfile` | `<version>`, `latest` |
| `nonroot.Dockerfile` | `nonroot-<version>`, `nonroot-latest` |

A directory may also contain only flavoured Dockerfiles.

### ➕ Adding a New Image
1. Create `images/<image-name>/` with the required files above.
2. Add the Renovate marker to `VERSION` so version bumps are automated.
3. Open a PR and merge to `main` — CI builds and pushes the image automatically.

### 🔄 CI/CD Workflow
- The `main-build.yaml` workflow uses `tj-actions/changed-files` to identify which image directories have changed.
- It extracts the `VERSION` and `LABELS` from the changed directory and builds a matrix entry per Dockerfile, passed to the reusable `_base.yaml` workflow.
- Images are tagged with the specific version and `latest`, prefixed with the flavour name for flavoured Dockerfiles.
- `_base.yaml` disables BuildKit's built-in provenance and instead pushes an `actions/attest` provenance attestation to the registry.
- **Releases = Renovate**: when upstream publishes a release, Renovate opens a PR bumping `VERSION`; merging it triggers the rebuild and publishes the new tags.

## 🚑 Troubleshooting
- **Local build fails with `curl: (22) ... 404`** — you forgot `--build-arg VERSION=...` (see Local Development).
- **`docker pull` says denied/not found** — you are probably missing the repo name in the path: use `ghcr.io/kaerbr/shipyard/<image-name>`.
- **Need to rebuild without a version change** (e.g. after a base-image or workflow fix) — the pipeline only fires on `images/**` changes on `main`; editing a `#` comment in `VERSION` is a safe trigger. Workflow-only changes do not trigger builds.
- **`detect-changes` fails for every image in a push** — one changed image directory is missing `VERSION` or `LABELS`; the matrix script runs with `set -euo pipefail` and aborts entirely.
