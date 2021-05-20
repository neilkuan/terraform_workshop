output "vpc_id" {
  value = aws_vpc.module_vpc.id
}

output "subnet_id" {
  value = aws_subnet.module_subnet_1.id
}