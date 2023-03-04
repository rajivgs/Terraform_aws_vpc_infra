variable "aws_vpc_value" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.55.0.0/16"
}


variable "aws_public_subnet-01" {
  type        = string
  description = "CIDR block for the public subnet 01"
  default     = "10.55.1.0/24"
}

variable "aws_public_subnet-02" {
  type        = string
  description = "CIDR block for the public subnet 01"
  default     = "10.55.2.0/24"
}

variable "aws_private_subnet-01" {
  type        = string
  description = "CIDR block for the private subnet 01"
  default     = "10.55.3.0/24"
}

variable "aws_private_subnet-02" {
  type        = string
  description = "CIDR block for the private subnet 02"
  default     = "10.55.4.0./24"

}