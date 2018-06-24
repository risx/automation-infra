provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-west-2"
}

variable "ami" "ami-db710fa3" 


resource "aws_instance" {
    ami             = "${var.ami}"
    instance_type   = "t2.nano"
    count           = 1
    key_name        = "risx"

    tags = {
        Name = "playground"
        Environment = "dev"
        Created = "timestamp()" 
    }
}