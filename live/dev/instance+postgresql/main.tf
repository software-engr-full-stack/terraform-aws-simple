variable "region" {
  type = string
}

provider "aws" {
  region = var.region
}

data "external" "myip_addr" {
  count = var.allow_all ? 0 : 1
  program = ["${path.module}/../../../lib/own-ip.sh"]
}

locals {
  myip = {
    addr = length(data.external.myip_addr) > 0 ? data.external.myip_addr[0].result.myip_addr : ""
    mask = 32
  }
}

module "network" {
  source = "../../../modules/network"
  region = var.region
  network_config = var.network.dev_instance-plus-postgresql
  enable_nat = false
  name = var.name
}

output "devices" {
  value = {
    eip = {
      public_ip = data.aws_eip.by_tag.public_ip
      public_dns = data.aws_eip.by_tag.public_dns
    }
    server = module.instance.output.public_ip
    database = module.db.output.endpoint
  }
}
