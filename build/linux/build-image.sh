#!/bin/sh -e

# Using Docker BuildKit, available since 2019.
# https://docs.docker.com/develop/develop-images/build_enhancements/
#
# With Docker BuildKit we can use the project root folder as context without worrying about it being too big and slow.
DOCKER_BUILDKIT=1 docker build --tag=phoneme-preverifier-build -f Dockerfile ../../
