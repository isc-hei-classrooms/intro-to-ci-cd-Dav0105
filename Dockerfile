# Build stage (build + test)
FROM debian:bookworm AS builder
WORKDIR /src
COPY . .
RUN apt-get update && apt-get install -y --no-install-recommends
RUN apt-get install -y build-essential cmake
RUN make release
RUN make test

# Runtime stage (runtime only)
FROM debian:bookworm-slim
COPY --from=builder /src/build/main /src/main
ENTRYPOINT [ "/src/main" ]