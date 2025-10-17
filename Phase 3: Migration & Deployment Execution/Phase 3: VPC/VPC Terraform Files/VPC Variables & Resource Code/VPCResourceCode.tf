resource "aws_vpc" "mainVPC" {
  tags = {
    Name = var.vpc_name
  }
  cidr_block           = var.cidr
  # region = var.vpc_region
  enable_dns_support   = var.dns
  enable_dns_hostnames = var.dns_hostname
  
}
