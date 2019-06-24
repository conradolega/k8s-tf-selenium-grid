resource "kubernetes_service" "selenium" {
  metadata {
    name = "selenium"
  }

  spec {
    selector {
      app = "${kubernetes_pod.selenium_hub.metadata.0.labels.app}"
    }

    port {
      port        = 80
      target_port = 4444
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "selenium_hub" {
  metadata {
    name = "selenium-hub"
    labels {
      app = "selenium-hub"
    }
  }

  spec {
    container {
      image = "selenium/hub:3.141.59-radium"
      name  = "selenium-hub"
    }
  }
}

resource "kubernetes_deployment" "selenium_nodes" {
  metadata {
    name = "selenium"
    labels {
      app = "selenium-node"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "selenium-node"
      }
    }

    template {
      metadata {
        labels {
          app = "selenium-node"
        }
      }

      spec {
        container {
          image = "selenium/node-chrome:3.141.59-radium"
          name  = "selenium-node"
          env {
            name  = "HUB_HOST"
            value = "selenium"
          }

          env {
            name  = "HUB_PORT"
            value = "80"
          }
        }
      }
    }
  }
}
