provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

// find amazon linux 2 latest ami id from aws ssm parameter
data "aws_ssm_parameter" "linux_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "example_instance" {
  ami           = data.aws_ssm_parameter.linux_ami.value
                  // use module "vpc" output resource id == subnet_id.
  subnet_id     = module.vpc.subnet_id
  instance_type = "t2.micro"
                  // if terraform workspace is "test" create 3 instances, other workspace create 2  instances.
  count         = terraform.workspace == "test" ? 3 : 2
  tags = {
    Name      = "web-server-${terraform.workspace}"
    Workspace = terraform.workspace
  }
}