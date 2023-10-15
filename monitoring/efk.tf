# Create a Kubernetes namespace for Elasticsearch
resource "kubernetes_namespace" "elasticsearch_namespace" {
  metadata {
    name = "elasticsearch"
  }
}

# Define an Elasticsearch StatefulSet and service
resource "kubernetes_stateful_set" "elasticsearch" {
  metadata {
    name      = "elasticsearch"
    namespace = kubernetes_namespace.elasticsearch_namespace.metadata[0].name
  }

  spec {
    # Define your Elasticsearch StatefulSet settings
  }
}

resource "kubernetes_service" "elasticsearch" {
  metadata {
    name      = "elasticsearch"
    namespace = kubernetes_namespace.elasticsearch_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_stateful_set.elasticsearch.metadata[0].name
    }

    port {
      port        = 9200
      target_port = 9200
    }
  }
}

# Define Elasticsearch persistent volume claims and other resources as needed
