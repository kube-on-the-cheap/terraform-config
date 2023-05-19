terraform {
  source = "../../../../..//modules/region-setup/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

include "tenancy" {
  path = find_in_parent_folders("tenancy.include.hcl")
}

inputs = {
  ad_count = 3
}
