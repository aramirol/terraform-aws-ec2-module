# S3 resource

resource "aws_s3_bucket" "bucket_test" {
  bucket = var.bucket_name
  acl    = var.bucket_acl

  tags = {
    Name        = "My bucket"
    Environment = "Bucket test"
  }
}