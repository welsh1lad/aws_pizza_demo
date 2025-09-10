
resource "aws_instance" "ec2_instance" {
  count         = var.instance_count        # Replace with the number of instances you want to create
  ami           = var.ami  # Replace with the AMI ID you want to use
  instance_type = var.ec2_type              # Replace with the instance type you want to use
  subnet_id     = var.subnet_id           # Replace with the ID of the subnet where you want to launch the instance
  security_groups = var.security_groups     # Replace with a list of security group IDs to associate
  tags = merge(
    var.tags,
    {
      Name = var.ec2_instance_name
    }
  )

  key_name                    = var.key_name
  associate_public_ip_address =  var.public_ip  # Replace with true or false depending on whether you want a public IP address assigned to your instance
}
