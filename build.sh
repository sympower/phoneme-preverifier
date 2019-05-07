#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

# Clean up, if needed
rm -f build/linux/*.o
rm -f build/linux/preverifier

docker run --rm -v "$PWD":/preverifier -w /preverifier/build/linux gcc:4.9 make

echo "SUCCESS! Binary can be found at: build/linux/preverifier"
