#!/bin/bash
cat > settings.ini << EOF 
[NGINX_LOG]
logpath = /var/log/nginx/access.log

[INFLUXDB]

host = ${INFLUX_HOST:-influx}
port = ${INFLUX_PORT:-8086}

database = ${INFLUX_DB:-geoip}

username = "$INFLUX_USER"
password = "$INFLUX_PW"

measurement = geodata

EOF

echo Config Written, sleeping 5 seconds

sleep 5

echo Starting geoparser.py
python geoparser.py
