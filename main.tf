provider "azurerm" {
  version = "2.81.0"
  features {}
}

resource "azurerm_resource_group" "terraform_test" {
  name = "terraform-main-resource-group"
  location = "South Central US"
}

resource "azurerm_container_group" "terraform_container_group_test" {
  name = "weatherapi"
  location = azurerm_resource_group.terraform_test.location
  resource_group_name = azurerm_resource_group.terraform_test.name

  ip_address_type = "public"
  dns_name_label = "mikerhodenapi"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "mikerhoden/weatherapi"
    cpu = "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }

  }
}