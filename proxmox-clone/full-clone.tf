resource "proxmox_vm_qemu" "ubuntu-server" {
  target_node = "pve"

  agent = 1
  vmid = 300
  clone   = "Cloud-qemu"
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 4096
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
  ipconfig0 = "ip=192.168.0.25/24,gw=192.168.0.1"
}
