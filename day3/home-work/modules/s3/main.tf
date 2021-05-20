provider "aws" {
  region = var.region
}

// use random_id because the bucket name must be an only vaule in this world.
resource "random_id" "bucket_name_suffix" {
  byte_length = 4
}


resource "aws_s3_bucket" "home_work_bucket" {
  bucket = "terraform-lab-home-work-bucket-${random_id.bucket_name_suffix.hex}"
  acl    = "private"
  tags = {
    Name        = "terraform-lab-home-work-bucket"
    Environment = "terraform-lab-dev"
  }
}