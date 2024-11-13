resource "routeros_bridge_port" "ports" {
  for_each = var.vlans

  bridge    = var.bridge_name # Use the existing bridge name
  interface = each.value.vlan_name
  pvid      = each.value.vlan_id
  hw        = true
}

