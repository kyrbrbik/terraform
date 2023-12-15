resource "proxmox_vm_qemu" "worker-n2" {
  for_each = var.name_map_worker_n2
  target_node = "pve1"
  vmid = each.value
  name = each.key
  onboot = true

  agent = 1

  clone   = "debian"
  cores   = 3
  sockets = 1
  cpu     = "host"
  memory  = var.memory_worker_n2

  network {
	bridge = "vmbr0"
	model  = "virtio"
  }
  disk {
	storage = "local-lvm"
	type = "virtio"
	size = "32G"
  }
  disk {
	storage = "data-slow"
	type = "virtio"
	size = "200G"
  }
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.124/24,gw=192.168.0.1"
  sshkeys = file("~/.ssh/id_rsa.pub")
  automatic_reboot = false
  
  lifecycle {
	ignore_changes = [
	  network,
	  disk,
	  ipconfig0,
	  sshkeys,
	]
  }
}

resource "proxmox_vm_qemu" "worker_new" {
  target_node = "pve"
  for_each = var.name_map_worker_new
  vmid = each.value
  name = each.key
  onboot = true

  agent = 1

  clone   = "Debian"
  cores   = var.cores_worker
  sockets = 1
  cpu     = "host"
  memory  = var.memory

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  disk {
    storage = "data-slow"
    type = "virtio"
    size = "32G"
  }
  disk {
	storage = "data-slow2"
	type = "scsi"
	size = "200G"
  }
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.${each.value}/24,gw=192.168.0.1"
  sshkeys = file("~/.ssh/id_rsa.pub")
  automatic_reboot = false
  
  lifecycle {
	ignore_changes = [
	  network,
	  disk,
	  ipconfig0,
	  sshkeys,
	]
  }
}
resource "proxmox_vm_qemu" "master_new" {
  target_node = "pve"
  for_each = var.name_map_master_new
  vmid = each.value
  name = each.key
  onboot = true

  agent = 1

  clone   = "Debian"
  cores   = var.cores_master
  sockets = 1
  cpu     = "host"
  memory  = var.memory

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  disk {
    storage = "data-slow2"
    type = "virtio"
    size = "32G"
  }
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.${each.value}/24,gw=192.168.0.1"
  sshkeys = file("~/.ssh/id_rsa.pub")
  automatic_reboot = false

  lifecycle {
	ignore_changes = [
	  network,
	  disk,
	  ipconfig0,
	  sshkeys,
	]
  }
}
