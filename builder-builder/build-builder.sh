#!bash

export RELEASE=warrior
docker build -t balena-builder:$RELEASE --build-arg FSL_BRANCH=$RELEASE --no-cache .
