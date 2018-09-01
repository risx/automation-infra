provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "wistful-terraform-state"
    region = "us-west-2"
    key    = "dynamodb-dev.tfstate"
  }
}

data "terraform_remote_state" "wistful" {
  backend = "s3"
  config {
    bucket = "wistful-terraform-state"
    region = "us-west-2"
    key    = "dynamodb-dev.tfstate"
  }
}

resource "aws_dynamodb_table" "Wistful" {
  name           = "Wistful"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "id"

  attribute {
    name = "id"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled = false
  }

  tags {
    Name        = "wistful"
    Environment = "dev"
  }
}