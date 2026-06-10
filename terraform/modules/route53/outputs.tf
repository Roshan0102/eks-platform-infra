output "name_servers" {
  value = aws_route53_zone.this.name_servers
}

output "argocd_fqdn" {
  value = aws_route53_record.argocd.fqdn
}