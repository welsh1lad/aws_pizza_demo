resource "aws_subnet" "main" {
  for_each                = var.subnets
  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az_zone
  map_public_ip_on_launch = each.value.public_enable

  tags = {
    Name     = each.value.name
    Platform = var.platform
  }
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = [for s in aws_subnet.main : s.id]
}