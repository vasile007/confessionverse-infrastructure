output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
output "web_sg_id" {
  value = module.security.web_sg_id
}

output "db_sg_id" {
  value = module.security.db_sg_id
}
output "ec2_public_ip" {
  value = module.ec2.public_ip
}
output "rds_endpoint" {
  value = module.rds.endpoint
}
