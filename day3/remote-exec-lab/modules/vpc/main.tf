provider "aws" {
  region = var.region
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "example_vpc"
  }
}

resource "aws_subnet" "example_subnet_1" {
  vpc_id = aws_vpc.example_vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "example_vpc_example_subnet_1"
  }
}

resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "example_vpc_igw"
  }
}

resource "aws_route_table_association" "example_a_igw" {
  subnet_id      = aws_subnet.example_subnet_1.id
  route_table_id = aws_vpc.example_vpc.main_route_table_id
}

resource "aws_route" "r_igw" {
  route_table_id            = aws_vpc.example_vpc.main_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.example_igw.id
  depends_on                = [aws_route_table_association.example_a_igw]
}
