variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "node_instance_type" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "min_capacity" {
  type = number
}

variable "max_capacity" {
  type = number
}


variable "domain_name" {
  type = string
}

variable "argocd_subdomain" {
  type = string
}

variable "nlb_dns_name" {
  type = string
}

variable "nlb_zone_id" {
  type = string
}