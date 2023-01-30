FROM golang:1.19.5-alpine3.16 as builder

ENV PROTOC_GO=v1.28.1
ENV PROTOC_GO_GRPC=v1.2.0

RUN set -x \
 && go install google.golang.org/protobuf/cmd/protoc-gen-go@$PROTOC_GO \
 && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@$PROTOC_GO_GRPC

FROM bufbuild/buf:1.13.1

RUN mkdir /.cache && chmod 777 /.cache

COPY --from=builder /go/bin /usr/bin

LABEL org.opencontainers.image.source="https://github.com/jetexe/gobuf-docker"
