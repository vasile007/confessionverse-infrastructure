locals {
  common_tags = merge(
    {
      Project   = var.name
      ManagedBy = "Terraform"
    },
    var.tags
  )
}

# Security Group pentru EC2 (web)
resource "aws_security_group" "web" {
  name        = "${var.name}-sg-web"
  description = "Web SG: allow HTTP/HTTPS from internet; optional SSH from a trusted CIDR."
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, {
    Name = "${var.name}-sg-web"
    Tier = "web"
  })
}

# Inbound HTTP
resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id = aws_security_group.web.id
  description       = "HTTP from internet"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

# Inbound HTTPS
resource "aws_vpc_security_group_ingress_rule" "web_https" {
  security_group_id = aws_security_group.web.id
  description       = "HTTPS from internet"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

# Optional inbound SSH (strict: only your IP/CIDR)
resource "aws_vpc_security_group_ingress_rule" "web_ssh" {
  count             = var.allow_ssh ? 1 : 0
  security_group_id = aws_security_group.web.id
  description       = "SSH from trusted CIDR"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = var.ssh_cidr
}

# Outbound pentru web: allow all (default e ok, explicit ca sa fie clar)
resource "aws_vpc_security_group_egress_rule" "web_all" {
  security_group_id = aws_security_group.web.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# Security Group pentru RDS (db)
resource "aws_security_group" "db" {
  name        = "${var.name}-sg-db"
  description = "DB SG: allow DB port only from web SG."
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, {
    Name = "${var.name}-sg-db"
    Tier = "db"
  })
}

# Inbound către DB: doar din SG-ul web (EC2)
resource "aws_vpc_security_group_ingress_rule" "db_from_web" {
  security_group_id            = aws_security_group.db.id
  description                  = "DB access from web SG only"
  ip_protocol                  = "tcp"
  from_port                    = var.db_port
  to_port                      = var.db_port
  referenced_security_group_id = aws_security_group.web.id
}

# Outbound DB: allow all (standard)
resource "aws_vpc_security_group_egress_rule" "db_all" {
  security_group_id = aws_security_group.db.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
