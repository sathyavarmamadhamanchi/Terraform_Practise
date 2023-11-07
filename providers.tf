#Terraform version
terraform {
  required_version = "~> 1.6.3"
}


#Provider
provider "aws" {
  region = "${var.aws_region}"
}
