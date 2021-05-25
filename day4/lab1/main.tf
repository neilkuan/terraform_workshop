provider "aws" {
  region  = "us-east-1"
}

module "ec2_with_mandatory_tagging" {
  source  = "github.com/cloudtp/hello-terraform-module"

  // Lab Task: Read the module code at https://github.com/cloudtp/hello-terraform-module
  // to set the required input parameter
  // INSERT_ARGUMENT
  Name = "Hello_Terraform_Module"
  user_id = "hello_terraform_module"
  EndDate = timeadd(timestamp(), "240h")
  size = "small"
}