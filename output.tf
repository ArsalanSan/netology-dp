# output "list_ip_intance" {
#     value = [for v in vsphere_virtual_machine.vms :"${v.name} = ${v.guest_ip_addresses[0]}"]
# }

# output "list_master_intance" {
#     value = length(local.vars.vms_workers)
# }