resource "azurerm_network_security_group" "mynsg" {
  name                = "networksecuritygroup1"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "mynic_association" {
  network_interface_id      = azurerm_network_interface.mynic.id
  network_security_group_id = azurerm_network_security_group.mynsg.id
}

resource "azurerm_subnet_network_security_group_association" "mysubnsg_association" {
  subnet_id                 = azurerm_subnet.mysub.id
  network_security_group_id = azurerm_network_security_group.mynsg.id
}

resource "azurerm_virtual_network" "myvnet"{
    name = "tervnet"
    resource_group_name = azurerm_resource_group.myrg.name
    location = azurerm_resource_group.myrg.location
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "mysub"{
    name = "mysubnet"
    virtual_network_name = azurerm_virtual_network.myvnet.name
    resource_group_name = azurerm_resource_group.myrg.name
    address_prefixes = ["10.0.0.0/24"]

}

resource "azurerm_network_interface" "mynic" {
  name                = "ter-nic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name



  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysub.id
    private_ip_address_allocation = "Dynamic"
  }
}