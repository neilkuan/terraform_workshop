provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "my_terraform_remote_module" {
  source  = "app.terraform.io/cathaydemo/lab/module"
  version = "1.0.0"
  region = "us-east-1"
  instance_count = 2
  server_name = "my_remote_module_server"
  instance_az       = data.aws_availability_zones.available.names[1]
  instance_type = "t3.micro"
}

module "my_terraform_remote_module" {
  source = "github.com/neilkuan/terraform-module-lab"
  region = "us-east-1"
  instance_count = 2
  server_name = "my_remote_module_server"
  instance_az       = "us-east-1a"
  instance_type = "t3.micro"
}
