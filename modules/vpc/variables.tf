variable "name" {
  type        = string
  description = "Name prefix for VPC resources."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets (2)."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets (2)."
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones to use (2). Example: [\"us-east-1a\", \"us-east-1b\"]."
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources."
  default     = {}
}
