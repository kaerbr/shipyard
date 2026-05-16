FROM curlimages/curl AS fetcher
ARG VERSION
RUN curl -fL -o /tmp/filen "https://github.com/FilenCloudDienste/filen-cli/releases/download/v${VERSION}/filen-cli-v${VERSION}-linux-x64"


FROM gcr.io/distroless/cc-debian13:nonroot
COPY --from=fetcher --chmod=755 /tmp/filen /usr/local/bin/filen
COPY LICENSE /usr/share/doc/filen/LICENSE
USER nonroot:nonroot
ENTRYPOINT ["/usr/local/bin/filen"]
