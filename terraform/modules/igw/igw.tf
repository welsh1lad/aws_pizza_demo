resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = format("%s-igw", var.vpc_name)
  }
}
