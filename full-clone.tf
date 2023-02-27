resource "proxmox_vm_qemu" "ubuntu-server" {
	target_node = "pve"

	agent = 1

	clone = "ubuntu-clone"
	cores = 2
	sockets = 1
	cpu = "host"
	memory = 2048

	network = {
	bridge = "vmbr0"
	model = "virtio"
	}	

}
	os_type = "cloud-init"
	sshkeys = <<EOF
	AAAAB3NzaC1yc2EAAAADAQABAAABgQC6hOZFKm/6OtpaZ8K/qinqSELu3XAiGglhYbM5jy9aVUT/Lispglw9b7lrkV4+2mtr3joDfWGVX2/aMiATH/ZSDCMcayYtZsx+zLnpbjvHylMNsUnS+Knj72jnH2CbnJ2HMGNSuwZxiCYIv174D72TcoVus46vVggSpfpPSzWiG536uhxR6dhpAK41H0sb4+1wXFS4csfFDUfjqc01iMbDPbaDEzquWWckU7QGDrRWWwpsl/0KNi47XWiTup3IZ/xGDd/oqs4JzRIC8tSiuXpxbB0zg0bwxWvh9C2xiJgvXrWXMonCTo4eEvoKzn2rfpDZjSw1VujuUAgHW8zfBNbsvYWWH/3r645rtsmc2rcF9fliAEbr6/lAVkPy0EI751uE42VpFg7wt1Ebbwop5w+YNb+z98TNNMQNXo34Y7GViPwr1GTd61FWMB4gFJa7/p2Nt20u6xpKM9rTjZ/QlM8oE/e2bZ3DhSCU7JRtpJEud3imqh8qUGXwKkH7mC8H9Tk= brbik@Olympus
	EOF