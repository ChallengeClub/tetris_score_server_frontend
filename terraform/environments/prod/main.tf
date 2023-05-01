terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" { # created s3 bucket on aws cconsole
    bucket  = "tetris-hosting-terraform-state-prod"
    region  = "ap-northeast-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "resources" {
  source = "../../resources"
  tetris_hostzone_subdomain = var.tetris_hostzone_subdomain
}

variable "tetris_hostzone_subdomain" {
  type = string
  sensitive = true
}