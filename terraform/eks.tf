resource "aws_eks_cluster" "app_cluster" {
  name     = "app_cluster"
  version = "1.33"
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids = [
      module.app_subnet.subnet_ids[1],
      module.app_subnet.subnet_ids[2],
    ]
    endpoint_private_access = true
    endpoint_public_access  = false
    security_group_ids      = [aws_security_group.internal.id]
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  depends_on = [aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy]
}



output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.app_cluster.endpoint
}
output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.app_cluster.certificate_authority[0].data
}
output "cluster_id" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.app_cluster.name
}
