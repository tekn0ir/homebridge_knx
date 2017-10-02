FROM node:stretch

MAINTAINER Anders Åslund <anders.aslund@teknoir.se>

# Update packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y libavahi-compat-libdnssd-dev dbus && \
  apt-get clean -y && \
  apt-get autoclean -y && \
  apt-get autoremove

RUN mkdir -p /var/run/dbus
RUN chown node.root /var/run/dbus
RUN sed -i "s/rlimit-nproc=3/#rlimit-nproc=3/" /etc/avahi/avahi-daemon.conf

USER node
WORKDIR /home/node
RUN npm install homebridge && npm install homebridge-knx

RUN mkdir .homebridge
COPY KNX-sample-config.json .homebridge/knx_config.json

EXPOSE 3000 5353 51826

USER root
COPY start.sh /usr/bin/start.sh
CMD start.sh
