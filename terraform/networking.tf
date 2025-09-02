module "igw" {
  source   = "./modules/igw"
  vpc_id   = module.app_vpc.vpc_id
  vpc_name = "app-vpc"
}

##
# module "igw_private" {
#  source   = "./modules/igw"
#  vpc_id   = module.service_vpc.vpc_id
#  vpc_name = "service-vpc"
#}

module "app_subnet" {
  source   = "./modules/subnets"
  vpc_id   = module.app_vpc.vpc_id
  platform = "dev"
  subnets = {
    subnet1 = {
      cidr_block    = "10.0.1.0/24"
      az_zone       = "eu-west-2a"
      public_enable = true
      name          = "app-public-subnet"
    }
    subnet2 = {
      cidr_block    = "10.0.2.0/24"
      az_zone       = "eu-west-2b"
      public_enable = false
      name          = "app-private-subnet-1"
    }
    subnet3 = {
      cidr_block    = "10.0.3.0/24"
      az_zone       = "eu-west-2c"
      public_enable = false
      name          = "app-private-subnet-2"
    }
  }
}

##
/* module "service_subnet" {
  source   = "./modules/subnets"
  vpc_id   = module.service_vpc.vpc_id
  platform = "dev"
  subnets = {
    subnet3 = {
      cidr_block    = "10.2.2.0/24"
      az_zone       = "eu-west-2b"
      public_enable = false
      name          = "service-private-subnet-1"
    }
    subnet4 = {
      cidr_block    = "10.2.3.0/24"
      az_zone       = "eu-west-2c"
      public_enable = false
      name          = "service-private-subnet-2"
    }
  }
}
*/

resource "aws_eip" "service_nat" {
  domain = "vpc"
  tags = {
    Name = "eip-service-nat-gateway"
  }
}

resource "aws_nat_gateway" "service_nat" {
  allocation_id = aws_eip.service_nat.id
  subnet_id     = module.app_subnet.subnet_ids[0]
  tags = {
    Name = "public-nat"
  }
  depends_on = [module.igw]
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

resource "aws_route_table" "private" {
  vpc_id = module.app_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id =  aws_nat_gateway.service_nat.id
  }

  tags = {
    Name = "apps-private-route-table"
  }
}

resource "aws_route_table_association" "private_association_1" {
  subnet_id      = module.app_subnet.subnet_ids[1]
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_association_2" {
  subnet_id      = module.app_subnet.subnet_ids[2]
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "public_association" {
  subnet_id      = module.app_subnet.subnet_ids[0]
  route_table_id = aws_route_table.public.id
}


