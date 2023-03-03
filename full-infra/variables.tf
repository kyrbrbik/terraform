variable "test_string" {
	type = string
	default = "abcdef"
}
variable "names" {
	type = list(string)
}
variable "vmid" {
	type = list(string)
}

variable "name" {
	type = string
}

variable "name_map" {
	type = map(string)
}