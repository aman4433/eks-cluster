variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = InsightsEKS
}

variable "ssh_public_key" {
  description = "SSH public key for worker node access"
  type        = string
}

# Define other variables as needed
