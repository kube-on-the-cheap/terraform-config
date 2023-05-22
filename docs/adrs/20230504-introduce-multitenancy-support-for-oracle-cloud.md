# Introduce multitenancy support for Oracle Cloud

- Status: accepted
- Date: 04-05-2023
- Tags: terraform, monorepo, structure, git

Technical Story: Multitenancy

## Context and Problem Statement

I want to be able to provision the same infrastructure (be it a k3s cluster or just a subset of resources) in different OCI tenants

## Decision Drivers <!-- optional -->

- Must reference the same root modules
- Must account for customizations at the region/account level
- Should include transversal per-project non-tenant-specific module(s)
- Should be easy to action
- Should be easy to add more and more tenants

## Considered Options

- One repo per tenant, same directory structure
- One repo for all tenants, composite directory structure

## Decision Outcome

Chosen option: one repo for all tenants, composite directory structure, because it will be easy to add new tenants, it's trivial to share configuration and we can keep the strong root module consistency introduced in [the previous ADR](20230428-terraform-module-versioning.md).

## Pros and Cons of the Options <!-- optional -->

### One repo per tenant, same directory structure

An easy way would be to replicate this repository structure in multiple ones.

- Good
  - it's trivial to replicate
  - execution paths are independent: you can target a specific environment, and the blast radius is minimal
- Bad
  - it requires a root module external reference
  - execution paths are independent: more moving parts to maintain, dependency references are external
  - duplication for code that needs to be present or recalled from all tenants

### One repo for all tenants, composite directory structure

Let's refactor the directory structure, passing from

```txt
configs
├── bootstrap
│   └── prerequisites
│       └── terragrunt.hcl
└── k3s
    ├── core-infra
    │   └── terragrunt.hcl
    └── k3s
        └── terragrunt.hcl
```

to something like

```txt
configs
├── project-setup
│   └── terragrunt.hcl
├── oci
│   ├── blacksd
│   │   └── eu-frankfurt-1
│   │       ├── region-setup
│   │       │   └── terragrunt.hcl
│   │       └── k3s
│   │           ├── k3s-core-infra
│   │           │   └── terragrunt.hcl
│   │           └── k3s-nodes
│   │               └── terragrunt.hcl
│   └── new_tenant...
│   │   └── new_region...
│   │       ├── region-setup
│   │       └── some_other_cloud_project...
│   │           ├── project_component_1
│   │           └── project_component_2
└── terragrunt.hcl
```

- Good
  - it's easy enough to add a new region in a tenancy, a new tenant, or simply a new module
  - execution paths are still independent
  - dependencies are explicit and can cross tenancy boundaries (minimum code duplication)
- Bad
  - it's heavily structured, so a bit hard to grasp
  - some directory structure is non-linear (eg. `region-setup` at the same level of `k3s`), but it's a requirement from Terragrunt to have the file with a specific naming syntax


## Links

- [Terragrunt configuration syntax](https://terragrunt.gruntwork.io/docs/getting-started/configuration/)
