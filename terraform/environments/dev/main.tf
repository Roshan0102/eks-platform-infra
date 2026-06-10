module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name

  vpc_cidr = var.vpc_cidr

  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs

  availability_zones = var.availability_zones
}

module "eks" {
  source = "../../modules/eks"

  project_name = var.project_name

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  node_instance_type = var.node_instance_type

  desired_capacity = var.desired_capacity
  min_capacity     = var.min_capacity
  max_capacity     = var.max_capacity
}

module "ebs_csi" {
  source = "../../modules/ebs-csi"

  cluster_name = module.eks.cluster_name

  oidc_provider_arn = module.eks.oidc_provider_arn

  oidc_provider_url = module.eks.oidc_provider_url
}

module "route53" {
  source = "../../modules/route53"

  domain_name    = var.domain_name
  subdomain_name = var.argocd_subdomain

  nlb_dns_name = var.nlb_dns_name
  nlb_zone_id  = var.nlb_zone_id
}

module "iam" {
  source = "../../modules/iam"

  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
}

data "aws_caller_identity" "current" {}

resource "null_resource" "update_karpenter_account_id" {
  triggers = {
    account_id = data.aws_caller_identity.current.account_id
  }

  provisioner "local-exec" {
    command = "sed -i 's/YOUR_AWS_ACCOUNT_ID/${data.aws_caller_identity.current.account_id}/g' ../../../../online-boutique-gitops/apps/cloudcart/karpenter/karpenter.yaml"
  }
}
