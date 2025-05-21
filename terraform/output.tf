output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.aks_rg.name
}

output "kubernetes_cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "private_aks_cluster_fqdn" {
  description = "FQDN of the private AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.private_fqdn
}

output "private_aks_cluster_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}

# Note: Jumpbox VM output removed

output "aks_vnet_id" {
  description = "ID of the AKS virtual network"
  value       = azurerm_virtual_network.aks_vnet.id
}

output "aks_private_subnet_id" {
  description = "ID of the AKS private subnet"
  value       = azurerm_subnet.aks_private_subnet.id
}

output "bastion_host_id" {
  description = "ID of the Azure Bastion host"
  value       = azurerm_bastion_host.aks_bastion.id
}

output "bastion_public_ip" {
  description = "Public IP address of the Azure Bastion host"
  value       = azurerm_public_ip.bastion_public_ip.ip_address
}

output "private_dns_zone_id" {
  description = "ID of the private DNS zone"
  value       = azurerm_private_dns_zone.aks_private_dns.id
}

output "kubeconfig" {
  description = "kubeconfig for connecting to the cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive   = true
}