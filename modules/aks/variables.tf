variable "cluster_name" {
  description = "The name of the Managed Kubernetes Cluster."
  type        = string
  default     = "k8ss"
}

variable "location" {
  description = "The Azure Region in which all resources should be provisioned."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which the AKS cluster is provisioned."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster."
  type        = string
  default     = "k8ss-dns"
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS facility."
  type        = string
  default     = "1.36.5"
}

variable "sku_tier" {
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free, Standard (which includes the Uptime SLA) and Premium."
  type        = string
  default     = "Free"
}

variable "support_plan" {
  description = "Specifies the support plan which should be used for this Kubernetes Cluster."
  type        = string
  default     = "KubernetesOfficial"
}

variable "identity_type" {
  description = "The type of identity used for the managed cluster."
  type        = string
  default     = "SystemAssigned"
}

variable "node_resource_group" {
  description = "The name of the Resource Group where the Kubernetes Nodes should exist."
  type        = string
  default     = null
}

variable "local_account_disabled" {
  description = "If true, local accounts will be disabled for the cluster."
  type        = bool
  default     = false
}

variable "role_based_access_control_enabled" {
  description = "Whether Role Based Access Control for the Kubernetes Cluster should be enabled."
  type        = bool
  default     = true
}

variable "run_command_enabled" {
  description = "Whether to expose run command API in AKS."
  type        = bool
  default     = true
}

variable "ai_toolchain_operator_enabled" {
  description = "Whether the AI toolchain operator should be enabled."
  type        = bool
  default     = false
}

variable "azure_policy_enabled" {
  description = "Should the Azure Policy Add-On be enabled?"
  type        = bool
  default     = false
}

variable "cost_analysis_enabled" {
  description = "Should Cost Analysis be enabled for this AKS Cluster?"
  type        = bool
  default     = false
}

variable "image_cleaner_enabled" {
  description = "Specifies whether Image Cleaner is enabled."
  type        = bool
  default     = true
}

variable "image_cleaner_interval_hours" {
  description = "Specifies the interval in hours when Image Cleaner should scan and clean images."
  type        = number
  default     = 168
}

variable "automatic_upgrade_channel" {
  description = "The upgrade channel for this Kubernetes Cluster."
  type        = string
  default     = "patch"
}

variable "node_os_upgrade_channel" {
  description = "The upgrade channel for this Kubernetes Cluster Nodes' OS Image."
  type        = string
  default     = "NodeImage"
}

variable "oidc_issuer_enabled" {
  description = "Enable or Disable the OIDC issuer URL."
  type        = bool
  default     = true
}

variable "open_service_mesh_enabled" {
  description = "Is Open Service Mesh enabled?"
  type        = bool
  default     = false
}

variable "private_cluster_enabled" {
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?"
  type        = bool
  default     = false
}

variable "private_cluster_public_fqdn_enabled" {
  description = "Specifies whether a Public FQDN for this Private Cluster should be added."
  type        = bool
  default     = false
}

variable "workload_identity_enabled" {
  description = "Specifies whether Azure AD Workload Identity should be enabled for the Cluster."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# Node pool variables
variable "default_node_pool_name" {
  description = "The name which should be used for the default Kubernetes Node Pool."
  type        = string
  default     = "agentpool"
}

variable "vm_size" {
  description = "The size of the Virtual Machine."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "node_count" {
  description = "The initial number of nodes which should exist in this Node Pool."
  type        = number
  default     = 2
}

variable "auto_scaling_enabled" {
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool?"
  type        = bool
  default     = true
}

variable "min_count" {
  description = "The minimum number of nodes which should exist in this Node Pool."
  type        = number
  default     = 2
}

variable "max_count" {
  description = "The maximum number of nodes which should exist in this Node Pool."
  type        = number
  default     = 5
}

variable "max_pods" {
  description = "The maximum number of pods that can run on each agent."
  type        = number
  default     = 110
}

variable "os_disk_size_gb" {
  description = "The size of the OS Disk which should be used for each agent in the Node Pool."
  type        = number
  default     = 128
}

variable "os_disk_type" {
  description = "The type of disk which should be used for the Operating System."
  type        = string
  default     = "Managed"
}

variable "os_sku" {
  description = "Specifies the OS SKU used by the agent pool."
  type        = string
  default     = "Ubuntu"
}

variable "node_pool_type" {
  description = "The type of Node Pool which should be created."
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "zones" {
  description = "Specifies a list of Availability Zones in which this Kubernetes Cluster should be located."
  type        = list(string)
  default     = ["1", "2", "3"]
}

# Network Profile
variable "network_plugin" {
  description = "Network plugin to use for networking."
  type        = string
  default     = "azure"
}

variable "network_plugin_mode" {
  description = "Network plugin mode to use for networking."
  type        = string
  default     = "overlay"
}

variable "outbound_type" {
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster."
  type        = string
  default     = "loadBalancer"
}

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster."
  type        = string
  default     = "standard"
}

variable "pod_cidr" {
  description = "The CIDR to use for pod IP addresses. Required when network_plugin_mode is set to overlay."
  type        = string
  default     = "10.244.0.0/16"
}

variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service."
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)."
  type        = string
  default     = "10.0.0.10"
}

variable "managed_outbound_ip_count" {
  description = "Count of desired managed outbound IPs for the cluster load balancer."
  type        = number
  default     = 1
}

