resource "aws_vpc" "assignment1-1-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "assignment1-subnet-1" {
  vpc_id            = aws_vpc.assignment1-1-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-assignment1-subnet-1"
  }
}

resource "aws_subnet" "assignment1-subnet-2" {
  vpc_id            = aws_vpc.assignment1-1-vpc.id
  cidr_block        = var.subnet_2_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-assignment1-subnet-2"
  }
}

resource "aws_subnet" "assignment1-subnet-3" {
  vpc_id            = aws_vpc.assignment1-1-vpc.id
  cidr_block        = var.subnet_3_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-assignment1-subnet-3"
  }
}

resource "aws_internet_gateway" "assignment1-1-igw" {
  vpc_id = aws_vpc.assignment1-1-vpc.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}


resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.assignment1-1-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.assignment1-1-igw.id
  }
  tags = {
    Name = "${var.env_prefix}-main-rtb"
  }
}

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.assignment1-1-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}