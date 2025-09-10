variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "eu-west-2"
}

variable "key_name" {
    type = string
    default= "dev-eks-bastion"
}

variable "platform" {
  description = "The platform for which the resources are being created"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "dev-eks-cluster"
  
}