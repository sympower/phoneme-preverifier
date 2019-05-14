#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

printf "\nBuilding Docker image to compile binaries for Linux ...\n\n"
build/linux/build-image.sh

printf "\nRunning Docker image to compile binaries for Linux ...\n\n"
build/linux/run-image.sh

printf "\nInstalling artifacts to artifact repository ...\n\n"
ant install

echo "SUCCESS! Binary can be found at: build/linux/preverifier"
