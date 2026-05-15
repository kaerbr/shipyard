# Stage 1: Fetch binary
FROM alpine:latest AS fetcher
# Declare ARG in this stage to use it
ARG VERSION

WORKDIR /tmp
RUN apk add --no-cache curl ca-certificates

# Download official linux-x64 binary directly
RUN curl -L -o filen "https://github.com/FilenCloudDienste/filen-cli/releases/download/v${VERSION}/filen-cli-v${VERSION}-linux-x64" && \
    chmod +x filen

# Stage 2: Final Image
FROM gcr.io/distroless/cc-debian13:nonroot
# Declare ARG in this stage to use it in labels

# Copy binary from fetcher stage
COPY --from=fetcher /tmp/filen /usr/local/bin/filen

# Copy local LICENSE for compliance
COPY LICENSE /usr/share/doc/filen/LICENSE

USER nonroot:nonroot

ENTRYPOINT ["/usr/local/bin/filen"]
