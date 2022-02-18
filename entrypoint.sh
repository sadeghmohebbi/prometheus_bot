#!/bin/sh
set -x

# Runing Telegram Prometheus_Bot
/app/prometheus_bot -c config.yml -l 9087 -t default.tmpl

sleep infinity
