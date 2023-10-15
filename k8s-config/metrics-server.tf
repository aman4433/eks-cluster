# Use kubectl to apply the Metrics Server add-on
resource "null_resource" "apply_metrics_server" {
  triggers = {
    cluster_name = var.eks_cluster_name
  }

  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/deploy/1.8+/metrics-server-deployment.yaml"
  }
}
