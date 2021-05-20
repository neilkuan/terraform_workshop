
provider "aws" {
  region = var.region
}


module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

data "aws_ssm_parameter" "linux_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_security_group" "web_server_sg" {
  name        = join("_", ["web_server", "module.vpc.vpc_id", "sg"])
  description = "Allow web server  inbound traffic"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = var.rules
    content {
      description = join(" ", [ingress.value["port"], "from VPC"])
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]

    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = join("_", ["web_server", "module.vpc.vpc_id", "sg"])
  }
  depends_on = [module.vpc.vpc_id]
}


resource "aws_instance" "web_server" {
  ami             = data.aws_ssm_parameter.linux_ami.value
  instance_type   = "t2.micro"
  subnet_id       = module.vpc.subnet_id
  security_groups = [aws_security_group.web_server_sg.id]
  tags = {
    Name = "${terraform.workspace}-example-web-server"
  }
  user_data = fileexists("./scripts.sh") ? file("./scripts.sh") : null
}

resource "aws_instance" "remote-server" {
  ami             = "ami-2757f631"
  instance_type   = "t2.micro"
  subnet_id       = module.vpc.subnet_id
  security_groups = [aws_security_group.web_server_sg.id]
  key_name        = "student"
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y && sudo apt-get install -y apache2 && sudo systemctl start apache2",
      "echo '<h1>this is the Cathay Lab test page</h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/student.pem")
      host        = self.public_ip
    }
  }
  tags = {
    Name = "${terraform.workspace}-example-web-server-remote-exec"
  }

}