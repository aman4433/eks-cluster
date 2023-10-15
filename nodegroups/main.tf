resource "aws_eks_node_group" "public1" {
  cluster_name    = var.cluster_name
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
