resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-eks-cluster-role"
    ManagedBy = "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.project_name}-eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-eks-node-group-role"
    ManagedBy = "terraform"
  }
}

locals {
  eks_node_group_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

resource "aws_iam_role_policy_attachment" "eks_node_group_policies" {
  for_each = toset(local.eks_node_group_policies)

  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = each.value
}


resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  version = var.cluster_version

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name      = var.cluster_name
    ManagedBy = "terraform"
  }
}


resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn

  subnet_ids = var.private_subnet_ids

  instance_types = [var.node_instance_type]

  scaling_config {
    desired_size = var.desired_capacity
    min_size     = var.min_capacity
    max_size     = var.max_capacity
  }

  capacity_type = "ON_DEMAND"

  ami_type = "AL2023_x86_64_STANDARD"

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_policies,
    aws_eks_cluster.this
  ]

  tags = {
    Name      = "${var.project_name}-node-group"
    ManagedBy = "terraform"
  }
}

resource "aws_ec2_tag" "cluster_security_group_tag" {
  resource_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  key         = "karpenter.sh/discovery"
  value       = var.cluster_name
}
