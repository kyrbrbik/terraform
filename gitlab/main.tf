resource "proxmox_vm_qemu" "ubuntu-server" {
  target_node = "pve"

  agent = 1
  vmid = 160
  clone   = "Cloud-qemu"
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 8192
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  disk {
    storage = "data-slow"
    type = "virtio"
    size = "20G"
  }
  disk {
	storage = "data-slow2"
	type = "virtio"
	size = "100G"
	}
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.160/24,gw=192.168.0.1"
}
