resource "aws_s3_bucket_object" "index_page" {
  bucket       = aws_s3_bucket.tetris-hosting-bucket.id
  for_each     = fileset(path.module, "../app/build/web/**/*")
  key          = "index.html"
  source       = "${path.module}/${each.value}"
  content_type = "text/html"
  etag         = filemd5("../app/build/web/index.html")
}
