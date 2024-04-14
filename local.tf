locals {
    vars = { 
        vms_masters = { for k, v in vsphere_virtual_machine.vms : k => v if startswith(k,"master") },
        vms_workers = { for k, v in vsphere_virtual_machine.vms : k => v if startswith(k,"worker") },
        vms_lbnodes = { for k, v in vsphere_virtual_machine.vms : k => v if startswith(k,"lbnode") },
        vms_volumes = { for k, v in vsphere_virtual_machine.vms : k => v if startswith(k,"nfs") },
        vms_devtools = { for k, v in vsphere_virtual_machine.vms : k => v if startswith(k,"jenkins") },
        user = var.user.name
    }
}