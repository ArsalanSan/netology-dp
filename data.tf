data "vsphere_datacenter" "dc" {
  name = var.env_vcsa.dc
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.env_vcsa.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.env_vcsa.storage
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.env_vcsa.network
  datacenter_id = data.vsphere_datacenter.dc.id
}
 
data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}