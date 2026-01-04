resource "google_compute_firewall" "fw_allow_health_check" {
  name    = "fw-allow-health-check" # Nombre exacto del reto
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # IPs críticas de Google para Health Checks y Load Balancing
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  # Este tag DEBE coincidir con el que pusiste en el modulo lb_template
  target_tags = ["allow-health-check"]
}
