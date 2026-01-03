variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "instance_name" {
  description = "Nombre de la instancia"
  type        = string
}

variable "machine_type" {
  description = "Tipo de máquina (ej: e2-medium)"
  type        = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  description = "Zona de GCP"
  type        = string
}

variable "network_tags" {
  description = "Etiquetas de red para firewall"
  type        = list(string)
  default     = []
}

variable "is_public" {
  description = "Define si la VM tiene IP pública"
  type        = bool
  default     = false
}

variable "image_family" {
  description = "Imagen del sistema operativo"
  type        = string
}

variable "network_name" {
  description = "Nombre de la red VPC"
  type        = string
  default     = "default"
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
  default     = "default"
}
