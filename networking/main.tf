# Create a security group for the EKS cluster
resource "aws_security_group" "eks_cluster_sg" {
  name_prefix   = "eks-cluster-sg-"
  description   = "Security group for the EKS cluster"
  vpc_id       = module.vpc.vpc_id  # Use the VPC created in the VPC module
}

# Create the necessary route table(s) and associate them with subnets
resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "Public-Route-Table"
  }
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = aws_subnet.public_subnet_a[0].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_b" {
  subnet_id      = aws_subnet.public_subnet_b[0].id
  route_table_id = aws_route_table.public.id
}
