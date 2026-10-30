# ---------------------------------------------------------------------------
# Root Variables — override via terraform.tfvars or -var flags
# ---------------------------------------------------------------------------

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
  default     = "80ea84e8-afce-4851-928a-9e2219724c69"
}

variable "resource_group_name" {
  description = "Optional: Specify target Resource Group name. If null or empty, it will be automatically fetched from the sandbox environment."
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "Name of the AKS cluster."
  type        = string
  default     = "k8ss"
}

variable "location" {
  description = "Azure region to deploy into (Central India by default)."
  type        = string
  default     = "centralindia"
}

variable "dns_prefix" {
  description = "DNS prefix for the cluster FQDN."
  type        = string
  default     = "k8ss-dns"
}

variable "kubernetes_version" {
  description = "Kubernetes version."
  type        = string
  default     = "1.36.5"
}

# ---- Node Pool ----

variable "vm_size" {
  description = "VM size for the default node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "node_count" {
  description = "Initial node count (Sandbox max: 3)."
  type        = number
  default     = 2

  validation {
    condition     = var.node_count >= 1 && var.node_count <= 3
    error_message = "Sandbox limitation: node_count must be between 1 and 3."
  }
}

variable "auto_scaling_enabled" {
  description = "Enable auto-scaling for default node pool."
  type        = bool
  default     = true
}

variable "min_count" {
  description = "Minimum node count (autoscaler, Sandbox max: 3)."
  type        = number
  default     = 1

  validation {
    condition     = var.min_count >= 1 && var.min_count <= 3
    error_message = "Sandbox limitation: min_count must be between 1 and 3."
  }
}

variable "max_count" {
  description = "Maximum node count (autoscaler, Sandbox max: 3)."
  type        = number
  default     = 3

  validation {
    condition     = var.max_count >= 1 && var.max_count <= 3
    error_message = "Sandbox limitation: max_count cannot exceed 3 nodes per cluster."
  }
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB."
  type        = number
  default     = 128
}

variable "os_sku" {
  description = "OS SKU for the node pool (Ubuntu, AzureLinux, etc.)."
  type        = string
  default     = "Ubuntu"
}

variable "zones" {
  description = "Availability zones for the node pool."
  type        = list(string)
  default     = ["1", "2", "3"]
}

# ---- Features ----

variable "oidc_issuer_enabled" {
  description = "Enable OIDC issuer for workload identity."
  type        = bool
  default     = true
}

variable "workload_identity_enabled" {
  description = "Enable workload identity."
  type        = bool
  default     = true
}

variable "image_cleaner_enabled" {
  description = "Enable image cleaner."
  type        = bool
  default     = true
}

variable "automatic_upgrade_channel" {
  description = "Auto-upgrade channel (none, patch, rapid, stable, node-image)."
  type        = string
  default     = "patch"
}

variable "tags" {
  description = "Tags to apply to the cluster."
  type        = map(string)
  default     = {}
}
