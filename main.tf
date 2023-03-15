# Create a VPC 
resource "aws_vpc" "main" {
  cidr_block       = var.aws_vpc_value
  instance_tenancy = "default"

  tags = {
    Name        = "Lotus"
    "procenter" = local.procenter

  }
}

# Create multiple public subnet for the VPC
resource "aws_subnet" "public-subnet-01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_public_subnet-01
  availability_zone = "ap-south-1a"
  tags = {
    Name        = "public-subnet-01"
    "procenter" = local.procenter

  }
}

resource "aws_subnet" "public-subnet-02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_public_subnet-02
  availability_zone = "ap-south-1b"
  tags = {
    Name        = "public-subnet-02"
    "procenter" = local.procenter

  }
}

# Create multiple private subnet for the VPC
resource "aws_subnet" "private_subnet-01" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_private_subnet-01
  availability_zone = "ap-south-1a"
  tags = {
    Name        = "private-subnet-01"
    "procenter" = local.procenter

  }
}
resource "aws_subnet" "private_subnet-02" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_private_subnet-02
  availability_zone = "ap-south-1b"
  tags = {
    Name        = "private-subnet-02"
    "procenter" = local.procenter

  }
}

# Create the Internet Gateway for the VPC 
resource "aws_internet_gateway" "vpc_igt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "IGT"
    "procenter" = local.procenter
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
    Name        = "Public-RT"
    "procenter" = local.procenter

  }
}


# Create the ElaticIP Address
resource "aws_eip" "elastic_ip" {
  vpc = true
  tags = {
    "Name"      = "Elastic_IP"
    "procenter" = local.procenter

  }
}


# Create the NAT Gateway for the VPC
resource "aws_nat_gateway" "vpc_ngt" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public-subnet-01.id
  tags = {
    "Name"      = "NGT"
    "procenter" = local.procenter

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
    Name        = "Private-RT"
    "procenter" = local.procenter

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
  subnet_id      = aws_subnet.private_subnet-01.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private_route_table_assocation_2" {
  subnet_id      = aws_subnet.private_subnet-02.id
  route_table_id = aws_route_table.private-route-table.id
}



# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"]
# }


# resource "aws_instance" "web" {
# 	ami = data.aws_ami.ubuntu.id
# 	instance_type = "t2.micro" 
#   key_name = "rajiv"
#   count = 1
#   subnet_id  = aws_subnet.public-subnet-01.id
#   associate_public_ip_address = true
# 	tags = {
# 		"Name" = "HelloWorld"
#     "procenter" = "true"
    	
# 	}
# }ami-0d81306eddc614a45

# resource "aws_security_group" "example" {
#   name        = "de-mo"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#     "procenter" = "true"
#   }
# }

resource "aws_security_group" "example" {
  # ... other configuration ...
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


}
resource "aws_instance" "t2_micro" {
  ami = "ami-0d81306eddc614a45"
  instance_type = "t2.micro"
  key_name = "bishnu"
  vpc_security_group_ids = [aws_security_group.example.id]
  count = 1
  availability_zone = "ap-south-1a"
  subnet_id =  aws_subnet.public-subnet-01.id
  associate_public_ip_address = true
  tags = {
    "Name" = "Demo"
    "procenter"  = "true"
  }
}

