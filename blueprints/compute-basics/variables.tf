variable "project_id" {
  description = "ID del proyecto de GCP"
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
  default     = ["http-server"]
}

variable "is_public" {
  description = "Define si la VM tiene IP pública"
  type        = bool
  default     = true
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

variable "instance_names" {
  type        = list(string)
  description = "Lista de nombres para las instancias de VM"
  default     = ["gcplab"] # Un valor por defecto seguro
}
