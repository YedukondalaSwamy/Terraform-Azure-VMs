resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_static_web_app" "webapp" {
  name                = "example1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}