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

