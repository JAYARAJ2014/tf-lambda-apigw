# Terraform + Lambda functions + API Gateway

AWS Lambda functions and API gateway are often used to create serverlesss
applications.

The steps listed below explains how to create a simple API using Lambda, API Gateway and Infrastructure as Code using Terraform.

NOTE: If you clone this repository, make sure to change the bucket names. Then run `terraform plan`, `terraform apply` and then once experiment is over, run a `terraform destroy` to make sure that you do not incur any charges.

There are additional comments available within the source code to explain further.

# 1 : Define required terraform providers.

In this example, we will upload the lambda in zip file format to S3 bucket. For creating zip archive, use `hashicorp/archive` provider and `hashicorp/aws` provider.

# 2: Initialize aws provider

# 3: Define an s3 bucket to host lambda function archive. (To store hellow-world.zip file)

# 4: Define a data block `archive_file`

A data block requests that Terraform read from a given data source and export the result under the given local name. The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside of the scope of a module.

# 5: Define an s3 bucket object

This is the actual zip file. Use the file name `name hello-world.zip` as the key for this object

# 6: Create Lambda execution role.

# 7: Attach a policy to the above role

so that lambda can write to cloudwatch.

# 7: Define the lambda

Specify the s3 location of the zip file, runtime and handler

# 8: Define teh CW log group

# 9: Create API Gateway

AWS managed service that allows you to create and manage HTTP APIs allowing you to implement an HTTP API using Lambda functions

... Continued: https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway
