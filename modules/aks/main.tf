terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                                = var.cluster_name
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  dns_prefix                          = var.dns_prefix
  kubernetes_version                  = var.kubernetes_version
  sku_tier                            = var.sku_tier
  support_plan                        = var.support_plan
  local_account_disabled              = var.local_account_disabled
  role_based_access_control_enabled   = var.role_based_access_control_enabled
  run_command_enabled                 = var.run_command_enabled
  ai_toolchain_operator_enabled       = var.ai_toolchain_operator_enabled
  azure_policy_enabled                = var.azure_policy_enabled
  cost_analysis_enabled               = var.cost_analysis_enabled
  image_cleaner_enabled               = var.image_cleaner_enabled
  image_cleaner_interval_hours        = var.image_cleaner_interval_hours
  automatic_upgrade_channel           = var.automatic_upgrade_channel
  node_os_upgrade_channel             = var.node_os_upgrade_channel
  oidc_issuer_enabled                 = var.oidc_issuer_enabled
  open_service_mesh_enabled           = var.open_service_mesh_enabled
  private_cluster_enabled             = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  workload_identity_enabled           = var.workload_identity_enabled
  node_resource_group                 = var.node_resource_group
  tags                                = var.tags

  identity {
    type = var.identity_type
  }

  default_node_pool {
    name                          = var.default_node_pool_name
    vm_size                       = var.vm_size
    node_count                    = var.node_count
    auto_scaling_enabled          = var.auto_scaling_enabled
    min_count                     = var.auto_scaling_enabled ? var.min_count : null
    max_count                     = var.auto_scaling_enabled ? var.max_count : null
    max_pods                      = var.max_pods
    os_disk_size_gb               = var.os_disk_size_gb
    os_disk_type                  = var.os_disk_type
    os_sku                        = var.os_sku
    type                          = var.node_pool_type
    zones                         = var.zones
    fips_enabled                  = false
    host_encryption_enabled       = false
    node_public_ip_enabled        = false
    only_critical_addons_enabled  = false
    orchestrator_version          = var.kubernetes_version
    scale_down_mode               = "Delete"
    tags                          = var.tags

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  network_profile {
    network_plugin      = var.network_plugin
    network_plugin_mode = var.network_plugin_mode
    network_data_plane  = "azure"
    outbound_type       = var.outbound_type
    load_balancer_sku   = var.load_balancer_sku
    pod_cidr            = var.pod_cidr
    pod_cidrs           = [var.pod_cidr]
    service_cidr        = var.service_cidr
    service_cidrs       = [var.service_cidr]
    dns_service_ip      = var.dns_service_ip

    load_balancer_profile {
      managed_outbound_ip_count = var.managed_outbound_ip_count
    }
  }

  node_provisioning_profile {
    mode = "Manual"
  }

  dynamic "auto_scaler_profile" {
    for_each = var.auto_scaling_enabled ? [1] : []
    content {
      balance_similar_node_groups                   = false
      daemonset_eviction_for_empty_nodes_enabled    = false
      daemonset_eviction_for_occupied_nodes_enabled = true
      empty_bulk_delete_max                         = "10"
      expander                                      = "random"
      ignore_daemonsets_utilization_enabled         = false
      max_graceful_termination_sec                  = "600"
      max_node_provisioning_time                    = "15m"
      max_unready_nodes                             = 3
      max_unready_percentage                        = 45
      new_pod_scale_up_delay                        = "0s"
      scale_down_delay_after_add                    = "10m"
      scale_down_delay_after_delete                 = "10s"
      scale_down_delay_after_failure                = "3m"
      scale_down_unneeded                           = "10m"
      scale_down_unready                            = "20m"
      scale_down_utilization_threshold              = "0.5"
      scan_interval                                 = "10s"
      skip_nodes_with_local_storage                 = false
      skip_nodes_with_system_pods                   = true
    }
  }

  lifecycle {
    ignore_changes = [
      network_profile[0].load_balancer_profile[0].idle_timeout_in_minutes,
      node_provisioning_profile[0].default_node_pools,
    ]
  }
}

