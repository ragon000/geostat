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
RUN rm /usr/local/lib/python3.7/Geohash/__init__.py

COPY . .

CMD ["./start.sh"]
