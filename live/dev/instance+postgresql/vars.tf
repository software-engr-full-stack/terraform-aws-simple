variable "secrets" {
  type = object({
    key_name = string
    database = object({
      name = string
      user = string
      password = string
    })
  })
}

variable "aws_ssh_id_pub" {
  type = string
  # I don't know if a blank string would break SSH.
  default = ""
}

variable "name" {
  type = string
}

variable "allow_all" {
  type = bool
  description = "If false, only allow SSH and HTTP traffic from own IP."
  default = false
}

variable "eip_tag" {
  type = string
}

variable "instance_type" {
  type = string
}

// TODO: convert "any" to more strict types

variable "ports" {
  type = any
}

variable "network" {
  type = any
}
