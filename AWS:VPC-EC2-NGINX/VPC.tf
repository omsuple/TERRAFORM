resource "aws_vpc" "vpc-01" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC_01"
  }

}

resource "aws_subnet" "pub-sub" {
  vpc_id     = aws_vpc.vpc-01.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "pub-subnet"
  }

}

resource "aws_subnet" "prvt-sub" {
  vpc_id     = aws_vpc.vpc-01.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "prvt-subnet"
  }

}

resource "aws_internet_gateway" "igw-01" {
  vpc_id = aws_vpc.vpc-01.id
  tags = {
    Name = "IGW-1"
  }

}

resource "aws_route_table" "rt-01" {
  vpc_id = aws_vpc.vpc-01.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-01.id
  }

}

resource "aws_route_table_association" "pub-subnet" {
  route_table_id = aws_route_table.rt-01.id
  subnet_id      = aws_subnet.pub-sub.id
