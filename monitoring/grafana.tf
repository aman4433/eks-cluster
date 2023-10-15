# Create a Kubernetes namespace for Grafana
resource "kubernetes_namespace" "grafana_namespace" {
  metadata {
    name = "grafana"
  }
}

# Define a Grafana deployment and service
resource "kubernetes_deployment" "grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.grafana_namespace.metadata[0].name
  }

  spec {
    # Define your Grafana deployment settings
  }
}

resource "kubernetes_service" "grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.grafana_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.grafana.metadata[0].name
    }

    port {
      port        = 80
      target_port = 3000
    }
  }
}

# Define Grafana data sources, dashboards, and other resources as needed
