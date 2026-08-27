FROM gcr.io/distroless/cc-debian13@sha256:9b615fff20e1a4fad29c2b30562580b212c7dd5e2225236735cca0070ed11c78
ARG VERSION
ADD --chmod=755 "https://github.com/FilenCloudDienste/filen-cli/releases/download/v${VERSION}/filen-cli-v${VERSION}-linux-x64" /usr/local/bin/filen
COPY LICENSE /usr/share/doc/filen/LICENSE
LABEL org.opencontainers.image.base.name=gcr.io/distroless/cc-debian13
ENTRYPOINT ["/usr/local/bin/filen"]
