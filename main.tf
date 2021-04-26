terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
  backend "s3" {
    bucket = "a9d6a632-e7b1-aa8d-6f04-1d95ca2ab1ef-backend"
    key    = "terraform/webpage/terraform.tfstate"
    region = "us-east-1"
  }
}
