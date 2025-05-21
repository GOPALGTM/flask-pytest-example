# Create Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks_rg.location   
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.aks_cluster_version

  default_node_pool {
    name            = "default"
    vm_size         = var.nodes_instance_types
    node_count      = var.nodes_desired_count
    max_pods        = 110
    os_disk_size_gb = var.node_disk_size

    vnet_subnet_id = azurerm_subnet.aks_public_subnet.id   
    tags = merge(var.common_tags, {
      Name     = var.aks_nodegroup_name
      Resource = "node-group"
    })
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"
    dns_service_ip     = "10.0.3.4"
    service_cidr       = "10.0.3.0/24"
  }

  tags = var.common_tags
}