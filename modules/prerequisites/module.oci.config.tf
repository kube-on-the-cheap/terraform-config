module "oci_config" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-config?ref=v1.0.0"

  config_oci_location = pathexpand("~/.oci/config")
}
