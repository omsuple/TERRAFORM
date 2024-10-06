output "instance-public-ip" {
  description = "This is public IP of the Instance(nginx-server)"
  value       = aws_instance.EC2-nginx.public_ip


}

output "URL" {
  description = "This is the URL of the server"
  value       = "http://${aws_instance.EC2-nginx.public_ip}"

}
