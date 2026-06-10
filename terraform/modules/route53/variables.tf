variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "subdomain_name" {
  description = "Subdomain name"
  type        = string
}

variable "nlb_dns_name" {
  description = "NLB DNS name"
  type        = string
}

variable "nlb_zone_id" {
  description = "NLB Hosted Zone ID"
  type        = string
}
