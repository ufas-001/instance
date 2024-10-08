provider "aws" {
  region = "us-east-1"
}
# Backend Configuration
terraform {
  backend "s3" {
    bucket         = "myinstance-tf-state-bucket"
    key            = "instance-server/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
data "aws_vpc" "main" {
  default = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name = "Ec2key"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    # Allow SSH from anywhere
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    # Allow SSH from anywhere
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    # Allow SSH from anywhere
  }

  ingress {
    from_port = 8443
    to_port = 8443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    # Allow SSH from anywhere
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}

