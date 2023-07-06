# Overview of the scp model d deployment

![Overview of the scp-model-d deployment](../../misc/diagrams/scp-model-d.png)

The `scp-model-d` deployment is prepared to work with external gNBs, exposing:
- `N2` control plane interface on the AMF using `SCTP port 38412`
- `N3` user plane  interface on the UPF using `UDP port 2152`

It also exposes the MongoDB database using `TCP port 27017`.

This deployment builds all the Docker images for the Network Functions, because the deployment `basic` lacks the SCP Network Function.

The configuration for this deployment is set up to use the `Model D` or `indirect communication with delegated discovery` for the communication between the Network Functions. This form of communication makes all the Network Functions present in the 5G Core to perform the requests to the SCP and the SCP (acting like a proxy) forwards the request to the appropiate Network Function. 

In `Model D` this includes the Network Function discovery mechanisms, so the SCP will receive the discovery request and forward it to the NRF. 

![SCP Model D communication diagram](../../misc/diagrams/model-d-diagram.png)

More information can be read in this [Ericsson White Paper about indirect communication](https://www.ericsson.com/en/reports-and-papers/white-papers/indirect-communication-for-service-based-architecture-in-5g-core).