FROM golang:1.17.6-alpine3.15 as builder
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN GOGC=off CGO_ENABLED=0 go build -v -o prometheus_bot


FROM ubuntu:20.04
RUN apt-get update && apt-get -y install ca-certificates tzdata

EXPOSE 9087
WORKDIR /app

COPY --from=builder /app/prometheus_bot ./prometheus_bot
COPY --from=builder /app/default.tmpl ./default.tmpl
COPY --from=builder /app/config.yml ./config.yml

CMD ["./prometheus_bot", "-c", "config.yml"]
