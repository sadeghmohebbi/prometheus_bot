#!/bin/sh

if [ -z "$VPN_SERVER_CERT" ]
then
    echo $VPN_PASSWORD |openconnect -u $VPN_LOGIN $VPN_SERVER --passwd-on-stdin -b
else
    echo $VPN_PASSWORD |openconnect -u $VPN_LOGIN $VPN_SERVER --servercert $VPN_SERVER_CERT --passwd-on-stdin -b
fi

# Wait a little
sleep 5

echo "Starting prometheus_bot"
set -x
# Runing Telegram Prometheus_Bot
/app/prometheus_bot -c config.yml -l 9087 -t default.tmpl

sleep infinity
