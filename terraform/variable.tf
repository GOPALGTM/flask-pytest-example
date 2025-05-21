variable "client_id" {
  description = "Azure Service Principal Client ID"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "aks-private-cluster-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
}

variable "public_subnet_address_prefix" {
  description = "Address prefix for the public subnet"
  type        = list(string)
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
}

variable "private_subnet_address_prefix" {
  description = "Address prefix for the private subnet"
  type        = list(string)
}

variable "bastion_subnet_name" {
  description = "Name of the bastion subnet"
  type        = string
}

variable "bastion_subnet_address_prefix" {
  description = "Address prefix for the bastion subnet"
  type        = list(string)
}

variable "bastion_public_ip_name" {
  description = "Name of the bastion public IP"
  type        = string
}

variable "bastion_public_ip_allocation_method" {
  description = "Allocation method for the bastion public IP"
  type        = string
  default     = "Static"
}

variable "bastion_host_name" {
  description = "Name of the bastion host"
  type        = string
}

variable "bastion_ip_configuration_name" {
  description = "Name of the bastion IP configuration"
  type        = string
}

variable "private_route_next_hop_ip" {
  description = "Next hop IP for the private route"
  type        = string
}

# Note: Jumpbox VM variables removed as requested

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "aks_cluster_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
}

variable "nodes_instance_types" {
  description = "VM size for AKS nodes"
  type        = string
}

variable "nodes_desired_count" {
  description = "Desired number of nodes in the AKS cluster"
  type        = number
}

variable "node_disk_size" {
  description = "OS disk size for AKS nodes in GB"
  type        = number
}

variable "aks_nodegroup_name" {
  description = "Name for the AKS node group"
  type        = string
}

variable "dns_service_ip" {
  description = "IP address for Kubernetes DNS service"
  type        = string
}

variable "service_cidr" {
  description = "CIDR for Kubernetes services"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}