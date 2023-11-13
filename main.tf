#AWS_EC2_Instance
resource "aws_instance" "ubuntu" {

    ami = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    availability_zone = "${var.aws_region}a" 

    tags = {
      Name = "${var.name}"
    }

}

#S3_buckets
resource "aws_s3_bucket" "bucket_a" {
  bucket = var.bucket_name
  tags = {
    Name = "my_bucket"
    Enivironment = var.environment
  }
 
}

