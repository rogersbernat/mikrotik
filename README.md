# MikroTik Terraform Module

This repository contains a Terraform module for managing VLANs, DHCP, and bridge configurations on MikroTik devices using the `terraform-routeros/routeros` provider. The module is intended to simplify the setup and maintenance of network infrastructure by automating VLAN provisioning and DHCP server configuration for MikroTik routers and switches.

## Features
- Create and manage VLAN interfaces for MikroTik bridge ports.
- Configure DHCP pools and servers for each VLAN.
- Easily define network segmentation and access rules.
- Modular configuration to facilitate reuse and maintenance.

Terraform CLI version used: v1.9.8
- MikroTik provider version required: `terraform-routeros/routeros` ~> 1.66.0
- MikroTik RouterOS device with API enabled.
- Access to Terraform Cloud or an appropriate backend for remote state storage.

## Structure
- `main.tf`: Defines the primary provider and module configuration.
- `variables.tf`: Defines configurable parameters such as VLAN settings and bridge names.
- `bridge_ports.tf`: Configures bridge ports on the MikroTik device.
- `networking.tf`: Sets up VLAN interfaces and IP addressing.
- `dhcp.tf`: Configures DHCP pools, servers, and associated network settings.

## Usage
To use this module, you can include it in your Terraform configuration as follows:

```hcl
module "mikrotik_vlans" {
  source      = "./mikrotik_vlan"
  bridge_name = var.bridge_name
  vlans       = var.vlans
}
```

### Example Configuration
Define the VLAN configuration by passing in a map of VLANs:

```hcl
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
  }))
}
```

To apply the configuration:

1. Initialize the Terraform configuration:
   ```sh
   terraform init
   ```

2. Plan the configuration to see what changes will be made:
   ```sh
   terraform plan
   ```

3. Apply the configuration to your MikroTik device:
   ```sh
   terraform apply -var-file="bridge.tfvars"
   ```


## Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your proposed changes. Make sure to follow best practices and write tests where applicable.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Authors
- Roger Sánchez Bernat

## Acknowledgments
- Thanks to the Terraform and MikroTik communities for their valuable support and resources.