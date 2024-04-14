resource "local_file" "ansible_inventory" {
  content    = templatefile("${path.module}/templates/hosts.tftpl", local.vars )
  filename   = "${abspath(path.module)}/playbook/hosts.yaml"

  depends_on = [ vsphere_virtual_machine.vms ]
}

resource "null_resource" "deploy_k8s_cluster" {
  provisioner "local-exec" {
    command = "ansible-playbook -i '${path.module}'/playbook/hosts.yaml '${path.module}'/playbook/install_k8s.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ local_file.ansible_inventory ]
}

resource "null_resource" "wait_afte_deploy_k8s_cluster" {
  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = [ null_resource.deploy_k8s_cluster ]
}