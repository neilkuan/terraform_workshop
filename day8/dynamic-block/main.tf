provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "terraform-vpc"
  cidr               = "10.0.0.0/16"
  azs                = data.aws_availability_zones.available.names
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway = false
  enable_vpn_gateway = false
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


locals {
  user_data = <<EOF
#!/bin/bash
sudo yum -y install httpd
sudo systemctl start httpd && sudo systemctl enable httpd
echo '<h1><center>This is our Cathay Bootcamp Website</center></h1>' > index.html
sudo mv index.html /var/www/html/
EOF
}

locals {
  rules = [{
   description      = "TLS from VPC",
   from_port        = 443,
   to_port          = 443,
   protocol         = "tcp",
   cidr_blocks      = ["0.0.0.0/0"]
  },{
    description      = "TPC from VPC",
    from_port        = 80,
    to_port          = 80,
    protocol         = "tcp",
    cidr_blocks      = ["0.0.0.0/0"]
  }]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id


  dynamic "ingress" {
    for_each = local.rules
    content {
      description      = ingress.value.description
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_instance" "dynamic_instance"{
  associate_public_ip_address = true
  ami                         = data.aws_ssm_parameter.linux_ami.value
  instance_type               = "t2.micro"
  security_groups          = [aws_security_group.allow_tls.id]
  subnet_id                   = module.vpc.public_subnets[0]
  user_data_base64            = base64encode(local.user_data)
  tags = {
    Name = "SG-Server"
  }
}