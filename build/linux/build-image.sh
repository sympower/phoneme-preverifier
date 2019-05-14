#!/bin/sh -e

DOCKER_BUILDKIT=1 docker build --tag=phoneme-preverifier-build -f build/linux/Dockerfile .
