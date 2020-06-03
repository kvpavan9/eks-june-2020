resource "aws_iam_role" "eks_nodes" {
  name = "eks-node-group-tuto"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.demo.name
  count           = length(var.node-group-names)
  node_group_name = var.node-group-names[count.index]
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = module.vpc.public_subnets
#  vpc_zone_identifier = module.vpc.public_subnets

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}