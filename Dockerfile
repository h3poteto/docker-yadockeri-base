FROM h3poteto/golang:1.13.4

RUN set -ex && \
    go get -u -v sigs.k8s.io/aws-iam-authenticator/cmd/aws-iam-authenticator && \
    go get -u github.com/jessevdk/go-assets && \
    go get -u github.com/jessevdk/go-assets-builder
