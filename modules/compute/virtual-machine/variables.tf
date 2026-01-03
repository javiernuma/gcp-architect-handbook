variable "project_id" { type = string }
variable "instance_name" { type = string }
variable "machine_type" { type = string, default = "e2-medium" }
variable "zone" { type = string }
variable "image_family" { type = string, default = "debian-cloud/debian-11" }
variable "network_name" { type = string, default = "default" }
variable "subnet_name" { type = string, default = "default" }
variable "is_public" { type = bool, default = false }
variable "network_tags" { type = list(string), default = [] }
variable "startup_script" { type = string, default = "" }