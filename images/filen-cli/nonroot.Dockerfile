FROM curlimages/curl:8.21.0@sha256:7c12af72ceb38b7432ab85e1a265cff6ae58e06f95539d539b654f2cfa64bb13 AS fetcher
ARG VERSION
RUN curl -fL -o /tmp/filen "https://github.com/FilenCloudDienste/filen-cli/releases/download/v${VERSION}/filen-cli-v${VERSION}-linux-x64"

FROM gcr.io/distroless/cc-debian13:nonroot@sha256:d3cda6e91129130d7229a1806b6a73d292ef245ab032da7851907798024cefba
COPY --from=fetcher --chmod=755 /tmp/filen /usr/local/bin/filen
COPY LICENSE /usr/share/doc/filen/LICENSE
USER nonroot:nonroot
LABEL org.opencontainers.image.base.name=gcr.io/distroless/cc-debian13:nonroot
ENTRYPOINT ["/usr/local/bin/filen"]