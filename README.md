# GeoStat
### Version 0.2
![Alt text](https://github.com/ratibor78/geostat/blob/master/geostat.png?raw=true "Grafana dashboard example")


GeoStat is a Python script for parsing Nginx logs files and getting GEO data from incoming IP's in it. This script convert parsed data in to Json format and send it to InfluxDB database so you can use it to build some nice Grafana dashboards for example. It runs as a _Docker_ Container and parse log in "tailf" style.
# Main Features:

  - Parsing incoming ip's from web server log and convert them in to GEO metrics for   the InfluxDB.
  - Used standard python libs for the maximum compatibility.
  - Having ENV Variables for comfortable changing parameters.

Json format that script send to InfluxDB looks like:
```
[
    {
        'fields': {
            'count': 1
        },
        'measurement': 'geo_cube',
        'tags': {
            'host': 'cube'
            'geohash': 'u8mb76rpv69r',
            'country_code': 'UA'
        }
     }
]
```
As you can see there is three tags fields, so you can build dashboards using geohash (with a point on the map) or country code, or build dashboards with variables based on host name tag. A count for any metric equal 1. This script don't parse log file from the begining but parse it line by line after runing. So you can build dashboards using **count** of geohashes or country codes after some time will pass.

You can find the example Grafana dashboard in **geomap.json** file or from grafana.com: https://grafana.com/dashboards/8342

### Tech

GeoStat uses a number of open source libs to work properly:

* [Geohash](https://github.com/vinsci/geohash) - Python module that provides functions for decoding and encoding Geohashes.
* [InfluxDB-Python](https://github.com/influxdata/influxdb-python) - Python client for InfluxDB.

# Installation

```sh
docker run -e INFLUX_HOST=<your influx hostname> \
           -e INFLUX_PORT=<your influx port (can be not set for port 8086)> \
           -e INFLUX_DB=<your influx db (can be not set for name nginx-geoip)> \ 
           -e INFLUX_USER=<influx login> \ 
           -e INFLUX_PW=<influx password> \
           ragon000/geostat
```
After first metrics will go to the InfluxDB you can create nice Grafana dashboards.

Have fun !

License
----

MIT

**Free Software, Hell Yeah!**
