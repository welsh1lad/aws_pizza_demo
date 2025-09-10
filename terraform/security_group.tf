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
    Name = "service-internal-security-group"
  }
}

# --------------------------
# ALB Security Group
# --------------------------
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP/HTTPS inbound to ALB"
  vpc_id      = module.app_vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Public access
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "eks_nodes_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.internal.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-ssh-sg"
  vpc_id      = module.app_vpc.vpc_id
  description = "Allow SSH in, egress to EKS API"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16","51.148.154.226/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]   # or lock down to EKS SG
  }
}

output "security_group_id" {
  description = "The ID of the internal security group"
  value       = aws_security_group.internal.id
}