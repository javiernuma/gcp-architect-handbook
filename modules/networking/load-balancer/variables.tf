variable "name" {
  description = "Nombre base para los recursos del Load Balancer"
  type        = string
}

variable "type" {
  description = "Tipo de Load Balancer: 'NETWORK' o 'HTTP'"
  type        = string
}

variable "region" {
  description = "Región de GCP (Solo necesaria para NETWORK LB)"
  type        = string
  default     = null
}

variable "instances" {
  description = "Lista de self_links de instancias (Para NETWORK LB)"
  type        = list(string)
  default     = []
}

variable "instance_group" {
  description = "Self_link del Instance Group (Para HTTP LB)"
  type        = string
  default     = null
}

variable "health_check_id" {
  description = "ID del Health Check (Para HTTP LB)"
  type        = string
  default     = null
}
variable "ip_address" {
  description = "IP estática reservada para el balanceador"
  type        = string
}