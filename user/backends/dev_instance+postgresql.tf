terraform {
  cloud {
    organization = "software-engr-full-stack"
    workspaces {
      name = "aws_dev_instance-plus-postgresql"
    }
  }
}
