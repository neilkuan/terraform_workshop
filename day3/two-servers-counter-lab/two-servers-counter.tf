// This is an AWS provider block
provider "aws" {
    region = "us-east-1"
}

// This is an AWS resource block that creates an EC2 instance
// Notice that this creates multiple instances, but does not show multiple servers in the graph
resource "aws_instance" "server1" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  count         = 3
  tags = {
    Name = "${count.index}"
  }
}

output "instance_ip_addr" {
  value = aws_instance.server1[*].private_ip
}