#!bash

RELEASE=warrior

docker run --rm -it --privileged -v $(pwd)/build/balena-intel:/home/build balena-builder:$RELEASE ./balena-yocto-scripts/build/barys --rm-work -d --machine genericx86-64
