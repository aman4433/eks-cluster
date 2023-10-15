output "node_group_name" {
  description = "Name of the EKS node group"
  value       = aws_eks_node_group.public1.node_group_name
}

# Define other outputs as needed
