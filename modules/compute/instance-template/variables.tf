variable "name" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-small"
}

variable "network_tags" {
  type    = list(string)
  default = ["network-lb-tag"]
}

variable "image_family" {
  type    = string
  default = "debian-12"
}

variable "startup_script" {
  type    = string
  default = ""
}

variable "network_name" {
  type    = string
  default = "default"
}



