# resource "oci_vault_secret" "s3_secret_key" {
#   compartment_id = module.oci_compartments[local.k3s_compartment_name].id
#   vault_id       = module.k3s_oci_kms.vault_id
#   secret_name    = "etcd-s3-secret-key"
#   description    = "Secret Key to access the k3s_etcd_backup bucket"
#   key_id         = module.k3s_oci_kms.master_encryption_keys_ids["token"]
#   secret_content {
#     # We don't really have a choice, do we?
#     content_type = "BASE64"
#     content      = base64encode(module.k3s_object_storage.s3_credentials["k3s_etcd_backup"]["SECRET_KEY"])
#   }
# }
