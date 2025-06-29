module "rg" {
  source ="../Child_Modules/resource_group"
  resource_group_name = "rg-beni"
  resource_group_location = "West Europe"
}

module "rg2" {
  source ="../Child_Modules/resource_group"
  resource_group_name = "rg-love"
  resource_group_location = "West Europe"
}
module "vnet" {
  depends_on = [module.rg]
  source ="../Child_Modules/vnet"
  name = "vnet-nt1"
  location = "West Europe"
  resource_group_name = "rg-beni" 
  address_space = ["10.0.0.0/16"]
}
module "subnet_frontend" {
  depends_on = [module.vnet]
  source ="../Child_Modules/subnet"
  subnet_name = "frontend-subnet"
  vnet_name="vnet-nt1"
  address_prefixes =["10.0.1.0/24"]
  rg_name = "rg-beni"

}

module "subnet_backend" {
  depends_on = [ module.vnet] 
  source = "../Child_Modules/subnet"
  subnet_name = "backend-subnet"
  vnet_name = "vnet-nt1"
  address_prefixes =["10.0.2.0/24"]
  rg_name = "rg-beni"

}

module "pip_frontend" {
  depends_on = [ module.rg ]
  source = "../Child_Modules/public_ip"
  pip_name = "pip-frontend"
  pip_rg_name = "rg-beni"
  pip_location = "West Europe"
  
}
module "frontend_vm"{
  depends_on = [ module.subnet_frontend]
  source = "../Child_Modules/virtual_machine"
  vm_name= "frontend-vm"
  rg_name_vm = "rg-beni"
  location_vm = "West Europe"
  vm_size = "Standard_B1s"
  nic_location = "West Europe"
  nic_name = "frontend-nic"
  rg_name_nic = "rg-beni"
  # nic_subnet_id = "/subscriptions/1212a59c-637f-45eb-8b74-8032483be797/resourceGroups/rg-beni/providers/Microsoft.Network/virtualNetworks/vnet-nt1/subnets/frontend-subnet"
  # public_ip_name = "/subscriptions/1212a59c-637f-45eb-8b74-8032483be797/resourceGroups/rg-beni/providers/Microsoft.Network/publicIPAddresses/pip-frontend"

}

module "key_vault" {
  depends_on = [ module.rg ]
  source = "../Child_Modules/key_vault"
   kv_name         = "nt-kv-vault"
  kv_location = "West Europe"
  resource_group_name = "rg-beni"

}

module "secret_un"{
  depends_on = [ module.key_vault ]
  source = "../Child_Modules/sceret_key_vault"
  secret_name = "vm-username"
  secret_value = "nmt19"
}

module "secret_pwd"{
  depends_on = [ module.key_vault ]
  source = "../Child_Modules/sceret_key_vault"
  secret_name = "vm-password"
  secret_value = "Nt@19sep"
}

# module "nsg" {
#   depends_on = [ module.frontend_vm ]
#   source     = "../Child_Modules/network_security_group"
#   nsg_name   = "nsg-frontend"
#   location   = "West Europe"
#   rg_name    = "rg-beni"
# }
