# ---------------------------------------------------------------------------
# Root Outputs
# ---------------------------------------------------------------------------

output "resource_group_name" {
  description = "Resolved/auto-discovered sandbox resource group name."
  value       = data.azurerm_resource_group.target.name
}

output "cluster_name" {
  description = "AKS cluster name."
  value       = module.aks.cluster_name
}

output "cluster_id" {
  description = "AKS cluster resource ID."
  value       = module.aks.cluster_id
}

output "cluster_fqdn" {
  description = "AKS cluster FQDN."
  value       = module.aks.cluster_fqdn
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for workload identity."
  value       = module.aks.oidc_issuer_url
}

output "kube_config_command" {
  description = "Command to fetch kubeconfig."
  value       = "az aks get-credentials --resource-group ${data.azurerm_resource_group.target.name} --name ${module.aks.cluster_name} --overwrite-existing"
}

output "kube_config_raw" {
  description = "Raw kubeconfig (sensitive)."
  value       = module.aks.kube_config_raw
  sensitive   = true
}
