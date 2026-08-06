# VM routeur Tailscale, hors périmètre projet comme son bridge.
# Sortie internet par vmbr1 comme les UTM (toléré le temps du build),
# et une patte sur le vlan t1 en .1 pour router le 10.10.10.0/24 vers le tailnet.
resource "proxmox_virtual_environment_vm" "tsr" {
  name      = "${var.vm_name_prefix}-PRS-TSR-01"
  node_name = var.node_name
  pool_id   = var.pool_id
  vm_id     = 987

  on_boot         = true
  stop_on_destroy = true

  cpu {
    cores = 1
    type  = "host"
  }

  memory {
    dedicated = 1024
  }

  disk {
    datastore_id = var.datastore
    import_from  = var.image_import_volid
    interface    = "scsi0"
    size         = 10
  }

  # net0 WAN, net1 vlan tailscale
  network_device {
    bridge = "vmbr1"
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

  serial_device {}

  initialization {
    datastore_id = var.datastore

    # .69 : suite de la série en x9 du groupe sur le WAN, à changer si pris
    ip_config {
      ipv4 {
        address = "192.168.254.69/24"
        gateway = "192.168.254.254"
      }
    }

    ip_config {
      ipv4 {
        address = "10.10.10.1/24"
      }
    }

    dns {
      servers = ["1.1.1.1", "9.9.9.9"]
    }

    user_account {
      username = var.ci_user
      password = var.ci_password
      keys     = [trimspace(var.ssh_public_key)]
    }
  }
}
