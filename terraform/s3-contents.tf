resource "aws_s3_object" "tetris-resources" {
  bucket       = aws_s3_bucket.tetris-hosting-bucket.id
  for_each     = module.distribution_files.files
  key          = each.key
  source       = each.value.source_path
  content_type = each.value.content_type
  etag         = filemd5("../app/build/web/index.html")
}

module "distribution_files" {
  source   = "hashicorp/dir/template" # 固定
  base_dir = "../app/build/web"       # ファイルを読み取るディレクトリ
}
