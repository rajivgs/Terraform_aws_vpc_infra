# Create a VPC 
resource "aws_vpc" "main" {
  cidr_block       = var.aws_vpc_value
  instance_tenancy = "default"

  tags = {
    Name = "Lotus"

  }
}


# Create multiple public subnet for the VPC 

resource "aws_subnet" "public-subnet-01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_public_subnet-01
  availability_zone = "ap-south-1a"
  tags = {
    Name = "public-subnet-01"
  }
}

resource "aws_subnet" "public-subnet-02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_public_subnet-02
  availability_zone = "ap-south-1b"
  tags = {
    Name = "public-subnet-02"
  }
}

# Create multiple private subnet for the VPC

resource "aws_subnet" "private_subnet-01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_private_subnet-01
  availability_zone = "ap-south-1a"
  tags = {
    Name = "private-subnet-01"
  }
}
resource "aws_subnet" "private_subnet-02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_private_subnet-02
  availability_zone = "ap-south-1b"
  tags = {
    Name = "private-subnet-02"
  }
}