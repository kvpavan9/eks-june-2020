### EKS Master Cluster IAM Role
resource "aws_iam_role" "eks-master" {
  name = "${var.cluster_name}-eks-master"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "eks-master-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-master.name
}

resource "aws_iam_role_policy_attachment" "eks-master-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-master.name
}

### EKS Master Cluster Security Group
resource "aws_security_group" "eks-master" {
  name        = "${var.cluster_name}-eks-master"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-eks-master"
  }
}

resource "aws_security_group_rule" "eks-master-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-master.id
  type              = "ingress"
}

### EKS Master Cluster
resource "aws_eks_cluster" "eks-master" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.eks-master.arn
  version                   = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    security_group_ids = [aws_security_group.eks-master.id]
    subnet_ids         = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-master-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-master-AmazonEKSServicePolicy,
  ]
}

