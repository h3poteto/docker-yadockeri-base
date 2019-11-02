FROM golang:1.13.4-alpine3.10

RUN set -ex && \
    apk add --no-cache \
    git \
    build-base \
    tar \
    gzip \
    curl

ENV GOPATH /go

RUN set -x \
    && adduser -D -u 1000 go \
    && echo 'go:password' | chpasswd \
    && mkdir -p /go \
    && chown -R go:go /go

USER go

RUN set -ex && \
    go get -u -v sigs.k8s.io/aws-iam-authenticator/cmd/aws-iam-authenticator && \
    go get bitbucket.org/liamstask/goose/cmd/goose && \
    go get -u github.com/jessevdk/go-assets && \
    go get -u github.com/jessevdk/go-assets-builder && \
    rm -rf /go/src
