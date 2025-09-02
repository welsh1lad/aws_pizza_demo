module "app_vpc" {
  source   = "./modules/vpc"
  region   = var.region
  platform = "var.platform"
  # vpc_cidr=var.dev_vpc_cidr
  vpc_cidr_block = "10.0.0.0/16"
  vpc_name       = "app-vpc"
}

## 
# module "service_vpc" {
#  source   = "./modules/vpc"
#  region   = var.region
#  platform = "var.platform"
#  # vpc_cidr=var.dev_vpc_cidr
#  vpc_cidr_block = "10.2.0.0/16"
#  vpc_name       = "service-vpc"
#}


