output "webserver_url" {
  description = "The webserver public IP"
  value       = join("", ["http://", module.ec2_instance.public_ip[0]])
}