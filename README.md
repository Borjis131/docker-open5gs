# Open5GS 5G Core in Docker

Open5GS 5G Core Network Functions images ready for Docker.

This repository contains the Dockerfiles and docker compose files used to deploy a configurable 5G Core.

The repository uses the same release version tags as Open5GS, so to use an specific Open5GS version just select the appropiate tag.

The Docker images are available:
- in DockerHub `borieher/<nf_name>:<open5gs_version>`
- in GitHub Container Registry `ghcr.io/borjis131/<nf_name>:<open5gs_version>`

## Configure it

All the images depend on the base image. So first, update the `.env` file with the desired values to use:

`OPEN5GS_VERSION` is the version of Open5GS to use.
- Accepted values are the tags, branches or commit IDs used in the Open5GS project
- Default value: v2.6.2
- Tested values: v2.5.5, v2.5.6, v2.5.8, v2.6.1, v2.6.2

`UBUNTU_VERSION` is the version of the ubuntu Docker image used as base for the containers.
- Accepted values are the tags used by Ubuntu in Docker Hub
- Default value: jammy
- Tested values: focal, jammy

`MONGODB_VERSION` is the version of the mongo Docker image used as database for Open5GS.
- Accepted values are the tags used by MongoDB in Docker Hub
- Default value: The one specified in the `.env` file
- Tested values: 3.6.8, 4.2, 6.0

`DOCKER_HOST_IP` is the IP address of the host running Docker. This modifies the `advertise` field in the `upf.yaml` config file for this to work when exposing the Docker containers network.

## Build it

To create the base image run:
```bash
make
```

This will take a while, after this you will have the base image, tagged with the `OPEN5GS_VERSION` selected.

After this you can run the following to create the Network Functions images:
```bash
# Example using the basic deployment with docker compose (V2)
docker compose -f compose-files/basic-v3/docker-compose.yaml --env-file=.env up -d

# or

# Example using the basic deployment with docker-compose (V1)
docker-compose -f compose-files/basic-v2/docker-compose.yaml up -d
```

## Use it
```bash
# Run the basic deployment with docker compose (V2)
docker compose -f compose-files/basic-v3/docker-compose.yaml --env-file=.env up -d

# Tear down the basic deployment with docker compose (V2)
docker compose -f compose-files/basic-v3/docker-compose.yaml --env-file=.env down

# or

# Run the basic deployment with docker-compose (V1)
docker-compose -f compose-files/basic-v2/docker-compose.yaml up -d

# Tear down the basic deployment with docker-compose (V1)
docker-compose -f compose-files/basic-v2/docker-compose.yaml down
```

### Repository contents

- `compose-files/` directory contains different docker compose deployments.
- `configs/` directory contains the Open5GS configuration files for each docker compose deployment.
- `docs/` directory contains the documentation for this project.
- `images/` directory has each Network Function Dockerfile.

Check `docs/` to see the documentation.
