terraform {
  required_version = ">= 1.9.8"
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "~> 1.66.0"
    }
  }
}
