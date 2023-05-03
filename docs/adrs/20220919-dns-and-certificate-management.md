# DNS and certificate management

- Status: accepted
- Date: 2020-09-19
- Tags: kubernetes, cert-manager, dns, oracle cloud

Technical Story: K3s

## Context and Problem Statement

We need to be able to create new hostnames for ingresses, and issue (and renew) certificates linked to those endpoints automatically. Which is the best and most cost-effective way to do this?

## Decision Drivers

- Automated way, minimal (if any) manual intervention
- Integration with Kubernetes (externaldns and cert-manager)
- As cheap as possible

## Considered Options

- Delegated zone to OCI DNS + externaldns + cert-manager (DNS validation)
- Delegated zone to third-party Cloud Provider + externaldns + cert-manager (DNS validation)
- Delegated zone to a self-hosted DNS + externaldns + cert-manager (DNS validation)
- No delegation + static records + cert-manager (HTTP validation)

## Decision Outcome

Chosen option: "Delegated zone to third-party Cloud Provider + externaldns + cert-manager (DNS validation)", because it's a zero-cost, well-integrated (cert-manager and externaldns in-tree) implementation that requires minimum setup. This is paid off with some setup complexity that - nevertheless - will be addressed.

### Negative Consequences

- The scope of the project is now a multi-cloud solution
- Stronger consequential execution bindings (Terragrunt is no longer optional)

## Pros and Cons of the Options

### Delegated zone to OCI DNS + externaldns + cert-manager

The simplest way (pursued initially) was to have a DNS public zone integrated in Oracle Cloud to be updated from within the CP perimeter with the usual dynamic groups + permissions schema to allow dynamic record provisioning and enabling the `DNS01` cert-manager validation (necessary for wildcards). Unfortunately, this is not available in the Free Tier.

- Good, because it's perfectly integrated and requires minium setup overhead
- Good, because it does not cross the OCI boundaries
- Bad, because it's a pay-per-use solution, and [a costly one](https://www.oracle.com/it/cloud/networking/pricing/#dns) (for us homelabber)

### Delegated zone to third-party Cloud Provider + externaldns + cert-manager (DNS validation)

Luckily, Digital Ocean [does not bill customers](https://docs.digitalocean.com/products/networking/dns/details/pricing/) for their DNS zone management. This, plus the fact that DO is a first-class citizen both in [externaldns](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/digitalocean.md) and [cert-manager](https://cert-manager.io/docs/configuration/acme/dns01/digitalocean/), makes for a perfect answer. This solution comes with some complexity, but we're prepared.

- Good, because it's as integrated as it gets
- Good, because it's as cheap as it gets
- Bad, because it adds another Cloud Provider to the mix

### Other options

TL;DR other options require too much effort, it being setting up manually DNS resources or automating our way out a DNS implementation. Not worth exploring, considering the other solutions
