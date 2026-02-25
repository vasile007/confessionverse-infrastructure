variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "db_name" {
  type    = string
  default = "confessionverse"
}

variable "db_username" {
  type    = string
  default = "postgres"
}

variable "db_password" {
  type = string
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "tags" {
  type    = map(string)
  default = {}
}
