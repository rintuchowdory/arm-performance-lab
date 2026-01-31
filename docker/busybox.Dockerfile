FROM busybox:latest

# BusyBox is extremely minimal, so we add a few essential tools manually.
# Note: BusyBox does not have a package manager, so we rely on built-ins.

# Create working directory
WORKDIR /app

# Copy benchmark scripts into the image (GitLab CI will mount them)
COPY . /app

# Default shell
CMD ["sh"]
