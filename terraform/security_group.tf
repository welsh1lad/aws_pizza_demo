# Create security group
resource "aws_security_group" "internal" {
  name_prefix = "apps-internal-security-group"
  description = "Allow traffic within the internal network"
  vpc_id      = module.app_vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "apps-internal-security-group"
  }
}

output "security_group_id" {
  description = "The ID of the internal security group"
  value       = aws_security_group.internal.id
}