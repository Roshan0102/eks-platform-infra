variable "project_name" {
  description = "Project name"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
}



variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS nodes"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "node_instance_type" {
  description = "EKS worker node instance type"
  type        = string
}

variable "desired_capacity" {
  description = "Desired worker node count"
  type        = number
}

variable "min_capacity" {
  description = "Minimum worker node count"
  type        = number
}

variable "max_capacity" {
  description = "Maximum worker node count"
  type        = number
}