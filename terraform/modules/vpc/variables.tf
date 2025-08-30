variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
}


variable "platform" {
    description = "The platform for which the VPC is being created"
    type        = string

}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to the VPC"
  type        = map(string)
  default     = {}
}