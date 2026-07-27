# Les 5 VM de la DMZ, 3 interfaces chacune :
# net0 DMZ (prod), net1 management, net2 tailscale (temporaire le temps du build)
locals {
  dmz_vms = {
    "prs-rvp-01" = { vmid = 911, ip = "10.9.175.10", mgmt_ip = "10.9.99.110", tsa_ip = "10.10.10.10", role = "haproxy", cores = 2, memory = 2048, disk = 20 }
    "prs-rvp-02" = { vmid = 912, ip = "10.9.175.11", mgmt_ip = "10.9.99.111", tsa_ip = "10.10.10.11", role = "haproxy", cores = 2, memory = 2048, disk = 20 }
    "prs-web-01" = { vmid = 913, ip = "10.9.175.20", mgmt_ip = "10.9.99.120", tsa_ip = "10.10.10.20", role = "web", cores = 1, memory = 1536, disk = 20 }
    "prs-web-02" = { vmid = 914, ip = "10.9.175.21", mgmt_ip = "10.9.99.121", tsa_ip = "10.10.10.21", role = "web", cores = 1, memory = 1536, disk = 20 }
    "prs-web-03" = { vmid = 915, ip = "10.9.175.22", mgmt_ip = "10.9.99.122", tsa_ip = "10.10.10.22", role = "web", cores = 1, memory = 1536, disk = 20 }
  }
}

resource "proxmox_virtual_environment_vm" "dmz" {
  for_each = local.dmz_vms

  name      = "${var.vm_name_prefix}-${upper(each.key)}"
  node_name = var.node_name
  pool_id   = var.pool_id
  vm_id     = each.value.vmid

  on_boot         = true
  stop_on_destroy = true

  cpu {
    cores = each.value.cores
    type  = "host"
  }

  memory {
    dedicated = each.value.memory
  }

  # import du disque fait côté serveur depuis l'OVA, pas besoin de shell sur pve3-ovh
  disk {
    datastore_id = var.datastore
    import_from  = var.image_import_volid
    interface    = "scsi0"
    size         = each.value.disk
  }

  network_device {
    bridge = var.dmz_bridge
    model  = "virtio"
  }

  network_device {
    bridge = var.mgmt_bridge
    model  = "virtio"
  }

  network_device {
    bridge = var.tsa_bridge
    model  = "virtio"
  }

  agent {
    enabled = var.qemu_agent
  }

  operating_system {
    type = "l26"
  }

  # les images cloud debian utilisent la console série
  serial_device {}

  initialization {
    datastore_id = var.datastore

    # un ip_config par interface, même ordre que les network_device
    # la default route passe par la DMZ, pas de gateway sur les 2 autres pattes
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.dmz_gateway
      }
    }

    ip_config {
      ipv4 {
        address = "${each.value.mgmt_ip}/24"
      }
    }

    ip_config {
      ipv4 {
        address = "${each.value.tsa_ip}/24"
      }
    }

    dns {
      servers = var.dns_servers
    }

    user_account {
      username = var.ci_user
      password = var.ci_password
      keys     = [trimspace(var.ssh_public_key)]
    }
  }
}
