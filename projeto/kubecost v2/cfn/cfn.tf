resource "aws_cloudformation_stack" "kubecost_athena" {
  name             = "${var.bucket_name[terraform.workspace]}-stack"
  capabilities     = ["CAPABILITY_IAM"]
  disable_rollback = true
  //template_url     = "https://loggi-kubecost-cur.s3.amazonaws.com/costusage/kubecost-cur-report/crawler-cfn.yml"
  template_url= "https://kubecost-cur-qa.s3.amazonaws.com/costusage/kubecost-cur-qa-report/crawler-cfn.yml"
}