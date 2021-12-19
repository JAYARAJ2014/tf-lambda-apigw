#defines a name for the API Gateway and sets its protocol to HTTP
resource "aws_apigatewayv2_api" "lambda" {
  name          = "serverless_lambda_gw"
  protocol_type = "HTTP"
}



