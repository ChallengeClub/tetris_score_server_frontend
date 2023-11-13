FROM ubuntu:22.04 AS base_image

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
COPY . .
WORKDIR /app
# Update the package list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git wget g++ cmake unzip zip unzip curl

# ▼▼▼▼▼ download and install bazel ▼▼▼▼▼
FROM base_image AS downloader
ARG BAZEL_VERSION=6.3.0

WORKDIR /var/bazel
RUN curl --remote-name "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-darwin-x86_64"

# ダウンロードした Bazel バイナリの名前を "bazel" に変更し、実行権限を付与
RUN mv "bazel-${BAZEL_VERSION}-darwin-x86_64" /usr/local/bin/bazel && \
    chmod +x /usr/local/bin/bazel

# 新しいユーザー 'ubuntu' を作成し、ダウンロードしたBazelのバイナリを現在のステージにコピー
FROM base_image
RUN useradd --system --create-home --home-dir=/home/ubuntu --shell=/bin/bash --gid=root --groups=sudo --uid=1000 ubuntu
USER ubuntu
WORKDIR /home/ubuntu
COPY --from=downloader /usr/local/bin/bazel /usr/local/bin/bazel

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