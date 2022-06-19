resource "aws_cur_report_definition" "kubecost_cur_definition" {
  report_name                = "${var.bucket_name[terraform.workspace]}-report"
  time_unit                  = "DAILY"
  format                     = "Parquet"
  compression                = "Parquet"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = aws_s3_bucket.kubecost_cur_bucket.bucket
  s3_prefix                  = "costusage/"
  s3_region                  = var.region
  additional_artifacts       = ["ATHENA"]
  refresh_closed_reports     = true
  report_versioning          = "OVERWRITE_REPORT"

  depends_on = [
    aws_s3_bucket_policy.allow_access_bucket_kubecost
  ]
}