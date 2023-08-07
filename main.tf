terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "ack-env" {
    ami = "ami-09dd2e08d601bff67"
    instance_type = "t2.micro"
    
    tags = {
        Name = "ack-org"
    }
}

