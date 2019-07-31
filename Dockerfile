FROM h3poteto/golang-glide:1.12.7-glide0.13.3

RUN set -ex && \
    go get -u -v sigs.k8s.io/aws-iam-authenticator/cmd/aws-iam-authenticator
