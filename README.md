# Terraform + Lambda functions + API Gateway

I have created this sample to explain the end to end process to my peers and friends. This sample is created by reading various sites. For your reading [Click Here](https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway)

# Pre Requisites

- Basic understanding of aws & services
- An access key configured locally on your computer.

# Notes

- AWS Lambda functions and API gateway are often used to create serverlesss
  applications.

- The steps listed below explains how to create a simple API using Lambda, API Gateway and Infrastructure as Code using Terraform.

- If you clone this repository, make sure to change the bucket names. You can do this by changing `terraform.tfvars` file and updating the bucketname.

- Run `terraform plan`, `terraform apply` and then once experiment is over, run a `terraform destroy` to make sure that you do not incur any charges.

- I have tried to be as intention revealing as possible when it comes to file names. Suggestions always welcome

- There are additional comments available within the source code to explain further.

# 1 : Define required terraform providers.

`providers.tf`

In this example, we will upload the lambda in zip file format to S3 bucket. For creating zip archive, use `hashicorp/archive` provider and `hashicorp/aws` provider.

# 2: Initialize aws provider

Run `terraform init`

# 3: Define an s3 bucket to host lambda function archive.

`s3.tf`

To store `hellow-world.zip` file

# 4: Define a data block

`archive_file` in `data.tf`

A data block requests that Terraform read from a given data source and export the result under the given local name. The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside of the scope of a module.

# 5: Define an s3 bucket object

`s3.tf`

This is the actual zip file. Use the file name `name hello-world.zip` as the key for this object

# 6: Create Lambda execution role.

`roles.tf`

# 7: Attach a policy to the above role

`policies.tf`

so that lambda can write to cloudwatch.

# 7: Define the lambda

`lambda.tf`

Specify the s3 location of the zip file, runtime and handler. The actual lambda code is in teh hello-world folder which is developed in NodeJS.

# 8: Define the CW log group

`cloudwatch.tf`

This file defines the log groups for both lambda and api gateway

# 9: Create API Gateway

`apigw.tf`

AWS managed service that allows you to create and manage HTTP APIs allowing you to implement an HTTP API using Lambda functions

# 10: Define a stage in APIGW

`apigw-stages.tf`

This is where you setup stages like Prod, QE, Dev etc.

# 11: Define APIGW - Lambda Integration

`apigw-lambda-integration.tf`

In this example, APIGW acts as a proxy to lambda. API Gateway passes the request information to your function via the event object. You can use information about the request in your function code.

# 12: Define the route

`apigw-route.tf`

This is where we define `GET /hello`

# 13: CW log group for APIGW

`cloudwatch.tf`

# 14: Create permission for APIGW to execute lambda

`permissions.tf`

# 15: Define output variables

`outputs.tf`

Define the output variables for s3 bucket, lambda function and most importantly the Base URL from APIGW.
We will use this URL to invoke the API

# 16: Run `terraform plan`

To ensure that there are no issues. If you are using Jenkins pipeline, make sure to output the plan and apply the same plan in the next step.

# 17: Run `terraform apply --auto-approve`

This will deploy the changes to cloud. To verify that everything works fine , copy the BaseURL from the output and paste it in a browser and append hello to it. (Look at `route_key = "GET /hello" ` inside `apigw-routes.tf`)
Example: `https://d9whm5dh16.execute-api.us-east-1.amazonaws.com/serverless_lambda_stage/hello`
Note that the /hello at the end is appended to the base url

# 18: Run `terraform destroy`

unless you want to pay for the resources living in there for long

# 19: Making Changes

Whenever you modify the code the etag (Basically means entity tag.It is a Computed Hash) in the S3 bucket object changes. This will force Terraform to move updated code to the S3 bucket under the same key.
Example output from `terraform plan`. Note that the `~` represents an in-place update.

```
 # aws_s3_bucket_object.lambda_hello_world will be updated in-place
  ~ resource "aws_s3_bucket_object" "lambda_hello_world" {
      ~ etag               = "f88e56c820d30e11b04f016426c7e9aa" -> "12590bba4c9c4cd87424cd67e7ca5c4a"

```

# 20: Using S3 bucket as TF State Backend store

Refer `providers.tf` . Backends will help protect tfstate. 
