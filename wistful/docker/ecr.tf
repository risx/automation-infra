provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "wistful-terraform-state"
    region = "us-west-2"
    key    = "docker-image-ecr.tfstate"
  }
}

data "terraform_remote_state" "wistful" {
  backend = "s3"
  config {
    bucket = "wistful-terraform-state"
    region = "us-west-2"
    key    = "docker-image-ecr.tfstate"
  }
}

resource "aws_ecr_repository" "wistful" {
    name = "wistful"
}