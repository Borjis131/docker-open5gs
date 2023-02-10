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

If the Docker image for mongo is higher than the 5.0 and it is crashing with a message regarding illegal AVX instruction and your host running Docker is running on a VM, specify the CPU type of the VM as the same CPU of the host.

> source: [docker-library/mongo GitHub issue](https://github.com/docker-library/mongo/issues/485#issuecomment-1028308997)
