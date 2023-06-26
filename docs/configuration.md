# Configuration guide

## Common configuration

### Network configuration

All the services are connected using a network called `open5gs` using the bridge driver and IPv4 addresses in the range 10.33.33.0/24. This network is destroyed with the Docker compose down command.

The `basic/` Docker compose deployment exposes three things:
- SCTP port 38412 for NGAP connections to the AMF
- UDP port 2152 for GTP connections to the UPF
- TCP port 27017 for connections to the mongo database

These ports are available in the loopback network of the host running Docker and the host itself exposes these ports for external connections.

### Database configuration

After building, the 5G Core will start without any user configured in the Open5GS mongo database.

The information for the database is kept in Docker volumes named `open5gs_db_config` and `open5gs_db_data`, this way the information added to the database is persistent between restarts.

You can use the Open5GS `open5gs-dbctl` script in the host to add users to the database.

The database Docker volumes are marked with a label `org.open5gs.mongodb_version` indicating the `MONGODB_VERSION` selected in the `.env` file. This marks the version used for the mongo container. This label is needed to debug issues with users changing the mongo container version but keeping the Docker volumes created.

> When upgrading/downgrading the `MONGODB_VERSION` the existing `open5gs_db_config` and `open5gs_db_data` Docker volumes could cause problems/crashing. It is recommended to remove them.

### Network Function configuration

You can override the command being run in the container by using the command section in each service specified in the Docker compose file:
```yaml
  nssf:
    ...
    command: "-c /open5gs/config/nssf.yaml"
    ...
```

## The `basic` Docker compose deployment

The `configs/basic/` configuration uses Open5GS 5G Network Functions without SCP.

The `configs/basic/upf.yaml` UPF config file is using the _advertise_ option with the `DOCKER_HOST_IP` environment variable present in the `.env` file (it is used through the `docker-host.external-ip` hosts entry). This configures the 5G Core to expect connections from external networks (not the docker network), through the host machine.

The files for the `basic` deployment `compose-files/basic/` contains the docker-compose.yaml files to work with Compose V2 using the Compose specification.

The `docker-compose.yaml` uses configs, the source config file present in `configs/basic/<nf>.yaml` and is mounted into the container path `/open5gs/config/<nf>.yaml`. This way you can try different configuration files without the need of rebuilding the Docker image.

## Specific Network Function configuration

### AMF configuration

AMF container lets you choose if you want to enable/disable checksum offloading. Checksum offloading is enabled by default but can be disabled by setting the environment variable `DISABLE_CHECKSUM_OFFLOADING` to TRUE in the Docker compose AMF service:
```yaml
  amf:
    ...
    environment:
      - DISABLE_CHECKSUM_OFFLOADING=TRUE
    ...
```

### UPF configuration

UPF container lets you enable/disable NAT in the UPF. NAT in the UPF is enabled by default but can be disabled by setting the environment variable `DISABLE_NAT` to TRUE in the Docker compose UPF service:
```yaml
  upf:
    ...
    environment:
      - DISABLE_NAT=TRUE
    ...
```

UPF container reads the subnets specified in the Open5GS config file and setups the network interfaces needed with the addresses specified and the NAT (or not) configuration:
```yaml
upf:
    ...
    subnet:
      - addr: 10.45.0.1/16
    ...
```
