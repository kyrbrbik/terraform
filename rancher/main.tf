resource "proxmox_vm_qemu" "rancher" {
	target_node = "pve"
	for_each = var.name_map
    vmid = each.value + 100
	name = each.key
	onboot = true

	agent = 1

	clone = "Cloud-qemu"
	cores = var.cores
	sockets = 1
	cpu = "host"
	memory = var.memory

	network {
		bridge = "vmbr0"
		model = "virtio"
	}
	disk {
		storage = "data-slow2"
		type = "virtio"
		size = var.disk_size
	}
	os_type = "cloud-init"
	ipconfig0 = "ip=192.168.0.${each.value}/24,gw=192.168.0.1"
	sshkeys = file("~/.ssh/id_rsa.pub")
}

resource "proxmox_vm_qemu" "loadbalancer" {
	target_node = "pve"
    vmid = 190
	name = "Rancher-lb"
	onboot = true

	agent = 1

	clone = "Cloud-qemu"
	cores = 1
	sockets = 1
	cpu = "host"
	memory = 2048

	network {
		bridge = "vmbr0"
		model = "virtio"
	}
	disk {
		storage = "data-slow2"
		type = "virtio"
		size = "20G"
	}
	os_type = "cloud-init"
	ipconfig0 = "ip=192.168.0.90/24,gw=192.168.0.1"
	sshkeys = file("~/.ssh/id_rsa.pub")
}

