variable "bridge_name" {
  description = "The name of the existing main bridge to manage"
  type        = string
  default     = "main_bridge" # Use the name of the default existing bridge
}

variable "default_lease_time" {
  description = "Default lease time for DHCP leases"
  type        = string
  default     = "24h"
}

variable "vlans" {
  description = "Map of VLANs to configure"
  type = map(object({
    vlan_id             = number
    vlan_name           = string
    vlan_subnet         = string # CIDR format for subnet address
    untagged_interfaces = list(string)
    tagged_interfaces   = list(string)
    ip_address          = string # IP address for the VLAN interface
    dhcp_enabled        = bool
    dhcp_pool_range     = string
    dhcp_dns_servers    = list(string)
    routing_table       = optional(string) # Add this line if routing tables are required
  }))
}