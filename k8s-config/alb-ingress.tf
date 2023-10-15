# Define Kubernetes resources for ALB Ingress Controller
resource "kubernetes_namespace" "alb_namespace" {
  metadata {
    name = "kube-system"
  }
}

resource "kubernetes_service_account" "alb_sa" {
  metadata {
    name      = "alb-ingress-controller"
    namespace = kubernetes_namespace.alb_namespace.metadata[0].name
  }
}

resource "kubernetes_cluster_role" "alb_role" {
  metadata {
    name = "alb-ingress-controller"
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list", "watch"]
  }
}

# Define the ALB Ingress Controller deployment and service
resource "kubernetes_deployment" "alb_controller" {
  metadata {
    name      = "alb-ingress-controller"
    namespace = kubernetes_namespace.alb_namespace.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "alb-ingress-controller"
      }
    }

    template {
      metadata {
        labels = {
          app = "alb-ingress-controller"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.alb_sa.metadata[0].name

        container {
          name  = "alb-ingress-controller"
          image = "docker.io/amazon/aws-alb-ingress-controller:v1.1.8"  # Use the desired version
          args = ["--ingress-class=alb", "--cluster-name=${var.eks_cluster_name}"]
        }
      }
    }
  }
}

# Define the AWS ALB Ingress Controller service
resource "kubernetes_service" "alb_service" {
  metadata {
    name      = "alb-ingress-controller"
    namespace = kubernetes_namespace.alb_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.alb_controller.metadata[0].name
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}
