module "vpc" {
  source = "./modules/vpc"

  name                 = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  tags                 = var.tags
}
module "security" {
  source = "./modules/security"

  name      = var.project_name
  vpc_id    = module.vpc.vpc_id
  db_port   = var.db_port
  allow_ssh = var.allow_ssh
  ssh_cidr  = var.ssh_cidr
  tags      = var.tags
}
module "ec2" {
  source = "./modules/ec2"

  name              = var.project_name
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security.web_sg_id
  tags              = var.tags
}
module "rds" {
  source = "./modules/rds"

  name              = var.project_name
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security.db_sg_id
  db_password       = var.db_password
  tags              = var.tags
}
