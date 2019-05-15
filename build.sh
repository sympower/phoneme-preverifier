#!/bin/bash -e

# Check the operating environment to know whether 'winpty' needs to be prepended to some docker commands in some Windows unix-like terminals
UNAME_OUT="$(uname -s)"
case "${UNAME_OUT}" in
    CYGWIN*)    WINPTY=winpty;;
    MINGW*)     WINPTY=winpty;;
    *)          WINPTY=""
esac
printf "\n>> Setting WINPTY=${WINPTY}\n\n"

printf "\n>> Building Docker image to compile binaries for Linux ...\n\n"
DOCKER_BUILDKIT=1 $WINPTY docker build --tag=phoneme-preverifier-build -f build/linux/Dockerfile .

# According to https://circleci.com/docs/2.0/building-docker-images/
# > "It is not possible to mount a folder from your job space into a container in Remote Docker (and vice versa). 
# >  You may use the docker cp command to transfer files between these two environments."

printf "\n>> Creating a dummy Docker container to hold a volume for all project files\n\n"
DATA_CONTAINER=phoneme-preverifier-data
ALREADY_EXISTS="$(docker ps --all --no-trunc --quiet --filter name=^$DATA_CONTAINER$)"
if [ ! -z "$ALREADY_EXISTS" ]; then
  printf "\n>> Old data container still exists, removing it ...\n\n"
  $WINPTY docker rm --force --volumes $DATA_CONTAINER
fi
$WINPTY docker create -v /project --name $DATA_CONTAINER debian:9.9 bash

printf "\n>> Copying project files into this volume ...\n\n"
$WINPTY docker cp . $DATA_CONTAINER:"/project"

printf "\n>> Running Docker image to compile binaries for Linux ...\n\n"
$WINPTY docker run --volumes-from $DATA_CONTAINER -it --rm phoneme-preverifier-build

printf "\n>> Copying build artifacts from data container volume ...\n\n"
$WINPTY docker cp $DATA_CONTAINER:project/build/linux/preverify ./build/linux/preverify

printf "\n>> Clean up data container and volumes... \n\n"
$WINPTY docker rm --force --volumes $DATA_CONTAINER

printf "\n>> Installing artifacts to artifact repository ...\n\n"
ant install

printf "\n>> SUCCESS! Binary can be found at: build/linux/preverifier \n\n"
