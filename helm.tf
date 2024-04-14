resource "null_resource" "csi_driver_nfs" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/manifests/nfs/rbac-csi-nfs.yaml -f ${path.module}/manifests/nfs/csi-nfs-driverinfo.yaml -f ${path.module}/manifests/nfs/csi-nfs-controller.yaml -f ${path.module}/manifests/nfs/csi-nfs-node.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ null_resource.deploy_k8s_cluster ]
}

resource "local_file" "storage_class" {
  content    = templatefile("${path.module}/templates/sc-nfs.tftpl", { nfs_server = local.vars.vms_volumes["nfs01"].guest_ip_addresses[0] } )
  filename   = "${abspath(path.module)}/manifests/nfs/sc-nfs.yaml"

  //depends_on = [ helm_release.csi_driver_nfs ]
  depends_on = [ null_resource.csi_driver_nfs ]
}

resource "null_resource" "storage_class" {
  provisioner "local-exec" {
    command = "kubectl apply -f '${path.module}'/manifests/nfs/sc-nfs.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ local_file.storage_class ]
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
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