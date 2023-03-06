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

# Create the Internet Gateway for the VPC 
resource "aws_internet_gateway" "vpc_igt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGT"
  }
}

# Create the Route Table for Internet Gateway
#public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igt.id
  }
  tags = {
    Name = "Public-RT"
  }
}


# Create the ElaticIP Address
resource "aws_eip" "elastic_ip" {
  vpc = true
}


# Create the NAT Gateway for the VPC
resource "aws_nat_gateway" "vpc_ngt" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public-subnet-01.id
  tags = {
    "Name" = "NGT"
  }
}

#private route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc_ngt.id

  }
  tags = {
    Name = "Private-RT"
  }
}

# Creating Route Assoication Public Subnet
resource "aws_route_table_association" "public_route_table_assocation_1" {
  subnet_id      = aws_subnet.public-subnet-01.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public_route_table_assocation_2" {
  subnet_id      = aws_subnet.public-subnet-02.id
  route_table_id = aws_route_table.public-route-table.id

}

# Creating Route Assoication Private Subnet
 resource "aws_route_table_association" "private_route_table_assocation_1" {
  subnet_id = aws_subnet.private_subnet-01.id
  route_table_id = aws_route_table.private-route-table.id 
 }

 resource "aws_route_table_association" "private_route_table_assocation_2" {
   subnet_id = aws_subnet.private_subnet-02.id
   route_table_id = aws_route_table.private-route-table.id
 }
