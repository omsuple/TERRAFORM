resource "aws_instance" "EC2-nginx" {
  ami                         = "ami-0fff1b9a61dec8a5f"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.pub-sub.id
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true
  user_data                   = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF

  tags = {
    Name = "EC2-nginx-server"
  }
}
