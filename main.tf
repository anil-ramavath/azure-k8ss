terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# ---------------------------------------------------------------------------
# Auto-discover the sandbox resource group
# ---------------------------------------------------------------------------
# In Azure sandbox environments a resource group is pre-provisioned.
# If var.resource_group_name is not provided, this external data source automatically
# queries the sandbox resource group via Azure CLI powershell script.
# ---------------------------------------------------------------------------
data "external" "sandbox_rg" {
  count   = var.resource_group_name == null || var.resource_group_name == "" ? 1 : 0
  program = ["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "${path.module}/get_sandbox_rg.ps1"]
}

locals {
  resource_group_name = var.resource_group_name != null && var.resource_group_name != "" ? var.resource_group_name : data.external.sandbox_rg[0].result.name
}

data "azurerm_resource_group" "target" {
  name = local.resource_group_name
}

# ---------------------------------------------------------------------------
# AKS Reusable Module Call
# ---------------------------------------------------------------------------
module "aks" {
  source = "./modules/aks"

  cluster_name        = var.cluster_name
  resource_group_name = data.azurerm_resource_group.target.name
  location            = var.location
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  # Node pool
  vm_size              = var.vm_size
  node_count           = var.node_count
  auto_scaling_enabled = var.auto_scaling_enabled
  min_count            = var.min_count
  max_count            = var.max_count
  os_disk_size_gb      = var.os_disk_size_gb
  os_sku               = var.os_sku
  zones                = var.zones

  # Features
  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled
  image_cleaner_enabled     = var.image_cleaner_enabled
  automatic_upgrade_channel = var.automatic_upgrade_channel

  tags = var.tags
}
