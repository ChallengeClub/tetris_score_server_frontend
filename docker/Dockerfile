FROM cirrusci/flutter:latest
ARG PROTOBUF_VERSION=v21.7
ARG PROTOBUF_ARCH=protoc-21.7-linux-x86_64.zip
ADD "https://github.com/protocolbuffers/protobuf/releases/download/${PROTOBUF_VERSION}/${PROTOBUF_ARCH}" ./  
RUN unzip ${PROTOBUF_ARCH} -d /.local
ENV PATH $PATH:/.local/bin
COPY . .
WORKDIR /app
EXPOSE 8888
RUN dart pub global activate protoc_plugin
ENV PATH $PATH:/root/.pub-cache/bin
RUN flutter pub get 
ENTRYPOINT bash