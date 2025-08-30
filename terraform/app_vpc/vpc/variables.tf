variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "eu-west-2"
}
variable "platform" {
  description = "The platform for which the VPC is being created"
  type        = string
  default     = "dev"
}
variable "dev_vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "app_vpc"
}