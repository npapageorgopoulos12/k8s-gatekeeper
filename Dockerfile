FROM golang:1.18 as builder
WORKDIR /webhook
COPY ./ /webhook
RUN go env -w GOPROXY=https://goproxy.cn,direct && \
    go mod tidy && \
    go build -o webhook cmd/webhook/main.go

FROM debian:latest as webhook
WORKDIR /workspace

COPY --from=builder /webhook/webhook .
COPY --from=builder /webhook/config ./config

# accept kubeconfig content as a build argument
ARG KUBECONFIG_CONTENT

# create the .kube directory and write the kubeconfig content
RUN mkdir -p /root/.kube && echo "$KUBECONFIG_CONTENT" > /root/.kube/config
RUN chmod 600 /root/.kube/config

CMD ["./webhook", "--externalClient=false"]
