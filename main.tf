#AWS_EC2_Instance
resource "aws_instance" "ubuntu" {

    ami = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    availability_zone = "${var.aws_region}a" 

    tags = {
      Name = "${var.name}"
    }

}

#S3_Bucket
resource "aws_s3_bucket" "Bucket_a" {
  bucket = var.bucket_name
  tags = {
    Name = "my bucket"
    Enivironment = "${var.environment}"
  }
 
}

