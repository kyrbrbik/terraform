resource "proxmox_vm_qemu" "master" {
  target_node = "pve"
  for_each = var.name_map_master
  vmid = each.value
  name = each.key
  onboot = true

  agent = 1

  clone   = "Cloud-qemu"
  cores   = var.cores_master
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
}

resource "proxmox_vm_qemu" "worker" {
  target_node = "pve"
  for_each = var.name_map_worker
  vmid = each.value
  name = each.key
  onboot = true

  agent = 1

  clone   = "Cloud-qemu"
  cores   = var.cores_worker
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
    size = "20G"
  }
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.${each.value}/24,gw=192.168.0.1"
}
