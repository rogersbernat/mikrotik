locals {
  # Aggregation of untagged interfaces for bridge ports
  untagged_interfaces = flatten([
    for vlan_key, vlan in var.vlans : [
      for iface in vlan.untagged_interfaces : {
        interface = iface
        vlan_id   = vlan.vlan_id
        pvid      = vlan.vlan_id
        bridge    = var.bridge_name
      }
    ]
  ])

  # Aggregation of tagged interfaces for bridge ports
  tagged_interfaces = flatten([
    for vlan_key, vlan in var.vlans : [
      for iface in vlan.tagged_interfaces : {
        interface = iface
        vlan_id   = vlan.vlan_id
        pvid      = null
        bridge    = var.bridge_name
      }
    ]
  ])

  # Use vlan_subnet directly without cidrsubnet manipulation
  vlan_subnets  = { for vlan_key, vlan in var.vlans : vlan_key => vlan.vlan_subnet }
  vlan_gateways = { for vlan_key, subnet in local.vlan_subnets : vlan_key => cidrhost(subnet, 1) }
  vlan_cidr_map = local.vlan_subnets
}