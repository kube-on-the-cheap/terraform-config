# Terraform module versioning

- Status: accepted
- Date: 2023-04-28
- Tags: terraform, module, monorepo

Technical Story: Cloud Infrastructure

## Context and Problem Statement

We want to provide versioning for modules, but also keep strong consistency

## Decision Drivers

- must be able to version independently the components
- must keep strong consistency between the root modules across all implementations
- must keep any version as SemVer compliant
- should be able to version independently the components
- should minimize the logic to put in the monorepo


## Considered Options

- Split `modules/components` and `modules/root` in two separate monorepos. Build a pipeline that tests and release new version every `component` or `root` change. Open a PR and apply it on this config repo.
- Split `modules/components` in a separate monorepo, but keep `modules/root` here. Build a pipeline that tests and release new version every `component` change. Open a PR and apply it on this config repo.
- Split `modules/root` in a separate monorepo and use multiple repositories for `modules/components`. Build a pipeline that tests and release new version every `component`, opens a PR towards the `root` and release a single version every change. Open a PR towards this config repo.

## Decision Outcome

Chosen option: split `modules/components` in a separate monorepo, but keep `modules/root` here. I can implement a pipeline that creates semver-compliant releases for every change, and use a dependabot-approach here to keep modules updated.

### Positive Consequences

- Strong consistency achieved: all root modules invocations will necessarily be at the same version
- Higher module reusability: with versioning I can introduce breaking changes, never for more than 1 root module at once
- A great step forward for multi-tenancy

### Negative Consequences

- Another repo, pipeline and upgrade path to maintain
