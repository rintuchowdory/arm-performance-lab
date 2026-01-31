#!/bin/bash

echo "=== Deploying Fastest Image to Laptop ==="

# Check if fastest.txt exists
if [ ! -f fastest.txt ]; then
    echo "Error: fastest.txt not found. Run the CI pipeline first."
    exit 1
fi

FASTEST=$(cat fastest.txt)

echo "Fastest image determined by CI: $FASTEST"

# GitLab registry info
REGISTRY="registry.gitlab.com/YOUR_GITLAB_USER/YOUR_PROJECT"

echo "Logging into GitLab registry..."
docker login registry.gitlab.com

echo "Pulling optimized image: $REGISTRY:$FASTEST"
docker pull "$REGISTRY:$FASTEST"

echo "Stopping old container (if exists)..."
docker stop dev_env 2>/dev/null || true
docker rm dev_env 2>/dev/null || true

echo "Starting new optimized container..."
docker run -d \
    --name dev_env \
    -v $HOME/dev:/workspace \
    "$REGISTRY:$FASTEST"

echo "Deployment complete. Your dev environment is now running the fastest image."

