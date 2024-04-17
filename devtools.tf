resource "null_resource" "deploy_jenkins" {
  provisioner "local-exec" {
    command = "ansible-playbook -i '${path.module}'/playbook/hosts.yaml '${path.module}'/playbook/jenkins.yaml"
  }

  triggers = {
      always_run = "${timestamp()}"
  }

  depends_on = [ null_resource.monitoring_deployment ]
}