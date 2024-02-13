# Overview of the internal deployment

![Overview of the internal deployment](../../misc/diagrams/internal.png)

The `internal` deployment is prepared to work with internal gNBs (and UEs), only exposing the MongoDB database using `TCP port 27017`.

The `internal/ueransim` deployment works with [UERANSIM](https://github.com/aligungr/UERANSIM) using the gNB and UE images from [docker-ueransim](https://github.com/Borjis131/docker-ueransim).

The `internal/packetrusher` deployment works with [PacketRusher](https://github.com/HewlettPackard/PacketRusher) using the packetrusher image from [docker-packetrusher](https://github.com/Borjis131/docker-packetrusher).

This deployment connects an emulated UE and gNB to the Open5GS 5G Core.