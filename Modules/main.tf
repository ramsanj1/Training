module "Terraform_linux_network" {
  source = "C:/Users/devop/Desktop/Terraform_linux_network"
  resource_group_name     = "terraformrg"
  resource_group_location = "west us"
  vnet_name               = "terraform_vnet"
  subnet_name             = "terraform_subnet"
}

module "Terraform_linux_instance" {
  source                  = "C:/Users/devop/Desktop/Terraform_linux_instance"
  resource_group_location = "west us"
  resource_group_name     = "terraformrg"
  subnet_id               = module.Terraform_linux_network.subnet_id
  vm_map = {
    tvm1 = {
      name = "tvm1"
      size           = "Standard_DS1_v2"
      os             = "UbuntuServer"
      admin_username = "azureuser1"
      admin_password = "Password!@#$"
    },
    tvm2 = {
      name = "tvm2"
      size           = "Standard_DS1_v2"
      os             = "UbuntuServer"
      admin_username = "azureuser2"
      admin_password = "Password!@#$"
    },
    tvm3 = {
      name = "tvm2"
      size           = "Standard_DS1_v2"
      os             = "UbuntuServer"
      admin_username = "azureuser3"
      admin_password = "Password!@#$"
    },
  }
}

