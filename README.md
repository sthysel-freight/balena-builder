# BalenaOS builder (Version 0.0.1)

![Shark Horse](pics/shorse.jpg)

This repo builds a BalenaOS builder image which is then used to build a custom
BalenaOS.


# Build the builder

```zsh
$ export RELEASE=warrior
docker build -t balena-builder:$RELEASE --build-arg FSL_BRANCH=$RELEASE --no-cache .
```

# Use the builder to build BalenaOS

## Prepare BalenaOS on host

Fetch the balena-intel sources 

```zsh
$ cd /build
$ git clone --recursive https://github.com/balena-os/balena-intel.git
```

## Use the balena-builder container to build BalenaOS

Build for the current targe machine intel-nuc

```zsh
$ docker run --rm -it --privileged -v /build:/home/build balena-builder ./balena-yocto-scripts/build/barys --rm-work -d --machine intel-nuc
```

Alternatively build all Balena supported platforms

```zsh
$ docker run --rm -it --privileged -v $(pwd)/build/balena-intel:/home/build balena-builder
```

This will take a while

# Resources

This process is based on alexgg's [docker-balena](https://github.com/alexgg/docker-balena)

