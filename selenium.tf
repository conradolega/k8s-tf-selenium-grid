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
