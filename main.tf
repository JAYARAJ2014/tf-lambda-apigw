terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.48.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region = var.aws_region
}

data "archive_file" "lambda_hello_world" {
  type = "zip"
  # path.module is the filesystem path of the module where the expression is placed.
  source_dir  = "${path.module}/hello-world"
  output_path = "${path.module}/hello-world.zip"
}
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

# Create a lambda Execution role
/**
aws_iam_role.lambda_exec defines an IAM role that allows Lambda to access resources in your AWS account.

*/
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"
  # jsonencode encodes a given value to a string using JSON syntax. RFC 7159.


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

# Create Lambda Policy 
/*
aws_iam_role_policy_attachment.
lambda_policy attaches a policy the IAM role. 
The AWSLambdaBasicExecutionRole is an AWS managed policy that allows your Lambda function to write to CloudWatch logs.
*/
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create the lambda function
resource "aws_lambda_function" "hello_world" {
  function_name = "hello_world"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_bucket_object.lambda_hello_world.key

  runtime = "nodejs12.x"
  handler = "hello.handler"
  /* 
  
  source_code_hash attribute will change whenever you update the code contained in the archive, 
  which lets Lambda know that there is a new version of your code available
   
  */
  source_code_hash = data.archive_file.lambda_hello_world.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn

}

#aws_cloudwatch_log_group.hello_world 
/*defines a log group to store log messages from your Lambda function for 30 days. 
By convention, Lambda stores logs in a group with the name /aws/lambda/<Function Name>.*/

resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "/aws/lambda/${aws_lambda_function.hello_world.function_name}"
  retention_in_days = 30
}


resource "aws_apigatewayv2_api" "name" {
  
}