output "web_sg_id" {
  value       = aws_security_group.web.id
  description = "Security Group ID for EC2 web server."
}

output "db_sg_id" {
  value       = aws_security_group.db.id
  description = "Security Group ID for RDS."
}
