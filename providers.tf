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

  backend "s3" {
    bucket = "aws-jay-tfstate-bucket-001"
    key    = "tf_key"
    region = "us-east-1"
  }
  required_version = "~> 1.0"
}


provider "aws" {
  region = var.aws_region
}
