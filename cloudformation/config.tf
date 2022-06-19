locals {
  common_tags = {
    application = "kubecost"
    team        = ""
    Name        = "${var.sufix}"
    environment = "tools"
    cost_center = "infraestrutura_de_tecnologia_sre"
    tribe       = "platform"
    kubernetes_cluster = "root"
    kubernetes_deployment	= "finops"
    kubernetes_label_app = "kubecost"
    kubernetes_label_bu	= ""
    kubernetes_label_team = "sre"
    kubernetes_namespace = "sre"
  }
}

provider "aws" {
  region  = var.region
  //profile = "root-account"
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
