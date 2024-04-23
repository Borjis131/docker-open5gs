# Open5GS 5G Core in Docker

[Open5GS](https://github.com/open5gs/open5gs) 5G Core Network Functions images ready for Docker.

This repository contains the Dockerfiles and docker compose files used to deploy a configurable 5G Core.

The repository uses the same release version tags as Open5GS, so to use an specific Open5GS version just select the appropiate tag.

The Docker images are available for `amd64/x86-64` and `arm64/v8`:
- in DockerHub `borieher/<nf_name>:<open5gs_version>`
- in GitHub Container Registry `ghcr.io/borjis131/<nf_name>:<open5gs_version>`

## Configure it

All the images depend on the base image. So first, update the `.env` file with the desired values to use:

`OPEN5GS_VERSION` is the version of Open5GS to use.
- Accepted values are the tags, branches or commit IDs used in the Open5GS project
- Default value: v2.7.1
- Tested values: v2.5.5, v2.5.6, v2.5.8, v2.6.1, v2.6.2, v2.6.3, v2.6.4, v2.6.6, v2.7.0, v2.7.1

`UBUNTU_VERSION` is the version of the ubuntu Docker image used as base for the containers.
- Accepted values are the tags used by Ubuntu in Docker Hub
- Default value: jammy
- Tested values: focal, jammy

`MONGODB_VERSION` is the version of the mongo Docker image used as database for Open5GS.
- Accepted values are the tags used by MongoDB in Docker Hub
- Default value: The one specified in the `.env` file
- Tested values: 3.6.8, 4.2, 6.0

`DOCKER_HOST_IP` is the IP address of the host running Docker. This modifies the `advertise` field in the `upf.yaml` config file for this to work when exposing the Docker containers network.

## Build it (2 ways)

### First way (make + docker compose build)

>Note: Requires make and docker-compose-plugin

To create the base image run:
```bash
make
```

This will take a while, after this you will have the base image called `base-open5gs`, tagged with the `OPEN5GS_VERSION` selected.

After this you can run the following to create the Network Functions images:
```bash
# Example using the basic deployment
docker compose -f compose-files/basic/docker-compose.yaml --env-file=.env up -d
```

### Second way (docker buildx bake)

>Note: Requires docker-buildx-plugin

With this method, you can build all the images all at once with a single command, run:
```bash
docker buildx bake
```

>Note: This command uses the `docker-bake.hcl` file, please update the `OPEN5GS_VERSION` and `UBUNTU_VERSION` variables there before running it.

## Use it

```bash
# Run the basic deployment
docker compose -f compose-files/basic/docker-compose.yaml --env-file=.env up -d

# Tear down the basic deployment
docker compose -f compose-files/basic/docker-compose.yaml --env-file=.env down
```

## Overview of the basic deployment

![Overview of the basic deployment](misc/diagrams/basic.png)

The `basic` deployment is prepared to work with external gNBs, exposing:
- `N2` control plane interface on the AMF using `SCTP port 38412`
- `N3` user plane  interface on the UPF using `UDP port 2152`

It also exposes the MongoDB database using `TCP port 27017`.

### Repository contents

- `compose-files/` directory contains different docker compose deployments.
- `configs/` directory contains the Open5GS configuration files for each docker compose deployment.
- `docs/` directory contains the documentation for this project.
- `images/` directory has each Network Function Dockerfile.
- `misc/` contains examples and diagrams.

Check `docs/` to see the full documentation.
