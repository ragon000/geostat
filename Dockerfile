FROM python:alpine

RUN apk add bash wget gzip tar

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
RUN tar xvf GeoLite2-City.tar.gz
RUN sh -c "mv GeoLite2-City_* Geolite2"
RUN sh -c "mv Geolite2/GeoLite2-City.mmdb GeoLiteCity.dat"
RUN sh -c "rm GeoLite2*"
RUN mv /usr/local/lib/python3.7/site-packages/Geohash/ /usr/local/lib/python3.7/site-packages/geohash/
RUN sed 's/from geohash/from .geohash/' /usr/local/lib/python3.7/site-packages/geohash/__init__.py > /usr/local/lib/python3.7/site-packages/geohash/__init__.py
COPY . .

CMD ["./start.sh"]
