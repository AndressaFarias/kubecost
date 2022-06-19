locals {
  common_tags = {
    application = "kubecost"
    team        = "sre"
    Name        = var.bucket_name[terraform.workspace]
    environment = "tools"
    cost_center = "infraestrutura_de_tecnologia_sre"
    tribe       = "platform"
  }

  kubecost_tags = {
    kubernetes_cluster    = "sre"
    kubernetes_deployment = "kubecost"
    kubernetes_label_app  = "kubecost"
    kubernetes_label_bu   = "tecnologia"
    kubernetes_label_team = "sre"
    kubernetes_namespace  = "kubecost"
  }
}

provider "aws" {
  region  = var.region
  version = "4.15.1"
  profile = terraform.workspace

  default_tags {
    tags = merge(
      local.common_tags,
      local.kubecost_tags,
    )
  }
}

terraform {
  required_version = "= 1.1.7"
  backend "s3" {
    profile = "tech-tools"
    bucket  = "loggi-terraform"
    key     = "aws/kubecost/terraform.tfstate"
    region  = "us-east-1"
  }
}
