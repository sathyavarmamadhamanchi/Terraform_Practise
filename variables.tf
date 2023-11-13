variable "aws_region" {
  description = "AWS region"
  default = "us-east-2"
}

variable "ami_id" {
    description = "ID of the AMI to provision"
    default = "ami-0e83be366243f524a"
}

variable "instance_type" {
  description = "Type of instance"
  default = "t2.micro"
}

variable "name" {
  description = "name to pass to Name tag"
  default = "provisioned by terraform"
}

variable "bucket_name" {
  description = "Name-of-the-to-create"
  default = "sathya-bucket-10964"
}

variable "environment" {
   description = "Name-of-the-environment"
  default = "Dev"
}

variable "bucket_acl" {
  description = "acl"
  default = "private"
}
