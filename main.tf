terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./network"
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.network.vpc_id
}

module "instances" {
  source             = "./instances"
  public_subnet_id   = module.network.public_subnet_id
  private_subnet_id  = module.network.private_subnet_id
  sg_web_id          = module.security_groups.sg_web_id
  sg_db_id           = module.security_groups.sg_db_id
  sg_backend_id      = module.security_groups.sg_backend_id
  ssh_key_name       = var.ssh_key_name
  ssh_private_key_path = var.ssh_private_key_path
}
