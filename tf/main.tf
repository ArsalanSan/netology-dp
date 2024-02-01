####----------------------------
#### Calling the vpc module ####
####----------------------------

# module "vpc" {
#   source   = "git::https://github.com/ArsalanSan/networks.git"
#   vpc_name = var.vpc_name
#   subnets  = local.subnets2
#   zone     = var.zone
# }

resource "yandex_vpc_network" "vpc" {
  description = "Create network"
  name = "vpc_test"
}

resource "yandex_vpc_subnet" "subnets" {
  name           = "create subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.10.11.0/24"]
}