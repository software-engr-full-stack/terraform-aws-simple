module "db" {
  source = "../../../modules/services/db/postgres"

  name = var.name
  data = module.network.data

  mod = {
    name = var.secrets.database.name
    username = var.secrets.database.user
    password = var.secrets.database.password
    postgres_port = 5432
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*22*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_eip" "by_tag" {
  filter {
    name   = "tag:Name"
    values = [var.eip_tag]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud-init.yml")
  vars = {
    aws_ssh_id_pub = var.aws_ssh_id_pub
  }
}

module "instance" {
  source = "../../../modules/services/instance"
  name = var.name

  instance = var.instance
  ports = var.ports

  ami_image_id = data.aws_ami.ubuntu.id

  myip = local.myip

  data = module.network.data

  eip = {
    do_associate = true
    allocation_id = data.aws_eip.by_tag.id
  }
  user_data = data.template_file.user_data.rendered
}
