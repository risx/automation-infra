provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-west-2"
}

variable "ami" { default = "ami-db710fa3" } 

resource "aws_security_group" "playground" {
  name        = "playground SG"
  description = "ports wanted/needed for the playground instance"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # maybe later if i ever had a VPN it'd be worth limiting this
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "playground"
    Environment = "dev"
    Created = "timestamp()" 
  }
}

resource "aws_instance" {
    ami             = "${var.ami}"
    instance_type   = "t2.nano"
    count           = 1
    key_name        = "automation"

    vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
    vpc_security_group_ids = ["${aws_security_group.internet.id}"]

    tags = {
        Name = "playground"
        Environment = "dev"
        Created = "timestamp()" 
    }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
    ]
  }
}