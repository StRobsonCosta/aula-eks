resource "kubernetes_deployment" "Django-API" {
  metadata {
    name = "django-api"
    labels = {
      nome = "django"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        nome = "django"
      }
    }

    template {
      metadata {
        labels = {
          nome = "django"
        }
      }

      spec {
        container {
          //image = "266735828008.dkr.ecr.us-east-2.amazonaws.com/producao:V1"
          image = "strobson/producao:V1"
          name  = "django"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/clientes/"
              port = 8000
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
    metadata {
        name = "load-balancer-django-api"
    }
    spec {
        selector = {        
            nome = "django"        
        }
        port {
            port = 8000
            target_port = 8000
        }
        type = "LoadBalancer"
    }
}


