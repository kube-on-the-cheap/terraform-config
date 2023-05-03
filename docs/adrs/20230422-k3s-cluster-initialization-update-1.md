# K3s cluster initialization - update 1

- Status: accepted
- Date: 2023-04-22
- Tags: k3s, kubernetes, control plane, masters, bootstrap, init

## Context and Problem Statement

Current bash-driven implementation is not easy to deploy, extend and troubleshoot. Let's find a better alternative.

## Decision Drivers

- Must be easy enough to introduce a change
- Must not require manual `target`ing in order to address implicit resource dependencies
- Must not compromise on security and well-form
- Should be easy to change `master`s and `worker`s indipendently
- Should not produce redundant code

## Considered Options

- Single terraform module for both, in a common root module
- Separate terraform modules for `master`s and `worker`s, with different root modules
- Separate terraform modules for `master`s and `worker`s in a common root module

## Decision Outcome

Chosen option: Separate terraform modules for `master`s and `worker`s in a common `root` module

## Pros and Cons of the Options

### Single terraform module for both, in a common `root` module

This is the current state of `oci-compute` and we want to change that.

- Good:
  - Dependencies are strong, explicit and do not require being passed around
- Bad:
  - Changes require a lot of effort
  - The blast radius is large

### Separate terraform modules for `master`s and `worker`s, with different root modules

We could keep separate `k3s-workers` and `k3s-masters` terraform module and invoke them from two different root modules.

- Good:
  - Minimum blast radius, I'm targeting only what I want to do
- Bad
  - There's a lot of duplication
  - Dependencies will grow a lot

### Separate terraform modules for `master`s and `worker`s in a common root module

We could have a common way of creating all necessary structures and a few conditionals for those needed just by `master`s and `worker`s.

- Good
  - It will be easy to add a few later components, like IAM policies
  - Dependencies are just the strict necessary
  - Duplication is minimum
  - Can customize Terragrunt workflow (destroy-before-create) just for this root module
- Bad
  - Blast radius for a single root module comprehends all compute nodes
