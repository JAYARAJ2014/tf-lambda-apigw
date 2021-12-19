/**
 maps an HTTP request to a target, in this case your Lambda function. 
 In the example configuration, the route_key matches any GET request matching the path /hello. 
 A target matching integrations/<ID> maps to a Lambda integration with the given ID.
*/
resource "aws_apigatewayv2_route" "hello_world" {
  api_id = aws_apigatewayv2_api.lambda.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.hello_world.id}"
}

