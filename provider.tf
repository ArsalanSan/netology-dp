provider "vsphere" {
  user           = var.credential_vcsa.user
  password       = var.credential_vcsa.password
  vsphere_server = var.credential_vcsa.server
 
  allow_unverified_ssl = true
}

provider "helm" {
  kubernetes {
    config_path = pathexpand(var.credential_k8s)
  }
}

# provider "kubernetes" {
#   config_path = pathexpand(var.credential_k8s)
# }