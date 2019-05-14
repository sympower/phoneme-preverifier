FROM debian:9.9

RUN apt-get update && apt-get install -y libc6-dev-i386 build-essential

WORKDIR /project/build/linux

# This is the default command executed when running the image. Feel free to override it by simply providing e.g. "bash"
# as an argument when running the image for debugging purposes, e.g. by: `./run-image.sh bash`
CMD ["make", "clean", "all"]
