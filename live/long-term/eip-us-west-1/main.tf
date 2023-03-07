terraform {
  required_version = ">= 1.3.9"
}

variable "eip_tag" {
  type = string
}

variable "region" {
  type = string
}

provider "aws" {
  region = var.region
}

resource "aws_eip" "permanent" {
  tags = {
    Name = var.eip_tag
  }
  vpc = true
}
