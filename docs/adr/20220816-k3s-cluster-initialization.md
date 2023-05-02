# K3s cluster initialization

- Status: superseded by [20230422-k3s-cluster-initialization-update-1](./20230422-k3s-cluster-initialization-update-1.md)
- Date: 2022-08-16
- Tags: k3s, kubernetes, control plane, masters, bootstrap, init

## Context and Problem Statement

In order to keep this initiative fully automated, Kubernetes cluster creation should be automated as well; the platform of choice (K3s) as a multi-node HA setup has a simple execution flow:

- one (the first) node will initialize the cluster and build the embedded `etcd` backend
- the subsequent nodes will join as masters and have a local replica of `etcd`

But how the node is selected? Better yet, how can a newly bootstrapping master be aware that it's not to perform a cluster initialization but have to join an existing cluster?

## Decision Drivers <!-- optional -->

- Have a reliable, updateable discovery method
- Do not rely on external managed service to do the discovery

## Considered Options

- [option 1]: using the **creation date** timestamp to identify if local id is the oldest
- [option 2]: query the **status of the Load Balancer** and determine if the cluster is already up and running

  Very brittle: an API server (or more) could be unable to respond.

- [option 3]: look for **a metadata key** to flag that one instace is the cluster initer

  It's a single OCI command to identify the specific key and retrieve if/what/how many node(s) are attempting cluster initing.
- … <!-- numbers of options can vary -->

## Decision Outcome

Chosen option: "[option 3]", because it's the most efficient and doesn't require complex backoff logic to prevent multiple inits (instance metadata are retained for some time after getting terminated).

## Pros and Cons of the Options <!-- optional -->

### [option 1]

[example | description | pointer to more information | …] <!-- optional -->

- Good:
  - easy enough to identify and compare (especially with `jq`)
  - data appears in the instance metadata
- Bad:
  - for multiple instance pool that requires several multiple OCI commands
  - backoff strategy is built-in and brittle
- … <!-- numbers of pros and cons can vary -->

### [option 2]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- … <!-- numbers of pros and cons can vary -->

### [option 3]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- … <!-- numbers of pros and cons can vary -->

## Links <!-- optional -->

- [Link type](link to adr) <!-- example: Refined by [xxx](yyyymmdd-xxx.md) -->
- … <!-- numbers of links can vary -->
