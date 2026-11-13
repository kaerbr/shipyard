FROM gcr.io/distroless/cc-debian13@sha256:809d04afa1be033c441f76bb0051878c342fb76d0ea236bc6dc94b655fa0fbd6
ARG VERSION
ADD --chmod=755 "https://github.com/FilenCloudDienste/filen-cli/releases/download/v${VERSION}/filen-cli-v${VERSION}-linux-x64" /usr/local/bin/filen
COPY LICENSE /usr/share/doc/filen/LICENSE
LABEL org.opencontainers.image.base.name=gcr.io/distroless/cc-debian13
ENTRYPOINT ["/usr/local/bin/filen"]
