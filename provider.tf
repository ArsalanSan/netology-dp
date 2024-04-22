terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.89.0"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "dp-s3-bucket"
    region     = "ru-central1"
    key        = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gqp5blt5vgc3tneeo8/etndrgmimfr3gv0sp4rk"
    dynamodb_table    = "table-tfstate"
  }

  required_version = ">=1.3.0"
}

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

provider "kubernetes" {
  config_path = pathexpand(var.credential_k8s)
}

# provider "kubectl" {
#   load_config_file       = false
# }