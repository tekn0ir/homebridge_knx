FROM balenalib/raspberrypi3-alpine-node:8

LABEL mantainer="Anders Åslund <teknoir@teknoir.se>" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="raspbian-homebridge" \
    org.label-schema.description="Docker running Alpine with Node.js and Homebridge KNX" \
    org.label-schema.url="https://www.teknoir.se" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/tekn0ir" \
    org.label-schema.vendor="Anders Åslund" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

RUN [ "cross-build-start" ]

RUN apk add --no-cache git python make g++ avahi-compat-libdns_sd avahi-dev dbus \
    iputils sudo nano \
  && chmod 4755 /bin/ping \
  && mkdir /homebridge \
  && npm set global-style=true \
  && npm set package-lock=false

#RUN mkdir -p /var/run/dbus
#RUN chown node.root /var/run/dbus
#RUN sed -i "s/rlimit-nproc=3/#rlimit-nproc=3/" /etc/avahi/avahi-daemon.conf

RUN npm install --unsafe-perm --verbose -g homebridge && npm install --unsafe-perm --verbose -g homebridge-knx

EXPOSE 3000 5353 51826

ENV GOSU_NAME docker

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh  \
    && sed -i -e 's/\r$//' /entrypoint.sh

COPY cmd.sh /
RUN chmod +x /cmd.sh  \
    && sed -i -e 's/\r$//' /cmd.sh

RUN [ "cross-build-end" ]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/cmd.sh"]
