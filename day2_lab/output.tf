output "private_ip_as_list" {
  value = aws_instance.example_instance.*.private_ip
}

output "public_ip_as_list" {
  value = aws_instance.example_instance.*.public_ip
}

output "private_ip" {
  value = aws_instance.example_instance[0].private_ip
}

output "public_ip" {
  value = aws_instance.example_instance[0].public_ip
}