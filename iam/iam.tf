# Associate the IAM OIDC provider with your EKS cluster
resource "aws_eks_cluster" "my_cluster" {
  name = var.eks_cluster_name
}

resource "aws_eks_cluster_auth" "my_cluster" {
  name = aws_eks_cluster.my_cluster.name
}

resource "aws_iam_oidc_provider" "eks_oidc" {
  url = aws_eks_cluster_auth.my_cluster.identifiers[0]
  client_id_list = ["sts.amazonaws.com"]
}

# Define an IAM role for the EKS cluster to assume
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity",
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_oidc_provider.eks_oidc.arn
        },
        Condition = {
          StringEquals = {
            "${aws_iam_oidc_provider.eks_oidc.arn}:sub" = "system:serviceaccount:kube-system:eks-cluster"
          }
        }
      }
    ]
  })
}

# Define an IAM policy for EBS access (based on your provided policy)
resource "aws_iam_policy" "ebs_access_policy" {
  name        = "EBSAccessPolicy"
  description = "Policy for EBS access"
  policy      = file("policies/ebs-access-policy.json") # Path to the JSON policy file
}

# Attach the EBS access policy to the EKS cluster role
resource "aws_iam_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = aws_iam_policy.ebs_access_policy.arn
  roles      = [aws_iam_role.eks_cluster_role.name]
}
