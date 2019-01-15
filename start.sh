#!/bin/bash
cat > settings.ini << EOF 
[NGINX_LOG]
logpath = /var/log/nginx/access.log

[INFLUXDB]

host = ${INFLUX_HOST:-influx}
port = ${INFLUX_PORT:-8086}

database = ${INFLUX_DB:-nginx-geoip}

username = "$INFLUX_USER"
password = "$INFLUX_PW"

measurement = geodata

EOF

python geoparser.py
