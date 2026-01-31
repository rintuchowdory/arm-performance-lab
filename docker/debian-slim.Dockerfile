FROM debian:12-slim

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential benchmarking tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    ca-certificates \
    coreutils \
    util-linux \
    build-essential \
    time \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

CMD ["bash"]
