resource "kubernetes_namespace" "ns-dp-app" {
  metadata {
    name = "dp-app"
   
    labels = {
      app = "dp-app"
    }
  }
  
  depends_on = [ null_resource.deploy_jenkins ]
}

resource "kubernetes_deployment" "dp-app" {
  metadata {
    name = "dp-app"
    namespace = "${kubernetes_namespace.ns-dp-app.metadata.0.labels.app}"
    labels = {
      "app.kubernetes.io/name" = "${kubernetes_namespace.ns-dp-app.metadata.0.labels.app}"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "${kubernetes_namespace.ns-dp-app.metadata.0.labels.app}"
      }
    }
    template {
      metadata {
        labels = {
         "app.kubernetes.io/name" = "${kubernetes_namespace.ns-dp-app.metadata.0.labels.app}"
        }
      }
      spec {
        container {
          image = "arsalansan/dp-app:latest"
          name  = "${kubernetes_namespace.ns-dp-app.metadata.0.labels.app}"

          port {
            container_port = 80
          }

          # resources {
          #   limits = {
          #     cpu    = "0.5"
          #     memory = "512Mi"
          #   }
          #   requests = {
          #     cpu    = "250m"
          #     memory = "50Mi"
          #   }
          # }
        }
      }
    }
  }

  depends_on = [ kubernetes_namespace.ns-dp-app ]
}
 
resource "kubernetes_service" "srv-dp-app" {
  metadata {
    name = "service-dp-app"
    namespace = "${kubernetes_namespace.ns-dp-app.metadata.0.labels.app}"
  }
  spec {
    selector = {
      "app.kubernetes.io/name" = "${kubernetes_namespace.ns-dp-app.metadata.0.labels.app}"
    }
    #session_affinity = "ClientIP"
    port {
      port = 80
      target_port = 80
    }

    #type = "LoadBalancer"
  }
  
  depends_on = [ kubernetes_namespace.ns-dp-app ]
}

resource "null_resource" "deploy_application_ingress" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/manifests/app/ingress-dp-app.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ kubernetes_namespace.ns-dp-app ]
}