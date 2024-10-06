resource "aws_security_group" "nginx-sg" {
  vpc_id = aws_vpc.vpc-01.id

  #inbound rule for HTTP
  ingress  {
    from_port  = 80
    to_port    = 80
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  

  #outbound rule
  egress  {
    from_port  = 0 # 0 means it is enabled for any port
    to_port    = 0
    protocol   = "-1" # -1 means any protocol is valid or enabled for traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }

}
