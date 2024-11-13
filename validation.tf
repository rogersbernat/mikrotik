# validation.tf

locals {
  ip_addresses = [for v in var.vlans : v.ip_address]
  subnets      = [for v in var.vlans : v.vlan_subnet]
  vlan_ids     = [for v in var.vlans : v.vlan_id]

  # Identify duplicates in VLAN IDs
  duplicate_vlan_ids = [
    for id in distinct(local.vlan_ids) : id
    if length([for v in local.vlan_ids : v if v == id]) > 1
  ]

  # Identify duplicates in subnets
  duplicate_subnets = [
    for subnet in distinct(local.subnets) : subnet
    if length([for s in local.subnets : s if s == subnet]) > 1
  ]

  # Unique checks
  vlan_id_unique = length(local.duplicate_vlan_ids) == 0
  subnet_unique  = length(local.duplicate_subnets) == 0

  # Naming conventions validation
  valid_vlan_names = alltrue([for v in var.vlans : can(regex("^[a-zA-Z0-9_-]+$", v.vlan_name))])

  # RFC 1918 IP range check for subnets
  rfc_1918_subnet_valid = alltrue([
    for subnet in local.subnets : can(regex("^(10\\.|172\\.(1[6-9]|2[0-9]|3[01])\\.|192\\.168\\.)", subnet))
  ])

  # Check for overlapping subnets (simplified)
  subnet_overlap = [
    for i in range(length(local.subnets)) : local.subnets[i] if length([
      for j in range(i + 1, length(local.subnets)) : local.subnets[j]
      if cidrhost(local.subnets[i], 0) == cidrhost(local.subnets[j], 0)
    ]) > 0
  ]
  subnet_overlap_unique = length(local.subnet_overlap) == 0

  # DHCP pool range validation (manual check for correct range format)
  valid_dhcp_pool_ranges = alltrue([
    for vlan_key, vlan in var.vlans : can(regex("^([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3})-([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3})$", vlan.dhcp_pool_range))
  ])

  # IP address format check
  valid_ip_addresses = alltrue([for ip in local.ip_addresses : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", ip))])
}

# Single null_resource for validation checks
resource "null_resource" "validation" {
  count = local.vlan_id_unique && local.subnet_unique && local.valid_vlan_names && local.rfc_1918_subnet_valid && local.subnet_overlap_unique && local.valid_dhcp_pool_ranges && local.valid_ip_addresses ? 0 : 1

  provisioner "local-exec" {
    command = <<EOT
      echo "Error: Validation checks failed."
      %{if length(local.duplicate_vlan_ids) > 0}
      echo "Duplicate VLAN IDs: ${join(", ", local.duplicate_vlan_ids)}"
      %{endif}
      %{if length(local.duplicate_subnets) > 0}
      echo "Duplicate Subnets: ${join(", ", local.duplicate_subnets)}"
      %{endif}
      %{if !local.valid_vlan_names}
      echo "Error: VLAN names must follow the naming convention (alphanumeric, dashes, and underscores only)."
      %{endif}
      %{if !local.rfc_1918_subnet_valid}
      echo "Error: One or more subnets do not fall within the private IP address ranges as defined by RFC 1918."
      %{endif}
      %{if !local.subnet_overlap_unique}
      echo "Error: Overlapping subnets detected."
      %{endif}
      %{if !local.valid_dhcp_pool_ranges}
      echo "Error: One or more DHCP pool ranges are invalid."
      %{endif}
      %{if !local.valid_ip_addresses}
      echo "Error: One or more IP addresses do not follow the correct IPv4 format."
      %{endif}
      exit 1
    EOT
    interpreter = ["bash", "-c"]
  }
}
