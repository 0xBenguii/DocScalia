variable "proxmox_endpoint" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_insecure" {
  type    = bool
  default = true
}

variable "node_name" {
  type = string
}

# disque de l'image cloud Debian 12, uploadée en OVA dans le contenu import
variable "image_import_volid" {
  type    = string
  default = "local:import/debian12-genericcloud-eq9.ova/debian-12-genericcloud-amd64.qcow2"
}

variable "datastore" {
  type    = string
  default = "local"
}

variable "vm_name_prefix" {
  type    = string
  default = "prs-bai-262-eq9"
}

variable "pool_id" {
  type    = string
  default = "prs-bai-eq9"
}

variable "dmz_bridge" {
  type    = string
  default = "prsbaie9l2"
}

variable "mgmt_bridge" {
  type    = string
  default = "prsbaie9l4"
}

# bridge temporaire pour l'accès admin tailscale, à supprimer en fin de maquette
variable "tsa_bridge" {
  type    = string
  default = "prsbaie9t1"
}

variable "dmz_gateway" {
  type    = string
  default = "10.9.175.1"
}

variable "dns_servers" {
  type    = list(string)
  default = ["10.9.175.1"]
}

variable "ci_user" {
  type    = string
  default = "ansible"
}

variable "ssh_public_key" {
  type = string
}

variable "ci_password" {
  type      = string
  sensitive = true
  default   = null
}

# laisser à false tant que le guest agent n'est pas installé dans les VM
variable "qemu_agent" {
  type    = bool
  default = false
}
