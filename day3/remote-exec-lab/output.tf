output "private_ip" {
  value = aws_instance.web_server.private_ip
}

output "public_ip_web_server" {
  value = "http://${aws_instance.web_server.public_ip}"
}

output "public_ip_web_server_remote" {
  value = "http://${aws_instance.remote-server.public_ip}"
}