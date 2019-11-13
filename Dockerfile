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
    && echo 'go:password' | chpasswd

RUN set -ex && \
    # https://github.com/kubernetes-sigs/aws-iam-authenticator/pull/276
    # これがマージされるまではfork版を使う
    git clone https://github.com/h3poteto/aws-iam-authenticator $GOPATH/src/sigs.k8s.io/aws-iam-authenticator && \
    cd $GOPATH/src/sigs.k8s.io/aws-iam-authenticator && \
    go mod download && \
    cd cmd/aws-iam-authenticator && \
    go install && \
    cd /go && \
    go get bitbucket.org/liamstask/goose/cmd/goose && \
    go get -u github.com/jessevdk/go-assets && \
    go get -u github.com/jessevdk/go-assets-builder && \
    rm -rf /go/src && \
    rm -rf /go/pkg

RUN set -ex && \
    mkdir -p /go/pkg/mod && \
    chown -R go:go /go

USER go
