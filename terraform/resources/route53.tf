resource "aws_route53_zone" "route53_hostzone" {
  name = var.tetris_hostzone_subdomain
}

resource "aws_route53_record" "cloudfront_alias_record" {
  zone_id = "${aws_route53_zone.route53_hostzone.zone_id}"
  name = var.tetris_hostzone_subdomain
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.tetris-hosting-cloudfront.domain_name}"
    zone_id = "${aws_cloudfront_distribution.tetris-hosting-cloudfront.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "acm_validation_records" {
    for_each = {
        for dvo in aws_acm_certificate.acm_certification.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.route53_hostzone.zone_id
}