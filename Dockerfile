FROM golang:1.17.6-alpine3.15 as builder
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN GOGC=off CGO_ENABLED=0 go build -v -o prometheus_bot


FROM alpine:3.15.0
RUN apk add --no-cache ca-certificates tzdata openvpn openconnect

EXPOSE 9087
WORKDIR /app

COPY --from=builder /app/prometheus_bot ./prometheus_bot
COPY --from=builder /app/default.tmpl ./default.tmpl
COPY --from=builder /app/config.yml ./config.yml
COPY --from=builder /app/entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

CMD ["./entrypoint.sh"]
