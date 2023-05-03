provider "aws" {
  alias = "us-east-1"
}

resource "aws_acm_certificate" "acm_certification" {
  domain_name       = var.tetris_hostzone_subdomain
  validation_method = "DNS"
  provider          = aws.us-east-1

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn = aws_acm_certificate.acm_certification.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation_records : record.fqdn]
  provider = aws.us-east-1
}