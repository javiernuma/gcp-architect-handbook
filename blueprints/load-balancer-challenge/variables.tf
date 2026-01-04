variable "project_id" { type = string }
variable "region" { type = string }
variable "zone" { type = string }

# Variables para Task 1 (Instancias individuales)
variable "instance_names" {
  type    = list(string)
  default = ["web1", "web2", "web3"]
}

# Variables para Task 3 (MIG)
variable "mig_name" {
  type    = string
  default = "lb-backend-group"
}

