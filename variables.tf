# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "us-east-1"
}

variable "lambda_bucket_name" {
  type    = string
  default = "aws-jay-lambda-bucket-20211218001"
}
