resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "${path.module}/manifests/"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  create_namespace = true
  #version    = "v4.6.0"
  values =[
    templatefile("${path.module}/templates/ingress-values.yaml",{
      replicas = length(local.vars.vms_workers)
    })
  ]

  depends_on = [ null_resource.deploy_k8s_cluster ]
}