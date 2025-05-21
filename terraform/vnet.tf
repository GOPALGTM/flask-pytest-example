# Create Virtual Network
resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  tags                = var.common_tags
}

# Create public subnet
resource "azurerm_subnet" "aks_public_subnet" {
  name                 = var.public_subnet_name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = var.public_subnet_address_prefix

  depends_on = [azurerm_virtual_network.aks_vnet]
}

# Create private subnet for AKS
resource "azurerm_subnet" "aks_private_subnet" {
  name                 = var.private_subnet_name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = var.private_subnet_address_prefix
}

# Create a dedicated subnet for Azure Bastion
resource "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = var.bastion_subnet_address_prefix
}

# Create a Public IP for Azure Bastion
resource "azurerm_public_ip" "bastion_public_ip" {
  name                = var.bastion_public_ip_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  allocation_method   = var.bastion_public_ip_allocation_method
  sku                 = "Standard"
  tags                = var.common_tags
}

# Create Azure Bastion Host
resource "azurerm_bastion_host" "aks_bastion" {
  name                = var.bastion_host_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  ip_configuration {
    name                 = var.bastion_ip_configuration_name
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }

  tags = var.common_tags
}

# Create Private Route Table
resource "azurerm_route_table" "private_route_table" {
  name                = "private-route-table"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  route {
    name                   = "private-route"
    address_prefix         = "10.100.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.private_route_next_hop_ip
  }

  tags = var.common_tags
}

resource "azurerm_subnet_route_table_association" "private_association" {
  subnet_id      = azurerm_subnet.aks_private_subnet.id
  route_table_id = azurerm_route_table.private_route_table.id
}

# Network Security Group for private subnet
resource "azurerm_network_security_group" "private_subnet_nsg" {
  name                = "${var.private_subnet_name}-nsg"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  security_rule {
    name                       = "AllowRequiredAKSPorts"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "9000", "22"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.common_tags
}

resource "azurerm_subnet_network_security_group_association" "private_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.aks_private_subnet.id
  network_security_group_id = azurerm_network_security_group.private_subnet_nsg.id
}

# Create Private DNS Zone for AKS
resource "azurerm_private_dns_zone" "aks_private_dns" {
  name                = "privatelink.${var.location}.azmk8s.io"
  resource_group_name = azurerm_resource_group.aks_rg.name
  tags                = var.common_tags
}

# Link the Private DNS Zone to the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "aks_dns_vnet_link" {
  name                  = "aks-dns-vnet-link"
  resource_group_name   = azurerm_resource_group.aks_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.aks_private_dns.name
  virtual_network_id    = azurerm_virtual_network.aks_vnet.id
  registration_enabled  = false
  tags                  = var.common_tags
}
