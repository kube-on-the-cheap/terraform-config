# K3s workers resource distribution

- Status: superseded by [20220904-k3s-workers-resource-distribution-update](20220904-k3s-workers-resource-distribution-update.md)
- Date: 2022-09-03
- Tags: k3s, kubernetes, data plane, workers, bootstrap, init

Technical Story: K3s

## Context and Problem Statement

How can we distribute the allotted resources for Flexible Ampere A1 instances in an effective way?

## Decision Drivers

- Striking a good balance between size and scale of workers
- [Oracle "Always Free" Tier](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm) boundaries respected

## Considered Options

- 3 smaller nodes (1/6)
- 1 large node (3/20)
- 1 large (2/12) + 1 medium (1/8) node

## Decision Outcome

Chosen option: "1 large + 1 medium node", because there won't be more than 1 Ampere A1 master for the foreseeable future, and having three smaller nodes would potentially prevent a memory-intensive application. Still, the multi-zone setup grant some redundancy.

### Positive Consequences

- We can more easily switch between resource tiers for Ampere A1 configs
