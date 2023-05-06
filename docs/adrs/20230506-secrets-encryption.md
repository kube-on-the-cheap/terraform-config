# Secrets encryption

- Status: draft
- Date: 06-05-2023
- Tags: secrets, pii, encryption, terragrunt, terraform

Technical Story: Centralized execution, Multitenancy

## Context and Problem Statement

I need to store securely secrets in a public git repository. This is necessary if I want to introduce multitenancy.

## Decision Drivers

- Must be comitted encrypted in the repository (duh) to use versioning and enforce dependency
- Must integrate well with Terraform and Terragrunt
- Must support programmatical (GitHub Actions) or user-driven ("it-runs-on-my-machine") decryption/encryption
- Must be cost-effective
- Should minimize third-party involvements
- Should prioritize short-lived, rotating tokens for encryption/decryption

## Considered Options

- GitHub Secrets as environment variables
- SOPS with PGP key
- SOPS with KMS from a supported Cloud Provider

## Decision Outcome

Chosen option: "SOPS with KMS from a supported Cloud Provider", where the Cloud Provider is Google Cloud because it ticks all the boxes and it's exceptionally secure and easy to maintain.

## Pros and Cons of the Options

### GitHub Secrets as environment variables

A simple option would be to add GitHub Secrets to account for all secrets.

- Good
  - Well integrated with Terraform and Terragrunt (see [here](https://terragrunt.gruntwork.io/docs/features/inputs/))
- Bad
  - Secrets used in any action execution
  - Secrets are long-lived, and not versioned
  - Rotating them requires a specific automation invoked elsewhere

### SOPS with PGP key

[SOPS](https://github.com/mozilla/sops) is a Mozilla project that is able to encrypt and decrypt a YAML/JSON file only in the values part. This proposal encrypts values with a PGP key.

- Good
  - SOPS decryption is natively integrated with Terragrunt
  - Allows versioning and leaves key readable, diffs are easy to pick up
  - Storing the private key in a GitHub Secret enables for an easy decryption
- Bad
  - We expose the private key, not cool
  - A PGP key is usually long-lived, rotating it is a pain

### SOPS with KMS from a supported Cloud Provider

SOPS also support encryption/decryption using a Cloud Provider KMS. Given also the Identity Federation we can set up with GitHub, we can use our GH identity on a Cloud Provider (eg. Google Cloud) without storing credentials anywhere. Amazing! :D

- All "Good" of Option 2 plus
  - Best case: we don't require storing any credentials, Identity Federation is there to help (pending investigation on the cost-effectiveness). Worst case: we input one single set of credentials
  - Google Cloud is already used to store the state, so the credentials we set in the worst case will be reused for that as well
  - Key Rotation is managed in the Cloud Provider APIs
  - It supports "on-my-machine" decryption using the default [`GOOGLE_APPLICATION_CREDENTIALS`](https://cloud.google.com/docs/authentication/application-default-credentials)
  - We can leverage [a free-forever tier](https://cloud.google.com/free/docs/free-cloud-features#secret-manager)
- Bad
  - If we exceed Key Usage in the free tier this can become a serious blocker
  - It may requires some planning and Infrastructure to set up

## Links

- [Enabling keyless authentication from GitHub Actions](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions)
