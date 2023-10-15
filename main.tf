provider "aws" {
  region = "us-east-2"  # Specify your desired AWS region
}

# Include submodule configurations
module "vpc" {
  source = "./vpc"
}

module "eks" {
  source = "./eks"
  # Pass variables as needed
  eks_cluster_name = module.vpc.vpc_name
  vpc_id = module.vpc.vpc_id
  # Add other variables
}

# Define outputs
output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
