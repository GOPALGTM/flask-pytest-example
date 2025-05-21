# General Configuration
resource_group_name       = "nonprod-rg"
dns_prefix                = "nonprod"
client_id                 = ""
client_secret             = ""
tenant_id                 = ""
subscription_id           = ""
location                  = "centralus"

# AKS Configuration
cluster_name              = "nonprod-aks"
aks_nodegroup_name        = "nonprod-aks-node-group"
nodes_desired_count       = 2
nodes_instance_types      = "Standard_A2_v2"
node_disk_size            = 100
aks_cluster_version       = "1.30"

# Network Configuration
vnet_name                 = "nonprod-aks-vnet"
vnet_address_space        = ["10.0.0.0/16"]
public_subnet_name        = "aks-public-subnet"    
public_subnet_address_prefix  = ["10.0.1.0/24"]   
private_subnet_name       = "nonprod-aks-private-subnet"
private_subnet_address_prefix = ["10.0.2.0/24"]
private_route_next_hop_ip = "10.10.1.1"

# Network Service Configuration
dns_service_ip            = "10.0.3.10"
service_cidr              = "10.0.3.0/24"

# Bastion Host Configuration
bastion_subnet_name       = "AzureBastionSubnet"
bastion_subnet_address_prefix = ["10.0.4.0/24"]
bastion_public_ip_name    = "bastion-public-ip"
bastion_public_ip_allocation_method = "Static"
bastion_host_name         = "devapp-bastion"
bastion_ip_configuration_name = "bastionIpConfiguration"

# Tags and Environment Configuration
common_tags = {
  Project       = "flask-app"
  Environment   = "nonprod"
  ManagedBy     = "terraform"
  Component     = "k8s"
  SubComponent  = "shared"
  Vertical      = "operations"
  Resource      = "node-group"
}

environment = "nonprod"