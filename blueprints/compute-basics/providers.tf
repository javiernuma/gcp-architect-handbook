terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0" # Define una versión estable para evitar errores por cambios en la API
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}