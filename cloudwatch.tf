#aws_cloudwatch_log_group.hello_world 
/*defines a log group to store log messages from your Lambda function for 30 days. 
By convention, Lambda stores logs in a group with the name /aws/lambda/<Function Name>.*/

resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "/aws/lambda/${aws_lambda_function.hello_world.function_name}"
  retention_in_days = 30
}




/**
aws_cloudwatch_log_group.api_gw defines a log group to store access logs for the aws_apigatewayv2_stage.lambda 
API Gateway stage.
**/
resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.lambda.name}"

  retention_in_days = 30
}
