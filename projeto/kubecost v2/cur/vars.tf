variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = {
    root-account = "kubecost-cur"
  }
}

