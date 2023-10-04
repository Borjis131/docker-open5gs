# syntax=docker/dockerfile:1

# global build-time arguments for FROM statements
ARG OPEN5GS_VERSION="v2.6.5"
ARG UBUNTU_VERSION="jammy"

FROM base-open5gs:${OPEN5GS_VERSION} AS builder

FROM ubuntu:${UBUNTU_VERSION}

# build-time arguments
ARG DEBIAN_FRONTEND="noninteractive"
ARG YQ_VERSION="v4.30.6"

# environment variables
ENV OPEN5GS_NF="upf"

# install dependencies
RUN apt-get update && apt-get install libssl-dev libtalloc-dev libtins-dev \
    libyaml-dev iproute2 iptables wget libmicrohttpd-dev -y

# install yq for x86-64/amd64
RUN wget --quiet https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq

# change working directory
WORKDIR /open5gs

# copy executable, default config and libs
COPY --from=builder /open5gs/install/bin/open5gs-upfd /open5gs/install/bin/open5gs-upfd
COPY --from=builder /open5gs/install/etc/open5gs/upf.yaml /open5gs/install/etc/open5gs/upf.yaml
COPY --from=builder /open5gs/install/lib/x86_64-linux-gnu/libogsproto.so.2 /open5gs/install/lib/x86_64-linux-gnu/libogscore.so.2 \
/open5gs/install/lib/x86_64-linux-gnu/libogsapp.so.2 /open5gs/install/lib/x86_64-linux-gnu/libogspfcp.so.2 /open5gs/install/lib/x86_64-linux-gnu/libogsgtp.so.2 \
/open5gs/install/lib/x86_64-linux-gnu/libogstun.so.2 /open5gs/install/lib/x86_64-linux-gnu/libogsipfw.so.2 /open5gs/install/lib/x86_64-linux-gnu/libogsmetrics.so.2 \
/open5gs/install/lib/x86_64-linux-gnu/libprom.so /open5gs/install/lib/x86_64-linux-gnu/

# copy helper_functions and entrypoint scripts
COPY ./helper_functions.sh /open5gs/helper_functions.sh
COPY ./entrypoint.sh /open5gs/entrypoint.sh

# create directory to store the logs
RUN mkdir -p /open5gs/install/var/log/open5gs/

ENTRYPOINT [ "/open5gs/entrypoint.sh" ]

# use CMD to provide arguments to ENTRYPOINT (can be overridden by user)
CMD [ "-c", "/open5gs/install/etc/open5gs/upf.yaml" ]
