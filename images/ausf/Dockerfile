# syntax=docker/dockerfile:1

# global build-time arguments for FROM statements
ARG OPEN5GS_VERSION="v2.6.0"
ARG UBUNTU_VERSION="focal"

FROM base:${OPEN5GS_VERSION} AS builder

FROM ubuntu:${UBUNTU_VERSION}

# build-time arguments
ARG DEBIAN_FRONTEND="noninteractive"

# environment variables
ENV OPEN5GS_NF="ausf"

# install dependencies
RUN apt-get update && apt-get install libgnutls28-dev libgcrypt-dev libtalloc-dev \
    libnghttp2-dev libmicrohttpd-dev libcurl4-gnutls-dev libyaml-dev -y

# change working directory
WORKDIR /open5gs

# copy executable, default config and libs
COPY --from=builder /open5gs/install/bin/open5gs-ausfd /open5gs/install/bin/open5gs-ausfd
COPY --from=builder /open5gs/install/etc/open5gs/ausf.yaml /open5gs/install/etc/open5gs/ausf.yaml
COPY --from=builder /open5gs/install/etc/open5gs/tls/ca.crt /open5gs/install/etc/open5gs/tls/ausf.crt /open5gs/install/etc/open5gs/tls/ausf.key /open5gs/install/etc/open5gs/tls/
COPY --from=builder /open5gs/install/etc/open5gs/hnet/curve25519-1.key /open5gs/install/etc/open5gs/hnet/curve25519-3.key /open5gs/install/etc/open5gs/hnet/curve25519-5.key \
/open5gs/install/etc/open5gs/hnet/secp256r1-2.key /open5gs/install/etc/open5gs/hnet/secp256r1-4.key /open5gs/install/etc/open5gs/hnet/secp256r1-6.key /open5gs/install/etc/open5gs/hnet/
COPY --from=builder /open5gs/install/lib/x86_64-linux-gnu/libogscrypt.so.2 /open5gs/install/lib/x86_64-linux-gnu/libogsproto.so.2 \
/open5gs/install/lib/x86_64-linux-gnu/libogscore.so.2 /open5gs/install/lib/x86_64-linux-gnu/libogssbi.so.2 /open5gs/install/lib/x86_64-linux-gnu/libogsapp.so.2 \
/open5gs/install/lib/x86_64-linux-gnu/libogssbi-openapi.so.2 /open5gs/install/lib/x86_64-linux-gnu/

# create directory to store the logs
RUN mkdir -p /open5gs/install/var/log/open5gs/

ENTRYPOINT [ "/open5gs/install/bin/open5gs-ausfd" ]

# use CMD to provide arguments to ENTRYPOINT (can be overridden by user)
CMD [ "-c", "/open5gs/install/etc/open5gs/ausf.yaml" ]
