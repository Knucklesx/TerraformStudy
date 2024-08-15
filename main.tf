terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }


  required_version = ">=0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

// resource "O que vai ser criado" "um alias"
resource "aws_instance" "app_server" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  key_name      = "gustavo-nort-virginia"
  tags = {
    Name = "Primeira instancia"
  }

}
