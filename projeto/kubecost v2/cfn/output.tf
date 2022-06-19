output "aws-athena-query-results_bucket_query-result-location"  {
  value = "s3://${aws_s3_bucket.aws-athena-query-results_bucket.bucket}/"
}