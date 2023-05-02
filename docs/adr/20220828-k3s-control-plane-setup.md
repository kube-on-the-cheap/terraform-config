# K3s control plane setup

- Status: accepted
- Date: 2022-08-28
- Tags: k3s, high availability, redundance, control plane, kubernetes

Technical Story: K3s

## Context and Problem Statement

What's the best K3s control plane setup without exceeding the free tier limits? In other words, can we achieve a fully highly-available control plane *and* keep multiple workers?

## Decision Drivers

- Ease of maintenance
- Solution resiliency
- [Oracle "Always Free" Tier](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm) boundaries respected

## Considered Options

- HA using a mix of Ampere A1 and AMD instances
- HA using Ampere A1 instances only
- No HA

## Decision Outcome

Chosen option: "No HA". The current AMD implementation isn't performant enough to be a master node, but `etcd` requires [an odd number of nodes](https://etcd.io/docs/v3.3/faq/#why-an-odd-number-of-cluster-members) to reach fault tolerance 1. We'll partially compensate for the loss of HA by scheduling `etcd` snapshot rotation to S3 (that's not HA, that's backup - but _c'est comme ça_).

### Positive Consequences

- Cluster initialization does not require checks to avoid multiple inits, and it's much faster
- Existing init automation will leave the chance to implement this later without effort

### Negative Consequences

- The single master is a SPoF

## Pros and Cons of the Options

### HA using a mix of Ampere A1 and AMD instances

This was supposedly the best option of three; two performant masters and one sub-par instance, and leaving only the former two behind a Load Balancer. Unfortunately, the AMD node brings down the whole `etcd` implementation.

- Good, because we can fully utilize the free resources provided
- Good, because we have no SPoF across the region
- Bad, because the specs don't make this solution viable

### HA using Ampere A1 instances only

Another path to follow is to use 3 nodes from Ampere A1 instances. This would leave a single node to cover for the worker role, plus two smaller AMD instance.

- Good, because we can have real HA on the control plane
- Bad, because we leave little resources to the data plane

### No HA

Last but not least, we have the possibility to not implement HA now.

- Good, because we're immediately up-and-running
- Good, because the existing init implementation will give us a way to implement HA just by scaling up the relevant Instance Pools
- Bad, because the master is a SPoF

## Links

- n/a
