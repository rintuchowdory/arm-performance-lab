FROM alpine:3.19

# Install basic tools for benchmarking
RUN apk update && apk add --no-cache \
    bash \
    curl \
    wget \
    coreutils \
    util-linux \
    busybox-extras \
    build-base

# Create a working directory
WORKDIR /app

# Default command
CMD ["bash"]
