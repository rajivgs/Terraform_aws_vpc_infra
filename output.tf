output "vpc_id" {    
    description = "VPC ID: "
  value = var.aws_vpc_value
}

output "private-subnet_id-01" {
  description = "Subnet ID: "  
  value = aws_subnet.private_subnet-01.id
}
output "private-subnet_id-02" {
  description = "Subnet ID: "  
  value = aws_subnet.private_subnet-02.id
}
output "public-subnet_id-01" {
  description = "Subnet ID: "  
  value = aws_subnet.public-subnet-01.id
}
output "public-subnet_id-02" {
  description = "Subnet ID: "  
  value = aws_subnet.public-subnet-02.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.vpc_igt.id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.vpc-ngt.id
}

output "elastic_ip" {
  description = "Elastic IP Address"
  value = aws_eip.elastic_ip.id
}
  