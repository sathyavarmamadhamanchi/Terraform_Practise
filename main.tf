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
resource "aws_s3_bucket" "sathya-bucket" {
  bucket = var.bucket_name
  tags = {
    Name = "sathya-bucket"
    Enivironment = var.environment
  }
 
}


# Add bucket versioning for state rollback
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.sathya-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Add bucket encryption to hide sensitive state data
#resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
  #bucket = aws_s3_bucket.sathya-bucket.bucket
  #rule {
   # apply_server_side_encryption_by_default {
   #   sse_algorithm     = "AES256"
   # }
  #}
#}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
  bucket = aws_s3_bucket.sathya-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

#Creating policy
resource "aws_iam_policy" "my-policy" {
  name = "my-policy"
  description = "my test policy"
  policy = jsonencode({
    Version = "2023-11-14"
    Statement = [
      {
        Action = ["ec2:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = ["s3:*"]
        Effect = "Allow"
        Resource = "${aws_s3_bucket.sathya-bucket.arn}"
      }
    ]
  })
}
