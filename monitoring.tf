resource "null_resource" "monitoring_setup" {
  provisioner "local-exec" {
    command = "kubectl apply --server-side  -f ${path.module}/manifests/kube-prometheus/setup/"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ 
    null_resource.wait_afte_deploy_k8s_cluster,
    helm_release.ingress_nginx
  ]
}

resource "null_resource" "monitoring_wait" {
  provisioner "local-exec" {
    command = "kubectl wait --for condition=Established --all CustomResourceDefinition --namespace=monitoring"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ null_resource.monitoring_setup ]
}

resource "null_resource" "monitoring_deployment" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/manifests/kube-prometheus/"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ null_resource.monitoring_wait ]
}