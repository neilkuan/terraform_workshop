provider "aws" {
  region = var.region
}

module "s3" {
  source = "./modules/s3"
  region = var.region
}