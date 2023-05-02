# K3s workers resource distribution - update 1

- Status: accepted
- Date: 2022-09-04
- Tags: k3s, kubernetes, data plane, workers, bootstrap, init

Technical Story: K3s

## Context and Problem Statement

How can we distribute the allotted resources for Flexible Ampere A1 instances in an effective way?

## Decision Drivers

- Striking a good balance between the size and scale of workers, while also maximizing resource usage
- [Oracle "Always Free" Tier](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm) boundaries respected - that means a maximum of two Instance Pools (from now on, IPs) and two Instance Configurations (ICs)

## Considered Options

- 1 large (2/12) + 1 medium (1/8) node
- 2 larg-_ish_ (1/10) + 1 medium-_ish_ (2/4) node

## Decision Outcome

Chosen option: "2 larg-_ish_ (1/10) + 1 medium-_ish_ (2/4) node", because when the Free Tier got in effect (after the end of the 1 mo trial) that's the best way to optimize resource usage while dealing with only two ICs. Also, the boot volume for workers will be bumped to 75 GBs so the 200 GB space will be 100% used.

### Negative Consequences

- It won't be as easy to change ICs, because as long as we're fully using our quota of 2/2, we won't be able to provision a new one to attach to the exising IP.
- Multiple worker type model works, but it's out of the picture with the "Always Free" tier

## Links

- Supersedes [20220903-k3s-workers-resource-distribution](20220903-k3s-workers-resource-distribution.md)
