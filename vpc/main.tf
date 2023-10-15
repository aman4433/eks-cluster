resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "InsightsEKS-VPC"
  }
}

resource "aws_subnet" "public_subnet_a" {
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = cidrsubnet(aws_vpc.my_vpc.cidr_block, 8, count.index)
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-${count.index}"
  }
}

resource "aws_subnet" "public_subnet_b" {
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = cidrsubnet(aws_vpc.my_vpc.cidr_block, 8, count.index + 2)
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-${count.index + 2}"
  }
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "vpc_name" {
  description = "Name of the VPC"
  value       = aws_vpc.my_vpc.tags.Name
}
