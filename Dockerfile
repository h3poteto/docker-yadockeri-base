FROM golang:1.14.2-alpine3.11

RUN set -ex && \
    apk add --no-cache \
    git \
    build-base \
    tar \
    gzip \
    curl \
    sudo

ENV GOPATH /go
WORKDIR /go

RUN set -x && \
    adduser -D -u 1000 go && \
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
