variable "ami" {
    type = string
    default = "ami-0cfb394ad3c3ac699"
}

variable "ec2_type" {
    type = string
    default = "t2.micro"
}

variable "ec2_instance_name" {
    type = string
    default = "bastion"
}

variable "instance_count" {
    type = number
    default = 1
}

variable "security_groups" {
    type = list(string)
    default = []
}

variable "key_name" {
    type = string
    default= "dev-eks-bastion"
}

variable "public_ip" {
    type = bool
    default = false
}

variable "tags" {
  description = "A map of tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "platform" {
    type = string
}