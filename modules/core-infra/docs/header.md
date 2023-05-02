## Intro


### IAM

Lots and lots to unpack, here. Some references:

* https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/corepolicyreference.htm

* [Policy syntax](https://docs.oracle.com/en-us/iaas/Content/Identity/policysyntax/policy-syntax.htm) is where to start at.

  ```txt
  Allow <identity_domain_name>/<subject> to <verb> <resource-type> in <location> where <conditions>
  ```

* [General variables](https://docs.oracle.com/en-us/iaas/Content/Identity/policyreference/policyreference_topic-General_Variables_for_All_Requests.htm) that work for every call:

* [Common policies](https://docs.oracle.com/en-us/iaas/Content/Identity/policiescommon/commonpolicies.htm) for a good starting point. Especially the "Let Block Volume, Object Storage, File Storage, Container Engine for Kubernetes, and Streaming services encrypt and decrypt volumes, volume backups, buckets, file systems, Kubernetes secrets, and stream pools" one contains a few interesting data about the composition of non-standard syntaxes using services:

  ```txt
  Allow service blockstorage, objectstorage-<region_name>, Fss<realm_key>Prod, oke, streaming to use keys in compartment ABC where target.key.id = '<key_OCID>'
  ```

* A [working example](https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/runningcommands.htm) for setting dynamic groups with tags
