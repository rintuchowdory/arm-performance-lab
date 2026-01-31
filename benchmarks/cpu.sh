#!/bin/bash

echo "=== CPU Benchmark (ARM) ==="

# Test 1: SHA256 hashing loop
echo "- Hashing test..."
START=$(date +%s.%N)
for i in {1..50000}; do
    echo -n "$i" | sha256sum >/dev/null
done
END=$(date +%s.%N)
HASH_TIME=$(echo "$END - $START" | bc)
echo "Hashing time: $HASH_TIME seconds"

# Test 2: Compression test
echo "- Compression test..."
dd if=/dev/zero bs=1M count=50 2>/dev/null | gzip -9 > /dev/null
echo "Compression test completed."

# Test 3: Prime number calculation
echo "- Prime calculation..."
START=$(date +%s.%N)
for i in {1..20000}; do
    factor $i >/dev/null
done
END=$(date +%s.%N)
PRIME_TIME=$(echo "$END - $START" | bc)
echo "Prime calculation time: $PRIME_TIME seconds"

echo "=== CPU Benchmark Finished ==="
