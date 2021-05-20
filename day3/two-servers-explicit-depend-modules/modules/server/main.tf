provider "aws" {
    region = var.region
}

// This is an AWS resource block that creates an EC2 instance
resource "aws_instance" "server1" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  tags = {
    Name = "module_server1"
    }
}