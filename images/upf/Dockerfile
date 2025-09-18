# syntax=docker/dockerfile:1

# global build-time arguments for FROM statements
ARG OPEN5GS_VERSION="v2.7.6"
ARG UBUNTU_VERSION="jammy"

FROM base-open5gs:${OPEN5GS_VERSION} AS builder

FROM ubuntu:${UBUNTU_VERSION}

# target container architecture
ARG TARGETARCH

# build-time arguments
ARG DEBIAN_FRONTEND="noninteractive"
ARG YQ_VERSION="v4.30.6"

# install dependencies
RUN apt-get update && apt-get install libssl-dev libtalloc-dev libtins-dev \
    libyaml-dev iproute2 iptables wget libmicrohttpd-dev -y

# install yq
RUN wget --quiet https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${TARGETARCH} -O /usr/bin/yq && chmod +x /usr/bin/yq

# copy executable, default config and libs
COPY --from=builder /open5gs/install/bin/open5gs-upfd /usr/local/bin/open5gs-upfd
COPY --from=builder /open5gs/install/etc/open5gs/upf.yaml /etc/open5gs/default/upf.yaml
COPY --from=builder /open5gs/install/lib/*/libogsproto.so.2 /open5gs/install/lib/*/libogscore.so.2 \
/open5gs/install/lib/*/libogsapp.so.2 /open5gs/install/lib/*/libogspfcp.so.2 /open5gs/install/lib/*/libogsgtp.so.2 \
/open5gs/install/lib/*/libogstun.so.2 /open5gs/install/lib/*/libogsipfw.so.2 /open5gs/install/lib/*/libogsmetrics.so.2 \
/open5gs/install/lib/*/libprom.so /usr/local/lib/

# configure dynamically linked libraries
RUN ldconfig

# copy helper_functions and entrypoint scripts
COPY ./helper_functions.sh /usr/local/bin/helper_functions.sh
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

# create directory to store the logs
RUN mkdir -p /var/log/open5gs/

ENTRYPOINT [ "entrypoint.sh" ]

# use CMD to provide arguments to ENTRYPOINT (can be overridden by user)
CMD [ "-c", "/etc/open5gs/default/upf.yaml" ]
