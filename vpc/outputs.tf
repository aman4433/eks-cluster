output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "vpc_name" {
  description = "Name of the VPC"
  value       = aws_vpc.my_vpc.tags.Name
}
