output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.my_cluster.endpoint
}

# Define other outputs as needed
