# Task 1: Firewall para las instancias standalone (Target: network-lb-tag)
resource "google_compute_firewall" "www_firewall_network_lb" {
  name    = "www-firewall-network-lb"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["network-lb-tag"]
}

# Task 3: Firewall para Health Checks de Google (Target: allow-health-check)
resource "google_compute_firewall" "fw_allow_health_check" {
  name          = "fw-allow-health-check"
  network       = "default"
  direction     = "INGRESS"
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"] # Rangos oficiales de Google
  target_tags   = ["allow-health-check"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}