# Overview of the basic deployment

![Overview of the basic deployment](../../misc/diagrams/basic.png)

The `basic` deployment is prepared to work with external gNBs, exposing:
- `N2` control plane interface on the AMF using `SCTP port 38412`
- `N3` user plane  interface on the UPF using `UDP port 2152`

It also exposes the MongoDB database using `TCP port 27017`.

`basic` and `scp-model-d` are the preferred deployments to build the Open5GS Docker images.
Keep in mind that because this deployment does not use the SCP Network Function, it will not build it. Use `scp-model-d` to build the SCP Docker image.