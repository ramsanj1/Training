variable "vm_map"{
  type = map(object({
    name = string
    location = string
    resource_group_name = string
    admin_password = string
    size = string
    admin_username = string
  }))
}
