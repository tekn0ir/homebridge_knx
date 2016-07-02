FROM node:wheezy

MAINTAINER Anders Åslund <anders.aslund@teknoir.se>

# Update packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y libavahi-compat-libdnssd-dev dbus && \
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

RUN sed -i "s/rlimit-nproc=3/#rlimit-nproc=3/" /etc/avahi/avahi-daemon.conf

CMD dbus-daemon --system && avahi-daemon -D && homebridge

