# syntax=docker/dockerfile:1

# global build-time arguments for FROM statements
ARG OPEN5GS_VERSION="v2.7.6"
ARG UBUNTU_VERSION="jammy"

FROM base-open5gs:${OPEN5GS_VERSION} AS builder

FROM ubuntu:${UBUNTU_VERSION}

# build-time arguments
ARG DEBIAN_FRONTEND="noninteractive"

# install dependencies
RUN apt-get update && apt-get install libgnutls28-dev libgcrypt-dev libtalloc-dev \
    libnghttp2-dev libmicrohttpd-dev libcurl4-gnutls-dev libyaml-dev libsctp-dev libidn-dev -y

# copy executable, default config and libs
COPY --from=builder /open5gs/install/bin/open5gs-smfd /usr/local/bin/open5gs-smfd
COPY --from=builder /open5gs/install/etc/open5gs/smf.yaml /etc/open5gs/default/smf.yaml
COPY --from=builder /open5gs/install/etc/freeDiameter/smf.conf /etc/freeDiameter/
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt /open5gs/install/etc/open5gs/tls/smf.crt /open5gs/install/etc/open5gs/tls/smf.key /etc/open5gs/default/tls/
COPY --from=builder /open5gs/install/lib/*/freeDiameter/ /open5gs/install/lib/*/freeDiameter/
COPY --from=builder /open5gs/install/lib/*/libogscrypt.so.2 /open5gs/install/lib/*/libogsproto.so.2 \
/open5gs/install/lib/*/libogscore.so.2 /open5gs/install/lib/*/libogssbi.so.2 /open5gs/install/lib/*/libogsapp.so.2 \
/open5gs/install/lib/*/libogssbi-openapi.so.2 /open5gs/install/lib/*/libogsmetrics.so.2 \
/open5gs/install/lib/*/libogsngap.so.2 /open5gs/install/lib/*/libogsasn1c-ngap.so.2 /open5gs/install/lib/*/libogsasn1c-common.so.2 \
/open5gs/install/lib/*/libogsasn1c-util.so.2 /open5gs/install/lib/*/libogsnas-5gs.so.2 /open5gs/install/lib/*/libogsnas-common.so.2 \
/open5gs/install/lib/*/libogsdiameter-gx.so.2 /open5gs/install/lib/*/libogsdiameter-common.so.2 \
/open5gs/install/lib/*/libogsdiameter-gy.so.2 /open5gs/install/lib/*/libogsdiameter-s6b.so.2 /open5gs/install/lib/*/libogsdiameter-rx.so.2 \
/open5gs/install/lib/*/libogspfcp.so.2 /open5gs/install/lib/*/libogsgtp.so.2 /open5gs/install/lib/*/libogsipfw.so.2 \
/open5gs/install/lib/*/libfdcore.so.7 /open5gs/install/lib/*/libfdproto.so.7 /open5gs/install/lib/*/libprom.so /usr/local/lib/

# configure dynamically linked libraries
RUN ldconfig

# create directory to store the logs
RUN mkdir -p /var/log/open5gs/

ENTRYPOINT [ "open5gs-smfd" ]

# use CMD to provide arguments to ENTRYPOINT (can be overridden by user)
CMD [ "-c", "/etc/open5gs/default/smf.yaml" ]
