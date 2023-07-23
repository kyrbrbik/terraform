variable "name_map_master" {
	type = map(string)
}
variable "name_map_worker" {
	type = map(string)
}
variable "name_map_worker_n2" {
	type = map(string)
}
variable "cores_master" {
	type = number
}
variable "cores_worker" {
	type = number
}
variable "memory" {
	type = number
}
variable "memory_worker_n2" {
	type = number
}

