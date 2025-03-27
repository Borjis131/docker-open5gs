# Frequently Asked Questions

## Docker compose volume warning

It is normal to see:
```bash
WARN[0297]
volume "open5gs_db_data" already exists but was not created for project "<deployment_name>".
volume "open5gs_db_config" already exists but was not created for project "<deployment_name>".
```

It is only a warning, telling you that the Docker volume exists.

## No connectivity to an external network

Run in the host:
```bash
sudo sysctl -w net.ipv4.conf.all.forwarding=1

sudo iptables -P FORWARD ACCEPT

# Extracted from:
# enable forwarding from Docker containers to the outside world
# https://docs.docker.com/network/bridge/#enable-forwarding-from-docker-containers-to-the-outside-world
```

## Environment variables not expanding

If you are seeing an error related to the environment variables in Docker compose not expanding, check where the `.env` file is located. To avoid errors, it is easier to specify the path using the `--env-file` command option (even though, if you are using v1 format with `docker-compose`, it is not needed).
```bash
# Example using the basic deployment with docker compose (v2)
docker compose -f compose-files/basic/docker-compose.yaml --env-file=.env up -d

# Example using the basic deployment with docker-compose (v1)
docker-compose -f compose-files/basic/docker-compose.yaml --env-file=.env up -d
```

## mongo version > 5 Docker image not working

### Case 1 (Virtual Machine)
If the Docker image for mongo is higher than the 5.0 and it is crashing with a message regarding illegal AVX instruction and your host running Docker is running on a VM, specify the CPU type of the VM as the same CPU of the host.

> source: [docker-library/mongo GitHub issue](https://github.com/docker-library/mongo/issues/485#issuecomment-1028308997)

### Case 2 (Raspberry Pi 4)
mongo provides images for `arm64/v8` but targets ARMv8.2-A and the Raspberry Pi 4 has an ARMv8.0-A cpu, so the Docker images provided do not work. In order for it to work, the `docker-compose.yaml` files provided need to use the appropiate Docker image. An example of those images can be found [here](https://github.com/themattman/mongodb-raspberrypi-docker).

> source: [mongodb developer community forum](https://www.mongodb.com/community/forums/t/mongodb-and-the-pi-4-on-ubuntu-64-bit-aka-armv8-0-a-support/220635)

An example of the Compose file for it can be found in `misc/examples/raspberry-pi/`.

## The Docker Compose version mess

Let's start differentiating the Compose (aka the Docker Compose executable) from the Compose files.

Compose comes in two flavors:
- Compose V1 is written in Python and invoked with `docker-compose`. This Compose is not supported since June 2023.
- Compose V2 is written in Go and invoked with `docker compose`.

Compose files come in four different flavors:
- Compose file version 1 (deprecated)
- Compose file version 2.x
- Compose file version 3.x (cross compatible between Docker Compose and Docker Swarm)
- Compose specification

>Note: The current (June 2023) and recommended versions for Compose and Compose files are `Compose V2` with the `Compose specification`.

Examples for Compose file version 2.x and Compose file version 3.x will be kept under `misc/examples/`.

If you want to run them using Compose V2 or Compose V1:
```bash
# Run the basic deployment with docker compose (V2) and Compose file version 3.x
docker compose -f misc/examples/basic-compose-file-v3.x/docker-compose.yaml --env-file=.env up -d

# Tear down the basic deployment with docker compose (V2) and Compose file version 3.x
docker compose -f misc/examples/basic-compose-file-v3.x/docker-compose.yaml --env-file=.env down

# or

# Run the basic deployment with docker-compose (V1) and Compose file version 2.x
docker-compose -f misc/examples/basic-compose-file-v2.x/docker-compose.yaml up -d

# Tear down the basic deployment with docker-compose (V1) and Compose file version 2.x
docker-compose -f misc/examples/basic-compose-file-v2.x/docker-compose.yaml down
```

## How to use the UERANSIM container

You can use the emulated UE connection by connecting to the UE container:
```bash
# connect to the UE container
docker exec -it ue bash

# Use the TUN interface to test the UE connection
ping -I uesimtun0 8.8.8.8
```

## How to use the PacketRusher container

### gtp5g kernel dependency

The project uses [PacketRusher](https://github.com/HewlettPackard/PacketRusher) using the packetrusher image from [docker-packetrusher](https://github.com/Borjis131/docker-packetrusher).

Check [docker-packetrusher](https://github.com/Borjis131/docker-packetrusher) and follow the section `Important notes` to use this image. This image depends on a kernel module being installed on the host machine, the `free5gc's gtp5g kernel module`.

### Using the UE's connection

You can use the emulated UE connection by using the VRF.

Check the logs of the PacketRusher container to see the VRF identifier:
```bash
docker logs -f packetrusher
...
time="2024-09-26T10:46:32Z" level=info msg="[UE][GTP] Interface val1234567891 has successfully been configured for UE 10.45.0.2"
time="2024-09-26T10:46:32Z" level=info msg="[UE][GTP] You can do traffic for this UE using VRF vrf1234567891, eg:"
time="2024-09-26T10:46:32Z" level=info msg="[UE][GTP] sudo ip vrf exec vrf1234567891 iperf3 -c IPERF_SERVER -p PORT -t 9000"
```

Connect to the PacketRusher container and then to the VRF:
```bash
# connect to the PacketRusher container
docker exec -it packetrusher bash

# Use the VRF inside the PacketRusher container
ip vrf exec vrf1234567891 bash

# Test the UE connection
ping 8.8.8.8
```