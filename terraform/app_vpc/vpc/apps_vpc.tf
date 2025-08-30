module "vpc" {
  source   = "../app_vpc/modules/vpc"
  region   = var.region
  platform = "var.platform"
  # vpc_cidr=var.dev_vpc_cidr
  vpc_cidr_block = var.dev_vpc_cidr
  vpc_name       = var.vpc_name

}