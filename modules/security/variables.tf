variable "name" {
  type        = string
  description = "Name prefix for security resources."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where security groups will be created."
}

variable "db_port" {
  type        = number
  description = "Database port (Postgres=5432, MySQL=3306)."
  default     = 5432
}

variable "allow_ssh" {
  type        = bool
  description = "If true, allow SSH to EC2 from ssh_cidr."
  default     = false
}

variable "ssh_cidr" {
  type        = string
  description = "CIDR allowed to SSH into EC2 (example: your public IP /32)."
  default     = "0.0.0.0/32"
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources."
  default     = {}
}
