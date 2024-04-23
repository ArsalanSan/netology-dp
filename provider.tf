terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.89.0"
    }
  }

  backend "s3" {
    endpoints = { 
      s3 = "https://storage.yandexcloud.net"
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gqp5blt5vgc3tneeo8/etndrgmimfr3gv0sp4rk"
    }
    bucket     = "dp-s3-bucket"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    
    dynamodb_table    = "table-tfsate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true 
    
  }

  required_version = ">=1.3.0"
}

# provider "yandex" {
#   service_account_key_file = var.sa_key_file
#   cloud_id                 = var.cloud_id
#   folder_id                = var.folder_id
# }

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