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
	type = "scsi"
	size = "2252M"
  }
  disk {
    storage = "local-lvm"
    type = "virtio"
    size = "26828M"
  }
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.${each.value}/24,gw=192.168.0.1"
  sshkeys = file("~/.ssh/id_rsa.pub")

  lifecycle {
	ignore_changes = [
	  network,
	  disk,
	  ipconfig0,
	  sshkeys,
	]
  }
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
	type = "scsi"
	size = "2252M"
  }
  disk {
	storage = "data-slow"
	type = "scsi"
	size = "128G"
  }
  disk {
    storage = "local-lvm"
    type = "virtio"
    size = "24780M"
  }
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.${each.value}/24,gw=192.168.0.1"
  sshkeys = file("~/.ssh/id_rsa.pub")

  lifecycle {
	ignore_changes = [
	  network,
	  disk,
	  ipconfig0,
	  sshkeys,
	]
  }
}

resource "proxmox_vm_qemu" "worker-n2" {
  for_each = var.name_map_worker_n2
  target_node = "pve1"
  vmid = each.value
  name = each.key
  onboot = true

  agent = 1

  clone   = "Cloud-qemu-2"
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
	size = "20G"
  }
  disk {
	storage = "data-slow"
	type = "virtio"
	size = "200G"
  }
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.124/24,gw=192.168.0.1"
  sshkeys = file("~/.ssh/id_rsa.pub")
  
  lifecycle {
	ignore_changes = [
	  network,
	  disk,
	  ipconfig0,
	  sshkeys,
	]
  }
}
