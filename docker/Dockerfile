# ATTENTION: use the build.sh script to build this image.
# ./build.sh <OCI_REPOSITORY> <BAZEL_VERSION>

FROM ubuntu:20.04 AS base_image

# ▼▼▼▼▼download and install bazel▼▼▼▼▼
# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
COPY ./app /app
WORKDIR /app
# Update the package list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git wget g++ cmake unzip zip curl

# ▼▼▼▼▼ download and install bazel ▼▼▼▼▼
RUN --mount=source=./docker/install_packages.sh,target=/mnt/install_packages.sh,type=bind \
    /mnt/install_packages.sh

FROM base_image AS downloader

ARG BAZEL_VERSION

WORKDIR /var/bazel
RUN --mount=source=./docker/install_bazel.sh,target=/mnt/install_bazel.sh,type=bind \
    /mnt/install_bazel.sh

FROM base_image

RUN useradd --system --create-home --home-dir=/home/ubuntu --shell=/bin/bash --gid=root --groups=sudo --uid=1000 ubuntu
USER ubuntu
WORKDIR /home/ubuntu
COPY --from=downloader /var/bazel/bazel /usr/local/bin/bazel

# ▼▼▼▼▼ download and install protobuf ▼▼▼▼▼
USER root
ARG PROTOBUF_VERSION=v23.4
ARG PROTOBUF_ARCH=protoc-23.4-linux-x86_64.zip
ADD "https://github.com/protocolbuffers/protobuf/releases/download/${PROTOBUF_VERSION}/${PROTOBUF_ARCH}" ./  
RUN unzip ${PROTOBUF_ARCH} -d /.local
ENV PATH $PATH:/.local/bin

# ▼▼▼▼▼ download and install flutter ▼▼▼▼▼
WORKDIR /app
RUN git clone --depth=1 --branch=stable https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter channel stable && flutter upgrade

# ▼▼▼▼▼ execute ▼▼▼▼▼
EXPOSE 8888
RUN dart pub global activate protoc_plugin
ENV PATH $PATH:/root/.pub-cache/bin
RUN flutter pub get 
ENTRYPOINT bash