resource "proxmox_vm_qemu" "node" {
  target_node = "pve"
  for_each = var.name_map
  vmid = each.value
  name = each.key
  onboot = true

  agent = 1

  clone   = "Cloud-qemu"
  cores   = 1
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
  ipconfig0 = "ip=192.168.0.${each.value}/24,gw=192.168.0.1"
}
