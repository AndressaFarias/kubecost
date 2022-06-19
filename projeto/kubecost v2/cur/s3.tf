resource "aws_s3_bucket" "kubecost_cur_bucket" {
  bucket = "loggi-${var.bucket_name[terraform.workspace]}"
}

resource "aws_s3_bucket_acl" "acl_kubecost_cur_bucket" {
  bucket = aws_s3_bucket.kubecost_cur_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "data_access" {
  bucket                  = aws_s3_bucket.kubecost_cur_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_access_bucket_kubecost" {
  bucket = aws_s3_bucket.kubecost_cur_bucket.id
  policy = data.aws_iam_policy_document.allow_access_bucket_kubecost.json
}


data "aws_iam_policy_document" "allow_access_bucket_kubecost" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.kubecost_cur_bucket.arn}/*",
      "${aws_s3_bucket.kubecost_cur_bucket.arn}"
    ]
  }
}

