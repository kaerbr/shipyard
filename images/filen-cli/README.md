# Filen CLI (Containerized)

Unofficial, minimal, and secure Docker image for the [Filen CLI](https://github.com/FilenCloudDienste/filen-cli).

> [!NOTE]
> This image is maintained by **kaerbr** in the [Shipyard](https://github.com/kaerbr/shipyard) repository. The underlying software is developed and owned by **FilenCloudDienste**.

## Features & Best Practices

- **Official Binaries**: Downloads verified pre-built binaries from [Filen's GitHub Releases](https://github.com/FilenCloudDienste/filen-cli/releases).
- **Security First**: 
  - Uses `gcr.io/distroless/cc-debian13:nonroot` as the base image.
  - No shell, no package manager, minimal attack surface.
  - Runs as a non-privileged `nonroot` user.
- **OCI Compliant**: Includes full OpenContainer Initiative (OCI) metadata (labels) for transparency and automated indexing.
- **Compliance**: AGPL-3.0 license included at `/usr/share/doc/filen/LICENSE`.

## Usage

### Running the Container

```bash
docker run --rm ghcr.io/kaerbr/shipyard/filen-cli:latest help
```

*Note: Since the CLI handles encryption and cloud storage, you will likely need to mount volumes for local file synchronization and provide credentials via configuration files or environment variables.*

### Building Locally

This image is built automatically via GitHub Actions, but you can build it manually:

```bash
# From the project root
docker build -t filen-cli \
  --build-arg VERSION="$(grep -v '^\s*#' images/filen-cli/VERSION)" \
  -f images/filen-cli/Dockerfile images/filen-cli
```

To build a specific version:

```bash
docker build -t filen-cli \
  --build-arg VERSION=0.0.39 \
  -f images/filen-cli/Dockerfile images/filen-cli
```

## Authorship & Maintenance

- **Software Vendor**: [FilenCloudDienste](https://filen.io)
- **Image Maintainer**: [kaerbr](https://github.com/kaerbr)
- **Build Source**: [kaerbr/shipyard/filen-cli](https://github.com/kaerbr/shipyard/tree/main/images/filen-cli)

## Future: Rust Rewrite

Filen is currently developing a Rust-based rewrite ([filen-rs](https://github.com/FilenCloudDienste/filen-rs)). Once stable, this image will likely transition to a `scratch` base for even smaller footprints and improved performance.
