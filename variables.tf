
variable "credential_vcsa" {
    description = "Credential for vsphere"
    type        = map(string)
    default     = {
        user     = ""
        password = ""
        server   = ""
    } 
}

variable "env_vcsa" {
    description = "Environment vsphere"
    type        = map(string)
    default     = {
        dc      = ""
        cluster = ""
        storage = ""
        network = ""
    }
}

variable "domain_name" {
  description = ""
  type        = string
  default     = ""
}

variable "credential_k8s" {
  description = "Credential for k8s"
  type        = string
  default     = "~/.kube/config"
}

variable "user" {
    description = "User"
    type        = map(string)
    default     = {
        name       = ""
        public_key = ""
    }
}

variable "template" {
    description = "Template for clone vm"
    type        = string
}

variable "vsphere_folder" {
    description = "Folder for VMs"
    type        = string
    default     = "/K8S"
}

variable "vms" {
    description = "Sitings VMs"
    type        = list(object({
        name         = string
        ipv4_address = string
        ipv4_netmask = string
        ipv4_gateway = string
        dns1         = string
        num_cpus     = number
        memory       = number
        size_disk    = number
    }))
    default = [
      {
        name         = "master01"
        ipv4_address = "10.122.207.2"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 2
        memory       = 4096
        size_disk    = 60
      },
      {
        name         = "master02"
        ipv4_address = "10.122.207.3"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 2
        memory       = 4096
        size_disk    = 60
      },
      {
        name         = "master03"
        ipv4_address = "10.122.207.4"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 2
        memory       = 4096
        size_disk    = 60
      },            
      {
        name         = "worker01"
        ipv4_address = "10.122.207.5"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 4
        memory       = 8192
        size_disk    = 80 
      },
      {
        name         = "worker02"
        ipv4_address = "10.122.207.6"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 4
        memory       = 8192
        size_disk    = 80 
      },
      {
        name         = "worker03"
        ipv4_address = "10.122.207.7"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 4
        memory       = 8192
        size_disk    = 80 
      },
      {
        name         = "jenkins01"
        ipv4_address = "10.122.207.9"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 4
        memory       = 8192
        size_disk    = 80
      },
      {
        name         = "lbnode01"
        ipv4_address = "10.122.207.10"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 2
        memory       = 2048
        size_disk    = 30
      },
      {
        name         = "nfs01"
        ipv4_address = "10.122.207.14"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 2
        memory       = 2048
        size_disk    = 400
      },
      {
        name         = "nfs02"
        ipv4_address = "10.122.207.13"
        ipv4_netmask = "28"
        ipv4_gateway = "10.122.207.1"
        dns1         = "77.88.8.1"
        num_cpus     = 2
        memory       = 2048
        size_disk    = 400
      }
    ]
}