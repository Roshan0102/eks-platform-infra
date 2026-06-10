resource "aws_route53_zone" "this" {
  name = var.domain_name

  tags = {
    ManagedBy = "terraform"
  }
}

resource "aws_route53_record" "argocd" {
  zone_id = aws_route53_zone.this.zone_id

  name = "${var.subdomain_name}.${var.domain_name}"

  type = "A"

  alias {
    name                   = var.nlb_dns_name
    zone_id                = var.nlb_zone_id
    evaluate_target_health = true
  }
}