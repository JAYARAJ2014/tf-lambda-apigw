
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
