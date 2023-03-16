resource "proxmox_vm_qemu" "ubuntu-server" {
  target_node = "pve"

  agent = 1

  clone   = "Cloud-qemu"
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 2048
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  disk {
    storage = "local-lvm"
    type = "virtio"
    size = "10G"
  }
  os_type = "cloud-init"
}
