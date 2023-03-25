
FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CODE_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

SHELL ["/bin/bash", "-c"]

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

RUN \
  echo "**** install runtime dependencies ****" && \
  apt-get -qq update && \
  apt-get install -qq -y \
    git \
    jq \
    libatomic1 \
    nano \
    net-tools \
    netcat \
    sudo \
    curl \
    build-essential \
    gcc

 
RUN mkdir -m777 /opt/rust /opt/cargo
ENV RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/cargo PATH=/opt/cargo/bin:$PATH

RUN bash -c "curl https://sh.rustup.rs -sSf | sh -s -- -y" 

# RUN bash -c 'source "$HOME/.cargo/env"'

RUN bash -c "cargo install cargo-cacher"
#RUN bash -c "cargo install --git https://github.com/Cloufish/cargo-cacher"

#ENTRYPOINT ["/bin/bash ./target/release/cargo-cacher"]
#CMD [ "-p", "8555", "-a" ]
ENTRYPOINT [ "/bin/bash" ]