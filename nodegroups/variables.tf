variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for worker node access"
  type        = string
}

# Define other variables as needed
