# Terraform Block
terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider Block (nothing to replace in this block for lab usage)
provider "aws" {
  region  = "us-west-1"
  profile = "default"
}



resource "aws_instance" "CL-ec2-instances" {
  count = 1
  tags = {
    "Name" = "CL-ce2-${1 + count.index}"
  }

  ami = "ami-09c5c62bac0d0634e"
  #vpc_id                 = "vpc-6f25e609"
  instance_type          = "t2.micro"
  key_name               = "public-w2-keys"
  vpc_security_group_ids = ["sg-02e7d742054576ed2"]
  subnet_id              = "subnet-744d832e"


}

