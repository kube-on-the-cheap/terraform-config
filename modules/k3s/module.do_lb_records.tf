module "do_lb_records" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/do-domain?ref=v1.0.0"

  do_domain     = var.do_oci_domain
  create_domain = false
  a_record_list = [
    {
      name  = "kube"
      value = module.k3s_masters.oci_lb_ip
    }
  ]
}
