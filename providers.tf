#Terraform version
terraform {
  required_version = "~> 4.19.0"
}


#Provider
provider "aws" {
  region = "${var.aws_region}"
}
