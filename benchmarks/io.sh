#!/bin/bash

echo "=== I/O Benchmark (ARM) ==="

TESTFILE="/tmp/io_testfile"

# Test 1: Write speed
echo "- Write test (500MB)..."
START=$(date +%s.%N)
dd if=/dev/zero of=$TESTFILE bs=1M count=500 conv=fdatasync 2>/dev/null
END=$(date +%s.%N)
WRITE_TIME=$(echo "$END - $START" | bc)
echo "Write time: $WRITE_TIME seconds"

# Test 2: Read speed
echo "- Read test (500MB)..."
START=$(date +%s.%N)
dd if=$TESTFILE of=/dev/null bs=1M 2>/dev/null
END=$(date +%s.%N)
READ_TIME=$(echo "$END - $START" | bc)
echo "Read time: $READ_TIME seconds"

# Test 3: fsync test
echo "- fsync test..."
START=$(date +%s.%N)
sync
END=$(date +%s.%N)
FSYNC_TIME=$(echo "$END - $START" | bc)
echo "Fsync time: $FSYNC_TIME seconds"

# Cleanup
rm -f $TESTFILE

echo "=== I/O Benchmark Finished ==="
