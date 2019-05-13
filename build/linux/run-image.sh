#!/bin/sh -e

ant -f ../../build.xml clean

# For testing the script on windows machine (cygwin, git bash etc), just prepend winpty to the entire command, like:
# winpty docker run --rm -it --mount src="$(pwd)/../..",target="/project",type=bind phoneme-preverifier-build $*
docker run --rm -it --mount src="$(pwd)/../..",target="/project",type=bind phoneme-preverifier-build $*

ant -f ../../build.xml install