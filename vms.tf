resource "vsphere_virtual_machine" "vms" {
  for_each = { for k,v in var.vms: v.name => v }
  name             = each.value.name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vsphere_folder
  num_cpus  = each.value.num_cpus
  memory    = each.value.memory
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
 
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
 
  disk { 
    label            = "disk-${each.value.name}"
    size             = each.value.size_disk
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
 
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = "false"
  }
  
  extra_config = {
    "guestinfo.metadata"          = base64encode(templatefile("${path.module}/templates/metadata.yaml", 
        { host_name = each.value.name, ipv4_address = each.value.ipv4_address, ipv4_netmask = each.value.ipv4_netmask, 
          ipv4_gateway = each.value.ipv4_gateway, dns1 = each.value.dns1, domain_name = var.domain_name }))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile("${path.module}/templates/userdata.yaml", { name = var.user.name, public_key = var.user.public_key }))
    "guestinfo.userdata.encoding" = "base64"
  }
  # lifecycle {
  #   ignore_changes = [
  #     annotation,
  #     clone[0].template_uuid,
  #     clone[0].customize[0].dns_server_list,
  #     clone[0].customize[0].network_interface[0]
  #   ]
  # }
}