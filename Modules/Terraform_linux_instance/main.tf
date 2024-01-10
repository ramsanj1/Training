# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  for_each = var.vm_map
  name                = "my-nic-{each.key}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = module.Terraform_linux_network.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.my_terraform_public_ip[each.key].id
  }
}
# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip" {
  for_each = var.vm_map
  name                = "myPublicIP-${each.key}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Dynamic"
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  for_each = var.vm_map
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic[each.key].id]
  size                  = each.value.size
  admin_username = each.value.admin_username
  disable_password_authentication = false 


  os_disk {
    name                 = "${each.value.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }
}



