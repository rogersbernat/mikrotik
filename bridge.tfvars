bridge_name = "main_bridge"

vlans = {
  vlan_office = {
    vlan_id             = 100
    vlan_name           = "vlan_office"
    vlan_subnet         = "192.168.1.0/24"
    untagged_interfaces = ["ether7"]
    tagged_interfaces   = []
    ip_address          = "192.168.1.1"
    dhcp_enabled        = true
    dhcp_pool_range     = "192.168.1.10-192.168.1.254"
    dhcp_dns_servers    = ["10.0.2.106, 1.1.1.1"]
  },
  vlan_ether2 = {
    vlan_id             = 102
    vlan_name           = "vlan_ether2"
    vlan_subnet         = "192.168.3.0/24"
    untagged_interfaces = ["ether2"]
    tagged_interfaces   = []
    ip_address          = "192.168.3.1"
    dhcp_enabled        = true
    dhcp_pool_range     = "192.168.3.10-192.168.3.254"
    dhcp_dns_servers    = ["10.0.2.106, 1.1.1.1"]
  },
  vlan_ether3 = {
    vlan_id             = 103
    vlan_name           = "vlan_ether3"
    vlan_subnet         = "192.168.4.0/24"
    untagged_interfaces = ["ether3"]
    tagged_interfaces   = []
    ip_address          = "192.168.4.1"
    dhcp_enabled        = true
    dhcp_pool_range     = "192.168.4.10-192.168.4.254"
    dhcp_dns_servers    = ["10.0.2.106, 1.1.1.1"]
  },
  vlan_ether4 = {
    vlan_id             = 104
    vlan_name           = "vlan_ether4"
    vlan_subnet         = "192.168.5.0/24"
    untagged_interfaces = ["ether4"]
    tagged_interfaces   = []
    ip_address          = "192.168.5.1"
    dhcp_enabled        = true
    dhcp_pool_range     = "192.168.5.10-192.168.5.254"
    dhcp_dns_servers    = ["10.0.2.106, 1.1.1.1"]
  },
  vlan_ether5 = {
    vlan_id             = 105
    vlan_name           = "vlan_ether5"
    vlan_subnet         = "192.168.6.0/24"
    untagged_interfaces = ["ether5"]
    tagged_interfaces   = []
    ip_address          = "192.168.6.1"
    dhcp_enabled        = true
    dhcp_pool_range     = "192.168.6.10-192.168.6.254"
    dhcp_dns_servers    = ["10.0.2.106, 1.1.1.1"]
  },
  vlan_ether6 = {
    vlan_id             = 106
    vlan_name           = "vlan_ether6"
    vlan_subnet         = "192.168.7.0/24"
    untagged_interfaces = ["ether6"]
    tagged_interfaces   = []
    ip_address          = "192.168.7.1"
    dhcp_enabled        = true
    dhcp_pool_range     = "192.168.7.10-192.168.7.254"
    dhcp_dns_servers    = ["10.0.2.106, 1.1.1.1"]
  },
  vlan_ether8 = {
    vlan_id             = 108
    vlan_name           = "vlan_ether8"
    vlan_subnet         = "192.168.8.0/24"
    untagged_interfaces = ["ether8"]
    tagged_interfaces   = []
    ip_address          = "192.168.8.1"
    dhcp_enabled        = true
    dhcp_pool_range     = "192.168.8.10-192.168.8.254"
    dhcp_dns_servers    = ["10.0.2.106, 1.1.1.1"]
  },
  vlan_ether9 = {
    vlan_id             = 109
    vlan_name           = "vlan_ether9"
    vlan_subnet         = "192.168.9.0/24"
    untagged_interfaces = ["ether9"]
    tagged_interfaces   = []
    ip_address          = "192.168.9.1"
    dhcp_enabled        = true
    dhcp_pool_range     = "192.168.9.10-192.168.9.254"
    dhcp_dns_servers    = ["10.0.2.106, 1.1.1.1"]
  }
}