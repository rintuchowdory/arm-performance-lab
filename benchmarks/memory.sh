#!/bin/bash

echo "=== Memory Benchmark (ARM) ==="

# Test 1: Memory allocation speed
echo "- Allocation test..."
START=$(date +%s.%N)
for i in {1..200000}; do
    x=$(printf "%0.sA" {1..1024})
done
END=$(date +%s.%N)
ALLOC_TIME=$(echo "$END - $START" | bc)
echo "Allocation time: $ALLOC_TIME seconds"

# Test 2: Memory copy speed
echo "- Memory copy test..."
dd if=/dev/zero of=/tmp/memtest bs=1M count=200 2>/dev/null
START=$(date +%s.%N)
cp /tmp/memtest /tmp/memtest_copy
END=$(date +%s.%N)
COPY_TIME=$(echo "$END - $START" | bc)
echo "Copy time: $COPY_TIME seconds"

# Test 3: Memory read speed
echo "- Memory read test..."
START=$(date +%s.%N)
cat /tmp/memtest >/dev/null
END=$(date +%s.%N)
READ_TIME=$(echo "$END - $START" | bc)
echo "Read time: $READ_TIME seconds"

# Cleanup
rm -f /tmp/memtest /tmp/memtest_copy

echo "=== Memory Benchmark Finished ==="
