terraform {
  backend "s3" {
    bucket = "terraform-stoque-cloudwatch-teste"
    key    = "terraform-lambda-tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.35.0"
    }
  }

  required_version = ">= 1.2.0"

}

provider "aws" {
  region = "us-east-1"

}