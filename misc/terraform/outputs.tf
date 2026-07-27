# l'inventaire ansible utilise la patte tailscale (10.10.10.x)
locals {
  haproxy_hosts = [for k, v in local.dmz_vms : "${k} ansible_host=${v.tsa_ip}" if v.role == "haproxy"]
  web_hosts     = [for k, v in local.dmz_vms : "${k} ansible_host=${v.tsa_ip}" if v.role == "web"]
}

output "dmz_vms" {
  value = {
    for k, vm in proxmox_virtual_environment_vm.dmz : k => {
      vmid    = vm.vm_id
      name    = vm.name
      ip      = local.dmz_vms[k].ip
      mgmt_ip = local.dmz_vms[k].mgmt_ip
      tsa_ip  = local.dmz_vms[k].tsa_ip
      role    = local.dmz_vms[k].role
    }
  }
}

# terraform output -raw ansible_inventory > ../ansible/inventory.ini
output "ansible_inventory" {
  value = join("\n", concat(
    ["[haproxy]"], local.haproxy_hosts,
    ["", "[web]"], local.web_hosts,
    ["", "[dmz:children]", "haproxy", "web"],
    ["", "[dmz:vars]", "ansible_user=${var.ci_user}", ""]
  ))
}
