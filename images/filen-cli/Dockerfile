FROM gcr.io/distroless/cc-debian13@sha256:dac90a25ffe03ebaace90cda886b081e61ab6cd77ac47eda51f7bcc15c320765
ARG VERSION
ADD --chmod=755 "https://github.com/FilenCloudDienste/filen-cli/releases/download/v${VERSION}/filen-cli-v${VERSION}-linux-x64" /usr/local/bin/filen
COPY LICENSE /usr/share/doc/filen/LICENSE
LABEL org.opencontainers.image.base.name=gcr.io/distroless/cc-debian13
ENTRYPOINT ["/usr/local/bin/filen"]
