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

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  
  # without this, requests to subpage requests (like "/page") directory goes to origin s3 bucket
  # 404 error would be thrown by s3, because the bucket doesn't have such a file or folder
  # resulting in cloudfront originated 403 response for client
  custom_error_response {
    error_caching_min_ttl = 86400
    error_code = 403
    response_code = 200
    response_page_path = "/"
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
