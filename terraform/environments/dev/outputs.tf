output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "nat_gateway_public_ip" {
  value = module.vpc.nat_gateway_public_ip
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_group_name" {
  value = module.eks.node_group_name
}

output "argocd_url" {
  value = module.route53.argocd_fqdn
}

output "route53_name_servers" {
  value = module.route53.name_servers
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  value = module.eks.oidc_provider_url
}

output "karpenter_controller_role_arn" {
  value = module.iam.karpenter_controller_role_arn
}

output "karpenter_node_role_arn" {
  value = module.iam.karpenter_node_role_arn
}

output "karpenter_node_instance_profile_name" {
  value = module.iam.karpenter_node_instance_profile_name
}
