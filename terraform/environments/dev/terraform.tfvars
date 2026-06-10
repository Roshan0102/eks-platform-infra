aws_region = "us-east-1"

project_name = "kncp"
vpc_cidr     = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]


cluster_name = "kncp-eks"

cluster_version = "1.32"

node_instance_type = "m7i-flex.large"

desired_capacity = 2
min_capacity     = 2
max_capacity     = 5

domain_name = "pramod-leveling.space"

argocd_subdomain = "argocd"

