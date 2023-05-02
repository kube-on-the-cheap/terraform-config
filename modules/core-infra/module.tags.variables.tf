variable "k3s_oci_tags" {
  /*
  oci_tags = [
    {
      namespace = {
        name = "K3s-NodeInfo"
        description = "K3s node informations"
      }
      values = {
        "NodeRole" = {
          allowed_values = [ "master", "worker" ]
          description = "The K3s node role (master or worker)"
        }
      }
    }
  ]
  */

  type = list(object(
    {
      namespace : object({
        name : string
        description : string
      })
      tags : map(object({
        description : string,
        allowed_values : optional(list(string), [])
      }))
    }
  ))
  description = "A list of tags namespaces and their composition, including the compartment they live in"
  # TODO: name validation
}
