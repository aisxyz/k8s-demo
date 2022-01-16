FROM golang:alpine AS base
WORKDIR /go/src/k8s
COPY . ./
RUN go build -o /go/bin/k8s-demo .

FROM golang:alpine
WORKDIR /go/src
COPY --from=base /go/bin/k8s-demo /go/bin/k8s-demo
EXPOSE 8080/tcp
ENTRYPOINT ["/go/bin/k8s-demo"]
