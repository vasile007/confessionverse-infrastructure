resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.name}-db-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier             = "${var.name}-infrastructure-db"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = var.instance_class
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible     = false
  multi_az                = false
  storage_encrypted       = true
  skip_final_snapshot     = true
  backup_retention_period = 0

  tags = merge(var.tags, {
    Name = "${var.name}-rds"
  })
}
