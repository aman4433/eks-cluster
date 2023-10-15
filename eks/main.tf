resource "aws_eks_cluster" "my_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = concat(aws_subnet.public_subnet_a[*].id, aws_subnet.public_subnet_b[*].id)
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}

resource "aws_eks_node_group" "public1" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "public1"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.public_subnet_a[*].id
  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 4
  }
  instance_types = ["t3.medium"]
  remote_access {
    ec2_ssh_key = var.ssh_public_key
  }
  tags = {
    Name = "public1"
  }
}

# Define other node groups as needed

# Define IAM roles, security groups, etc. here

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.my_cluster.endpoint
}
