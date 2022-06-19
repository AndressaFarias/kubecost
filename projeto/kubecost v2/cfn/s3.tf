resource "aws_s3_bucket" "aws-athena-query-results_bucket" {
  bucket = "aws-athena-query-results${var.bucket_name[terraform.workspace]}"
}

resource "aws_s3_bucket_acl" "acl_aws-athena-query-results_bucket" {
  bucket = aws_s3_bucket.aws-athena-query-results_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "data_access" {
  bucket                  = aws_s3_bucket.aws-athena-query-results_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}