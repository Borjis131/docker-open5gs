# Open5GS 5G Core in Docker

[Open5GS](https://github.com/open5gs/open5gs) 5G Core Network Functions images ready for Docker.

This repository contains the Dockerfiles, Docker Compose files and Helm charts to deploy a configurable 5G Core.

The repository uses the same release version tags as Open5GS, so to use an specific Open5GS version just select the appropiate tag.

The Docker images are available for `amd64/x86-64` and `arm64`:
- in DockerHub `borieher/<nf_name>:<open5gs_version>`
- in GitHub Container Registry `ghcr.io/borjis131/<nf_name>:<open5gs_version>`

> [!TIP]
> You can use the tag `latest` to download the latest docker-open5gs version available.
> Currently latest tag points to `v2.7.6`

The Helm charts are available:
- in DockerHub `registry-1.docker.io/borieher/<chart_name> --version <chart_version>`

> [!NOTE]
> The <chart_version> is not the same as the <open5gs_version>

## Configure it

All the images (except `webui`) depend on the `base-open5gs` image to be built, after that each image is independent.

First, update the `.env` and `docker-bake.hcl` files with the desired values to use.

The `.env` file is used to build the images using Make or Docker Compose, as well as deploying in Docker Compose. The `docker-bake.hcl` file is used to build the images using bake.

`OPEN5GS_VERSION` is the version of Open5GS to use.
- Accepted values are the tags, branches or commit IDs used in the Open5GS project
- Default value: v2.7.6
- Tested values: v2.5.5, v2.5.6, v2.5.8, v2.6.1, v2.6.2, v2.6.3, v2.6.4, v2.6.6, v2.7.0, v2.7.1, v2.7.2, v2.7.5, v2.7.6

`UBUNTU_VERSION` is the version of the ubuntu Docker image used as base for the containers.
- Accepted values are the tags used by Ubuntu in Docker Hub
- Default value: jammy
- Tested values: focal, jammy

`MONGODB_VERSION` is the version of the mongo Docker image used as database for Open5GS.
- Accepted values are the tags used by MongoDB in Docker Hub
- Default value: The one specified in the `.env` file
- Tested values: 3.6.8, 4.2, 6.0, 8.0

`NODE_VERSION` is the version of Node.js being used to build the Open5GS WebUI.
- Accepted values are the tags used by Node in Docker Hub for its bookworm-slim image and the Node.js dependency of Open5GS WebUI
- Default value: 20
- Tested values: 20

`DOCKER_HOST_IP` is the IP address of the host running Docker. This modifies the `advertise` field in the `upf.yaml` config file for this to work when exposing the Docker containers network.

## Build it

<details>
<summary>Build it with Bake</summary>

> Tip: This is the recommended way to build the project, you can build the images all at once with a single command taking advantage of docker buildx parallelism

> Note: This method uses the `docker-bake.hcl` file and requires `docker-buildx-plugin`

From the top level directory of the repository run:
```bash
docker buildx bake
```

</details>
<details>
<summary>Build it with Make</summary>

> Note: This method uses the `Makefile` and `.env` files

From the top level directory of the repository run the following to create the `base-open5gs` image and all the Network Function images:
```bash
make all
```

This will take a while.

</details>
<details>
<summary>Build it with Docker Compose</summary>

> Note: This method uses the `Makefile`, `.env` and `docker-compose.yaml` files

Some deployments have the build instructions for the images (like the `basic` deployment), only depending of the `base-open5gs` image. Some other deployments download the images needed from container registries like Docker Hub or GitHub Container Registry (like the `network-slicing` deployment).

First create the `base-open5gs` image, from the top level directory of the repository run:
```bash
make base-open5gs
```

Then select the appropiate deployment (`basic`, `scp-model-d` or `roaming`). From the top level directory of the repository, run:
```bash
# Example using the basic deployment
docker compose -f compose-files/basic/docker-compose.yaml --env-file=.env up -d
```

This command builds all the images for the deployment selected and then runs the deployment.

</details>
<details>
<summary>Build the Helm charts</summary>

Use the following commands inside the `helm/` directory.

First retrieve the dependencies of each chart individually, the `open5gs` chart must be the latest one, cause it depends on all the other charts:
```bash
helm dependency build ./<chart_name>
```

You can also package the charts (it is not mandatory):
```bash
helm package ./<chart_name>
```

</details>

## Use it

<details>
<summary>Use it with Docker Compose</summary>

Update the `.env` file with the desired values to use:

Then select the appropiate deployment and from the top level directory of the repository run:
```bash
# Run the basic deployment
docker compose -f compose-files/basic/docker-compose.yaml --env-file=.env up -d

# Tear down the basic deployment
docker compose -f compose-files/basic/docker-compose.yaml --env-file=.env down
```

</details>
<details>
<summary>Use it with Kubernetes</summary>

You can download the packaged charts from the repository or you can use the ones built by yourself.

Current `CHART_VERSION` value for the Open5GS chart is 0.3.5, using `OPEN5GS_VERSION` v2.7.5 as default.
The `CHART_VERSION` for individual charts is 0.3.4, using `OPEN5GS_VERSION` v2.7.5 as default.

To download a chart:
```bash
helm pull oci://registry-1.docker.io/borieher/<chart_name> --version <CHART_VERSION>
```

To install a chart run:
```bash
helm install -n <namespace> <release_name> ./<chart_name>
```

You can provide your custom values using the helm flag `-f` and providing a `values.yaml` file:
```bash
helm install -n <namespace> -f values.yaml <release_name> ./<chart_name>
```

If the namespace does not exist, create it by using the helm flag `--create-namespace`.

To uninstall a chart and remove a namespace run:
```bash
helm uninstall -n <namespace> <release_name>

kubectl delete namespace <namespace>
```

</details>

## Repository structure

- `compose-files/` directory contains different docker compose deployments.
- `configs/` directory contains the Open5GS configuration files for each docker compose deployment.
- `docs/` directory contains the documentation for this project.
- `images/` directory has each Network Function Dockerfile.
- `misc/` contains examples and diagrams.

### Overview of the basic deployment

![Overview of the basic deployment](misc/diagrams/basic.png)

The `basic` deployment is prepared to work with external gNBs, exposing:
- `N2` control plane interface on the AMF using `SCTP port 38412`
- `N3` user plane  interface on the UPF using `UDP port 2152`

It also exposes the MongoDB database using `TCP port 27017`.

Check `docs/` to see the full documentation for the different deployments.
