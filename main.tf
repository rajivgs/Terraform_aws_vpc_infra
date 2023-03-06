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











# # Creating VPC,name, CIDR and Tags
# resource "aws_vpc" "dev" {
#   cidr_block           = "10.0.0.0/16"
#   instance_tenancy     = "default"

#   tags = {
#     Name = "dev"
#   }
# }

# # Creating Public Subnets in VPC
# resource "aws_subnet" "dev-public-1" {
#   vpc_id                  = aws_vpc.dev.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = "true"
#   availability_zone       = "ap-south-1a"

#   tags = {
#     Name = "dev-public-1"
#   }
# }

# resource "aws_subnet" "dev-public-2" {
#   vpc_id                  = aws_vpc.dev.id
#   cidr_block              = "10.0.2.0/24"
#   map_public_ip_on_launch = "true"
#   availability_zone       = "ap-south-1b"

#   tags = {
#     Name = "dev-public-2"
#   }
# }

# # Creating Internet Gateway in AWS VPC
# resource "aws_internet_gateway" "dev-gw" {
#   vpc_id = aws_vpc.dev.id

#   tags = {
#     Name = "dev"
#   }
# }

# # Creating Route Tables for Internet gateway
# resource "aws_route_table" "dev-public" {
#   vpc_id = aws_vpc.dev.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.dev-gw.id
#   }

#   tags = {
#     Name = "dev-public-1"
#   }
# }

# # Creating Route Associations public subnets
# resource "aws_route_table_association" "dev-public-1-a" {
#   subnet_id      = aws_subnet.dev-public-1.id
#   route_table_id = aws_route_table.dev-public.id
# }

# resource "aws_route_table_association" "dev-public-2-a" {
#   subnet_id      = aws_subnet.dev-public-2.id
#   route_table_id = aws_route_table.dev-public.id
# }
