resource "null_resource" "deploy_application_namespace" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/manifests/app/namespace-dp-app.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ null_resource.deploy_jenkins ]
}

resource "null_resource" "deploy_application_svc_dp" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/manifests/app/service-dp-app.yaml -f ${path.module}/manifests/app/deployment-dp-app.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ null_resource.deploy_application_namespace ]
}

resource "null_resource" "deploy_application_ingress" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/manifests/app/ingress-dp-app.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ null_resource.deploy_application_namespace ]
}