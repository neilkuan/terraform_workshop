data "aws_ssm_parameter" "linux_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

// get the az in this region
data "aws_availability_zones" "available" {
  state = "available"
}
