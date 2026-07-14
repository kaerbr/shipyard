FROM curlimages/curl:8.21.0@sha256:7c12af72ceb38b7432ab85e1a265cff6ae58e06f95539d539b654f2cfa64bb13 AS fetcher
ARG VERSION
RUN curl -fL -o /tmp/filen "https://github.com/FilenCloudDienste/filen-cli/releases/download/v${VERSION}/filen-cli-v${VERSION}-linux-x64"

FROM gcr.io/distroless/cc-debian13@sha256:ed7c407fd64eb0af9dddb9456b94cee188a40a7f53cf38c9836e1e9ae14fca02
COPY --from=fetcher --chmod=755 /tmp/filen /usr/local/bin/filen
COPY LICENSE /usr/share/doc/filen/LICENSE
LABEL org.opencontainers.image.base.name=gcr.io/distroless/cc-debian13
ENTRYPOINT ["/usr/local/bin/filen"]
