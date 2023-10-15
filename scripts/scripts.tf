# Run a script on your EKS cluster using a null_resource
resource "null_resource" "run_script" {
  triggers = {
    cluster_name = var.eks_cluster_name
  }

  provisioner "local-exec" {
    command = <<EOT
      #!/bin/bash
      kubectl apply -f /path/to/your/script.yaml
    EOT

    working_dir = "${path.module}/scripts"
  }
}
