output "public_dns" {
  value = "${aws_instance.ubuntu.public_dns}"
}

output "S3_bucket_name" {
  value = "${aws_s3_bucket.sathya-bucket.id}"
}
