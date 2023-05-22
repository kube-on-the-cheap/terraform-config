module "do_domain_acme" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/do-domain?ref=v1.0.0"

  do_domain     = local.do_domains.acme
  create_domain = var.do_create_acme_domain
}

module "do_domain_oci" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/do-domain?ref=v1.0.0"

  do_domain     = local.do_domains.oci
  create_domain = true
  cname_record_list = [
    {
      name  = "_acme-challenge"
      value = local.do_domains.acme
    }
  ]
}
