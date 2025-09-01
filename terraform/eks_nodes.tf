resource "aws_launch_template" "eks-with-disks" {
  name = "eks-with-disks"

  key_name = "<KEY_PAIR_NAME>"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 50
      volume_type = "gp3"
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-nworker"
    }
  }
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.app_cluster.name
  node_group_name = "app-private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    module.app_subnet.subnet_ids[0],
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.micro"]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  launch_template {
    name    = aws_launch_template.eks-with-disks.name
    version = aws_launch_template.eks-with-disks.latest_version
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}