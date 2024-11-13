terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "~> 1.66.0"
    }
  }

  backend "remote" {
    organization = "rogersbernat"
    workspaces {
      name = "mikrotik"
    }
  }
}

provider "routeros" {
  hosturl  = "http://10.0.2.111"
  username = var.username
  password = var.password
  insecure = true
}

# VLAN Interface module instance
module "vlans" {
  source      = "./mikrotik_vlan"
  bridge_name = var.bridge_name # Use existing bridge name
  vlans       = var.vlans
}