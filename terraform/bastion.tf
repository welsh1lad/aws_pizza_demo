module "name" {
    source = "./modules/ec2"
    ami    = "ami-04fb7beeed4da358b" # Amazon Linux 2 AMI ID in us-east-1
    ec2_type = "t2.micro"
    instance_count = 1
    ec2_instance_name = "bastion-host"
    platform = "dev"
    vpc_id = module.app_vpc.vpc_id
    subnet_id = element(module.app_subnet.subnet_ids, 0) # Replace with the ID of the subnet where you want to launch the instance
    security_groups = [aws_security_group.bastion_sg.id] # Replace with a list of security group IDs to associate
    tags = {
        Name = "bastion-host"
    }
    public_ip = true    # Assign a public IP address to the instance
}