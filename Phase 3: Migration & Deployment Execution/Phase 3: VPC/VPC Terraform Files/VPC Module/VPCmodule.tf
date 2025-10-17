terraform {
  backend "s3" {
    bucket       = "fphn-terraform-state-bucket"    # REPLACE WITH YOUR BUCKET NAME
    key          = "fphn-backend/terraform.tfstate" #WHERE THE STATE FILE IS WRITTEN TO
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.16.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "east1"

}

provider "aws" {
  region = "us-east-2"
  alias  = "east2"

}


# Modules To Deploy the main and management VPCs
# Main Hospital Site VPC

module "mainVPC" {
  source = "C:/Users/fisir/Terraform/FPHNTerraform/VPC/VPCSetup/VPCDefinitions"

  # Input Variables
  vpc_name = "Main Hospital Site VPC"
  cidr     = "10.0.0.0/16"
  providers = {
    aws = aws.east1
  }
}

# Management Site VPC

module "managementVPC" {
  source = "C:/Users/fisir/Terraform/FPHNTerraform/VPC/VPCSetup/VPCDefinitions"

  # Input Variables
  vpc_name = "Management Site VPC"
  cidr     = "10.2.0.0/16"
  providers = {
    aws = aws.east1
  }
}

# Disaster Recovery Site VPC

module "DRVPC" {
  source = "C:/Users/fisir/Terraform/FPHNTerraform/VPC/VPCSetup/VPCDefinitions"

  # Input Variables
  vpc_name = "Disaster Recovery Site VPC"
  cidr     = "10.1.0.0/16"
  providers = {
    aws = aws.east2
  }
}
