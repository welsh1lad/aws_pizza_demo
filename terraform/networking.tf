module "igw" {
  source   = "./modules/igw"
  vpc_id   = module.app_vpc.vpc_id
  vpc_name = "app-vpc"
}

module "app_subnet" {
  source   = "./modules/subnets"
  vpc_id   = module.app_vpc.vpc_id
  platform = "dev"
  subnets = {
    subnet1 = {
      cidr_block    = "10.1.0.0/24"
      az_zone       = "eu-west-2a"
      public_enable = true
      name          = "app-publice-subnet-1"
    }
  }
}

module "service_subnet" {
  source   = "./modules/subnets"
  vpc_id   = module.service_vpc.vpc_id
  platform = "dev"
  subnets = {
    subnet2 = {
      cidr_block    = "10.2.0.0/24"
      az_zone       = "eu-west-2b"
      public_enable = false
      name          = "service-private-subnet-1"
    }
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "eip-nat-gateway"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = module.app_subnet.subnet_ids[0]

  tags = {
    Name = "app-nat"
  }
  depends_on = [module.igw]
}

resource "aws_route_table" "private" {
  vpc_id = module.service_vpc.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "service-private-route-table"
  }
}

resource "aws_route_table" "public" {
  vpc_id = module.app_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.igw.igw_id
  }

  tags = {
    Name = "apps-public-route-table"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = module.service_subnet.subnet_ids[0]
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = module.app_subnet.subnet_ids[0]
  route_table_id = aws_route_table.public.id
}
