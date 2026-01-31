#!/bin/bash

echo "=== Selecting Fastest Image ==="

# Simple scoring system:
# Lower time = better score
# Each benchmark file contains lines like:
# "Hashing time: 1.23 seconds"

extract_time() {
    grep "$1" "$2" | awk '{print $3}'
}

CPU_TIME=$(extract_time "Hashing time" cpu.txt)
MEM_TIME=$(extract_time "Allocation time" memory.txt)
IO_TIME=$(extract_time "Write time" io.txt)
PKG_TIME=$(extract_time "update time" pkg.txt)

echo "CPU: $CPU_TIME"
echo "MEM: $MEM_TIME"
echo "IO:  $IO_TIME"
echo "PKG: $PKG_TIME"

# Calculate a simple total score
TOTAL=$(echo "$CPU_TIME + $MEM_TIME + $IO_TIME + $PKG_TIME" | bc)

echo "Total score: $TOTAL" > fastest.txt
echo "=== Fastest image selected ==="
