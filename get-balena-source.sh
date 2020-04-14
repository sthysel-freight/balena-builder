#!/usr/bin/env bash

TARGET=./build/balena-intel

mkdir -p $TARGET
git clone --recursive https://github.com/balena-os/balena-intel.git $TARGET
