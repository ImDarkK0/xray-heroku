FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
RUN apk update && apk add --no-cache tzdata
RUN -e "SET_CONTAINER_TIMEZONE=true" \
RUN -e "CONTAINER_TIMEZONE=Asia/Colombo"
WORKDIR /go/src/xray/core
RUN git clone --progress https://github.com/XTLS/Xray-core.git . && \
    go mod download && \
    CGO_ENABLED=0 go build -o /tmp/xray -trimpath -ldflags "-s -w -buildid=" ./main

FROM alpine
COPY --from=builder /tmp/xray /usr/bin

ADD xray.sh /xray.sh
RUN chmod +x /xray.sh
CMD /xray.sh
