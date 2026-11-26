FROM gcr.io/distroless/cc-debian13@sha256:e8343d4a7da8bb210df0c3ea29de38bbadbba6c773bed0cd8bde506fca3a5c44
ARG VERSION
ADD --chmod=755 "https://github.com/FilenCloudDienste/filen-cli/releases/download/v${VERSION}/filen-cli-v${VERSION}-linux-x64" /usr/local/bin/filen
COPY LICENSE /usr/share/doc/filen/LICENSE
LABEL org.opencontainers.image.base.name=gcr.io/distroless/cc-debian13
ENTRYPOINT ["/usr/local/bin/filen"]
