output "security_group_id" {
  description = "ID of the EKS cluster security group"
  value       = aws_security_group.eks_cluster_sg.id
}

# Define other outputs as needed
