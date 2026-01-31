#!/bin/bash

echo "=== Selecting Fastest Image ==="

# Define images
IMAGES=("alpine" "ubuntu" "debian-slim" "busybox")

# Initialize score file
echo "| Image | CPU | MEM | IO | PKG | Total |" > summary.md
echo "|-------|-----|-----|----|-----|-------|" >> summary.md

BEST_IMAGE=""
BEST_SCORE=9999

for IMG in "${IMAGES[@]}"; do
  CPU=$(grep "$IMG" cpu.txt | awk '{print $3}')
  MEM=$(grep "$IMG" memory.txt | awk '{print $3}')
  IO=$(grep "$IMG" io.txt | awk '{print $3}')
  PKG=$(grep "$IMG" pkg.txt | awk '{print $3}')

  TOTAL=$(echo "$CPU + $MEM + $IO + $PKG" | bc)
  echo "| $IMG | $CPU | $MEM | $IO | $PKG | $TOTAL |" >> summary.md

  if (( $(echo "$TOTAL < $BEST_SCORE" | bc -l) )); then
    BEST_SCORE=$TOTAL
    BEST_IMAGE=$IMG
  fi
done

echo "$BEST_IMAGE" > fastest.txt
echo "Fastest image: $BEST_IMAGE with score $BEST_SCORE"
