variable "name" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "network_tags" {
  type    = list(string)
  default = []
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



