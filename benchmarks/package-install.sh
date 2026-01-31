#!/bin/bash

echo "=== Package Install Benchmark (ARM) ==="

# Detect distro
if command -v apk >/dev/null 2>&1; then
    PKG_MANAGER="apk"
elif command -v apt-get >/dev/null 2>&1; then
    PKG_MANAGER="apt"
else
    echo "No supported package manager found. Skipping."
    exit 0
fi

echo "Detected package manager: $PKG_MANAGER"

# Alpine benchmark
if [ "$PKG_MANAGER" = "apk" ]; then
    echo "- apk update..."
    START=$(date +%s.%N)
    apk update >/dev/null
    END=$(date +%s.%N)
    UPDATE_TIME=$(echo "$END - $START" | bc)
    echo "apk update time: $UPDATE_TIME seconds"

    echo "- apk add curl..."
    START=$(date +%s.%N)
    apk add --no-cache curl >/dev/null
    END=$(date +%s.%N)
    INSTALL_TIME=$(echo "$END - $START" | bc)
    echo "apk add time: $INSTALL_TIME seconds"
fi

# Debian/Ubuntu benchmark
if [ "$PKG_MANAGER" = "apt" ]; then
    echo "- apt-get update..."
    START=$(date +%s.%N)
    apt-get update >/dev/null 2>&1
    END=$(date +%s.%N)
    UPDATE_TIME=$(echo "$END - $START" | bc)
    echo "apt-get update time: $UPDATE_TIME seconds"

    echo "- apt-get install curl..."
    START=$(date +%s.%N)
    apt-get install -y --no-install-recommends curl >/dev/null 2>&1
    END=$(date +%s.%N)
    INSTALL_TIME=$(echo "$END - $START" | bc)
    echo "apt-get install time: $INSTALL_TIME seconds"
fi

echo "=== Package Install Benchmark Finished ==="
