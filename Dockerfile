FROM node:stretch

MAINTAINER Anders Åslund <anders.aslund@teknoir.se>

# Update packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y avahi-daemon avahi-discover libnss-mdns libavahi-compat-libdnssd-dev dbus gosu && \
  apt-get clean -y && \
  apt-get autoclean -y && \
  apt-get autoremove

RUN mkdir -p /var/run/dbus
RUN chown node.root /var/run/dbus
RUN sed -i "s/rlimit-nproc=3/#rlimit-nproc=3/" /etc/avahi/avahi-daemon.conf

RUN npm install --unsafe-perm --verbose -g homebridge && npm install --unsafe-perm --verbose -g homebridge-knx

EXPOSE 3000 5353 51826

ENV GOSU_NAME docker

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh  \
    && sed -i -e 's/\r$//' /entrypoint.sh

COPY cmd.sh /
RUN chmod +x /cmd.sh  \
    && sed -i -e 's/\r$//' /cmd.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/cmd.sh"]
