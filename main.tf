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
  # user_data     = <<-EOF
  #                 #!/bin/bash
  #                       cd /home/ubuntu
  #                       echo "<h1>Feito com Terraform</h1>" > index.html
  #                       nohup busybox httpd -f -p 8080 &
  #                 EOF



  tags = {
    Name = "Terraform Ansible Python 2"
  }

}
