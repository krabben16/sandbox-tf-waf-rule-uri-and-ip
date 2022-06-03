terraform {
  required_version = "1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }

  backend "local" {}
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-north-east-1"
}
