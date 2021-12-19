resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "aws-jay-lambda-bucket-20211218001" ## NOTE: The bucket name cannot contain underscores
  acl           = "private"
  force_destroy = true
}



resource "aws_s3_bucket_object" "lambda_hello_world" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "hello-world.zip"
  source = data.archive_file.lambda_hello_world.output_path
  # filemd5 is a variant of md5 that hashes the contents of a given file rather than a literal string.
  etag = filemd5(data.archive_file.lambda_hello_world.output_path)
}
