terraform {
  cloud {
    organization = "software-engr-full-stack"
    workspaces {
      name = "aws_long-term_eip_us-west-1"
    }
  }
}
