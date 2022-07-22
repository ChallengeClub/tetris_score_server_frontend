resource "aws_s3_bucket_object" "index_page" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  source       = "../app/build/web/index.html"
  content_type = "text/html"
  etag         = filemd5("../app/build/web/index.html")
}
