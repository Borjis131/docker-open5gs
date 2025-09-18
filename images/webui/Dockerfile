# syntax=docker/dockerfile:1

# global build-time arguments for FROM statements
ARG NODE_VERSION="20"

FROM node:${NODE_VERSION}-bookworm AS builder

# build-time arguments for builder
ARG OPEN5GS_VERSION="v2.7.6"
ARG DEBIAN_FRONTEND="noninteractive"

# install dependencies
RUN apt-get update && apt-get install git -y

# clone the specific open5gs version
RUN git clone --depth 1 --branch=${OPEN5GS_VERSION} https://github.com/open5gs/open5gs

# install webui
RUN cd open5gs/webui && npm ci && npm run build

FROM node:${NODE_VERSION}-bookworm-slim

# copy webui
COPY --from=builder /open5gs/webui/ /usr/local/src/webui

ENV DB_URI="mongodb://localhost/open5gs"
ENV HOSTNAME="0.0.0.0"
ENV PORT=9999
ENV NODE_ENV="dev"

WORKDIR /usr/local/src/webui
ENTRYPOINT ["npm"]

# use CMD to provide arguments to ENTRYPOINT (can be overridden by user)
CMD [ "run", "dev" ]
