/*
resource "aws_s3_bucket" kubecost_cur_bucket {
  bucket = "${var.sufix}"
  tags = local.common_tags
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.kubecost_cur_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "data_access" {
  bucket = aws_s3_bucket.kubecost_cur_bucket.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
*/

resource "aws_cloudformation_stack" "stack_athena_kubecost" {
  name          = "${var.sufix}-teste"
  #template_url  = "s3://kubecost-aws-cost-and-usage-report.s3.amazonaws.com/costusage/aws-cost-report/crawler-cfn.yml"
  template_url  = "https://s3-external-1.amazonaws.com/cf-templates-17jujlt7uou8b-us-east-1/2022126h7j-crawler-cfn.yml"
  tags          = local.common_tags
  
}

