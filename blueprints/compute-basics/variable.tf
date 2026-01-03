variable "project_id" {
  description = "El ID del proyecto de GCP"
  type        = string
}

variable "region" {
  default     = "us-central1"
  type        = string
}

variable "zone" {
  default     = "us-central1-a"
  type        = string
}

variable "instance_name" {
  default     = "instance-1"
  type        = string
}

variable "machine_type" {
  default     = "e2-medium"
  type        = string
}