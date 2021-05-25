provider "aws" {
  region = "us-east-1"
}

// get the az in this region
data "aws_availability_zones" "available" {
  state = "available"
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
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"
  name   = "terraform_cloud_sg"
  vpc_id = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  // let ec2 instance to outside install package  
  egress_with_cidr_blocks      = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

data "aws_ssm_parameter" "linux_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
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

module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 2.0"
  associate_public_ip_address = true
  name                        = "terraform-demo-cloud"
  ami                         = data.aws_ssm_parameter.linux_ami.value
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [module.security_group.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  user_data_base64            = base64encode(local.user_data)
}