resource "aws_s3_bucket" "tetris-hosting-bucket" {
  bucket_prefix = "tetris-hosting"
}

# access control list
resource "aws_s3_bucket_acl" "tetris-hosting-bucket-acl" {
  bucket = aws_s3_bucket.tetris-hosting-bucket.id
  acl    = "private"
}


resource "aws_s3_bucket_website_configuration" "tetris-hosting-config" {
  bucket = aws_s3_bucket.tetris-hosting-bucket.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "tetris-hosting-bucket-policy" {
  bucket = aws_s3_bucket.tetris-hosting-bucket.id
  policy = data.aws_iam_policy_document.tetris-hosting-policy-doc.json
}

resource "aws_s3_bucket_versioning" "tetris-hosting-versioning" {
  bucket = aws_s3_bucket.tetris-hosting-bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

data "aws_iam_policy_document" "tetris-hosting-policy-doc" {
  statement {
    sid    = "Allow CloudFront"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.tetris-hosting.iam_arn]
    }
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.tetris-hosting-bucket.arn}/*"
    ]
  }
}
