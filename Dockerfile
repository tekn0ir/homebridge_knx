FROM node:wheezy

MAINTAINER Anders Åslund <anders.aslund@teknoir.se>

# Update packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y libavahi-compat-libdnssd-dev && \
  apt-get clean -y && \
  apt-get autoclean -y && \
  apt-get autoremove

RUN npm install -g homebridge && npm install -g homebridge-knx

# setup
RUN mkdir -p /var/run/dbus
WORKDIR /root
RUN mkdir .homebridge
COPY KNX-sample-config.json .homebridge/config.json

EXPOSE 51826

CMD ["homebridge"]
