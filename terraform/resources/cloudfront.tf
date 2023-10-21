resource "aws_cloudfront_distribution" "tetris-hosting-cloudfront" {
  origin {
    domain_name = aws_s3_bucket.tetris-hosting-bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.tetris-hosting-bucket.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.tetris-hosting.cloudfront_access_identity_path
    }
  }
  price_class = "PriceClass_200"
  enabled = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases = [var.tetris_hostzone_subdomain]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.tetris-hosting-bucket.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.subpage-redirect-function.arn
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"]
    }
  }
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.acm_certification.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  
}

resource "aws_cloudfront_origin_access_identity" "tetris-hosting" {}

resource "aws_cloudfront_function" "subpage-redirect-function" {
  name    = "subpage-redirect-function"
  runtime = "cloudfront-js-1.0"
  comment = "without this, invalid access to  origin s3 throws 404 error"
  publish = true
  code    = file("${path.module}/cloudfront-function.js")
}