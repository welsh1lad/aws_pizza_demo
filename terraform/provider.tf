terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
  default_tags {
    tags = {
      Managed-By  = "Terraform"
      EKS-Cluster = "app_cluster"
    }
  }
}
