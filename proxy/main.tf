resource "proxmox_vm_qemu" "node" {
  target_node = "pve"
  for_each = var.name_map
  vmid = each.value
  name = each.key
  onboot = true

  agent = 1

  clone   = "Cloud-qemu"
  cores   = var.cores
  sockets = 1
  cpu     = "host"
  memory  = var.memory

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  disk {
    storage = "local-lvm"
    type = "virtio"
    size = "15G"
  }
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.${each.value}/24,gw=192.168.0.1"
  automatic_reboot = true
}
