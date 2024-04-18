output "list_ip_intance" {
    value = [for v in vsphere_virtual_machine.vms :"${v.name} = ${v.default_ip_address}"]
}