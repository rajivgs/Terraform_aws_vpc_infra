output "vpc_id" {
  description = "VPC ID: "
  value       = var.aws_vpc_value
}

output "private-subnet_id-01" {
  description = "Subnet ID: "
  value       = aws_subnet.private_subnet-01.id
}
output "private-subnet_id-02" {
  description = "Subnet ID: "
  value       = aws_subnet.private_subnet-02.id
}
output "public-subnet_id-01" {
  description = "Subnet ID: "
  value       = aws_subnet.public-subnet-01.id
}
output "public-subnet_id-02" {
  description = "Subnet ID: "
  value       = aws_subnet.public-subnet-02.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID: "
  value = aws_internet_gateway.vpc_igt.id
}

output "public_route_table" {
  description = "Public Route Table: "
  value = aws_route_table.public-route-table
}

output "private_route_table" {
    description = "Private Route Table: "
  value = aws_route_table.private-route-table
}

output "nat_gateway_id" {
    description = "NAT Gateway ID: "
  value = aws_nat_gateway.vpc_ngt.id
}

output "elastic_ip" {
  description = "Elastic IP Address"
  value       = aws_eip.elastic_ip.id
}
  