FROM golang:1.15.2-buster

RUN set -ex && \
    apt-get update && \
    apt-get install -y \
    git \
    build-essential \
    tar \
    gzip \
    curl \
    sudo \
    unzip && \
    rm -rf /var/lib/apt/lists/*

ENV GOPATH /go
WORKDIR /go

RUN set -ex && \
    useradd -m -s /bin/bash go && \
    echo 'go:password' | chpasswd && \
    echo '%go ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN set -ex && \
    go get bitbucket.org/liamstask/goose/cmd/goose && \
    go get -u github.com/jessevdk/go-assets && \
    go get -u github.com/jessevdk/go-assets-builder && \
    rm -rf /go/src && \
    rm -rf /go/pkg

RUN set -ex && \
    mkdir -p /go/pkg/mod && \
    chown -R go:go /go

USER go
