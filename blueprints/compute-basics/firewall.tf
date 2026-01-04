# ==========================================================
# REGLAS DE FIREWALL (NETWORK SECURITY)
# ==========================================================

# Regla para permitir tráfico HTTP (Puerto 80)
# Se aplica de forma masiva a cualquier instancia con el tag 'http-server'
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-shared"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# Regla para permitir SSH (Puerto 22) - Útil para troubleshooting
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-shared"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-enabled"]
}