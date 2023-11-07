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
