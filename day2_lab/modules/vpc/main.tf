resource "aws_vpc" "module_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "module-vpc"
  }
}

resource "aws_subnet" "module_subnet_1" {
  vpc_id = aws_vpc.module_vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "module-vpc-subnet-1"
  }
}
