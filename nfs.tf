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

  depends_on = [ null_resource.csi_driver_nfs ]
}

resource "null_resource" "storage_class" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/manifests/nfs/sc-nfs.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ local_file.storage_class ]
}