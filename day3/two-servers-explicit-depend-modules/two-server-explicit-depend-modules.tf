// Create an explicit dependency on a resource

// This is an AWS provider block
provider "aws" {
    region = "us-east-1"
}

module "server" {
  source = "./modules/server"
  region = "us-east-1"
}


// This is an AWS resource block that creates an EC2 instance
resource "aws_instance" "server2" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  tags = {
    Name = "server2"
  }
}

resource "aws_instance" "server3" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  tags = {
    Name = "server3"
  }
  // Explicitly create a dependency. server2 module.server1 and must exist before server3 can be created
  depends_on    = [aws_instance.server2, module.server]
}
