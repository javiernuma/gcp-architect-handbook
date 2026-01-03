variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "is_public" {
  type    = bool
  default = true
}

variable "network_name" {
  type    = string
  default = "default"
}

variable "subnet_name" {
  type    = string
  default = "default"
}

variable "network_tags" {
  type    = list(string)
  default = ["http-server", "lb-backend"]
}