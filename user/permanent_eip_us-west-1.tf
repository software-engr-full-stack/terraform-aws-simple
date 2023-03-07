terraform {
  cloud {
    organization = "software-engr-full-stack"
    workspaces {
      name = "aws_permanent_eip_us-west-1"
    }
  }
}
