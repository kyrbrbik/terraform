resource "proxmox_vm_qemu" "ubuntu-server" {
  target_node = "pve"

  agent = 1

  clone   = "ubuntu-cloud"
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 2048

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  os_type = "cloud-init"
}
