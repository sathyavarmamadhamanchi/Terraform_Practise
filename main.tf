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

data "aws_iam_policy_document" "my-policy-document" {
  statement {
    sid = "allows3"
    effect = "Allow"
    actions = [  
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [ "*" ,]
  }
}

resource "aws_iam_policy" "my-policy" {
  name = "my-policy"
  path = "/"
  policy = "${data.aws_iam_policy_document.my-policy-document.json}"
}




resource "aws_iam_role" "my_role" {

  name = "my_role"

  assume_role_policy = jsonencode({
    versioning = "2023-11-14"
    statement = [
      {
      actions = "sts:AssumeRole"
      effect = "Allow"
      sid = "myrole"
      Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
  
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole",]
    principals {
      type = "service"
      identifiers = ["ec2.amazonaws.com",]
    }
  }
}

resource "aws_iam_role" "instance" {
  name = "instance_role"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}
