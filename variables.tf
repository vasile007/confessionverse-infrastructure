variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project name prefix."
  default     = "confessionverse"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.0.0/24", "10.20.1.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.10.0/24", "10.20.11.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Owner       = "VasileB"
  }
}
variable "db_port" {
  type    = number
  default = 5432
}

variable "allow_ssh" {
  type    = bool
  default = false
}

variable "ssh_cidr" {
  type    = string
  default = "0.0.0.0/32"
}
variable "db_password" {
  type      = string
  sensitive = true
}
