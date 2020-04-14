FROM debian:stretch

# Non-interactive debconf package configuration
ARG DEBIAN_FRONTEND=noninteractive

# Add Debian repositories for docker and npm
RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  lsb-release \
  software-properties-common \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Update Debian and Install Yocto Proyect Quick Start and Balena dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  chrpath \
  containerd.io \
  cpio \
  curl \
  debianutils \
  diffstat \
  docker-ce \
  docker-ce-cli \
  dos2unix \
  file \
  gawk \
  gcc-multilib \
  git-core \
  iputils-ping \
  jq \
  libegl1-mesa \
  libsdl1.2-dev \
  locales \
  nodejs \
  npm \
  pylint3 \
  python \
  python3 \
  python3-git \
  python3-jinja2 \
  python3-pexpect \
  python3-pip \
  socat \
  sudo \
  texinfo \
  unzip \
  vim \
  wget \
  xterm \
  xz-utils \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Set bash as default shell
RUN echo "dash dash/sh boolean false" | debconf-set-selections - && dpkg-reconfigure dash

# Set the locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.utf8 \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

# Install docker in docker
ARG DIND_COMMIT=52379fa76dee07ca038624d639d9e14f4fb719ff
ENV DOCKER_EXTRA_OPTS '--storage-driver=overlay'
RUN curl -fL -o /usr/local/bin/dind "https://raw.githubusercontent.com/moby/moby/${DIND_COMMIT}/hack/dind" && \
    chmod +x /usr/local/bin/dind
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

VOLUME /var/lib/docker
EXPOSE 2375

# Install repo
RUN curl -o /usr/local/bin/repo http://commondatastorage.googleapis.com/git-repo-downloads/repo && chmod a+x /usr/local/bin/repo

ARG USER=build

# User management
RUN groupadd -g 1000 ${USER} && useradd -u 1000 -g 1000 -ms /bin/bash ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# Allow the normal user to run docker
RUN usermod -a -G docker ${USER}

USER ${USER}
WORKDIR /home/${USER}

ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["/bin/sh","-c", "./balena-yocto-scripts/build/barys", "--rm-work", "-d"]

RUN echo "echo Welcome to Balena OS builder $FSL_BRANCH docker image!" >> /home/${USER}/.bashrc
