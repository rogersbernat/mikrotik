# # validation.tf

# locals {
#   ip_addresses = [for v in var.vlans : v.ip_address]
#   subnets      = [for ip in local.ip_addresses : cidrsubnet(ip, 0, 0)]

#   # Identify duplicates in VLAN IDs
#   duplicate_vlan_ids = [
#     for id in distinct(local.vlan_ids) : id
#     if length([for v in local.vlan_ids : v if v == id]) > 1
#   ]

#   # Identify duplicates in subnets
#   duplicate_subnets = [
#     for subnet in distinct(local.subnets) : subnet
#     if length([for s in local.subnets : s if s == subnet]) > 1
#   ]

#   # Unique checks
#   vlan_id_unique = length(local.duplicate_vlan_ids) == 0
#   subnet_unique  = length(local.duplicate_subnets) == 0
# }

# # Single null_resource for validation checks
# resource "null_resource" "validation" {
#   count = local.vlan_id_unique && local.subnet_unique ? 0 : 1

#   provisioner "local-exec" {
#     command     = <<EOT
# echo "Error: Duplicate VLAN IDs or subnets detected."
# %{if length(local.duplicate_vlan_ids) > 0}
# Duplicate VLAN IDs: ${join(", ", local.duplicate_vlan_ids)}
# %{endif}
# %{if length(local.duplicate_subnets) > 0}
# Duplicate Subnets: ${join(", ", local.duplicate_subnets)}
# %{endif}
# exit 1
# EOT
#     interpreter = ["bash", "-c"]
#   }
# }