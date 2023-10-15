
variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# Define other variables as needed
