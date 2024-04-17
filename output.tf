output "list_ip_intance" {
    value = [for v in vsphere_virtual_machine.vms :"${v.name} = ${v.guest_ip_addresses[0]}"]
}